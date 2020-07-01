package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class PositGenerator(val nbits: Int, val es: Int) extends Module with HasHardPositParams {

  val io = IO(new Bundle {
    val in = Input(new unpackedPosit(nbits, es))
    val trailingBits = Input(UInt(trailingBitCount.W))
    val stickyBit = Input(Bool())
    val out = Output(UInt(nbits.W))
  })

  val fraction = io.in.fraction(maxFractionBits - 1, 0)
  val negExp = io.in.exponent < 0.S

  val regime =
    Mux(negExp, -io.in.exponent(maxExponentBits - 1, es), io.in.exponent(maxExponentBits - 1, es)).asUInt()
  val exponent = io.in.exponent(if (es > 0) es - 1 else 0, 0)
  val offset =
    regime - (negExp & regime =/= (nbits - 1).U)

  val expFrac =
    if (es > 0)
      Cat(Mux(negExp, 1.U(2.W), 2.U(2.W)), exponent, fraction, io.trailingBits).asSInt()
    else
      Cat(Mux(negExp, 1.U(2.W), 2.U(2.W)), fraction, io.trailingBits).asSInt()

  //u => un ; T => Trimmed ; R => Rounded ; S => Signed
  val uT_uS_posit = (expFrac >> offset)(nbits - 2 + trailingBitCount, 0).asUInt()
  val uR_uS_posit = uT_uS_posit(nbits - 2 + trailingBitCount, trailingBitCount)

  val stickyBitMask = lowerBitMask(offset)(nbits - 3, 0)
  val gr =
    uT_uS_posit(trailingBitCount - 1, trailingBitCount - 2)
  val stickyBit =
    io.stickyBit | (expFrac.asUInt() & stickyBitMask).orR() | {
      if (trailingBitCount > 2) uT_uS_posit(trailingBitCount - 3, 0).orR()
      else false.B
    }
  val roundingBit =
    Mux(uR_uS_posit.andR(), false.B,
      gr(1) & ~(~uR_uS_posit(0) & gr(1) & ~gr(0) & ~stickyBit))
  val R_uS_posit = uR_uS_posit + roundingBit

  //Underflow Correction
  val uFC_R_uS_posit =
    Cat(0.U(1.W), R_uS_posit | isZero(R_uS_posit))

  val R_S_posit =
    Mux(io.in.sign, ~uFC_R_uS_posit + 1.U, uFC_R_uS_posit)

  io.out := Mux(io.in.isNaR, NaR,
    Mux((io.in.fraction === 0.U) | io.in.isZero, zero, R_S_posit))
}
