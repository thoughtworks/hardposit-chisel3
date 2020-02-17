package hardposit

import chisel3._

class PositFMA(totalBits: Int, es: Int) extends Module {
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

  private val NaR = 1.U << (totalBits - 1)

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
  private val productFraction = num1.fraction * num2.fraction

  private val maxProductFractionBits = 2 * (totalBits + 1)

  private val addendFraction = (num3.fraction << totalBits).asUInt
  private val addendExponent = num3.exponent

  private val isAddendLargerThanProduct = (addendExponent > productExponent) || (addendExponent === productExponent && (addendFraction > productFraction))

  private val largerExponent = Mux(isAddendLargerThanProduct, addendExponent, productExponent)
  private val largerFraction = Mux(isAddendLargerThanProduct, addendFraction, productFraction)
  private val largerSign = Mux(isAddendLargerThanProduct, addendSign, productSign)

  private val smallerExponent = Mux(isAddendLargerThanProduct, productExponent, addendExponent)
  private val smallerFraction = Mux(isAddendLargerThanProduct, productFraction, addendFraction)
  private val smallerSign = Mux(isAddendLargerThanProduct, productSign, addendSign)

  private val exponentDifference = (largerExponent - smallerExponent).asUInt()
  private val shiftedSmallerFraction = (smallerFraction >> exponentDifference).asUInt()

  private val isAddition = !(largerSign ^ smallerSign)
  private val addedFraction = largerFraction + shiftedSmallerFraction
  private val subtractedFraction = largerFraction - shiftedSmallerFraction

  private val result = Wire(new unpackedPosit(totalBits, es))
  result.isNaR := num1.isNaR || num2.isNaR || num3.isNaR
  result.isZero := (num1.isZero || num2.isZero) && num3.isZero
  result.sign := largerSign
  result.exponent := Mux(isAddition, largerExponent + 1.S, largerExponent)
  result.fraction := Mux(isAddition, addedFraction(maxProductFractionBits - 1, totalBits + 1), subtractedFraction(maxProductFractionBits - 2, totalBits))

  private val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.in <> result

  io.isNaR := result.isNaR || (positGenerator.io.out === NaR)
  io.isZero := result.isZero || (positGenerator.io.out === 0.U)
  io.out := Mux(result.isNaR, NaR, positGenerator.io.out)
}
