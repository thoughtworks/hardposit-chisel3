package hardposit

import chisel3._
import chisel3.util.log2Ceil

class PtoIConverter(totalBits: Int, es: Int, intWidth: Int) extends Module {
  val io = IO(new Bundle {
    val posit = Input(UInt(totalBits.W))
    val unsignedOut = Input(Bool())
    val roundingMode = Input(Bool())            // Indicate rounding mode 0 for round to nearest even(RNE) and 1 for round to zero(RZ)
    val integer = Output(UInt(intWidth.W))
  })
  private val maxSignedInteger = (1.U << (intWidth - 1)) - 1.U
  private val maxUnsignedInteger = (1.U << intWidth) - 1.U
  private val maxExponentBits =  log2Ceil(totalBits) + es + 2

  private val positExtractor = Module(new PositExtractor(totalBits, es))
  positExtractor.io.in := io.posit
  private val num = positExtractor.io.out

  private val magGeOne = ~num.exponent(maxExponentBits - 1)
  private val intSign = num.sign
  private val normalisedFraction = Mux(magGeOne, num.fraction << num.exponent.asUInt(), 0.U)
  private val inRange = Mux(io.unsignedOut, num.exponent < intWidth.S, num.exponent < (intWidth - 1).S)
  private val specialCase = ~inRange | num.isNaR | (intSign & io.unsignedOut)
  private val specialCaseOut = Mux(specialCase & io.unsignedOut & (~intSign | num.isNaR), maxUnsignedInteger, 0.U) |
                               Mux(specialCase & ~io.unsignedOut, maxSignedInteger + (~num.isNaR & intSign), 0.U)

  private val unsignedFraction = normalisedFraction(intWidth + totalBits - 1, totalBits)
  private val roundingBit = ~io.roundingMode & normalisedFraction(totalBits - 1)
  private val roundedInteger = unsignedFraction + roundingBit
  private val normalOut = Mux(intSign, ~roundedInteger + 1.U, roundedInteger)

  io.integer := Mux(specialCase, specialCaseOut, normalOut)
}
