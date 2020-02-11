package hardposit

import chisel3._
import chisel3.util.log2Ceil

abstract class PositArithmeticModule(totalBits: Int) extends Module {
  val io = IO(new PositArithmeticBundle(totalBits))
}

class PositArithmeticBundle(val totalBits: Int) extends Bundle {
  val num1 = Input(UInt(totalBits.W))
  val num2 = Input(UInt(totalBits.W))
  val out = Output(UInt(totalBits.W))
  val isNaN = Output(Bool())
}

class unpackedPosit(val totalBits: Int, val es: Int) extends Bundle {
  val sign = Bool()
  val exponent = SInt((log2Ceil(math.pow(2, es).toInt * totalBits) + es + 2).W)
  val fraction = UInt((totalBits + 1).W)
  val isZero = Bool()
  val isNaR = Bool()

  override def cloneType =
    new unpackedPosit(totalBits, es).asInstanceOf[this.type]
}