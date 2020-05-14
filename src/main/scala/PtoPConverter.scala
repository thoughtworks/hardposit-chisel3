package hardposit

import chisel3._
import chisel3.util.{Cat, log2Ceil}

class PtoPConverter(inWidth: Int, inEs: Int, outWidth: Int, outEs: Int) extends Module with HasHardPositParams {
  require((inWidth != outWidth) | (inEs != outEs))

  override val totalBits: Int = 0
  override val es: Int = 0
  val io = IO(new Bundle {
    val in = Input(UInt(inWidth.W))
    val out = Output(UInt(outWidth.W))
  })

  val maxInExponentBits  = getMaxExponentBits(inWidth, inEs)
  val maxInFractionBits  = getMaxFractionBits(inWidth, inEs)

  val maxOutExponentBits = getMaxExponentBits(outWidth, outEs)
  val maxOutFractionBits = getMaxFractionBits(outWidth, outEs)

  val maxOutExp = ((1 << (maxOutExponentBits - 1)) - 1).S(maxOutExponentBits.W)
  val minOutExp = (1 << (maxOutExponentBits - 1)).U.asSInt()

  val narrowConv = maxInFractionBits > maxOutFractionBits

  val extractor = Module(new PositExtractor(inWidth, inEs))
  val generator = Module(new PositGenerator(outWidth, outEs))

  extractor.io.in := io.in
  generator.io.in <> extractor.io.out

  val adjFrac =
    if(narrowConv)
      (extractor.io.out.fraction(maxInFractionBits, 0) >>  maxInFractionBits - maxOutFractionBits)(maxOutFractionBits, 0)
    else
      (extractor.io.out.fraction(maxInFractionBits, 0) << maxOutFractionBits - maxInFractionBits)(maxOutFractionBits, 0)

  val adjExp =
    if (maxInExponentBits > maxOutExponentBits)
      Mux(extractor.io.out.exponent < minOutExp, minOutExp,
      Mux(extractor.io.out.exponent > maxOutExp, maxOutExp, extractor.io.out.exponent))
    else extractor.io.out.exponent

  val inFracWithTrailOffset = Cat(extractor.io.out.fraction, 0.U((trailingBitCount + stickyBitCount).W))
  val trailingBits =
    if(narrowConv)
      inFracWithTrailOffset(maxInFractionBits - maxOutFractionBits + trailingBitCount + stickyBitCount - 1,
        maxInFractionBits - maxOutFractionBits + stickyBitCount )
    else 0.U

  val stickyBit =
    if (narrowConv)
      inFracWithTrailOffset(maxInFractionBits - maxOutFractionBits + stickyBitCount - 1, 0).orR()
    else false.B

  generator.io.in.fraction  := adjFrac
  generator.io.in.exponent  := adjExp
  generator.io.trailingBits := trailingBits
  generator.io.stickyBit    := stickyBit

  io.out := generator.io.out
}
