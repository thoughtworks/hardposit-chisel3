package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class ItoPConverter(val totalBits: Int, val es: Int, intWidth: Int) extends Module with HasHardPositParams {
  val io = IO(new Bundle {
    val integer = Input(UInt(intWidth.W))
    val unsignedIn = Input(Bool())
    val posit = Output(UInt(totalBits.W))
  })
  val narrowConv = intWidth > maxFractionBitsWithHiddenBit

  val result = Wire(new unpackedPosit(totalBits, es))

  result.isNaR  := false.B
  result.isZero := io.integer === 0.U
  result.sign   := io.integer(intWidth - 1).asBool() && !io.unsignedIn

  val intVal = Mux(result.sign, ~io.integer + 1.U, io.integer)

  private val zeroCountMappings = Array.range(0, intWidth).reverse.map(index => {
    !(intVal(index) === 0.U) -> (intWidth - (index + 1)).U
  })

  val zeroCount = MuxCase(0.U, zeroCountMappings)
  val shiftedIntVal = intVal << zeroCount

  result.exponent :=
    Cat(0.U, (intWidth - 1).U - zeroCount).asSInt()

  result.fraction := {
    if(narrowConv)
      shiftedIntVal(intWidth - 1, 0) >> (intWidth - maxFractionBitsWithHiddenBit)
    else
      shiftedIntVal(intWidth - 1, 0) << (maxFractionBitsWithHiddenBit - intWidth)
  }

  val trailingBits =
    if(narrowConv)
      Cat(shiftedIntVal, 0.U(trailingBitCount.W))(intWidth - maxFractionBitsWithHiddenBit + trailingBitCount - 1, intWidth - maxFractionBitsWithHiddenBit)
    else 0.U

  val stickyBit =
    if(narrowConv)
      Cat(shiftedIntVal, 0.U(trailingBitCount.W))(intWidth - maxFractionBitsWithHiddenBit - 1, 0).orR()
    else false.B

  private val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.in <> result
  positGenerator.io.trailingBits := trailingBits
  positGenerator.io.stickyBit    := stickyBit

  io.posit := positGenerator.io.out
}
