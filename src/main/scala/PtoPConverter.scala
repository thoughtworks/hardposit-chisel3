package hardposit

import chisel3._
import chisel3.util.Cat

class PtoPConverter(inWidth: Int, inEs: Int, outWidth: Int, outEs: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(inWidth.W))
    val out = Output(UInt(outWidth.W))
  })
  private val NaR = 1.U << (outWidth - 1)

  val extractor = Module(new PositExtractor(inWidth, inEs))
  val generator = Module(new PositGenerator(outWidth, outEs))

  extractor.io.in := io.in
  generator.io.in.sign := extractor.io.out.sign
  generator.io.in.exponent := extractor.io.out.exponent
  generator.io.in.isNaR := extractor.io.out.isNaR
  generator.io.in.isZero := extractor.io.out.isZero

  val shiftedFraction = extractor.io.out.fraction(inWidth - 1, 0) << outWidth >> inWidth
  generator.io.in.fraction := Cat(1.U, shiftedFraction(outWidth - 1, 0))

  io.out := Mux(extractor.io.out.isNaR, NaR, generator.io.out)
}
