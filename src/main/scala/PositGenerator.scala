package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase, PriorityMux}

class PositGenerator(val totalBits: Int, val es: Int) extends Module with HasHardPositParams {

  val io = IO(new Bundle {
    val in = Input(new unpackedPosit(totalBits, es))
    val trailingBits = Input(UInt(trailingBitCount.W))
    val stickyBit = Input(Bool())
    val out = Output(UInt(totalBits.W))
  })

  val fraction = io.in.fraction(maxFractionBits - 1, 0)
  val negExp = io.in.exponent < 0.S

  val regime =
    Mux(negExp, -io.in.exponent(maxExponentBits - 1, es), io.in.exponent(maxExponentBits - 1, es)).asUInt()
  val exponent = io.in.exponent(if (es > 0) es - 1 else 0, 0)
  val offset =
    regime - (negExp & regime =/= (totalBits - 1).U)

  val expFrac =
    if (es > 0)
      Cat(Mux(negExp, 1.U(2.W), 2.U(2.W)), exponent, fraction).asSInt()
    else
      Cat(Mux(negExp, 1.U(2.W), 2.U(2.W)), fraction).asSInt()

  //u => un ; R => Rounded ; S => Signed
  val uR_uS_posit = (expFrac >> offset)(totalBits - 2, 0).asUInt()

  val trailingBitMask = ((1.U << offset) - 1.U)(totalBits - 3, 0)
  val trailingBits = Cat(expFrac.asUInt() & trailingBitMask, io.trailingBits)
  val gr =
    (trailingBits >> offset) (1, 0)
  val stickyBit =
    io.stickyBit | (trailingBits & trailingBitMask).orR()
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
