package hardposit

import chisel3._

class PositMul(totalBits: Int, es: Int) extends PositArithmeticModule(totalBits) {

  private val maxFractionBits = 2 * (totalBits + 1)

  private val num1Extractor = Module(new PositExtractor(totalBits, es))
  num1Extractor.io.in := io.num1
  private val num1 = num1Extractor.io.out

  private val num2Extractor = Module(new PositExtractor(totalBits, es))
  num2Extractor.io.in := io.num2
  private val num2 = num2Extractor.io.out

  private val result = Wire(new unpackedPosit(totalBits, es))
  result.isNaR := num1.isNaR || num2.isNaR
  result.isZero := num1.isZero && num2.isZero
  result.sign := num1.sign ^ num2.sign
  result.exponent := num1.exponent + num2.exponent + 1.S
  result.fraction := (num1.fraction * num2.fraction)(maxFractionBits - 1, totalBits + 1)

  private val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.in <> result

  private val NaR= 1.U << (totalBits - 1)
  private def checkSame(num1:UInt,num2:UInt,number:UInt):Bool = num1 === number || num2 === number

  io.out := Mux(checkSame(io.num1,io.num2,0.U), 0.U,
            Mux(checkSame(io.num1,io.num2,NaR), NaR,
              positGenerator.io.out))

  private def check(num1: UInt,num2: UInt) : Bool = num1 === 0.U && num2 === NaR

  io.isNaN := check(io.num1,io.num2) || check(io.num2,io.num1)
}
