package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class ItoPConverter(totalBits: Int, es: Int, intWidth: Int) extends Module {
  val io = IO(new Bundle {
    val integer = Input(UInt(intWidth.W))
    val unsignedIn = Input(Bool())
    val posit = Output(UInt(totalBits.W))
  })
  private val result = Wire(new unpackedPosit(totalBits, es))
  result.isNaR := false.B
  result.isZero := io.integer === 0.U
  result.sign := io.integer(intWidth - 1).asBool() && !io.unsignedIn
  private val integerValue = Mux(result.sign, ~io.integer + 1.U, io.integer)

  private val zeroCountMappings = Array.range(0, intWidth).reverse.map(index => {
    !(integerValue(index) === 0.U) -> (intWidth - (index + 1)).U
  })

  private val zeroCount = MuxCase(0.U, zeroCountMappings)
  private val shiftedIntegerValue = integerValue << zeroCount

  result.exponent := Cat(0.U, (intWidth - 1).U - zeroCount).asSInt()
  result.fraction := Cat(1.U, shiftedIntegerValue(intWidth - 2, 0) << totalBits + 1 >> intWidth)

  private val stickyBit = if(intWidth > totalBits + 1) shiftedIntegerValue(intWidth - totalBits - 2, 0).orR() else false.B
  result.stickyBit := stickyBit

  private val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.in := result

  io.posit := positGenerator.io.out
}
