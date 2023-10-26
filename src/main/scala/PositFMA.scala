package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase, log2Ceil}

class PositFMACore(val nbits: Int, val es: Int) extends Module with HasHardPositParams {

  val io = IO(new Bundle {
    val num1   = Input(new unpackedPosit(nbits, es))
    val num2   = Input(new unpackedPosit(nbits, es))
    val num3   = Input(new unpackedPosit(nbits, es))
    val sub    = Input(Bool())
    val negate = Input(Bool())

    val trailingBits = Output(UInt(trailingBitCount.W))
    val stickyBit    = Output(Bool())
    val out          = Output(new unpackedPosit(nbits, es))
  })

  val num1 = io.num1
  val num2 = io.num2
  val num3 = io.num3

  val productSign = num1.sign ^ num2.sign ^ io.negate
  val addendSign  = num3.sign ^ io.negate ^ io.sub

  val productExponent = num1.exponent +& num2.exponent
  val productFraction =
    WireInit(UInt(maxMultiplierFractionBits.W), num1.fraction * num2.fraction)

  val prodOverflow        = productFraction(maxMultiplierFractionBits - 1)
  val normProductFraction =
    Mux(prodOverflow, productFraction(maxMultiplierFractionBits - 1, 1), productFraction(maxMultiplierFractionBits - 2, 0))
  val normProductExponent = productExponent + Cat(0.U, prodOverflow).asSInt
  val prodStickyBit       = prodOverflow & productFraction(0)

  val addendIsZero   = num3.isZero
  val addendFraction = Mux(addendIsZero, 0.U, Cat(num3.fraction, 0.U(maxFractionBits.W)))
  val addendExponent = num3.exponent

  val isAddendGtProduct =
    ~addendIsZero &
      ((addendExponent > normProductExponent) |
        (addendExponent === normProductExponent && (addendFraction > normProductFraction)))

  val gExp  = Mux(isAddendGtProduct, addendExponent, normProductExponent)
  val gFrac = Mux(isAddendGtProduct, addendFraction, normProductFraction)
  val gSign = Mux(isAddendGtProduct, addendSign, productSign)

  val lExp  = Mux(isAddendGtProduct, normProductExponent, addendExponent)
  val lFrac = Mux(isAddendGtProduct, normProductFraction, addendFraction)
  val lSign = Mux(isAddendGtProduct, productSign, addendSign)

  val expDiff = (gExp - lExp).asUInt
  val shftInBound = expDiff < (maxMultiplierFractionBits - 1).U
  val shiftedLFrac =
    Mux(shftInBound, lFrac >> expDiff, 0.U(maxMultiplierFractionBits.W))
  val lfracStickyMask =
    lowerBitMask(expDiff)(maxMultiplierFractionBits - 1, 0)
  val lFracStickyBit = (lFrac & lfracStickyMask).orR

  val isAddition = ~(gSign ^ lSign)
  val signedLFrac =
    Mux(isAddition, shiftedLFrac, ~shiftedLFrac + 1.U)
  val fmaFraction =
    WireInit(UInt(maxMultiplierFractionBits.W), gFrac +& signedLFrac)

  val fmaOverflow = isAddition & fmaFraction(maxMultiplierFractionBits - 1)
  val adjFmaFraction =
    Mux(fmaOverflow, fmaFraction, Cat(fmaFraction(maxMultiplierFractionBits - 2, 0), 0.U(1.W)))
  val adjFmaExponent = gExp + Cat(0.U, fmaOverflow).asSInt

  val normalizationFactor = countLeadingZeros(adjFmaFraction)
  val normFmaExponent = adjFmaExponent -& normalizationFactor.asSInt
  val normFmaFraction = (adjFmaFraction << normalizationFactor)(maxMultiplierFractionBits - 1, 0)

  val result = Wire(new unpackedPosit(nbits, es))
  result.isNaR    := num1.isNaR | num2.isNaR | num3.isNaR
  result.isZero   := !result.isNaR & ((num1.isZero | num2.isZero) & num3.isZero)
  result.sign     := gSign
  result.exponent := normFmaExponent
  result.fraction := normFmaFraction(maxMultiplierFractionBits - 1, maxMultiplierFractionBits - maxFractionBitsWithHiddenBit).asUInt

  io.trailingBits := normFmaFraction(maxFractionBitsWithHiddenBit - 1, maxFractionBitsWithHiddenBit - trailingBitCount)
  io.stickyBit    := prodStickyBit | lFracStickyBit | normFmaFraction(maxFractionBitsWithHiddenBit - trailingBitCount - 1, 0).orR

  io.out := result
}

class PositFMA(val nbits: Int, val es: Int) extends Module with HasHardPositParams {

  val io = IO(new Bundle {
    val num1   = Input(UInt(nbits.W))
    val num2   = Input(UInt(nbits.W))
    val num3   = Input(UInt(nbits.W))
    val sub    = Input(Bool())
    val negate = Input(Bool())

    val isNaR  = Output(Bool())
    val isZero = Output(Bool())
    val out    = Output(UInt(nbits.W))
  })

  val positFMACore = Module(new PositFMACore(nbits, es))

  val num1Extractor = Module(new PositExtractor(nbits, es))
  val num2Extractor = Module(new PositExtractor(nbits, es))
  val num3Extractor = Module(new PositExtractor(nbits, es))
  num2Extractor.io.in := io.num2
  num1Extractor.io.in := io.num1
  num3Extractor.io.in := io.num3

  positFMACore.io.num1 := num1Extractor.io.out
  positFMACore.io.num2 := num2Extractor.io.out
  positFMACore.io.num3 := num3Extractor.io.out
  positFMACore.io.sub    := io.sub
  positFMACore.io.negate := io.negate

  private val positGenerator = Module(new PositGenerator(nbits, es))

  positGenerator.io.in := positFMACore.io.out
  positGenerator.io.trailingBits := positFMACore.io.trailingBits
  positGenerator.io.stickyBit    := positFMACore.io.stickyBit

  io.isZero := positFMACore.io.out.isZero | isZero(positGenerator.io.out)
  io.isNaR  := positFMACore.io.out.isNaR  | isNaR(positGenerator.io.out)
  io.out    := positGenerator.io.out
}