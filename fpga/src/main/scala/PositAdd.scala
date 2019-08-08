import java.io.File

import chisel3._
import chisel3.util.{MuxCase, log2Ceil}
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
  new File("soc/chisel_output/float.v").delete()
}