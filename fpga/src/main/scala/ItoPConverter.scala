package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class ItoPConverter(totalBits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val integer = Input(UInt(totalBits.W))
    val unsigned = Input(Bool())
    val posit = Output(UInt(totalBits.W))
  })

  private val resultSign = io.integer(totalBits - 1).asBool() && !io.unsigned
  private val integerValue = Mux(resultSign, ~io.integer + 1.U, io.integer)

  private val zeroCountMappings = Array.range(0, totalBits - 1).reverse.map(index => {
    !(integerValue(index) === 0.U) -> (totalBits - (index + 1)).U
  })

  private val zeroCount = MuxCase(0.U, zeroCountMappings)
  private val shiftedIntegerValue = integerValue << zeroCount

  private val resultExponent = Cat(0.U, (totalBits - 1).U - zeroCount).asSInt()
  private val resultFraction = shiftedIntegerValue(totalBits - 2, 0) << 1.U

  private val positGenerator = Module(new PositGeneratorWrapper(totalBits, es))
  positGenerator.io.sign := resultSign
  positGenerator.io.exponent := resultExponent
  positGenerator.io.fraction := resultFraction
  positGenerator.io.decimal := true.B

  io.posit := positGenerator.io.posit

}
