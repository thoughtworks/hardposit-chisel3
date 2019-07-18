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
  io.led := soc.io.led_pio_export
}

object PositTop extends App {
  val optionsManager = new ExecutionOptionsManager("chisel3") with HasChiselExecutionOptions with HasFirrtlOptions
  optionsManager.setTargetDirName("soc/chisel_output")
  Driver.execute(optionsManager, () => new PositTop())
  private val file = new File("soc/chisel_output/soc_system.v")
  file.delete()
}