import chisel3._

class PositCompare(totalBits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val num1 = Input(UInt(totalBits.W))
    val num2 = Input(UInt(totalBits.W))
    val lt = Output(Bool())
    val eq = Output(Bool())
    val ge = Output(Bool())
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

  val eqExp: Bool = num1Exponent === num2Exponent

  val eqMag: Bool = eqExp && (num1Fraction === num2Fraction)
  val ltMag: Bool = (num1Exponent < num2Exponent) || (eqExp && (num1Fraction < num2Fraction))

  io.lt := (num1Sign && !num2Sign) || ((num1Sign && !ltMag && !eqMag) || (!num2Sign && ltMag))
  io.eq := eqMag && (num1Sign === num2Sign)
  io.ge := !io.lt && !io.eq
}
