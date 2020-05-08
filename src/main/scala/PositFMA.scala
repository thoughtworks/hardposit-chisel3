package hardposit

import chisel3._
import chisel3.util.MuxCase

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

  val productExponent = num1.exponent + num2.exponent
  val productFraction =
    WireInit(UInt(maxProductFractionBits.W), num1.fraction * num2.fraction)

  val prodOverflow        = productFraction(maxProductFractionBits - 1)
  val normProductFraction = (productFraction >> prodOverflow.asUInt()).asUInt()
  val normProductExponent = productExponent + Mux(prodOverflow, 1.S, 0.S)
  val prodStickyBit       = Mux(prodOverflow, productFraction(0), false.B)

  val addendFraction = (num3.fraction << maxFractionBits).asUInt
  val addendExponent = num3.exponent

  val isAddendLargerThanProduct =
    (addendExponent > normProductExponent) |
      (addendExponent === normProductExponent &&
        (addendFraction > normProductFraction))

  val largeExp  = Mux(isAddendLargerThanProduct, addendExponent, normProductExponent)
  val largeFrac = Mux(isAddendLargerThanProduct, addendFraction, normProductFraction)
  val largeSign = Mux(isAddendLargerThanProduct, addendSign, productSign)

  val smallExp  = Mux(isAddendLargerThanProduct, normProductExponent, addendExponent)
  val smallFrac = Mux(isAddendLargerThanProduct, normProductFraction, addendFraction)
  val smallSign = Mux(isAddendLargerThanProduct, productSign, addendSign)

  val expDiff = (largeExp - smallExp).asUInt()
  val shiftedSmallFrac =
    Mux(expDiff < maxProductFractionBits.U, smallFrac >> expDiff, 0.U)
  val smallFracStickyBit = (smallFrac & ((1.U << expDiff) - 1.U)).orR()

  val isAddition = ~(largeSign ^ smallSign)
  val signedSmallerFraction =
    Mux(isAddition, shiftedSmallFrac, ~shiftedSmallFrac + 1.U)
  val fmaFraction =
    WireInit(UInt(maxProductFractionBits.W), largeFrac +& signedSmallerFraction)

  val sumOverflow = fmaFraction(maxProductFractionBits - 1)
  val adjFmaFraction =
    Mux(isAddition, fmaFraction >> sumOverflow.asUInt(), fmaFraction(maxProductFractionBits - 2, 0))
  val adjFmaExponent = largeExp + Mux(isAddition & sumOverflow, 1.S, 0.S)
  val sumStickyBit = Mux(isAddition & sumOverflow, fmaFraction(0), false.B)

  val normalizationFactor = MuxCase(0.S, Array.range(0, maxProductFractionBits - 2).map(index => {
    (adjFmaFraction(maxProductFractionBits - 2, maxProductFractionBits - index - 2) === 1.U) -> index.S
  }))

  val normFmaExponent = adjFmaExponent - normalizationFactor
  val normFmaFraction = adjFmaFraction << normalizationFactor.asUInt()

  val result = Wire(new unpackedPosit(totalBits, es))
  result.isNaR    := num1.isNaR || num2.isNaR || num3.isNaR
  result.isZero   := (num1.isZero || num2.isZero) && num3.isZero
  result.sign     := largeSign
  result.exponent := normFmaExponent
  result.fraction := (normFmaFraction >> maxFractionBits).asUInt()

  val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.in <> result
  positGenerator.io.trailingBits := normFmaFraction(maxFractionBits - 1, maxFractionBits - trailingBitCount)
  positGenerator.io.stickyBit    := prodStickyBit | sumStickyBit | smallFracStickyBit | normFmaFraction(maxFractionBits - trailingBitCount - 1, 0).orR()

  io.isNaR  := result.isNaR || (positGenerator.io.out === NaR)
  io.isZero := result.isZero || (positGenerator.io.out === 0.U)
  io.out    := Mux(result.isNaR, NaR, positGenerator.io.out)
}
