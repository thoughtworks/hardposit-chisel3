import chisel3._
import chisel3.util.{Cat, MuxCase, log2Ceil}

class ExponentExtractor(totalBits: Int, es: Int) extends Module {
  require(es >= 0)
  val io = IO(new Bundle {
    val num = Input(UInt(totalBits.W))
    val totalLength = Output(UInt((log2Ceil(totalBits) + 1).W))
    val exponent = Output(SInt((log2Ceil(math.pow(2,es).toInt * totalBits) + es + 2).W))
  })

  private val regimeExtractor = Module(new RegimeExtractor(totalBits - 1))
  regimeExtractor.io.num := io.num(totalBits - 2, 0)
  private val regime = regimeExtractor.io.regime

  private val maxBits = totalBits - 1
  private val regimeLength = Mux(regimeExtractor.io.regimeLength === maxBits.U, maxBits.U, regimeExtractor.io.regimeLength + 1.U)

  private val exponentLength = Mux(regimeLength + es.U >= maxBits.U, maxBits.U - regimeLength, es.U)

  private val exponentCombinations = Array.range(2, maxBits - 1 - es).map(index => {
    (regimeLength === index.U) -> Cat(0.U(1.W),io.num(maxBits - (index + 1), maxBits - (index + 1) - es))(es+1,1)
  })

  private val exponentCombinations1 = Array.range(1, es).reverse.map(index => {
    (regimeLength === (maxBits - index).U) -> Cat(io.num(index - 1, 0),0.U((es-index).W))
  })

  io.totalLength := regimeLength + exponentLength
  private val exponent = Mux(exponentLength === 0.U, 0.U, MuxCase(0.U, exponentCombinations ++ exponentCombinations1))

  io.exponent := (math.pow(2,es).toInt.S * regime) + exponent.asSInt()
}
