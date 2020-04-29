package hardposit

import chisel3._

class PositCompare(totalBits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val num1 = Input(SInt(totalBits.W))
    val num2 = Input(SInt(totalBits.W))
    val lt = Output(Bool())
    val eq = Output(Bool())
    val gt = Output(Bool())
  })

  io.lt := (io.num1 < io.num2)
  io.eq := (io.num1 === io.num2)
  io.gt := (!io.lt && !io.eq)
}
