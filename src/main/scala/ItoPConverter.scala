package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class ItoPConverter(totalBits: Int, es: Int, intWidth: Int) extends Module {
  val io = IO(new Bundle {
    val integer = Input(UInt(intWidth.W))
    val unsignedIn = Input(Bool())
    val posit = Output(UInt(totalBits.W))
  })

  private val resultSign = io.integer(intWidth - 1).asBool() && !io.unsignedIn
  private val integerValue = Mux(resultSign, ~io.integer + 1.U, io.integer)

  private val zeroCountMappings = Array.range(0, intWidth).reverse.map(index => {
    !(integerValue(index) === 0.U) -> (intWidth - (index + 1)).U
  })

  private val zeroCount = MuxCase(0.U, zeroCountMappings)
  private val shiftedIntegerValue = integerValue << zeroCount

  private val resultExponent = Cat(0.U, (intWidth - 1).U - zeroCount).asSInt()
  private val resultFraction = shiftedIntegerValue(intWidth - 2, 0) << totalBits + 1 >> intWidth

  private val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.sign := resultSign
  positGenerator.io.exponent := resultExponent
  positGenerator.io.fraction := resultFraction
  positGenerator.io.decimal := true.B

  io.posit := positGenerator.io.posit

}
