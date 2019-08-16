import chisel3._
import chisel3.util.log2Ceil

class FieldsExtractor(totalBits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val num = Input(UInt(totalBits.W))
    val sign = Output(Bool())
    val exponent = Output(SInt((log2Ceil(math.pow(2, es).toInt * totalBits) + es + 1).W))
    val fraction = Output(UInt((totalBits + 1).W))
  })

  private val num = Mux(io.num(totalBits - 1), -io.num, io.num)

  io.sign := io.num(totalBits - 1)

  private val exponentExtractor = Module(new ExponentExtractor(totalBits, es))
  exponentExtractor.io.num := num
  private val totalLengthAfterExponent = exponentExtractor.io.totalLength
  io.exponent := exponentExtractor.io.exponent

  private val fractionExtractor = Module(new FractionExtractor(totalBits))
  fractionExtractor.io.noOfUsedBits := totalLengthAfterExponent + 1.U
  fractionExtractor.io.num := num
  io.fraction := fractionExtractor.io.fraction
}
