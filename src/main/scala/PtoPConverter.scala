package hardposit

import chisel3._
import chisel3.util.Cat

class PtoPConverter(inWidth: Int, inEs: Int, outWidth: Int, outEs: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(inWidth.W))
    val out = Output(UInt(outWidth.W))
  })

  val extractor = Module(new PositExtractor(inWidth, inEs))
  val generator = Module(new PositGenerator(outWidth, outEs))

  extractor.io.in := io.in
  generator.io.in <> extractor.io.out

  val shiftedFraction = extractor.io.out.fraction(inWidth - 1, 0) << outWidth >> inWidth
  generator.io.in.fraction := Cat(1.U, shiftedFraction(outWidth - 1, 0))

  io.out := generator.io.out
}
