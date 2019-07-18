import chisel3._
import chisel3.core.{Bundle, Input, Output, UInt}
import chisel3.util.HasBlackBoxResource

class soc_system extends BlackBox with HasBlackBoxResource{
  val io = IO(new Bundle {
    val clk_clk = Input(Bool())
    val reset_reset = Input(Bool())
    val led_pio_export = Output(UInt(8.W))
  })

  setResource("/soc_system.v")
}
