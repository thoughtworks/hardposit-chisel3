package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class PositGeneratorWrapper(totalBits: Int, es: Int) extends Module {
  private val base = 1 << es
  private val exponentBits = (base * (totalBits - 1)) + 1
  private val NaR = (1 << totalBits - 1)
  private val maxExponent = (base * (totalBits - 1)) - 1

  val io = IO(new Bundle {
    val sign = Input(Bool())
    val exponent = Input(SInt(exponentBits.W))
    val decimal = Input(Bool())
    val fraction = Input(UInt(totalBits.W))
    val posit = Output(UInt(totalBits.W))
  })

  private val fractionWithDecimal = Cat(io.decimal, io.fraction)
  private val exponentOffsetCombinations = Array.range(0, totalBits + 1).map(index => {
    (fractionWithDecimal(totalBits, totalBits - index) === 1.U) -> index.S
  })

  private val exponentOffset = MuxCase(0.S, exponentOffsetCombinations)

  private val exponent = io.exponent - exponentOffset
  private val fraction = fractionWithDecimal << exponentOffset.asUInt()

  private val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.sign := io.sign
  positGenerator.io.exponent := exponent
  positGenerator.io.fraction := fraction

  io.posit := Mux(fractionWithDecimal === 0.U | exponent <= 0.S - maxExponent.S, 0.U, Mux(exponent > maxExponent.S, NaR.U, positGenerator.io.posit))
}
