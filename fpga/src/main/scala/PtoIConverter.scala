package hardposit

import chisel3._

class PtoIConverter(totalBits: Int, es: Int, intWidth: Int) extends Module {
  val io = IO(new Bundle {
    val posit = Input(UInt(totalBits.W))
    val unsignedOut = Input(Bool())
    val integer = Output(UInt(intWidth.W))
  })

  private val positFields = Module(new FieldsExtractor(totalBits, es))
  positFields.io.num := io.posit
  private val numFraction = positFields.io.fraction
  private val numExponent = positFields.io.exponent
  private val numSign = positFields.io.sign

  private val intSign = numSign & !io.unsignedOut
  private val normalisedFraction = numFraction << numExponent.asUInt()

  private val unsignedInteger = Mux(io.unsignedOut,
    Mux(numExponent < intWidth.S, normalisedFraction(intWidth + totalBits - 1, totalBits), math.pow(2, intWidth).toInt.U - 1.U),
    Mux(numExponent < (intWidth - 1).S, normalisedFraction(intWidth + totalBits - 1, totalBits), math.pow(2, intWidth).toInt.U - 1.U))

  io.integer := Mux(intSign, ~unsignedInteger + 1.U, unsignedInteger)
}
