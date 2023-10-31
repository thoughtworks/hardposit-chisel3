package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class PositAddCore(val nbits: Int, val es: Int) extends Module with HasHardPositParams {

  val io = IO(new Bundle{
    val num1   = Input(new unpackedPosit(nbits, es))
    val num2   = Input(new unpackedPosit(nbits, es))
    val sub    = Input(Bool())

    val trailingBits = Output(UInt(trailingBitCount.W))
    val stickyBit = Output(Bool())
    val out    = Output(new unpackedPosit(nbits, es))
  })

  val num1 = io.num1
  val num2 = io.num2

  val result = Wire(new unpackedPosit(nbits, es))

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

  when(num1magGt) {
    assert((largeSign === num1.sign) & (smallSign === num2AdjSign))
  }
  when(!num1magGt) {
    assert((largeSign === num2AdjSign) & (smallSign === num1.sign))
  }

  val expDiff = (largeExp - smallExp).asUInt
  val shiftedSmallFrac =
    Mux(expDiff < (maxAdderFractionBits - 1).U, smallFrac >> expDiff, 0.U)

  when(expDiff === 0.U) {
    assert(shiftedSmallFrac === smallFrac)
  }
  when(expDiff === (maxAdderFractionBits - 1).U) {
    assert(shiftedSmallFrac === 0.U)
  }

  val smallFracStickyBit =
    Mux(expDiff > (maxAdderFractionBits - maxFractionBitsWithHiddenBit - 1).U,
    (smallFrac & ((1.U << (expDiff - (maxAdderFractionBits - maxFractionBitsWithHiddenBit - 1).U)) - 1.U)).orR, false.B)

  val isAddition = !(largeSign ^ smallSign)

  when(!isAddition) {
    assert(io.sub ^ num1.sign ^ num2.sign)
  }

  val signedSmallerFrac =
    Mux(isAddition, shiftedSmallFrac, ~shiftedSmallFrac + 1.U)
  val adderFrac =
    WireInit(UInt(maxAdderFractionBits.W), largeFrac +& signedSmallerFrac)

  val sumOverflow = isAddition & adderFrac(maxAdderFractionBits - 1)

  when(!isAddition) {
    assert(!sumOverflow)
  }

  assert((sumOverflow.getWidth).asUInt === 1.U)

  val adjAdderExp = largeExp - sumOverflow.asSInt

  assert(adjAdderExp.getWidth.asUInt === maxExponentBits.U)

  val adjAdderFrac =
    Mux(sumOverflow, adderFrac(maxAdderFractionBits - 1, 1), adderFrac(maxAdderFractionBits - 2, 0))

  when(sumOverflow) {
    assert(adjAdderFrac === (adderFrac >> 1))  //
  }

  assert((adjAdderFrac.getWidth).asUInt === (maxAdderFractionBits - 1).asUInt) // P

  val sumStickyBit = sumOverflow & adderFrac(0)

  when(!sumOverflow) {
    assert(!sumStickyBit)
  }

  val normalizationFactor = countLeadingZeros(adjAdderFrac)

  assert(normalizationFactor <= (2.U << maxAdderFractionBits - 1).asUInt)
  assert(normalizationFactor >= 0.U)

  val normExponent = adjAdderExp - normalizationFactor.asSInt

  assert(normExponent.getWidth.asUInt === maxExponentBits.U)

  val normFraction = adjAdderFrac << normalizationFactor.asUInt

  result.isNaR    := num1.isNaR || num2.isNaR
  result.isZero   := (num1.isZero && num2.isZero) | (adderFrac === 0.U)
  result.sign     := largeSign
  result.exponent := normExponent
  result.fraction := normFraction(maxAdderFractionBits - 2, maxAdderFractionBits - maxFractionBitsWithHiddenBit - 1)

  io.trailingBits := normFraction(maxAdderFractionBits - maxFractionBitsWithHiddenBit - 2, maxAdderFractionBits - maxFractionBitsWithHiddenBit - trailingBitCount - 1)
  io.stickyBit    := sumStickyBit | normFraction(stickyBitCount - 1, 0).orR

  io.out := result
}

class PositAdd(val nbits: Int, val es: Int) extends Module with HasHardPositParams {
  require(nbits > es)
  require(es >= 0)

  val io = IO(new Bundle{
    val num1   = Input(UInt(nbits.W))
    val num2   = Input(UInt(nbits.W))
    val sub    = Input(Bool())

    val isZero = Output(Bool())
    val isNaR  = Output(Bool())
    val out    = Output(UInt(nbits.W))
  })

  val positAddCore = Module(new PositAddCore(nbits, es))

  val num1Extractor = Module(new PositExtractor(nbits, es))
  val num2Extractor = Module(new PositExtractor(nbits, es))
  num1Extractor.io.in := io.num1
  num2Extractor.io.in := io.num2

  positAddCore.io.num1 := num1Extractor.io.out
  positAddCore.io.num2 := num2Extractor.io.out
  positAddCore.io.sub  := io.sub

  private val positGenerator = Module(new PositGenerator(nbits, es))
  positGenerator.io.in           := positAddCore.io.out
  positGenerator.io.trailingBits := positAddCore.io.trailingBits
  positGenerator.io.stickyBit    := positAddCore.io.stickyBit

  io.isZero := positAddCore.io.out.isZero | isZero(positGenerator.io.out)
  io.isNaR  := positAddCore.io.out.isNaR  | isNaR(positGenerator.io.out)
  io.out    := positGenerator.io.out
}