package hardposit

import chisel3._

class PtoPConverter(inWidth: Int, inEs: Int, outWidth: Int, outEs: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(inWidth.W))
    val out = Output(UInt(outWidth.W))
  })
  private val NaR = math.pow(2, outWidth - 1).toInt.U


  val extract = Module(new PositExtractor(inWidth, inEs))
  val generate = Module(new PositGenerator(outWidth, outEs))

  extract.io.num := io.in
  generate.io.sign := extract.io.sign
  generate.io.exponent := extract.io.exponent
  generate.io.decimal := true.B

  val shiftedFraction = extract.io.fraction(inWidth - 1, 0) << outWidth >> inWidth
  generate.io.fraction := shiftedFraction

  io.out := Mux(extract.io.isNaR, NaR, generate.io.posit)
}
