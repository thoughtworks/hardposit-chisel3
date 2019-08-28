import chisel3._
import chisel3.util.MuxCase
import firrtl.{ExecutionOptionsManager, HasFirrtlOptions}

class PositAdd(totalBits: Int, es: Int) extends PositArithmeticModule(totalBits) {
  require(totalBits > es)
  require(es >= 0)

  private val num1Fields = Module(new FieldsExtractor(totalBits, es))
  num1Fields.io.num := io.num1
  private val num1Sign = num1Fields.io.sign
  private val num1Exponent = num1Fields.io.exponent
  private val num1Fraction = num1Fields.io.fraction

  private val num2Fields = Module(new FieldsExtractor(totalBits, es))
  num2Fields.io.num := io.num2
  private val num2Sign = num2Fields.io.sign
  private val num2Exponent = num2Fields.io.exponent
  private val num2Fraction = num2Fields.io.fraction

  private val num1IsHigherExponent = num1Exponent > num2Exponent

  private val highestExponent = Mux(num1IsHigherExponent, num1Exponent, num2Exponent)
  private val highestExponentSign = Mux(num1IsHigherExponent, num1Sign, num2Sign)
  private val highestExponentFraction = Mux(num1IsHigherExponent, num1Fraction, num2Fraction)

  private val smallestExponent = Mux(num1IsHigherExponent, num2Exponent, num1Exponent)
  private val smallestExponentSign = Mux(num1IsHigherExponent, num2Sign, num1Sign)
  private val smallestExponentFraction = Mux(num1IsHigherExponent, num2Fraction, num1Fraction)

  private val exponentDifference = highestExponent - smallestExponent

  private val shiftingCombinations = Array.range(0, totalBits + 1).map(index => {
    (exponentDifference.asUInt() === index.U) -> smallestExponentFraction(totalBits, index)
  })

  private val smallestExponentFractionAfterAdjustment = MuxCase(0.U((totalBits + 2).W), shiftingCombinations)

  private val addedFraction = highestExponentFraction + smallestExponentFractionAfterAdjustment
  private val finalAddedDecimal = addedFraction(totalBits + 1)
  private val finalAddedExponent = highestExponent + 1.S
  private val finalAddedFraction = addedFraction(totalBits, 1)

  private val isHighestExponentFractionHigher = highestExponentFraction >= smallestExponentFractionAfterAdjustment(totalBits, 0)
  private val subtractedFraction = Mux(isHighestExponentFractionHigher,
    highestExponentFraction - smallestExponentFractionAfterAdjustment,
    smallestExponentFractionAfterAdjustment - highestExponentFraction
  )
  private val finalSubtractedDecimal = subtractedFraction(totalBits)
  private val finalSubtractedExponent = highestExponent
  private val finalSubtractedFraction = subtractedFraction(totalBits - 1, 0)
  private val finalSubtractedSign = Mux(isHighestExponentFractionHigher, highestExponentSign, smallestExponentSign)

  private val isSameSignAddition = !(highestExponentSign ^ smallestExponentSign)
  private val positGenerator = Module(new PositGeneratorWrapper(totalBits, es))
  positGenerator.io.decimal := Mux(isSameSignAddition, finalAddedDecimal, finalSubtractedDecimal)
  positGenerator.io.sign := Mux(isSameSignAddition, highestExponentSign, finalSubtractedSign)
  positGenerator.io.exponent := Mux(isSameSignAddition, finalAddedExponent, finalSubtractedExponent)
  positGenerator.io.fraction := Mux(isSameSignAddition, finalAddedFraction, finalSubtractedFraction)
  private val infiniteRepresentation: UInt = math.pow(2, totalBits - 1).toInt.U

  private def check(num1: UInt, num2: UInt): Bool = num1 === 0.U || num2 === infiniteRepresentation

  io.out := Mux(check(io.num1, io.num2), io.num2, Mux(check(io.num2, io.num1), io.num1, positGenerator.io.posit))
  io.isNaN := false.B
}

object PositAdd extends App {
  val optionsManager = new ExecutionOptionsManager("chisel3") with HasChiselExecutionOptions with HasFirrtlOptions
  optionsManager.setTargetDirName("soc/chisel_output")
  Driver.execute(optionsManager, () => new PositAdd(8, 2))
}