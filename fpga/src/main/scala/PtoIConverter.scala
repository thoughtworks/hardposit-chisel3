package hardposit

import chisel3._

class PtoIConverter(totalBits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val posit = Input(UInt(totalBits.W))
    val unsigned = Input(Bool())
    val integer = Output(UInt(totalBits.W))
  })

  private val positFields = Module(new FieldsExtractor(totalBits, es))
  positFields.io.num := io.posit
  private val numFraction = positFields.io.fraction
  private val numExponent = positFields.io.exponent
  private val numSign = positFields.io.sign

  private val intSign = numSign & !io.unsigned
  private val normalisedFraction = numFraction << numExponent.asUInt()

  private val unsignedInteger = Mux(io.unsigned,
    Mux(numExponent < totalBits.S, normalisedFraction(2 * totalBits - 1, totalBits), math.pow(2, totalBits).toInt.U - 1.U),
    Mux(numExponent < (totalBits - 1).S, normalisedFraction(2 * totalBits - 1, totalBits), math.pow(2, totalBits).toInt.U - 1.U))

  io.integer := Mux(intSign, ~unsignedInteger + 1.U, unsignedInteger)
}
