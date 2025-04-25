package hardposit

import chisel3._
import chisel3.util.{Cat, Fill, MuxCase}

class PositGenerator(val nbits: Int, val es: Int) extends Module with HasHardPositParams {
  override val desiredName = s"posit_${nbits}_generator"

  val io = IO(new Bundle {
    val in = Input(new unpackedPosit(nbits, es))
    val trailingBits = Input(UInt(trailingBitCount.W))
    val stickyBit = Input(Bool())
    val out = Output(UInt(nbits.W))
  })

  val fraction = io.in.fraction(maxFractionBits - 1, 0)
  val negExp = io.in.exponent < 0.S

  // Regime calculation (robust)
  val k = (io.in.exponent >> es).asSInt
  val regimeBits = Wire(UInt((nbits - 1).W))
  val regimeLength = Wire(UInt(log2Ceil(nbits).W))

  when(k >= 0.S) {
    regimeBits := Cat(Fill(k.asUInt + 1.U, 1.U(1.W)), 0.U((nbits - 1).W)) >> (nbits.U - (k.asUInt + 2.U))
    regimeLength := k.asUInt + 2.U
  } .otherwise {
    regimeBits := Cat(1.U(1.W), Fill((-k).asUInt, 0.U(1.W))) >> (nbits.U - ((-k).asUInt + 2.U))
    regimeLength := (-k).asUInt + 2.U
  }

  val exponent = if (es > 0) io.in.exponent(es - 1, 0).asUInt else 0.U
  val offset = regimeLength

  val expFrac =
    if (es > 0)
      Cat(regimeBits, exponent, fraction, io.trailingBits).asSInt
    else
      Cat(regimeBits, fraction, io.trailingBits).asSInt

  // u => un ; T => Trimmed ; R => Rounded ; S => Signed
  val uT_uS_posit = (expFrac >> offset)(nbits - 2 + trailingBitCount, 0).asUInt
  val uR_uS_posit = uT_uS_posit(nbits - 2 + trailingBitCount, trailingBitCount)

  val stickyBitMask = lowerBitMask(offset)(nbits - 3, 0)
  val gr = uT_uS_posit(trailingBitCount - 1, trailingBitCount - 2)
  val stickyBit =
    io.stickyBit | (expFrac.asUInt & stickyBitMask).orR |
      (if (trailingBitCount > 2) uT_uS_posit(trailingBitCount - 3, 0).orR else false.B)

  val roundingBit = Mux(uR_uS_posit.andR, false.B,
    gr(1) & ~(~uR_uS_posit(0) & gr(1) & ~gr(0) & ~stickyBit))
  val R_uS_posit = uR_uS_posit + roundingBit

  // Underflow Correction
  val uFC_R_uS_posit = Cat(0.U(1.W), R_uS_posit | isZero(R_uS_posit))
  val R_S_posit = Mux(io.in.sign, ~uFC_R_uS_posit + 1.U, uFC_R_uS_posit)

  io.out := Mux(io.in.isNaR, NaR,
    Mux((io.in.fraction === 0.U) || io.in.isZero, zero, R_S_posit))
}
