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

  private val exponent = Mux(normalisedExponent < 0.S, if (es > 0) normalisedExponent.abs() + (base.asSInt() + ((normalisedExponent + 1.S) % base.S) - 1.S) * 2.S else 0.S - normalisedExponent, normalisedExponent).asUInt()
  private val positRegime = (exponent >> es).asUInt()
  private val positExponent = exponent(if (es > 0) es - 1 else 0, 0)

  private val positiveExponentCombinations = Array.range(0, totalBits).map(index => {
    val regimeBits = (math.pow(2, index + 2) - 2).toInt.U((index + 2).W)
    val bitsRequiredForRegime = index + 2
    val bitsRequiredForExponent = es
    val bitsRequiredForFraction = totalBits
    val usedBits = bitsRequiredForRegime + bitsRequiredForExponent + bitsRequiredForFraction
    val numberOfBitsExcludingSignBit = totalBits - 1

    var finalPosit = regimeBits
    finalPosit = if (es > 0) Cat(finalPosit, positExponent) else finalPosit
    finalPosit = Cat(finalPosit, normalisedFraction)
    (positRegime === index.U) -> finalPosit(usedBits - 1, usedBits - numberOfBitsExcludingSignBit)
  })

  private val negativeExponentCombinations = Array.range(1, totalBits - 1).map(index => {
    val regimeBits = 1.U((index + 1).W)
    val bitsRequiredForRegime = index + 1
    val bitsRequiredForExponent = es
    val bitsRequiredForFraction = totalBits
    val usedBits = bitsRequiredForRegime + bitsRequiredForExponent + bitsRequiredForFraction
    val numberOfBitsExcludingSignBit = totalBits - 1

    var finalPosit = regimeBits
    finalPosit = if (es > 0) Cat(finalPosit, positExponent) else finalPosit
    finalPosit = Cat(finalPosit, normalisedFraction)
    (positRegime === index.U) -> finalPosit(usedBits - 1, usedBits - numberOfBitsExcludingSignBit)
  })

  private val unsignedPosit = Mux(normalisedExponent >= 0.S, MuxCase(0.U, positiveExponentCombinations), MuxCase(0.U, negativeExponentCombinations))
  private val posit = Cat(io.sign, Mux(io.sign, 0.U - unsignedPosit, unsignedPosit))

  io.posit := Mux(fractionWithDecimal === 0.U | normalisedExponent <= 0.S - maxExponent.S, 0.U, Mux(normalisedExponent > maxExponent.S, NaR.U, posit))
}
