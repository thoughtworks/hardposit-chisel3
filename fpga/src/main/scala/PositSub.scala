import chisel3._

class PositSub(totalBits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val num1 = Input(UInt(totalBits.W))
    val num2 = Input(UInt(totalBits.W))
    val out = Output(UInt(totalBits.W))
    val isNaN = Output(Bool())
  })

  private val positAdd = Module(new PositAdd(totalBits, es))
  positAdd.io.num1 := io.num1
  positAdd.io.num2 := 0.U - io.num2

  private val infiniteRepresentation = math.pow(2, totalBits - 1).toInt.U
  io.out := positAdd.io.out
  io.isNaN := io.num1 === infiniteRepresentation && io.num2 === infiniteRepresentation
}
