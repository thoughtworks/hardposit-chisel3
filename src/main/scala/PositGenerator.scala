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

  val exponentOffset = PriorityMux(Array.range(0, maxFractionBits).map(index => { //TODO Remove normalization check
    (io.in.fraction(maxFractionBits, maxFractionBits - index) === 1.U) -> index.S
  }))

  val normalisedExponent = io.in.exponent - exponentOffset
  val normalisedFraction =
    (io.in.fraction << exponentOffset.asUInt()) (maxFractionBits - 1, 0)
  val negExp = normalisedExponent < 0.S

  val positRegime =
    Mux(negExp, -(normalisedExponent >> es), normalisedExponent >> es).asUInt()
  val positExponent = normalisedExponent(if (es > 0) es - 1 else 0, 0)
  val positOffset =
    positRegime - (negExp & positRegime =/= (totalBits - 1).U)

  val expFrac =
    if (es > 0)
      Cat(Mux(negExp, 1.U(2.W), 2.U(2.W)), positExponent, normalisedFraction).asSInt()
    else
      Cat(Mux(negExp, 1.U(2.W), 2.U(2.W)), normalisedFraction).asSInt()

  //u => un ; R => Rounded ; S => Signed
  val uR_uS_posit = (expFrac >> positOffset)(totalBits - 2, 0).asUInt()

  val trailingBitMask = ((1.U << positOffset) - 1.U)(totalBits - 3, 0)
  val trailingBits = Cat(expFrac.asUInt() & trailingBitMask, io.trailingBits)
  val gr =
    (trailingBits >> positOffset) (1, 0)
  val stickyBit =
    io.stickyBit | (trailingBits & trailingBitMask).orR()
  val roundingBit =
    Mux(uR_uS_posit.andR(), false.B,
      gr(1) & ~(~uR_uS_posit(0) & gr(1) & ~gr(0) & ~stickyBit))
  val R_uS_posit = uR_uS_posit + roundingBit

  //Underflow Correction
  val uFC_R_uS_posit =
    Cat(0.U(1.W), R_uS_posit | (R_uS_posit === 0.U))

  val R_S_posit =
    Mux(io.in.sign, ~uFC_R_uS_posit + 1.U, uFC_R_uS_posit)

  io.out := Mux(io.in.isNaR, NaR,
    Mux((io.in.fraction === 0.U) | io.in.isZero, zero, R_S_posit))
}
