import chisel3._
import chisel3.util.{MuxCase, log2Ceil}

class RegimeExtractor(totalBits: Int) extends Module {
  require(totalBits > 1)
  val io = IO(new Bundle {
    val num = Input(UInt(totalBits.W))
    val regimeLength = Output(UInt(log2Ceil(totalBits).W))
    val regime = Output(SInt((log2Ceil(totalBits) + 1).W))
  })

  private val regimeMappingForOnes = Array.range(0, totalBits - 1).map(index => {
    val num = io.num(totalBits - 1, totalBits - (2 + index))
    val regimePattern = (math.pow(2, index + 2) - 2).toInt.U
    (num === regimePattern) -> index.U
  })

  private val regimeMappingForZeroes = Array.range(0, totalBits - 1).map(index => {
    val num = io.num(totalBits - 1, totalBits - (2 + index))
    (num === 1.U) -> index.U
  })

  io.regimeLength := MuxCase(0.U, regimeMappingForOnes ++ regimeMappingForZeroes) + 1.U
  io.regime := Mux(io.num(totalBits - 1), io.regimeLength.asSInt() - 1.S, 0.S - io.regimeLength.asSInt())
}
