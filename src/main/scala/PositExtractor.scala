package hardposit

import chisel3._
import chisel3.util.log2Ceil

class PositExtractor(totalBits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(totalBits.W))
    val out = Output(new unpackedPosit(totalBits, es))
  })

  private val num = Mux(io.in(totalBits - 1), -io.in, io.in)
  private val NaR = 1.U << (totalBits - 1)

  io.out.isZero := (io.in === 0.U)
  io.out.isNaR := (io.in === NaR)

  io.out.sign := io.in(totalBits - 1).asBool()
  private val exponentExtractor = Module(new ExponentExtractor(totalBits, es))
  exponentExtractor.io.num := num
  private val totalLengthAfterExponent = exponentExtractor.io.totalLength
  io.out.exponent := exponentExtractor.io.exponent

  private val fractionExtractor = Module(new FractionExtractor(totalBits))
  fractionExtractor.io.noOfUsedBits := totalLengthAfterExponent + 1.U
  fractionExtractor.io.num := num
  io.out.fraction := fractionExtractor.io.fraction
}
