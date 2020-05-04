package hardposit

import chisel3._

class PositExtractor(totalBits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(totalBits.W))
    val out = Output(new unpackedPosit(totalBits, es))
  })

  io.out.sign := io.in(totalBits - 1)
  private val num = Mux(io.out.sign, -io.in , io.in)

  io.out.isZero := ~io.in.orR()
  io.out.isNaR := io.in(totalBits - 1) & (~io.in(totalBits - 2, 0).orR())
  io.out.stickyBit := false.B

  private val exponentExtractor = Module(new ExponentExtractor(totalBits, es))
  exponentExtractor.io.num := num
  private val totalLengthAfterExponent = exponentExtractor.io.totalLength
  io.out.exponent := exponentExtractor.io.exponent

  private val fractionExtractor = Module(new FractionExtractor(totalBits))
  fractionExtractor.io.noOfUsedBits := totalLengthAfterExponent + 1.U
  fractionExtractor.io.num := num
  io.out.fraction := fractionExtractor.io.fraction
}
