package hardposit

import chisel3._

class PositMulCore(val totalBits: Int, val es: Int) extends Module with HasHardPositParams {

  val io = IO(new Bundle{
    val num1   = Input(new unpackedPosit(totalBits, es))
    val num2   = Input(new unpackedPosit(totalBits, es))

    val trailingBits = Output(UInt(trailingBitCount.W))
    val stickyBit = Output(Bool())
    val out    = Output(new unpackedPosit(totalBits, es))
  })

  val num1 = io.num1
  val num2 = io.num2

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

  io.trailingBits := normProductFrac(maxMultiplierFractionBits - maxFractionBitsWithHiddenBit - 1, maxFractionBitsWithHiddenBit - trailingBitCount)
  io.stickyBit    := normProductFrac(maxFractionBitsWithHiddenBit - trailingBitCount - 1, 0).orR()

  io.out := result
}

class PositMul(val totalBits: Int, val es: Int) extends Module with HasHardPositParams {

  val io = IO(new Bundle {
    val num1 = Input(UInt(totalBits.W))
    val num2 = Input(UInt(totalBits.W))

    val isZero = Output(Bool())
    val isNaR = Output(Bool())
    val out = Output(UInt(totalBits.W))
  })

  val positMulCore = Module(new PositMulCore(totalBits, es))

  val num1Extractor = Module(new PositExtractor(totalBits, es))
  val num2Extractor = Module(new PositExtractor(totalBits, es))
  num1Extractor.io.in := io.num1
  num2Extractor.io.in := io.num2

  positMulCore.io.num1 := num1Extractor.io.out
  positMulCore.io.num2 := num2Extractor.io.out

  val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.in           := positMulCore.io.out
  positGenerator.io.trailingBits := positMulCore.io.trailingBits
  positGenerator.io.stickyBit    := positMulCore.io.stickyBit

  io.isZero := positMulCore.io.out.isZero | isZero(positGenerator.io.out)
  io.isNaR  := positMulCore.io.out.isNaR  | isNaR(positGenerator.io.out)
  io.out    := positGenerator.io.out
}