package hardposit

import chisel3._

class Eval_PositPNtoPN(inWidth: Int, inEs: Int, outWidth: Int, outEs: Int) extends Module {

  val io = IO(new Bundle {
    val in = Input(UInt(inWidth.W))

    val expected = Input(UInt(outWidth.W))
    val actual = Output(UInt(outWidth.W))

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val p2p = Module(new PtoPConverter(inWidth, inEs, outWidth, outEs))
  p2p.io.in := io.in

  io.actual := p2p.io.out

  io.check := true.B
  io.pass := (io.expected === io.actual)
}

class Eval_PositP16toP32 extends Eval_PositPNtoPN(16, 1, 32, 2)
class Eval_PositP16toP64 extends Eval_PositPNtoPN(16, 1, 64, 3)
class Eval_PositP32toP16 extends Eval_PositPNtoPN(32, 2, 16, 1)
class Eval_PositP32toP64 extends Eval_PositPNtoPN(32, 2, 64, 3)
class Eval_PositP64toP16 extends Eval_PositPNtoPN(64, 3, 16, 1)
class Eval_PositP64toP32 extends Eval_PositPNtoPN(64, 3, 32, 2)
