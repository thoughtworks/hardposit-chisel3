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

class unpackedPosit(val totalBits: Int, val es: Int) extends Bundle with HasHardPositParams {

  val sign = Bool()
  val exponent = SInt(maxExponentBits.W)
  val fraction = UInt(maxFractionBitsWithHiddenBit.W) //TODO Transfer only fraction bits without hidden bit
  val isZero = Bool()
  val isNaR = Bool()

  override def cloneType =
    new unpackedPosit(totalBits, es).asInstanceOf[this.type]
}

trait HasHardPositParams {
  val totalBits: Int
  val es: Int

  def maxExponentBits: Int = log2Ceil(totalBits) + es + 2

  def maxFractionBits: Int = if (es + 2 >= totalBits) 0 else totalBits - 3 - es

  def maxFractionBitsWithHiddenBit: Int = maxFractionBits + 1

  def maxProductFractionBits: Int = 2 * maxFractionBitsWithHiddenBit

  def NaR: UInt = (1.U << (totalBits - 1)).asUInt()

  def zero: UInt = 0.U(totalBits.W)

  def isNaR(num: UInt): Bool = num(totalBits - 1) & ~num(totalBits - 2, 0).orR()

  def isZero(num: UInt): Bool = ~num.orR()

  def trailingBitCount = 2
}