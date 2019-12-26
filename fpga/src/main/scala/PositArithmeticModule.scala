package hardposit

import chisel3._

abstract class PositArithmeticModule(totalBits: Int) extends Module {
  val io = IO(new PositArithmeticBundle(totalBits))
}

class PositArithmeticBundle(val totalBits: Int) extends Bundle {
  val num1 = Input(UInt(totalBits.W))
  val num2 = Input(UInt(totalBits.W))
  val out = Output(UInt(totalBits.W))
  val isNaN = Output(Bool())
}
