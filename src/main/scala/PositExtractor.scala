package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class PositExtractor(val totalBits: Int, val es: Int) extends Module with HasHardPositParams {
  val io = IO(new Bundle {
    val in  = Input(UInt(totalBits.W))
    val out = Output(new unpackedPosit(totalBits, es))
  })

  val sign   = io.in(totalBits - 1)
  val absIn  = Mux(sign, ~io.in + 1.U, io.in).asUInt()
  val negExp = ~absIn(totalBits - 2)

  val regExpFrac  = absIn(totalBits - 2, 0)
  val zerosRegime = Mux(negExp, regExpFrac, ~regExpFrac)
  val regimeCount =
    Cat(0.U(1.W),
      Mux(isZero(zerosRegime), (totalBits - 1).U, countLeadingZeros(zerosRegime)))
  val regime =
    Mux(negExp, ~regimeCount + 1.U, regimeCount - 1.U)

  val expFrac = absIn << (regimeCount + 2.U)
  val extractedExp =
    if (es > 0) expFrac(totalBits - 1, totalBits - es)
    else 0.U
  val frac = expFrac(totalBits - es - 1, totalBits - es - maxFractionBits)

  io.out.isNaR    := isNaR(io.in)
  io.out.isZero   := isZero(io.in)

  io.out.sign     := sign
  io.out.exponent := {
    if (es > 0) Cat(regime, extractedExp)
    else regime
  }.asSInt()
  io.out.fraction := Cat(1.U, frac)
}
