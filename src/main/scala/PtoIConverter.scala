package hardposit

import chisel3._

class PtoIConverter(totalBits: Int, es: Int, intWidth: Int) extends Module {
  val io = IO(new Bundle {
    val posit = Input(UInt(totalBits.W))
    val unsignedOut = Input(Bool())
    val integer = Output(UInt(intWidth.W))
  })

  private val maxUnsignedInteger = math.pow(2, intWidth).toLong.U(intWidth - 1, 0) - 1.U
  private val maxSignedInteger = math.pow(2, intWidth - 1).toLong.U(intWidth - 1, 0) - 1.U

  private val positFields = Module(new FieldsExtractor(totalBits, es))
  positFields.io.num := io.posit
  private val numFraction = positFields.io.fraction
  private val numExponent = positFields.io.exponent
  private val numSign = positFields.io.sign

  private val intSign = numSign & !io.unsignedOut
  private val zeroOut = numSign & io.unsignedOut
  private val normalisedFraction = numFraction << numExponent.asUInt()
  private val inRange = Mux(io.unsignedOut, numExponent < intWidth.S, numExponent < (intWidth - 1).S)

  private val unsignedInteger = Mux(inRange,
    normalisedFraction(intWidth + totalBits - 1, totalBits),
    Mux(io.unsignedOut, maxUnsignedInteger, maxSignedInteger))

  io.integer := Mux(intSign, Mux(inRange, ~unsignedInteger + 1.U, ~unsignedInteger), Mux(zeroOut, 0.U, unsignedInteger))
}
