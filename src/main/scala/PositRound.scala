package hardposit

import chisel3._
import chisel3.util._

object roundToNearestEven {
  def apply(last: Bool, guard: Bool, round: Bool, sticky: Bool): Bool = {
    guard & ~(~last & guard & ~round & ~sticky)
  }
}

class PositRound(val nbits: Int, val es: Int) extends Module with HasHardPositParams{

  val io = IO(new Bundle {
    val in = Input(new unpackedPosit(nbits, es))
    val trailingBits = Input(UInt(trailingBitCount.W))
    val stickyBit = Input(Bool())

    val out = Output(new unpackedPosit(nbits,es))
  })

  io.out := io.in

  val roundBit = roundToNearestEven(
    io.in.fraction(0),
    io.trailingBits(trailingBitCount - 1),
    io.trailingBits(trailingBitCount - 2),
    io.stickyBit | {
      if (trailingBitCount > 2) io.trailingBits(trailingBitCount - 3, 0).orR()
      else false.B
    })

  val roundFrac  = WireInit(UInt((maxFractionBitsWithHiddenBit + 1).W), io.in.fraction +& roundBit)
  val fracOverflow = roundFrac(maxFractionBitsWithHiddenBit)

  val roundExp = WireInit(SInt((maxExponentBits + 1).W), io.in.exponent +& fracOverflow.zext)
  val overflow = roundExp >= maxExponent.S

  io.out.exponent :=
    Mux(io.in.isNaR || io.in.isZero,
      0.S, Mux(overflow,
        maxExponent.S, roundExp))

  io.out.fraction :=
    Mux(fracOverflow || overflow || io.in.isNaR || io.in.isZero,
      Cat(1.U, 0.U(maxFractionBits.W)),
      roundFrac)
}
