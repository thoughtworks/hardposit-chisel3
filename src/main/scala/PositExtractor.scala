package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class PositExtractor(val totalBits: Int, val es: Int) extends Module with HasHardPositParams {
  val io = IO(new Bundle {
    val in = Input(UInt(totalBits.W))
    val out = Output(new unpackedPosit(totalBits, es))
  })

  val sign = io.in(totalBits - 1)
  val absIn = Mux(sign, ~io.in + 1.U, io.in).asUInt()

  val regExpFrac = absIn(totalBits - 2, 0)
  val regMaps =
    Array.range(0, totalBits - 2).reverse.map(index => {
      (!(regExpFrac(index + 1) === regExpFrac(index))) -> (totalBits - (index + 2)).U
    })
  val regimeCount =
    Cat(0.U(1.W), MuxCase((totalBits - 1).U, regMaps))
  val regime =
    Mux(absIn(totalBits - 2), regimeCount - 1.U, ~regimeCount + 1.U)

  val expFrac = absIn << (regimeCount + 2.U)
  val extractedExponent =
    if (es > 0) expFrac(totalBits - 1, totalBits - es)
    else 0.U
  val frac = (expFrac << es)(totalBits - 1, totalBits - maxFractionBits)

  io.out.sign      := sign
  io.out.isZero    := isZero(io.in)
  io.out.isNaR     := isNaR(io.in)
  io.out.exponent  := ((regime << es) | extractedExponent).asSInt
  io.out.fraction  := Cat(1.U, frac)
}
