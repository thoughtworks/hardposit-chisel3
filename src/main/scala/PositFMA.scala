package hardposit

import chisel3._
import chisel3.util.MuxCase

class PositFMA(totalBits: Int, es: Int) extends Module {
  private val maxProductFractionBits = 2 * (totalBits + 1)
  private val NaR = (1.U << (totalBits - 1)).asUInt()

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

  private val num1Extractor = Module(new PositExtractor(totalBits, es))
  num1Extractor.io.in := io.num1
  private val num1 = num1Extractor.io.out

  private val num2Extractor = Module(new PositExtractor(totalBits, es))
  num2Extractor.io.in := io.num2
  private val num2 = num2Extractor.io.out

  private val num3Extractor = Module(new PositExtractor(totalBits, es))
  num3Extractor.io.in := io.num3
  private val num3 = num3Extractor.io.out

  io.isNaR := num1.isNaR || num2.isNaR || num3.isNaR
  io.isZero := (num1.isZero || num2.isZero) && num3.isZero

  private val productSign = num1.sign ^ num2.sign ^ io.negate
  private val addendSign = num3.sign ^ io.negate ^ io.sub

  private val productExponent = num1.exponent + num2.exponent
  private val productFraction = WireInit(UInt(maxProductFractionBits.W), num1.fraction * num2.fraction)

  private val prodOverflow = productFraction(maxProductFractionBits - 1)
  private val normProductFraction = (productFraction >> prodOverflow.asUInt()).asUInt()
  private val normProductExponent = productExponent + Mux(prodOverflow, 1.S, 0.S)
  private val prodStickyBit = Mux(prodOverflow, productFraction(0), false.B)

  private val addendFraction = (num3.fraction << totalBits).asUInt
  private val addendExponent = num3.exponent

  private val isAddendLargerThanProduct = (addendExponent > normProductExponent) | (addendExponent === normProductExponent && (addendFraction > normProductFraction))

  private val largerExponent = Mux(isAddendLargerThanProduct, addendExponent, normProductExponent)
  private val largerFraction = Mux(isAddendLargerThanProduct, addendFraction, normProductFraction)
  private val largerSign = Mux(isAddendLargerThanProduct, addendSign, productSign)

  private val smallerExponent = Mux(isAddendLargerThanProduct, normProductExponent, addendExponent)
  private val smallerFraction = Mux(isAddendLargerThanProduct, normProductFraction, addendFraction)
  private val smallerSign = Mux(isAddendLargerThanProduct, productSign, addendSign)

  private val exponentDifference = (largerExponent - smallerExponent).asUInt()
  private val shiftedSmallerFraction = (smallerFraction >> exponentDifference).asUInt()
  private val smallFractionStickyBit = (smallerFraction & ((1.U << exponentDifference) - 1.U)).orR()

  private val isAddition = ~(largerSign ^ smallerSign)
  private val signedSmallerFraction = Mux(isAddition, shiftedSmallerFraction, ~shiftedSmallerFraction + 1.U)
  private val fmaFraction = WireInit(UInt(maxProductFractionBits.W), largerFraction +& signedSmallerFraction)

  private val sumOverflow = fmaFraction(maxProductFractionBits - 1)
  private val adjFmaFraction = Mux(isAddition, fmaFraction >> sumOverflow.asUInt(), fmaFraction(maxProductFractionBits - 2, 0))
  private val adjFmaExponent = largerExponent + Mux(isAddition & sumOverflow, 1.S, 0.S)
  private val sumStickyBit = Mux(isAddition & sumOverflow, fmaFraction(0), false.B)

  private val normalizationFactor = MuxCase(0.S, Array.range(0, maxProductFractionBits - 2).map(index => {
    (adjFmaFraction(maxProductFractionBits - 2, maxProductFractionBits - index - 2) === 1.U) -> index.S
  }))

  private val normFmaExponent = adjFmaExponent - normalizationFactor
  private val normFmaFraction = adjFmaFraction << normalizationFactor.asUInt()

  private val result = Wire(new unpackedPosit(totalBits, es))
  result.isNaR := num1.isNaR || num2.isNaR || num3.isNaR
  result.isZero := (num1.isZero || num2.isZero) && num3.isZero
  result.sign := largerSign
  result.exponent := normFmaExponent
  result.fraction := (normFmaFraction >> totalBits).asUInt()
  result.stickyBit := prodStickyBit | sumStickyBit | smallFractionStickyBit | normFmaFraction(totalBits - 1, 0).orR()

  private val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.in <> result

  io.isNaR := result.isNaR || (positGenerator.io.out === NaR)
  io.isZero := result.isZero || (positGenerator.io.out === 0.U)
  io.out := Mux(result.isNaR, NaR, positGenerator.io.out)
}
