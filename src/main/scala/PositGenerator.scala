package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase, PriorityMux}

class PositGenerator(totalBits: Int, es: Int) extends Module {
  private val base = 1 << es
  private val NaR = 1.U << (totalBits - 1)
  private val maxExponent = (base * (totalBits - 1)) - 1

  val io = IO(new Bundle {
    val in = Input(new unpackedPosit(totalBits, es))
    val out = Output(UInt(totalBits.W))
  })

  private val exponentOffset = PriorityMux(Array.range(0, totalBits + 1).map(index => {
    (io.in.fraction(totalBits, totalBits - index) === 1.U) -> index.S
  }))

  private val normalisedExponent = io.in.exponent - exponentOffset
  private val normalisedFraction = (io.in.fraction << exponentOffset.asUInt()) (totalBits - 1, 0)

  private val signedExponent = Mux(normalisedExponent < 0.S,
    if (es > 0) {
      val expModBase = (normalisedExponent + 1.S) (es - 1, 0).asUInt
      val signedExpModBase = Mux(expModBase =/= 0.U, Cat(1.U, expModBase).asSInt, 0.S)
      normalisedExponent.abs() + (((base - 1).S + signedExpModBase) << 1.U)
    } else 0.S - normalisedExponent, normalisedExponent).asUInt()

  private val positRegime = (signedExponent >> es).asUInt()
  private val positExponent = signedExponent(if (es > 0) es - 1 else 0, 0)

  private val positOffset = positRegime + es.U + Mux(normalisedExponent >= 0.S, 3.U, 2.U)

  private val regimeBits = Mux(normalisedExponent >= 0.S, (1.U << positRegime + 2.U).asUInt() - 2.U, 1.U << (positRegime + 1.U) >> (positRegime + 1.U))
  private val regimeWithExponentBits = if (es > 0) Cat(regimeBits, positExponent) else regimeBits

  //u => un ; T => Trimmed ; R => Rounded ; S => Signed
  private val uT_uS_posit = Cat(regimeWithExponentBits, normalisedFraction)
  private val T_uS_posit = (uT_uS_posit >> positOffset) (totalBits - 2, 0)
  private val uR_uS_posit = Mux(T_uS_posit === 0.U, 1.U((totalBits - 1).W), T_uS_posit)

  private val trailingBits = (uT_uS_posit & ((1.U << positOffset) - 1.U)).asUInt()
  private val lastBit = T_uS_posit(0)
  private val afterBit = (trailingBits >> (positOffset - 1.U))(0)
  private val stickyBit = io.in.stickyBit | (trailingBits & ((1.U << (positOffset -1.U)) - 1.U)).orR()
  private val roundingBit = (lastBit & afterBit) | (afterBit & stickyBit)

  private val R_uS_posit = uR_uS_posit + roundingBit
  private val R_S_posit = Cat(io.in.sign, Mux(io.in.sign, ~R_uS_posit + 1.U, R_uS_posit))

  io.out := Mux((normalisedExponent > maxExponent.S) | io.in.isNaR, NaR,
    Mux((io.in.fraction === 0.U) | (normalisedExponent <= 0.S - maxExponent.S) | io.in.isZero, 0.U, R_S_posit))
}
