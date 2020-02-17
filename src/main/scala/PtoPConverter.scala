package hardposit

import chisel3._

class PtoPConverter(inWidth: Int, inEs: Int, outWidth: Int, outEs: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(inWidth.W))
    val out = Output(UInt(outWidth.W))
  })
  private val NaR = 1.U << (outWidth - 1)


  val extractor = Module(new PositExtractor(inWidth, inEs))
  val generator = Module(new PositGenerator(outWidth, outEs))

  extractor.io.in := io.in
  generator.io.sign := extractor.io.out.sign
  generator.io.exponent := extractor.io.out.exponent
  generator.io.decimal := true.B

  val shiftedFraction = extractor.io.out.fraction(inWidth - 1, 0) << outWidth >> inWidth
  generator.io.fraction := shiftedFraction

  io.out := Mux(extractor.io.out.isNaR, NaR, generator.io.posit)
}
