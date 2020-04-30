package hardposit

import chisel3._

class PtoIConverter(totalBits: Int, es: Int, intWidth: Int) extends Module {
  val io = IO(new Bundle {
    val posit = Input(UInt(totalBits.W))
    val unsignedOut = Input(Bool())
    val roundingMode = Input(Bool())            // Indicate rounding mode 0 for round to nearest even(RNE) and 1 for round to zero(RZ)
    val integer = Output(UInt(intWidth.W))
  })
  private val maxInteger = (1.U << (intWidth - 1))
  private val positExtractor = Module(new PositExtractor(totalBits, es))
  positExtractor.io.in := io.posit
  private val num = positExtractor.io.out

  private val intSign = num.sign & !io.unsignedOut
  private val zeroOut = num.sign & io.unsignedOut
  private val normalisedFraction = num.fraction << num.exponent.asUInt()
  private val inRange = Mux(io.unsignedOut, num.exponent < intWidth.S, num.exponent < (intWidth - 1).S)
  private val specialCase = !inRange || num.isNaR || zeroOut
  private val specialSign = !num.isNaR && num.sign

  private val unsignedFraction = normalisedFraction(intWidth + totalBits - 1, totalBits)
  private val roundingBit = ~io.roundingMode & normalisedFraction(totalBits - 1)
  private val roundedInteger = unsignedFraction + roundingBit
  private val normalOut = Mux(intSign, ~roundedInteger + 1.U, roundedInteger)

  private val specialCaseOut = Mux(io.unsignedOut, 0.U, Mux(inRange, maxInteger - 1.U, maxInteger))

  io.integer := Mux(specialCase, specialCaseOut, normalOut)
}
