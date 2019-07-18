import java.io.File

import chisel3._
import chisel3.core.Bundle
import firrtl.{ExecutionOptionsManager, HasFirrtlOptions}

class PositTop extends Module{
  val io = IO(new Bundle {
    val led = Output(UInt(4.W))
  })

  private val soc = Module(new soc_system)
  soc.io.clk_clk := clock.asUInt().toBool()
  soc.io.reset_reset := reset.asBool()

  private val fp = Module(new FloatOperation)
  fp.io.num1 := soc.io.num1_export
  fp.io.num2 := soc.io.num2_export
  soc.io.result_export := fp.io.result
  io.led := 5.U
}

object PositTop extends App {
  val optionsManager = new ExecutionOptionsManager("chisel3") with HasChiselExecutionOptions with HasFirrtlOptions
  optionsManager.setTargetDirName("soc/chisel_output")
  Driver.execute(optionsManager, () => new PositTop())
  new File("soc/chisel_output/soc_system.v").delete()
  new File("soc/chisel_output/float.v").delete()
}