package hardposit

import chisel3._

class PtoIConverter(totalBits: Int, es: Int, intWidth: Int) extends Module {
  val io = IO(new Bundle {
    val posit = Input(UInt(totalBits.W))
    val unsignedOut = Input(Bool())
    val integer = Output(UInt(intWidth.W))
  })

  private val positFields = Module(new PositExtractor(totalBits, es))
  positFields.io.num := io.posit
  private val numFraction = positFields.io.fraction
  private val numExponent = positFields.io.exponent
  private val numSign = positFields.io.sign

  private val intSign = numSign & !io.unsignedOut
  private val zeroOut = numSign & io.unsignedOut
  private val normalisedFraction = numFraction << numExponent.asUInt()
  private val inRange = Mux(io.unsignedOut, numExponent < intWidth.S, numExponent < (intWidth - 1).S)
  private val specialCase = !inRange || positFields.io.isNaR || zeroOut
  private val specialSign = !positFields.io.isNaR && numSign

  private val normalOut = Mux(intSign,
    ~normalisedFraction(intWidth + totalBits - 1, totalBits) + 1.U,
    normalisedFraction(intWidth + totalBits - 1, totalBits))

  private val specialCaseOut = Mux((specialSign === !io.unsignedOut), (1.U << (intWidth - 1)), 0.U) |
    Mux(!specialSign, (1.U << (intWidth - 1)) - 1.U, 0.U)

  io.integer := Mux(specialCase, specialCaseOut, normalOut)
}
