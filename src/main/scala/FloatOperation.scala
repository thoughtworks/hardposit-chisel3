package hardposit

import java.io.File

import chisel3._
import chisel3.core.{Bundle, Input, Output, UInt}
import firrtl.{ExecutionOptionsManager, HasFirrtlOptions}

class FloatOperation extends Module {
  val io = IO(new Bundle {
    val num1 = Input(UInt(32.W))
    val num2 = Input(UInt(32.W))
    val result = Output(UInt(32.W))
  })

  private val fp = Module(new float)
  fp.io.clk := clock.asUInt().toBool()
  fp.io.areset := reset.toBool()
  fp.io.a := io.num1
  fp.io.b := io.num2
  io.result := fp.io.q
}

object FloatOperation extends App {
  val optionsManager = new ExecutionOptionsManager("chisel3") with HasChiselExecutionOptions with HasFirrtlOptions
  optionsManager.setTargetDirName("soc/chisel_output")
  Driver.execute(optionsManager, () => new FloatOperation())
  new File("soc/chisel_output/float.v").delete()
}