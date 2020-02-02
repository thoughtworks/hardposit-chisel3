package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase, log2Ceil}

class FractionExtractor(totalBits: Int) extends Module {
  val io = IO(new Bundle {
    val noOfUsedBits = Input(UInt(log2Ceil(totalBits + 1).W))
    val num = Input(UInt(totalBits.W))
    val fraction = Output(UInt((totalBits + 1).W))
  })

  val fractionCombinations = Array.range(3, totalBits).map(index => {
    (io.noOfUsedBits === index.U) -> Cat(io.num(totalBits - (index + 1), 0), 0.U(index.W))
  })

  io.fraction := Cat(1.U, MuxCase(0.U, fractionCombinations))
}
