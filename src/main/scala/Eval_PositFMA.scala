package hardposit

import chisel3._

class Eval_PositFMA(nbits: Int, es: Int) extends Module {

  val io = IO(new Bundle {
    val num1 = Input(UInt(nbits.W))
    val num2 = Input(UInt(nbits.W))
    val num3 = Input(UInt(nbits.W))

    val expected = Input(UInt(nbits.W))
    val actual = Output(UInt(nbits.W))

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val positFMA = Module(new PositFMA(nbits, es))
  positFMA.io.num1 := io.num1
  positFMA.io.num2 := io.num2
  positFMA.io.num3 := io.num3
  positFMA.io.sub := false.B
  positFMA.io.negate := false.B

  io.actual := positFMA.io.out

  io.check := true.B
  io.pass := (io.expected === io.actual)
}

class Eval_PositFMAP16 extends Eval_PositFMA(16, 1)

class Eval_PositFMAP32 extends Eval_PositFMA(32, 2)

class Eval_PositFMAP64 extends Eval_PositFMA(64, 3)

class Eval_PositFMA_add(nbits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val num1 = Input(UInt(nbits.W))
    val num2 = Input(UInt(nbits.W))

    val expected = Input(UInt(nbits.W))
    val actual = Output(UInt(nbits.W))

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val positFMA = Module(new PositFMA(nbits, es))
  positFMA.io.num1 := io.num1
  positFMA.io.num2 := (1.U << (nbits - 2).U)
  positFMA.io.num3 := io.num2
  positFMA.io.sub := false.B
  positFMA.io.negate := false.B

  io.actual := positFMA.io.out

  io.check := true.B
  io.pass := (io.expected === io.actual)
}

class Eval_PositFMAP16_add extends Eval_PositFMA_add(16, 1)

class Eval_PositFMAP32_add extends Eval_PositFMA_add(32, 2)

class Eval_PositFMAP64_add extends Eval_PositFMA_add(64, 3)

class Eval_PositFMA_mul(nbits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val num1 = Input(UInt(nbits.W))
    val num2 = Input(UInt(nbits.W))

    val expected = Input(UInt(nbits.W))
    val actual = Output(UInt(nbits.W))

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val positFMA = Module(new PositFMA(nbits, es))
  positFMA.io.num1 := io.num1
  positFMA.io.num2 := io.num2
  positFMA.io.num3 := 0.U
  positFMA.io.sub := false.B
  positFMA.io.negate := false.B

  io.actual := positFMA.io.out

  io.check := true.B
  io.pass := (io.expected === io.actual)
}

class Eval_PositFMAP16_mul extends Eval_PositFMA_mul(16, 1)

class Eval_PositFMAP32_mul extends Eval_PositFMA_mul(32, 2)

class Eval_PositFMAP64_mul extends Eval_PositFMA_mul(64, 3)