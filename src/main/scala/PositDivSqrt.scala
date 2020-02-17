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

  private val result = RegInit(0.U.asTypeOf(new unpackedPosit(totalBits, es)))
  private val remLo = RegInit(0.U((totalBits + 2).W))
  private val remHi = RegInit(0.U((totalBits + 2).W))
  private val divisor = RegInit(0.U((totalBits + 2).W))

  val num1Extractor = Module(new PositExtractor(totalBits, es))
  num1Extractor.io.in := io.num1
  private val num1 = num1Extractor.io.out

  val num2Extractor = Module(new PositExtractor(totalBits, es))
  num2Extractor.io.in := io.num2
  private val num2 = num2Extractor.io.out

  private val isNaR = Mux(io.sqrtOp, num1.sign | num1.isNaR, num1.isNaR)
  private val isZero = Mux(io.sqrtOp, num1.isZero, num1.isZero | num2.isNaR)
  private val divideByZero = !io.sqrtOp && num2.isZero
  private val specialCase = isNaR || isZero || divideByZero
  private val exponentDifference = num1.exponent - num2.exponent

  private val idle = cycleCount === 0.U
  private val readyIn = cycleCount <= 1.U

  private val starting = readyIn && io.validIn
  private val started_normally = starting && !specialCase

  private val radicand = Mux(io.sqrtOp && num1.exponent(0).asBool(), num1.fraction << 1, num1.fraction)

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
    result.sign := Mux(io.sqrtOp, false.B, num1.sign ^ num2.sign)
    result.exponent := Mux(io.sqrtOp, num1.exponent >> 1, exponentDifference)
  }

  when(started_normally && !io.sqrtOp) {
    divisor := num2.fraction
  }

  remLo := Mux(readyIn && io.sqrtOp, radicand << 2, 0.U) |
    Mux(!readyIn && sqrtOp_stored, remLo << 2, 0.U)

  private val rem = Mux(readyIn && io.sqrtOp, radicand(totalBits + 1, totalBits), 0.U) |
    Mux(readyIn && !io.sqrtOp, radicand.asUInt(), 0.U) |
    Mux(!readyIn && sqrtOp_stored, remHi << 2.U | remLo >> totalBits.U, 0.U) |
    Mux(!readyIn && !sqrtOp_stored, remHi << 1.U, 0.U)


  private val testDiv = Mux(readyIn && io.sqrtOp, 1.U, 0.U) |
    Mux(readyIn && !io.sqrtOp, num2.fraction, 0.U) |
    Mux(!readyIn && sqrtOp_stored, Cat(result.fraction << 1.U, 1.U), 0.U) |
    Mux(!readyIn && !sqrtOp_stored, divisor, 0.U)

  private val testRem = rem.zext - testDiv.zext
  private val nextBit = testRem >= 0.S

  when(started_normally || cycleCount > 2.U) {
    remHi := Mux(nextBit, testRem.asUInt(), rem)
  }

  result.fraction := Mux(started_normally || !readyIn, Cat(result.fraction, nextBit.asUInt()), 0.U)
  result.isNaR := isNaR_out
  result.isZero := isZero_out

  private val validOut = cycleCount === 1.U

  private val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.in <> result

  private val out = Mux(isZero_out, 0.U, Mux(isNaR_out || divideByZero, NaR, positGenerator.io.out))

  io.validOut_div := validOut && !sqrtOp_stored
  io.validOut_sqrt := validOut && sqrtOp_stored
  io.isNaR := result.isNaR
  io.isZero := result.isZero
  io.exceptions := exceptions_out
  io.out := out
}
