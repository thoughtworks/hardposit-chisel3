package hardposit

import chisel3._

class Eval_PositINtoPN(nbits: Int, es: Int, intWidth: Int) extends Module {

  val io = IO(new Bundle {
    val in = Input(UInt(intWidth.W))

    val expected = Input(UInt(nbits.W))
    val actual = Output(UInt(nbits.W))

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val i2p = Module(new ItoPConverter(nbits, es, intWidth))
  i2p.io.integer := io.in
  i2p.io.unsignedIn := false.B

  io.actual := i2p.io.posit

  io.check := true.B
  io.pass := (io.expected === io.actual)
}

class Eval_PositI32toP16 extends Eval_PositINtoPN(16, 1, 32)
class Eval_PositI64toP16 extends Eval_PositINtoPN(16, 1, 64)
class Eval_PositI32toP32 extends Eval_PositINtoPN(32, 2, 32)
class Eval_PositI64toP32 extends Eval_PositINtoPN(32, 2, 64)
class Eval_PositI32toP64 extends Eval_PositINtoPN(64, 3, 32)
class Eval_PositI64toP64 extends Eval_PositINtoPN(64, 3, 64)

class Eval_PositUINtoPN(nbits: Int, es: Int, intWidth: Int) extends Module {

  val io = IO(new Bundle {
    val in = Input(UInt(intWidth.W))

    val expected = Input(UInt(nbits.W))
    val actual = Output(UInt(nbits.W))

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val i2p = Module(new ItoPConverter(nbits, es, intWidth))
  i2p.io.integer := io.in
  i2p.io.unsignedIn := true.B

  io.actual := i2p.io.posit

  io.check := true.B
  io.pass := (io.expected === io.actual)
}

class Eval_PositUI32toP16 extends Eval_PositUINtoPN(16, 1, 32)
class Eval_PositUI64toP16 extends Eval_PositUINtoPN(16, 1, 64)
class Eval_PositUI32toP32 extends Eval_PositUINtoPN(32, 2, 32)
class Eval_PositUI64toP32 extends Eval_PositUINtoPN(32, 2, 64)
class Eval_PositUI32toP64 extends Eval_PositUINtoPN(64, 3, 32)
class Eval_PositUI64toP64 extends Eval_PositUINtoPN(64, 3, 64)
