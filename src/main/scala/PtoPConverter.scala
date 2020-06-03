package hardposit

import chisel3._
import chisel3.util.{Cat, log2Ceil}

class PtoPConverterCore(inWidth: Int, inEs: Int, outWidth: Int, outEs: Int) extends Module with HasHardPositParams {
  lazy val totalBits: Int = inWidth
  lazy val es: Int = inEs
  require((inWidth != outWidth) | (inEs != outEs), "Conversion between identical posit configuration")

  val io = IO(new Bundle {
    val in = Input(new unpackedPosit(inWidth, inEs))

    val trailingBits = Output(UInt(trailingBitCount.W))
    val stickyBit    = Output(Bool())
    val out          = Output(new unpackedPosit(outWidth, outEs))
  })

  val maxInExponentBits  = getMaxExponentBits(inWidth, inEs)
  val maxInFractionBits  = getMaxFractionBits(inWidth, inEs)

  val maxOutExponentBits = getMaxExponentBits(outWidth, outEs)
  val maxOutFractionBits = getMaxFractionBits(outWidth, outEs)

  val maxOutExp = ((1 << (maxOutExponentBits - 1)) - 1).S(maxOutExponentBits.W)
  val minOutExp = (1 << (maxOutExponentBits - 1)).U.asSInt()

  val narrowConv = maxInFractionBits > maxOutFractionBits

  io.out := io.in

  io.out.fraction := {
    if (narrowConv)
      (io.in.fraction(maxInFractionBits, 0) >> maxInFractionBits - maxOutFractionBits) (maxOutFractionBits, 0)
    else
      (io.in.fraction(maxInFractionBits, 0) << maxOutFractionBits - maxInFractionBits) (maxOutFractionBits, 0)
  }

  io.out.exponent := {
    if (maxInExponentBits > maxOutExponentBits)
      Mux(io.in.exponent < minOutExp, minOutExp,
        Mux(io.in.exponent > maxOutExp, maxOutExp, io.in.exponent))
    else io.in.exponent
  }

  val inFracWithTrailOffset = Cat(io.in.fraction, 0.U((trailingBitCount + stickyBitCount).W))

  io.trailingBits := {
    if(narrowConv)
      inFracWithTrailOffset(maxInFractionBits - maxOutFractionBits + trailingBitCount + stickyBitCount - 1,
        maxInFractionBits - maxOutFractionBits + stickyBitCount )
    else 0.U }

  io.stickyBit := {
    if (narrowConv)
      inFracWithTrailOffset(maxInFractionBits - maxOutFractionBits + stickyBitCount - 1, 0).orR()
    else false.B }
}

class PtoPConverter(inWidth: Int, inEs: Int, outWidth: Int, outEs: Int) extends Module{

  val io = IO(new Bundle {
    val in  = Input(UInt(inWidth.W))
    val out = Output(UInt(outWidth.W))
  })
  val p2pCore = Module(new PtoPConverterCore(inWidth, inEs, outWidth, outEs))

  val extractor = Module(new PositExtractor(inWidth, inEs))
  val generator = Module(new PositGenerator(outWidth, outEs))

  extractor.io.in := io.in
  p2pCore.io.in   := extractor.io.out

  generator.io.in           := p2pCore.io.out
  generator.io.trailingBits := p2pCore.io.trailingBits
  generator.io.stickyBit    := p2pCore.io.stickyBit

  io.out := generator.io.out

}