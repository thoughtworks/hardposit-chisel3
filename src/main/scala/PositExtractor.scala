package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class PositExtractor(val nbits: Int, val es: Int) extends Module with HasHardPositParams {
  override val desiredName = s"posit_${nbits}_extractor"
  val io = IO(new Bundle {
    val in  = Input(UInt(nbits.W))
    val out = Output(new unpackedPosit(nbits, es))
  })

  val sign   = io.in(nbits - 1) // Extract sign bit
  val absIn  = Mux(sign, ~io.in + 1.U, io.in).asUInt // If negative, adjust 2's complement
  val negExp = ~absIn(nbits - 2) // If the first bit of regime is zero, the the value is between (1, -1)

  val regExpFrac  = absIn(nbits - 2, 0)  // Extract (regime + es + fractional) parts
  val zerosRegime = Mux(negExp, regExpFrac, ~regExpFrac)
  val regimeCount =
    Cat(0.U(1.W),
      Mux(isZero(zerosRegime), (nbits - 1).U, countLeadingZeros(zerosRegime)))
  val regime =
    Mux(negExp, ~regimeCount + 1.U, regimeCount - 1.U) // k = m-1 if

  // Formal: k within range (nbits-1) to 1

  val expFrac = absIn << (regimeCount + 2.U) // Extract (es + fractional) parts
  val extractedExp =
    if (es > 0) expFrac(nbits - 1, nbits - es)
    else 0.U
  val frac = expFrac(nbits - es - 1, nbits - es - maxFractionBits) // Extract fractional part

  io.out.isNaR    := isNaR(io.in)
  io.out.isZero   := isZero(io.in)
  // Formal: If regime + es = nbits, then fractional has to be 1
  // Formal: If regime = nbits, then exponent has to be 1 ?
  io.out.sign     := sign
  io.out.exponent := {
    if (es > 0) Cat(regime, extractedExp)
    else regime
  }.asSInt
  io.out.fraction := Cat(1.U, frac)
}
