package hardposit

import chisel3._
import chisel3.util.{Cat, log2Ceil}

class PtoPConverter(inWidth: Int, inEs: Int, outWidth: Int, outEs: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(inWidth.W))
    val out = Output(UInt(outWidth.W))
  })
  val maxOutExponentBits = log2Ceil(outWidth) + outEs + 2
  val maxInExponentBits = log2Ceil(inWidth) + inEs + 2

  val maxOutExp = ((1 << (maxOutExponentBits - 1)) - 1).S(maxOutExponentBits.W)
  val minOutExp = (1 << (maxOutExponentBits - 1)).U.asSInt()

  val extractor = Module(new PositExtractor(inWidth, inEs))
  val generator = Module(new PositGenerator(outWidth, outEs))

  extractor.io.in := io.in
  generator.io.in <> extractor.io.out

  val exp = extractor.io.out.exponent
  val adjustedFraction = extractor.io.out.fraction(inWidth - 1, 0) << outWidth >> inWidth
  val adjustedExponent = if (maxInExponentBits > maxOutExponentBits) Mux(extractor.io.out.exponent < minOutExp, minOutExp,
    Mux(extractor.io.out.exponent > maxOutExp, maxOutExp, extractor.io.out.exponent))
  else extractor.io.out.exponent

  printf(p"max: $maxOutExp\n")
  val stickyBit = if (inWidth > outWidth) extractor.io.out.fraction(inWidth - outWidth - 1, 0).orR() else false.B
  generator.io.in.fraction := Cat(1.U, adjustedFraction(outWidth - 1, 0))
  generator.io.in.exponent := adjustedExponent
  generator.io.in.stickyBit := stickyBit

  io.out := generator.io.out
}
