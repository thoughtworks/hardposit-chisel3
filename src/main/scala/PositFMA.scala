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

  private val NaR = math.pow(2, totalBits - 1).toInt.U

  private val num1Fields = Module(new PositExtractor(totalBits, es))
  num1Fields.io.num := io.num1
  private val num1Sign = num1Fields.io.sign
  private val num1Exponent = num1Fields.io.exponent
  private val num1Fraction = num1Fields.io.fraction

  private val num2Fields = Module(new PositExtractor(totalBits, es))
  num2Fields.io.num := io.num2
  private val num2Sign = num2Fields.io.sign
  private val num2Exponent = num2Fields.io.exponent
  private val num2Fraction = num2Fields.io.fraction

  private val num3Fields = Module(new PositExtractor(totalBits, es))
  num3Fields.io.num := io.num3
  private val num3Sign = num3Fields.io.sign
  private val num3Exponent = num3Fields.io.exponent
  private val num3Fraction = num3Fields.io.fraction

  io.isNaR := num1Fields.io.isNaR || num2Fields.io.isNaR || num3Fields.io.isNaR
  io.isZero := (num1Fields.io.isZero || num2Fields.io.isZero) && num3Fields.io.isZero

  private val productSign = num1Sign ^ num2Sign ^ io.negate
  private val addendSign = num3Sign ^ io.negate ^ io.sub

  private val productExponent = num1Exponent + num2Exponent
  private val productFraction = num1Fraction * num2Fraction

  private val maxProductFractionBits = 2 * (totalBits + 1)

  private val addendFraction = (num3Fraction << totalBits).asUInt
  private val addendExponent = num3Exponent

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

  private val resultExponent = Mux(isAddition, largerExponent + 1.S, largerExponent)
  private val resultFraction = Mux(isAddition, addedFraction(maxProductFractionBits - 2, totalBits + 1), subtractedFraction(maxProductFractionBits - 3, totalBits))
  private val resultDecimal = Mux(isAddition, addedFraction(maxProductFractionBits - 1), subtractedFraction(maxProductFractionBits - 2))
  private val resultSign = largerSign

  private val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.decimal := resultDecimal
  positGenerator.io.sign := resultSign
  positGenerator.io.exponent := resultExponent
  positGenerator.io.fraction := resultFraction

  io.isNaR := num1Fields.io.isNaR || num2Fields.io.isNaR || num3Fields.io.isNaR || (positGenerator.io.posit === NaR)
  io.isZero := (num1Fields.io.isZero || num2Fields.io.isZero) && num3Fields.io.isZero || (positGenerator.io.posit === 0.U)

  io.out := Mux(io.isNaR, NaR, positGenerator.io.posit)
}
