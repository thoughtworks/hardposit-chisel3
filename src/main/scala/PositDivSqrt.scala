package hardposit

import chisel3._
import chisel3.util.{Cat, log2Up}

class PositDivSqrtCore(val nbits: Int, val es: Int) extends Module with HasHardPositParams {
  override val desiredName = s"posit_${nbits}_divsqrt_core"
  val io = IO(new Bundle {
    val validIn = Input(Bool())
    val readyIn = Output(Bool())

    val sqrtOp = Input(Bool())
    val num1   = Input(new unpackedPosit(nbits, es))
    val num2   = Input(new unpackedPosit(nbits, es))

    val validOut_div  = Output(Bool())
    val validOut_sqrt = Output(Bool())
    val exceptions    = Output(UInt(5.W))

    val trailingBits = Output(UInt(trailingBitCount.W))
    val stickyBit    = Output(Bool())
    val out          = Output(new unpackedPosit(nbits, es))
  })

  val num1 = io.num1
  val num2 = io.num2

  val cycleCount = RegInit(0.U(log2Up(maxDividerFractionBits + 1).W))

  val sqrtOp_stored = Reg(Bool())
  val isNaR_out     = Reg(Bool())
  val isZero_out    = Reg(Bool())
  val exec_out      = RegInit(0.U(5.W))
  val sign_out      = Reg(Bool())
  val divSqrtExp    = RegInit(0.S(maxExponentBits.W))
  val divSqrtFrac   = RegInit(0.U(maxDividerFractionBits.W))
  val frac_out      = WireInit(0.U(maxDividerFractionBits.W))
  val exp_out       = WireInit(0.S(maxExponentBits.W))

  val result  = WireInit(0.U.asTypeOf(new unpackedPosit(nbits, es)))
  val remLo   = RegInit(0.U((maxFractionBitsWithHiddenBit + 1).W))
  val remHi   = RegInit(0.U(maxDividerFractionBits.W))
  val divisor = RegInit(0.U(maxDividerFractionBits.W))

  val divZ        = !io.sqrtOp && num2.isZero
  val isNaR       = Mux(io.sqrtOp, num1.sign | num1.isNaR, num1.isNaR | num2.isNaR | divZ)
  val isZero      = num1.isZero
  val specialCase = isNaR | isZero
  val expDiff     = num1.exponent - num2.exponent

  val idle    = cycleCount === 0.U
  val readyIn = cycleCount <= 1.U

  val starting         = readyIn && io.validIn
  val started_normally = starting && !specialCase

  val radicand = Mux(io.sqrtOp && num1.exponent(0).asBool, num1.fraction << 1, num1.fraction)

  when(!idle | io.validIn) {
    cycleCount := Mux(starting && specialCase, 2.U, 0.U) |
                  Mux(started_normally, maxDividerFractionBits.U, 0.U) |
                  Mux(!idle, cycleCount - 1.U, 0.U)
  }

  io.readyIn := readyIn

  when(starting) {
    sqrtOp_stored  := io.sqrtOp
    isNaR_out      := isNaR
    isZero_out     := isZero
    exec_out       := Mux(divZ, 8.U, 0.U)
  }

  when(started_normally) {
    sign_out   := Mux(io.sqrtOp, false.B, num1.sign ^ num2.sign)
    divSqrtExp := Mux(io.sqrtOp, num1.exponent >> 1, expDiff)
  }

  when(started_normally & ~io.sqrtOp) {
    divisor := num2.fraction
  }

  remLo := Mux(readyIn && io.sqrtOp, radicand << 2, 0.U) |
           Mux(!readyIn && sqrtOp_stored, remLo << 2, 0.U)

  val rem = Mux(readyIn && io.sqrtOp, radicand(maxFractionBitsWithHiddenBit, maxFractionBitsWithHiddenBit - 1), 0.U) |
    Mux(readyIn && !io.sqrtOp, radicand.asUInt, 0.U) |
    Mux(!readyIn && sqrtOp_stored, remHi << 2.U | remLo >> maxFractionBits.U, 0.U) |
    Mux(!readyIn && !sqrtOp_stored, remHi << 1.U, 0.U)


  val testDiv =
    Mux(readyIn && io.sqrtOp, 1.U, 0.U) |
    Mux(readyIn && !io.sqrtOp, num2.fraction, 0.U) |
    Mux(!readyIn && sqrtOp_stored, Cat(divSqrtFrac << 1.U, 1.U), 0.U) |
    Mux(!readyIn && !sqrtOp_stored, divisor, 0.U)

  val testRem = rem.zext - testDiv.zext
  val nextBit = testRem >= 0.S

  when(started_normally || cycleCount > 2.U) {
    remHi := Mux(nextBit, testRem.asUInt, rem)
  }

  val nextFraction = Cat(divSqrtFrac, nextBit.asUInt)
  divSqrtFrac := Mux(started_normally, nextBit, 0.U) |
             Mux(!readyIn, nextFraction, 0.U)

  val normReq = !divSqrtFrac(maxDividerFractionBits - 1)
  frac_out := Mux(normReq, Cat(divSqrtFrac, 0.U(1.W)), divSqrtFrac)
  exp_out  := divSqrtExp + normReq.asSInt

  result.isNaR    := isNaR_out
  result.isZero   := isZero_out
  result.exponent := exp_out
  result.sign     := sign_out
  result.fraction := frac_out(maxDividerFractionBits - 1, maxDividerFractionBits - maxFractionBitsWithHiddenBit)

  val validOut = cycleCount === 1.U

  io.validOut_div  := validOut && !sqrtOp_stored
  io.validOut_sqrt := validOut && sqrtOp_stored
  io.exceptions    := exec_out

  io.trailingBits := frac_out(maxDividerFractionBits - maxFractionBitsWithHiddenBit - 1, trailingBitCount)
  io.stickyBit    := frac_out(trailingBitCount - 1, 0).orR | remHi.orR

  io.out := result
}

class PositDivSqrt(val nbits: Int, val es: Int) extends Module with HasHardPositParams {
  override val desiredName = s"posit_${nbits}_divsqrt"
  val io = IO(new Bundle {
    val validIn = Input(Bool())
    val readyIn = Output(Bool())

    val sqrtOp = Input(Bool())
    val num1   = Input(UInt(nbits.W))
    val num2   = Input(UInt(nbits.W))

    val isZero        = Output(Bool())
    val isNaR         = Output(Bool())
    val validOut_div  = Output(Bool())
    val validOut_sqrt = Output(Bool())
    val exceptions    = Output(UInt(5.W))
    val out           = Output(UInt(nbits.W))
  })

  val positDivSqrtCore = Module(new PositDivSqrtCore(nbits, es))

  val num1Extractor = Module(new PositExtractor(nbits, es))
  val num2Extractor = Module(new PositExtractor(nbits, es))
  num1Extractor.io.in := io.num1
  num2Extractor.io.in := io.num2

  positDivSqrtCore.io.num1 := num1Extractor.io.out
  positDivSqrtCore.io.num2 := num2Extractor.io.out

  positDivSqrtCore.io.sqrtOp  := io.sqrtOp
  positDivSqrtCore.io.validIn := io.validIn

  io.readyIn := positDivSqrtCore.io.readyIn

  io.validOut_div  := positDivSqrtCore.io.validOut_div
  io.validOut_sqrt := positDivSqrtCore.io.validOut_sqrt
  io.exceptions    := positDivSqrtCore.io.exceptions

  val positGenerator = Module(new PositGenerator(nbits, es))
  positGenerator.io.in := positDivSqrtCore.io.out
  positGenerator.io.trailingBits := positDivSqrtCore.io.trailingBits
  positGenerator.io.stickyBit    := positDivSqrtCore.io.stickyBit

  io.isZero := positDivSqrtCore.io.out.isZero | isZero(positGenerator.io.out)
  io.isNaR  := positDivSqrtCore.io.out.isNaR  | isNaR(positGenerator.io.out)
  io.out    := positGenerator.io.out
}