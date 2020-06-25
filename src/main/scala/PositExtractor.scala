package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class PositExtractor(val nbits: Int, val es: Int) extends Module with HasHardPositParams {
  val io = IO(new Bundle {
    val in  = Input(UInt(nbits.W))
    val out = Output(new unpackedPosit(nbits, es))
  })

  val sign   = io.in(nbits - 1)
  val absIn  = Mux(sign, ~io.in + 1.U, io.in).asUInt()
  val negExp = ~absIn(nbits - 2)

  val regExpFrac  = absIn(nbits - 2, 0)
  val zerosRegime = Mux(negExp, regExpFrac, ~regExpFrac)
  val regimeCount =
    Cat(0.U(1.W),
      Mux(isZero(zerosRegime), (nbits - 1).U, countLeadingZeros(zerosRegime)))
  val regime =
    Mux(negExp, ~regimeCount + 1.U, regimeCount - 1.U)

  val expFrac = absIn << (regimeCount + 2.U)
  val extractedExp =
    if (es > 0) expFrac(nbits - 1, nbits - es)
    else 0.U
  val frac = expFrac(nbits - es - 1, nbits - es - maxFractionBits)

  io.out.isNaR    := isNaR(io.in)
  io.out.isZero   := isZero(io.in)

  io.out.sign     := sign
  io.out.exponent := {
    if (es > 0) Cat(regime, extractedExp)
    else regime
  }.asSInt()
  io.out.fraction := Cat(1.U, frac)
}
