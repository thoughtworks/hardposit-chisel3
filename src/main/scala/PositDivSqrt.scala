package hardposit

import chisel3._
import chisel3.util.{Cat, log2Ceil, log2Up}

class PositDivSqrt(totalBits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val validIn = Input(Bool())
    val readyIn = Output(Bool())

    val sqrtOp = Input(Bool())
    val num1 = Input(UInt(totalBits.W))
    val num2 = Input(UInt(totalBits.W))

    val validOut_div = Output(Bool())
    val validOut_sqrt = Output(Bool())
    val isNaR = Output(Bool())
    val isZero = Output(Bool())
    val out = Output(UInt(totalBits.W))
    val exceptions = Output(UInt(5.W))
  })
  private val NaR = 1.U << (totalBits - 1)

  private val cycleCount = RegInit(0.U(log2Up(totalBits + 3).W))

  private val sqrtOp_stored = Reg(Bool())
  private val isNaR_out = Reg(Bool())
  private val isZero_out = Reg(Bool())
  private val exceptions_out = RegInit(0.U(5.W))

  private val resultSign = Reg(Bool())
  private val resultExponent = Reg(SInt((log2Ceil(math.pow(2, es).toInt * totalBits) + es + 2).W))
  private val resultFraction = RegInit(0.U((totalBits + 2).W))

  private val remLo = RegInit(0.U((totalBits + 2).W))
  private val remHi = RegInit(0.U((totalBits + 2).W))
  private val divisor = RegInit(0.U((totalBits + 2).W))

  val num1Fields = Module(new PositExtractor(totalBits, es))
  num1Fields.io.num := io.num1
  private val num1Sign = num1Fields.io.sign
  private val num1Exponent = num1Fields.io.exponent
  private val num1Fraction = num1Fields.io.fraction

  val num2Fields = Module(new PositExtractor(totalBits, es))
  num2Fields.io.num := io.num2
  private val num2Sign = num2Fields.io.sign
  private val num2Exponent = num2Fields.io.exponent
  private val num2Fraction = num2Fields.io.fraction

  private val isNaR = Mux(io.sqrtOp, num1Sign | num1Fields.io.isNaR, num1Fields.io.isNaR)
  private val isZero = Mux(io.sqrtOp, num1Fields.io.isZero, num1Fields.io.isZero | num2Fields.io.isNaR)
  private val divideByZero = !io.sqrtOp && num2Fields.io.isZero
  private val specialCase = isNaR || isZero || divideByZero
  private val exponentDifference = num1Exponent - num2Exponent

  private val idle = cycleCount === 0.U
  private val readyIn = cycleCount <= 1.U

  private val starting = readyIn && io.validIn
  private val started_normally = starting && !specialCase

  private val radicand = Mux(io.sqrtOp && num1Exponent(0).asBool(), num1Fraction << 1, num1Fraction)

  when(!idle | io.validIn) {
    cycleCount := Mux(starting && specialCase, 1.U, 0.U |
      Mux(started_normally, (totalBits + 1).U, 0.U)) |
      Mux(!idle, cycleCount - 1.U, 0.U)
  }

  io.readyIn := readyIn

  when(starting) {
    sqrtOp_stored := io.sqrtOp
    isNaR_out := isNaR
    isZero_out := isZero
    exceptions_out := Mux(divideByZero, 8.U, 0.U)
  }

  when(started_normally) {
    resultSign := Mux(io.sqrtOp, false.B, num1Sign ^ num2Sign)
    resultExponent := Mux(io.sqrtOp, num1Exponent >> 1, exponentDifference)
  }

  when(started_normally && !io.sqrtOp) {
    divisor := num2Fraction
  }

  remLo := Mux(readyIn && io.sqrtOp, radicand << 2, 0.U) |
    Mux(!readyIn && sqrtOp_stored, remLo << 2, 0.U)

  private val rem = Mux(readyIn && io.sqrtOp, radicand(totalBits + 1, totalBits), 0.U) |
    Mux(readyIn && !io.sqrtOp, radicand.asUInt(), 0.U) |
    Mux(!readyIn && sqrtOp_stored, remHi << 2.U | remLo >> totalBits.U, 0.U) |
    Mux(!readyIn && !sqrtOp_stored, remHi << 1.U, 0.U)


  private val testDiv = Mux(readyIn && io.sqrtOp, 1.U, 0.U) |
    Mux(readyIn && !io.sqrtOp, num2Fraction, 0.U) |
    Mux(!readyIn && sqrtOp_stored, Cat(resultFraction << 1.U, 1.U), 0.U) |
    Mux(!readyIn && !sqrtOp_stored, divisor, 0.U)

  private val testRem = rem.zext - testDiv.zext
  private val nextBit = testRem >= 0.S

  when(started_normally || cycleCount > 2.U) {
    remHi := Mux(nextBit, testRem.asUInt(), rem)
  }

  resultFraction := Mux(started_normally || !readyIn, Cat(resultFraction, nextBit.asUInt()), 0.U)

  private val validOut = cycleCount === 1.U

  private val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.decimal := resultFraction(totalBits + 1, totalBits)
  positGenerator.io.fraction := resultFraction(totalBits - 1, 0)
  positGenerator.io.exponent := resultExponent
  positGenerator.io.sign := resultSign

  private val out = Mux(isZero_out, 0.U, Mux(isNaR_out || divideByZero, NaR, positGenerator.io.posit))

  io.validOut_div := validOut && !sqrtOp_stored
  io.validOut_sqrt := validOut && sqrtOp_stored
  io.isNaR := isNaR_out
  io.isZero := isZero_out
  io.exceptions := exceptions_out
  io.out := out
}
