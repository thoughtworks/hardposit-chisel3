package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class PositAdd(val totalBits: Int, val es: Int) extends Module with HasHardPositParams {
  require(totalBits > es)
  require(es >= 0)

  val io = IO(new Bundle{
    val num1   = Input(UInt(totalBits.W))
    val num2   = Input(UInt(totalBits.W))
    val sub    = Input(Bool())

    val isZero = Output(Bool())
    val isNaR  = Output(Bool())
    val out    = Output(UInt(totalBits.W))
  })

  val num1Extractor = Module(new PositExtractor(totalBits, es))
  val num2Extractor = Module(new PositExtractor(totalBits, es))

  num1Extractor.io.in := io.num1
  num2Extractor.io.in := io.num2

  val num1 = num1Extractor.io.out
  val num2 = num2Extractor.io.out

  val result = Wire(new unpackedPosit(totalBits, es))

  val num1magGt =
    (num1.exponent > num2.exponent) |
     (num1.exponent === num2.exponent &&
      (num1.fraction > num2.fraction))
  val num2AdjSign = num2.sign ^ io.sub

  val largeSign = Mux(num1magGt, num1.sign, num2AdjSign)
  val largeExp  = Mux(num1magGt, num1.exponent, num2.exponent)
  val largeFrac =
    Cat(Mux(num1magGt, num1.fraction, num2.fraction), 0.U((maxAdderFractionBits - maxFractionBitsWithHiddenBit - 1).W))

  val smallSign = Mux(num1magGt, num2AdjSign, num1.sign)
  val smallExp  = Mux(num1magGt, num2.exponent, num1.exponent)
  val smallFrac =
    Cat(Mux(num1magGt, num2.fraction, num1.fraction), 0.U((maxAdderFractionBits - maxFractionBitsWithHiddenBit - 1).W))

  val expDiff = (largeExp - smallExp).asUInt()
  val shiftedSmallFrac =
    Mux(expDiff < (maxAdderFractionBits - 1).U, smallFrac >> expDiff, 0.U)
  val smallFracStickyBit =
    Mux(expDiff > (maxAdderFractionBits - maxFractionBitsWithHiddenBit - 1).U,
    (smallFrac & ((1.U << (expDiff - (maxAdderFractionBits - maxFractionBitsWithHiddenBit - 1).U)) - 1.U)).orR(), false.B)

  val isAddition = !(largeSign ^ smallSign)
  val signedSmallerFrac =
    Mux(isAddition, shiftedSmallFrac, ~shiftedSmallFrac + 1.U)
  val adderFrac =
    WireInit(UInt(maxAdderFractionBits.W), largeFrac +& signedSmallerFrac)

  val sumOverflow = isAddition & adderFrac(maxAdderFractionBits - 1)

  val adjAdderExp = largeExp - sumOverflow.asSInt()
  val adjAdderFrac =
    Mux(sumOverflow, adderFrac(maxAdderFractionBits - 1, 1), adderFrac(maxAdderFractionBits - 2, 0))
  val sumStickyBit = sumOverflow & adderFrac(0)

  val normalizationFactor = MuxCase(0.S, Array.range(0, maxAdderFractionBits - 1).map(index => {
    (adjAdderFrac(maxAdderFractionBits - 2, maxAdderFractionBits - index - 2) === 1.U) -> index.S
  }))

  val normExponent = adjAdderExp - normalizationFactor
  val normFraction = adjAdderFrac << normalizationFactor.asUInt()

  result.isNaR    := num1.isNaR || num2.isNaR
  result.isZero   := (num1.isZero && num2.isZero) | (adderFrac === 0.U)
  result.sign     := largeSign
  result.exponent := normExponent
  result.fraction := normFraction(maxAdderFractionBits - 2, maxAdderFractionBits - maxFractionBitsWithHiddenBit - 1)

  private val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.in <> result
  positGenerator.io.trailingBits := normFraction(maxAdderFractionBits - maxFractionBitsWithHiddenBit - 2, maxAdderFractionBits - maxFractionBitsWithHiddenBit - trailingBitCount - 1)
  positGenerator.io.stickyBit    := sumStickyBit | normFraction(stickyBitCount - 1, 0).orR()

  io.isZero := result.isZero
  io.isNaR  := result.isNaR
  io.out    := positGenerator.io.out
}