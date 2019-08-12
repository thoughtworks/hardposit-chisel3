import chisel3._
import chisel3.util.{MuxCase, log2Ceil}

class ExponentExtractor(totalBits: Int, es: Int) extends Module {
  require(es >= 0)
  val io = IO(new Bundle{
    val regimeLength = Input(UInt((log2Ceil(totalBits) + 1).W))
    val num = Input(UInt(totalBits.W))
    val totalLength = Output(UInt((log2Ceil(totalBits) + 1).W))
    val exponent = Output(UInt(log2Ceil(es + 2).W))
  })

  private val maxBits = totalBits - 1
  private val regimeLength = Mux(io.regimeLength === maxBits.U,maxBits.U,io.regimeLength + 1.U)

  private val exponentLength = Mux(regimeLength + es.U >= maxBits.U,maxBits.U - regimeLength,es.U)

  private val exponentCombinations = Array.range(2,totalBits).map(index => {
    if(index + es > maxBits){
       (regimeLength === index.U) -> io.num(maxBits - index,0)
    }
    else {
      (regimeLength === index.U) -> io.num(maxBits - index + 1,maxBits - index + 1 - es)
    }
  })

  io.totalLength := regimeLength + exponentLength
  io.exponent :=  Mux(exponentLength === 0.U,0.U,MuxCase(0.U,exponentCombinations))
}
