import chisel3._
import firrtl.{ExecutionOptionsManager, HasFirrtlOptions}

class PositAdd(totalBits: Int, es: Int) extends Module {
  require(totalBits > es)
  val io = IO(new Bundle {
    val num1 = Input(UInt(totalBits.W))
    val num2 = Input(UInt(totalBits.W))
    val out = Output(UInt(totalBits.W))
  })

  io.out := 0.U
}

object PositAdd extends App {
  val optionsManager = new ExecutionOptionsManager("chisel3") with HasChiselExecutionOptions with HasFirrtlOptions
  optionsManager.setTargetDirName("soc/chisel_output")
  Driver.execute(optionsManager, () => new PositAdd(8,0))
}