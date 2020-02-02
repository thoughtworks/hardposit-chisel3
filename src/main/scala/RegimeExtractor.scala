package hardposit

import chisel3._
import chisel3.util.{MuxCase, log2Ceil}

class RegimeExtractor(totalBits: Int) extends Module {
  require(totalBits > 1)
  val io = IO(new Bundle {
    val num = Input(UInt(totalBits.W))
    val regimeLength = Output(UInt((log2Ceil(totalBits) + 1).W))
    val regime = Output(SInt((log2Ceil(totalBits) + 1).W))
  })

  private val regimeMappings = Array.range(0, totalBits - 1).reverse.map(index => {
    (!(io.num(index + 1) === io.num(index))) -> (totalBits - (index + 1)).U
  })

  io.regimeLength := MuxCase(totalBits.U, regimeMappings)

  io.regime := Mux(io.num(totalBits - 1), io.regimeLength.asSInt() - 1.S, 0.S - io.regimeLength.asSInt())
}
