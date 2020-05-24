package hardposit

import chisel3._

class PtoIConverterCore(val totalBits: Int, val es: Int, val intWidth: Int) extends Module with HasHardPositParams {
  val io = IO(new Bundle {
    val posit        = Input(new unpackedPosit(totalBits, es))
    val unsignedOut  = Input(Bool())
    val roundingMode = Input(Bool())

    val integer = Output(UInt(intWidth.W))
  })

  val num = io.posit

  val magGeOne = !num.exponent(maxExponentBits - 1)
  val normFrac =
    Mux(magGeOne, num.fraction << num.exponent.asUInt(), 0.U)

  val inRange =
    Mux(io.unsignedOut, num.exponent < intWidth.S, num.exponent < (intWidth - 1).S)
  val specialCase = ~inRange | num.isNaR | (num.sign & io.unsignedOut)
  val specialCaseOut =
    Mux(specialCase & io.unsignedOut & (~num.sign | num.isNaR), maxUnsignedInteger(intWidth), 0.U) |
    Mux(specialCase & ~io.unsignedOut, maxSignedInteger(intWidth) + (~num.isNaR & num.sign), 0.U)

  val unsignedFrac = normFrac(intWidth + maxFractionBits - 1, maxFractionBits)
  val roundingBit  = ~io.roundingMode & normFrac(maxFractionBits - 1)
  val roundedInt   = unsignedFrac + roundingBit
  val normalOut    = Mux(num.sign, ~roundedInt + 1.U, roundedInt)

  io.integer := Mux(specialCase, specialCaseOut, normalOut)
}

class PtoIConverter(val totalBits: Int, val es: Int, val intWidth: Int) extends Module with HasHardPositParams {
  val io = IO(new Bundle {
    val posit        = Input(UInt(totalBits.W))
    val unsignedOut  = Input(Bool())
    val roundingMode = Input(Bool())   // Indicate rounding mode 0 for round to nearest even(RNE)
                                       // and 1 for round to zero(RZ)
    val integer = Output(UInt(intWidth.W))
  })
  val p2iCore = Module(new PtoIConverterCore(totalBits, es, intWidth))

  val positExtractor = Module(new PositExtractor(totalBits, es))
  positExtractor.io.in := io.posit

  p2iCore.io.posit        := positExtractor.io.out
  p2iCore.io.unsignedOut  := io.unsignedOut
  p2iCore.io.roundingMode := io.roundingMode

  io.integer := p2iCore.io.integer
}
