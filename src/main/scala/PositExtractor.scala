package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class PositExtractor(val nbits: Int, val es: Int) extends Module with HasHardPositParams {
  val io = IO(new Bundle {
    val in  = Input(UInt(nbits.W))
    val out = Output(new unpackedPosit(nbits, es))
  })

  val sign   = io.in(nbits - 1)
  val absIn  = Mux(sign, (~io.in).asUInt + 1.U, io.in).asUInt
  val negExp = ~absIn(nbits - 2)

  val regExpFrac  = absIn(nbits - 2, 0)
  val zerosRegime = Mux(negExp.asBool, regExpFrac, ~regExpFrac)
  val regimeCount =
    Cat(0.U(1.W),
      Mux(isZero(zerosRegime.asUInt), (nbits - 1).U, countLeadingZeros(zerosRegime)))

  assert((regimeCount <= (nbits.asUInt - 1.U))  & (regimeCount >= 1.U))

  val regime = Mux(negExp.asBool, (~regimeCount).asUInt + 1.U, regimeCount - 1.U)

  assert(regime >= 0.U)
  val regime_range = (2.U << (nbits.U - 2.U)).asUInt
  assert(regime < regime_range)

  val expFrac = absIn << (regimeCount + 2.U)
  val extractedExp =
    if (es > 0) expFrac(nbits - 1, nbits - es)
    else 0.U

  if(es > 0) {
    assert((extractedExp < (2.U << es-1).asUInt) & (extractedExp >= 0.U))
  }

  val frac = expFrac(nbits - es - 1, nbits - es - maxFractionBits)

  assert((frac <= (2.U << maxFractionBits - 1).asUInt) & (frac >= 0.U))
  when((es.U + regimeCount) === nbits.U - 1.U) {
    assert(frac === 0.U)
  }

  io.out.isNaR    := isNaR(io.in)
  io.out.isZero   := isZero(io.in)

  when(io.out.isNaR) {
    assert(!io.out.isZero)
  }
  when(io.out.isZero) {
    assert(!io.out.isNaR)
  }

  io.out.sign     := sign
  io.out.exponent := {
    if (es > 0) Cat(regime, extractedExp)
    else regime
  }.asSInt
  io.out.fraction := Cat(1.U, frac)
}
