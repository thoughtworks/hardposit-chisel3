package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase, log2Ceil}

class PositGenerator(totalBits: Int, es: Int) extends Module {
  private val base = math.pow(2, es).toInt
  private val exponentBits = log2Ceil(base * (totalBits - 1)) + 1
  val io = IO(new Bundle {
    val sign = Input(Bool())
    val exponent = Input(SInt(exponentBits.W))
    val fraction = Input(UInt(totalBits.W))
    val posit = Output(UInt(totalBits.W))
  })

  private val exponent = Mux(io.exponent < 0.S, if (es > 0) io.exponent.abs() + (base.asSInt() + ((io.exponent + 1.S) % base.S) - 1.S) * 2.S else 0.S - io.exponent, io.exponent).asUInt()
  private val positRegime = exponent / base.U
  private val positExponent = (exponent % base.U) (if (es > 0) es - 1 else 0, 0)


  //    private val exponent = io.exponent.abs().asUInt()
  //    private val remainder: UInt = exponent % base.U
  //    private val isDivisible = exponent > 0.U || remainder === 0.U
  //    private val positRegime = exponent / base.U + Mux(isDivisible,0.U,1.U)
  //    private val positExponent = Mux(isDivisible,remainder,base.U - remainder) (if (es > 0) es - 1 else 0, 0)

  private val positiveExponentCombinations = Array.range(0, totalBits).map(index => {
    val regimeBits = (math.pow(2, index + 2) - 2).toInt.U
    val bitsRequiredForRegime = index + 2
    val bitsRequiredForExponent = es
    val bitsRequiredForFraction = totalBits
    val usedBits = bitsRequiredForRegime + bitsRequiredForExponent + bitsRequiredForFraction
    val numberOfBitsExcludingSignBit = totalBits - 1

    var finalPosit = regimeBits
    finalPosit = if (es > 0) Cat(finalPosit, positExponent) else finalPosit
    finalPosit = Cat(finalPosit, io.fraction)
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
    finalPosit = Cat(finalPosit, io.fraction)
    (positRegime === index.U) -> finalPosit(usedBits - 1, usedBits - numberOfBitsExcludingSignBit)
  })

  val posit = Mux(io.exponent >= 0.S, MuxCase(0.U, positiveExponentCombinations), MuxCase(0.U, negativeExponentCombinations))
  io.posit := Cat(io.sign, Mux(io.sign, 0.U - posit, posit))
}
