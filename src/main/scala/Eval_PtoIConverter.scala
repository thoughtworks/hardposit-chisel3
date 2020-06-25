package hardposit

import chisel3._

class Eval_PositPNtoIN(nbits: Int, es: Int, intWidth: Int) extends Module {

  val io = IO(new Bundle {
    val in = Input(UInt(nbits.W))

    val expected = Input(UInt(intWidth.W))
    val actual = Output(UInt(intWidth.W))

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val p2i = Module(new PtoIConverter(nbits, es, intWidth))
  p2i.io.posit := io.in
  p2i.io.unsignedOut := false.B
  p2i.io.roundingMode := true.B

  io.actual := p2i.io.integer

  io.check := true.B
  io.pass := (io.expected === io.actual)
}

class Eval_PositP16toI32 extends Eval_PositPNtoIN(16, 1, 32)
class Eval_PositP16toI64 extends Eval_PositPNtoIN(16, 1, 64)
class Eval_PositP32toI32 extends Eval_PositPNtoIN(32, 2, 32)
class Eval_PositP32toI64 extends Eval_PositPNtoIN(32, 2, 64)
class Eval_PositP64toI32 extends Eval_PositPNtoIN(64, 3, 32)
class Eval_PositP64toI64 extends Eval_PositPNtoIN(64, 3, 64)

class Eval_PositPNtoUIN(nbits: Int, es: Int, intWidth: Int) extends Module {

  val io = IO(new Bundle {
    val in = Input(UInt(nbits.W))

    val expected = Input(UInt(intWidth.W))
    val actual = Output(UInt(intWidth.W))

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val p2i = Module(new PtoIConverter(nbits, es, intWidth))
  p2i.io.posit := io.in
  p2i.io.unsignedOut := true.B
  p2i.io.roundingMode := true.B

  io.actual := p2i.io.integer

  io.check := true.B
  io.pass := (io.expected === io.actual)
}

class Eval_PositP16toUI32 extends Eval_PositPNtoUIN(16, 1, 32)
class Eval_PositP16toUI64 extends Eval_PositPNtoUIN(16, 1, 64)
class Eval_PositP32toUI32 extends Eval_PositPNtoUIN(32, 2, 32)
class Eval_PositP32toUI64 extends Eval_PositPNtoUIN(32, 2, 64)
class Eval_PositP64toUI32 extends Eval_PositPNtoUIN(64, 3, 32)
class Eval_PositP64toUI64 extends Eval_PositPNtoUIN(64, 3, 64)