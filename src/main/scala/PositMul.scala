package hardposit

import chisel3._

class PositMul(val totalBits: Int, val es: Int) extends Module with HasHardPositParams {

  val io = IO(new Bundle{
    val num1   = Input(UInt(totalBits.W))
    val num2   = Input(UInt(totalBits.W))

    val isZero = Output(Bool())
    val isNaR  = Output(Bool())
    val out    = Output(UInt(totalBits.W))
  })

  val num1Extractor = Module(new PositExtractor(totalBits, es))
  val num2Extractor = Module(new PositExtractor(totalBits, es))

  val num1 = num1Extractor.io.out
  val num2 = num2Extractor.io.out

  num1Extractor.io.in := io.num1
  num2Extractor.io.in := io.num2

  val prodExp = num1.exponent + num2.exponent
  val prodFrac =
    WireInit(UInt(maxMultiplierFractionBits.W), num1.fraction * num2.fraction)
  val prodOverflow = prodFrac(maxMultiplierFractionBits - 1)

  val normProductFrac = (prodFrac << (~prodOverflow).asUInt()).asUInt()
  val normProductExp  = prodExp + Mux(prodOverflow, 1.S, 0.S)

  val result = Wire(new unpackedPosit(totalBits, es))
  result.isNaR    := num1.isNaR  | num2.isNaR
  result.isZero   := num1.isZero | num2.isZero
  result.sign     := num1.sign ^ num2.sign
  result.exponent := normProductExp
  result.fraction := normProductFrac(maxMultiplierFractionBits - 1, maxMultiplierFractionBits - maxFractionBitsWithHiddenBit)

  private val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.in <> result
  positGenerator.io.trailingBits := normProductFrac(maxMultiplierFractionBits - maxFractionBitsWithHiddenBit - 1, maxFractionBitsWithHiddenBit - trailingBitCount)
  positGenerator.io.stickyBit    := normProductFrac(maxFractionBitsWithHiddenBit - trailingBitCount - 1, 0).orR()

  io.isZero := result.isZero
  io.isNaR := result.isNaR
  io.out := positGenerator.io.out
}
