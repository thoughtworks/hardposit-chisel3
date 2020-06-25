package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class ItoPConverterCore(val nbits: Int, val es: Int, intWidth: Int) extends Module with HasHardPositParams {
  val io = IO(new Bundle {
    val integer    = Input(UInt(intWidth.W))
    val unsignedIn = Input(Bool())

    val trailingBits = Output(UInt(trailingBitCount.W))
    val stickyBit    = Output(Bool())
    val posit        = Output(new unpackedPosit(nbits, es))
  })
  val narrowConv = intWidth > maxFractionBitsWithHiddenBit

  val result = Wire(new unpackedPosit(nbits, es))

  result.isNaR  := false.B
  result.isZero := io.integer === 0.U
  result.sign   := io.integer(intWidth - 1).asBool() && !io.unsignedIn

  val intVal = Mux(result.sign, ~io.integer + 1.U, io.integer)

  val zeroCount = countLeadingZeros(intVal)
  val shiftedIntVal = intVal << zeroCount

  result.exponent :=
    Cat(0.U, (intWidth - 1).U - zeroCount).asSInt()

  result.fraction := {
    if(narrowConv)
      shiftedIntVal(intWidth - 1, intWidth - maxFractionBitsWithHiddenBit)
    else
      Cat(shiftedIntVal(intWidth - 1, 0), 0.U((maxFractionBitsWithHiddenBit - intWidth).W))
  }

  io.trailingBits := {
    if(narrowConv)
      Cat(shiftedIntVal, 0.U(trailingBitCount.W))(intWidth - maxFractionBitsWithHiddenBit + trailingBitCount - 1, intWidth - maxFractionBitsWithHiddenBit)
    else 0.U }

  io.stickyBit := {
    if(narrowConv)
      Cat(shiftedIntVal, 0.U(trailingBitCount.W))(intWidth - maxFractionBitsWithHiddenBit - 1, 0).orR()
    else false.B }

  io.posit := result
}

class ItoPConverter(val nbits: Int, val es: Int, intWidth: Int) extends Module with HasHardPositParams {
  val io = IO(new Bundle {
    val integer    = Input(UInt(intWidth.W))
    val unsignedIn = Input(Bool())

    val posit = Output(UInt(nbits.W))
  })

  val i2pCore = Module(new ItoPConverterCore(nbits, es, intWidth))
  i2pCore.io.integer    := io.integer
  i2pCore.io.unsignedIn := io.unsignedIn

  val positGenerator = Module(new PositGenerator(nbits, es))
  positGenerator.io.in := i2pCore.io.posit
  positGenerator.io.trailingBits := i2pCore.io.trailingBits
  positGenerator.io.stickyBit    := i2pCore.io.stickyBit

  io.posit := positGenerator.io.out
}
