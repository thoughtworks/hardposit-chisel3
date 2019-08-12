import chisel3._
import firrtl.{ExecutionOptionsManager, HasFirrtlOptions}

class PositAdd(totalBits: Int, es: Int) extends Module {
  require(totalBits > es)
  require(es >= 0)

  val io = IO(new Bundle {
    val num1 = Input(UInt(totalBits.W))
    val num2 = Input(UInt(totalBits.W))
    val out = Output(UInt(totalBits.W))
  })

  /*
  private val regimeExtractor = new RegimeExtractor(totalBits - 1)
  regimeExtractor.io.num := io.num1(totalBits - 2, 0)
  private val regimeLength = regimeExtractor.io.regimeLength
  private val regime = regimeExtractor.io.regime

  private val exponentExtractor = new ExponentExtractor(totalBits,es)
  exponentExtractor.io.regimeLength := regimeLength
  exponentExtractor.io.num := io.num1
  private val totalLengthAfterExponent = exponentExtractor.io.totalLength
  private val exponent = exponentExtractor.io.exponent
  */
  io.out := 0.U
}

object PositAdd extends App {
  val optionsManager = new ExecutionOptionsManager("chisel3") with HasChiselExecutionOptions with HasFirrtlOptions
  optionsManager.setTargetDirName("soc/chisel_output")
  Driver.execute(optionsManager, () => new PositAdd(8,0))
}