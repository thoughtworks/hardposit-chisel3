package hardposit

import chisel3._
import chisel3.util.log2Ceil

class PositExtractor(totalBits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val num = Input(UInt(totalBits.W))
    val isZero = Output(Bool())
    val isNaR = Output(Bool())
    val sign = Output(Bool())
    val exponent = Output(SInt((log2Ceil(math.pow(2, es).toInt * totalBits) + es + 2).W))
    val fraction = Output(UInt((totalBits + 1).W))
  })

  private val num = Mux(io.num(totalBits - 1), -io.num, io.num)
  private val NaR = 1.U << (totalBits - 1)

  io.isZero := (io.num === 0.U)
  io.isNaR := (io.num === NaR)

  io.sign := io.num(totalBits - 1).asBool()
  private val exponentExtractor = Module(new ExponentExtractor(totalBits, es))
  exponentExtractor.io.num := num
  private val totalLengthAfterExponent = exponentExtractor.io.totalLength
  io.exponent := exponentExtractor.io.exponent

  private val fractionExtractor = Module(new FractionExtractor(totalBits))
  fractionExtractor.io.noOfUsedBits := totalLengthAfterExponent + 1.U
  fractionExtractor.io.num := num
  io.fraction := fractionExtractor.io.fraction
}
