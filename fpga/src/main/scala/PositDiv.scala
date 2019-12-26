package hardposit

import chisel3._

class PositDiv(totalBits: Int, es: Int) extends PositArithmeticModule(totalBits) {
  private val positMul = Module(new PositMul(totalBits, es))
  positMul.io.num1 := io.num1
  positMul.io.num2 := math.pow(2, totalBits - 1).toInt.U - io.num2
  io.out := positMul.io.out
  io.isNaN := positMul.io.isNaN
}
