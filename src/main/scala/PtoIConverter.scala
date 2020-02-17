package hardposit

import chisel3._

class PtoIConverter(totalBits: Int, es: Int, intWidth: Int) extends Module {
  val io = IO(new Bundle {
    val posit = Input(UInt(totalBits.W))
    val unsignedOut = Input(Bool())
    val integer = Output(UInt(intWidth.W))
  })

  private val positExtractor = Module(new PositExtractor(totalBits, es))
  positExtractor.io.in := io.posit
  private val num = positExtractor.io.out

  private val intSign = num.sign & !io.unsignedOut
  private val zeroOut = num.sign & io.unsignedOut
  private val normalisedFraction = num.fraction << num.exponent.asUInt()
  private val inRange = Mux(io.unsignedOut, num.exponent < intWidth.S, num.exponent < (intWidth - 1).S)
  private val specialCase = !inRange || num.isNaR || zeroOut
  private val specialSign = !num.isNaR && num.sign

  private val normalOut = Mux(intSign,
    ~normalisedFraction(intWidth + totalBits - 1, totalBits) + 1.U,
    normalisedFraction(intWidth + totalBits - 1, totalBits))

  private val specialCaseOut = Mux((specialSign === !io.unsignedOut), (1.U << (intWidth - 1)), 0.U) |
    Mux(!specialSign, (1.U << (intWidth - 1)) - 1.U, 0.U)

  io.integer := Mux(specialCase, specialCaseOut, normalOut)
}
