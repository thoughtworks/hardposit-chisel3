package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase, PriorityMux, log2Ceil}

class PositGenerator(totalBits: Int, es: Int) extends Module {
  private val base = 1 << es
  private val NaR = 1.U << (totalBits - 1)
  private val maxExponent = (base * (totalBits - 1)) - 1
  private val trailingBitCount = 3
    require(trailingBitCount >= 3)

  val io = IO(new Bundle {
    val in = Input(new unpackedPosit(totalBits, es))
    val out = Output(UInt(totalBits.W))
  })

  private val exponentOffset = PriorityMux(Array.range(0, totalBits + 1).map(index => {
    (io.in.fraction(totalBits, totalBits - index) === 1.U) -> index.S
  }))

  private val normalisedExponent = io.in.exponent - exponentOffset
  private val normalisedFraction = (io.in.fraction << exponentOffset.asUInt())(totalBits - 1, 0)

  private val signedExponent = Mux(normalisedExponent < 0.S, if (es > 0) normalisedExponent.abs() + (base.asSInt() + ((normalisedExponent + 1.S) % base.S) - 1.S) * 2.S else 0.S - normalisedExponent, normalisedExponent).asUInt()
  private val positRegime = (signedExponent >> es).asUInt()
  private val positExponent = signedExponent(if (es > 0) es - 1 else 0, 0)
  private val positOffset = positRegime + es.U + Mux(normalisedExponent >= 0.S, 3.U, 2.U)

  private val regimeBits = Mux(normalisedExponent >= 0.S, (1.U << positRegime + 2.U).asUInt() - 2.U, 1.U << (positRegime + 1.U) >> (positRegime + 1.U))
  private val regimeWithExponentBits = if(es > 0) Cat(regimeBits, positExponent) else regimeBits

  //u => un ; T => Trimmed ; R => Rounded ; S => Signed
  private val uT_uS_posit = Cat(regimeWithExponentBits, normalisedFraction)
  private val T_uS_posit = (uT_uS_posit >> positOffset)(totalBits - 2, 0)
  private val uR_uS_posit = Mux(T_uS_posit === 0.U, 1.U((totalBits - 1).W), T_uS_posit)

  private val trailingBits = (uT_uS_posit << trailingBitCount >> positOffset)(trailingBitCount - 1, 0)
  private val guardBit = trailingBits(trailingBitCount - 1)
  private val roundBit = trailingBits(trailingBitCount -2)
  private val stickyBit = trailingBits(trailingBitCount - 3, 0).orR()
  private val grs = Cat(guardBit,roundBit,stickyBit)
  private val roundingBit = Mux(uR_uS_posit.andR(), false.B, Mux(grs =/= 4.U, guardBit, T_uS_posit(0)))

  private val R_uS_posit = uR_uS_posit + roundingBit
  private val R_S_posit = Cat(io.in.sign, Mux(io.in.sign, 0.U - R_uS_posit, R_uS_posit))

  io.out := Mux((io.in.fraction === 0.U) | (normalisedExponent <= 0.S - maxExponent.S) | io.in.isZero, 0.U,
    Mux((normalisedExponent > maxExponent.S) | io.in.isNaR, NaR, R_S_posit))
}
