package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class PositExtractor(val totalBits: Int, val es: Int) extends Module with HasHardPositParams {
  val io = IO(new Bundle {
    val in = Input(UInt(totalBits.W))
    val out = Output(new unpackedPosit(totalBits, es))
  })

  io.out.sign := io.in(totalBits - 1)
  io.out.isZero := ~io.in.orR()
  io.out.isNaR := io.in(totalBits - 1) & (~io.in(totalBits - 2, 0).orR())
  io.out.stickyBit := false.B

  val num = Mux(io.out.sign, ~io.in + 1.U, io.in).asUInt()

  val regExpFrac = num(totalBits - 2, 0)
  val regMaps =
    Array.range(0, totalBits - 2).reverse.map(index => {
      (!(regExpFrac(index + 1) === regExpFrac(index))) -> (totalBits - (index + 2)).U
    })
  val regimeLength =
    Cat(0.U(1.W), MuxCase((totalBits - 1).U, regMaps))
  val regime =
    Mux(num(totalBits - 2), regimeLength - 1.U, ~regimeLength + 1.U)

  val expFrac = num << (regimeLength + 2.U)
  val extractedExponent =
    if (es > 0) expFrac(totalBits - 1, totalBits - es)
    else 0.U
  val frac = expFrac << es

  io.out.exponent := ((regime << es) | extractedExponent).asSInt
  io.out.fraction := Cat(1.U, frac(totalBits - 1, totalBits - maxFractionBits))
}
