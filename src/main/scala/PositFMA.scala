package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class PositFMA(val totalBits: Int, val es: Int) extends Module with HasHardPositParams {

  val io = IO(new Bundle {
    val num1 = Input(UInt(totalBits.W))
    val num2 = Input(UInt(totalBits.W))
    val num3 = Input(UInt(totalBits.W))
    val sub = Input(Bool())
    val negate = Input(Bool())
    val isNaR = Output(Bool())
    val isZero = Output(Bool())
    val out = Output(UInt(totalBits.W))
  })

  val num1Extractor = Module(new PositExtractor(totalBits, es))
  val num2Extractor = Module(new PositExtractor(totalBits, es))
  val num3Extractor = Module(new PositExtractor(totalBits, es))

  num2Extractor.io.in := io.num2
  num1Extractor.io.in := io.num1
  num3Extractor.io.in := io.num3

  val num1 = num1Extractor.io.out
  val num2 = num2Extractor.io.out
  val num3 = num3Extractor.io.out

  val productSign = num1.sign ^ num2.sign ^ io.negate
  val addendSign  = num3.sign ^ io.negate ^ io.sub

  val productExponent = num1.exponent +& num2.exponent
  val productFraction =
    WireInit(UInt(maxMultiplierFractionBits.W), num1.fraction * num2.fraction)

  val prodOverflow        = productFraction(maxMultiplierFractionBits - 1)
  val normProductFraction =
    Mux(prodOverflow, productFraction(maxMultiplierFractionBits - 1, 1), productFraction(maxMultiplierFractionBits - 2, 0))
  val normProductExponent = productExponent + Cat(0.U, prodOverflow).asSInt()
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

  val expDiff = (gExp - lExp).asUInt()
  val shftInBound = expDiff < (maxMultiplierFractionBits - 1).U
  val shiftedLFrac =
    Mux(shftInBound, lFrac >> expDiff, 0.U)
  val lFracStickyBit = (lFrac & ((1.U << expDiff) - 1.U)).orR()

  val isAddition = ~(gSign ^ lSign)
  val signedLFrac =
    Mux(isAddition, shiftedLFrac, ~shiftedLFrac + 1.U)
  val fmaFraction =
    WireInit(UInt(maxMultiplierFractionBits.W), gFrac +& signedLFrac)

  val fmaOverflow = isAddition & fmaFraction(maxMultiplierFractionBits - 1)
  val adjFmaFraction =
    Mux(fmaOverflow, fmaFraction, Cat(fmaFraction(maxMultiplierFractionBits - 2, 0), 0.U(1.W)))
  val adjFmaExponent = gExp + Cat(0.U, fmaOverflow).asSInt()

  val normalizationFactor = MuxCase(maxMultiplierFractionBits.S, Array.range(0, maxMultiplierFractionBits - 1).map(index => {
    (adjFmaFraction(maxMultiplierFractionBits - 1, maxMultiplierFractionBits - index - 1) === 1.U) -> index.S
  }))

  val normFmaExponent = adjFmaExponent -& normalizationFactor
  val normFmaFraction = (adjFmaFraction << normalizationFactor.asUInt())(maxMultiplierFractionBits - 1, 0)

  val result = Wire(new unpackedPosit(totalBits, es))
  result.isNaR    := num1.isNaR | num2.isNaR | num3.isNaR
  result.isZero   := !result.isNaR & ((num1.isZero | num2.isZero) & num3.isZero)
  result.sign     := gSign
  result.exponent := normFmaExponent
  result.fraction := normFmaFraction(maxMultiplierFractionBits - 1, maxMultiplierFractionBits - maxFractionBitsWithHiddenBit).asUInt()

  val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.in <> result
  positGenerator.io.trailingBits := normFmaFraction(maxFractionBitsWithHiddenBit - 1, maxFractionBitsWithHiddenBit - trailingBitCount)
  positGenerator.io.stickyBit    := prodStickyBit | lFracStickyBit | normFmaFraction(maxFractionBitsWithHiddenBit - trailingBitCount - 1, 0).orR()

  io.isNaR  := result.isNaR  | isNaR(positGenerator.io.out)
  io.isZero := result.isZero | isZero(positGenerator.io.out)
  io.out    := positGenerator.io.out
}
