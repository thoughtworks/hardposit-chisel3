import chisel3._
import chisel3.util.Cat

class PositMul(totalBits: Int, es: Int) extends Module {

  val io = IO(new Bundle {
    val num1 = Input(UInt(totalBits.W))
    val num2 = Input(UInt(totalBits.W))
    val out = Output(UInt(totalBits.W))
  })

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

  private val finalFraction = num1Fraction * num2Fraction
  private val finalExponent = num1Exponent + num2Exponent

  private val maxFractionBits = 2 * (totalBits + 1)
  private val positGenerator = Module(new PositGeneratorWrapper(totalBits, es))
  positGenerator.io.sign := num1Sign ^ num2Sign
  positGenerator.io.exponent := finalExponent + 1.S
  positGenerator.io.decimal := finalFraction(maxFractionBits - 1)
  positGenerator.io.fraction := finalFraction(maxFractionBits - 2, totalBits + 1)

  io.out := positGenerator.io.posit
}
