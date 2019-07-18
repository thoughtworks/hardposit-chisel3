import chisel3._
import chisel3.core.{BlackBox, Bundle, Input, Output, UInt}
import chisel3.util.HasBlackBoxResource

class float extends BlackBox with HasBlackBoxResource{
  val io = IO(new Bundle {
    val clk = Input(Bool())
    val areset = Input(Bool())
    val a = Input(UInt(32.W))
    val b = Input(UInt(32.W))
    val q = Output(UInt(32.W))
  })

  setResource("/float.v")
}
