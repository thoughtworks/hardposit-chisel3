package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase, log2Ceil}

class PositGeneratorWrapper(totalBits: Int, es: Int) extends Module {
  private val base = 1 << es
  private val exponentBits = log2Ceil(totalBits) + es + 2
  private val NaR = (1 << totalBits - 1)
  private val maxExponent = (base * (totalBits - 1)) - 1

  val io = IO(new Bundle {
    val sign = Input(Bool())
    val exponent = Input(SInt(exponentBits.W))
    val decimal = Input(Bool())
    val fraction = Input(UInt(totalBits.W))
    val posit = Output(UInt(totalBits.W))
  })

  private val fractionWithDecimal = Cat(io.decimal, io.fraction)
  private val exponentOffsetCombinations = Array.range(0, totalBits + 1).map(index => {
    (fractionWithDecimal(totalBits, totalBits - index) === 1.U) -> index.S
  })

  private val exponentOffset = MuxCase(0.S, exponentOffsetCombinations)

  private val normalisedExponent = io.exponent - exponentOffset
  private val normalisedFraction = (fractionWithDecimal << exponentOffset.asUInt())(totalBits - 1, 0)

  private val signedExponent = Mux(normalisedExponent < 0.S, if (es > 0) normalisedExponent.abs() + (base.asSInt() + ((normalisedExponent + 1.S) % base.S) - 1.S) * 2.S else 0.S - normalisedExponent, normalisedExponent).asUInt()
  private val positRegime = (signedExponent >> es).asUInt()
  private val positExponent = signedExponent(if (es > 0) es - 1 else 0, 0)

  private val regimeBits = Mux(normalisedExponent >= 0.S, (1.U << positRegime + 2.U).asUInt() - 2.U, 1.U << (positRegime + 1.U) >> (positRegime + 1.U))
  private val regimeWithExponentBits = if(es > 0) Cat(regimeBits, positExponent) else regimeBits
  private val unRoundedPosit = Cat(regimeWithExponentBits, normalisedFraction)
  private val positOffset = positRegime + es.U + Mux(normalisedExponent >= 0.S, 3.U, 2.U)
  private val unsignedPosit = (unRoundedPosit >> positOffset)(totalBits - 2, 0)

  private val posit = Cat(io.sign, Mux(io.sign, 0.U - unsignedPosit, unsignedPosit))

  io.posit := Mux(fractionWithDecimal === 0.U | normalisedExponent <= 0.S - maxExponent.S, 0.U, Mux(normalisedExponent > maxExponent.S, NaR.U, posit))
}
