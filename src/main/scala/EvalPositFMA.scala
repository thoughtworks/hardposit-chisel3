package hardposit

import chisel3._

class EvalPositFMA(totalBits: Int, es: Int) extends Module {

  val io = IO(new Bundle {
    val num1 = Input(UInt(totalBits.W))
    val num2 = Input(UInt(totalBits.W))
    val num3 = Input(UInt(totalBits.W))

    val expected = Input(UInt(totalBits.W))
    val actual = Output(UInt(totalBits.W))

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val positFMA = Module(new PositFMA(totalBits, es))
  positFMA.io.num1 := io.num1
  positFMA.io.num2 := io.num2
  positFMA.io.num3 := io.num3
  positFMA.io.sub := false.B
  positFMA.io.negate := false.B

  io.actual := positFMA.io.out

  io.check := true.B
  io.pass := (io.expected === io.actual)
}

class EvalPositFMA_16 extends EvalPositFMA(16, 1)

class EvalPositFMA_32 extends EvalPositFMA(32, 2)

class EvalPositFMA_64 extends EvalPositFMA(64, 3)

class EvalPositFMA_add(totalBits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val num1 = Input(UInt(totalBits.W))
    val num2 = Input(UInt(totalBits.W))

    val expected = Input(UInt(totalBits.W))
    val actual = Output(UInt(totalBits.W))

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val positFMA = Module(new PositFMA(totalBits, es))
  positFMA.io.num1 := io.num1
  positFMA.io.num2 := (1 << (totalBits - 2)).U
  positFMA.io.num3 := io.num2
  positFMA.io.sub := false.B
  positFMA.io.negate := false.B

  io.actual := positFMA.io.out

  io.check := true.B
  io.pass := (io.expected === io.actual)
}

class EvalPositFMA_add_16 extends EvalPositFMA_add(16, 1)

class EvalPositFMA_add_32 extends EvalPositFMA_add(32, 2)

class EvalPositFMA_add_64 extends EvalPositFMA_add(64, 3)

class EvalPositFMA_mul(totalBits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val num1 = Input(UInt(totalBits.W))
    val num2 = Input(UInt(totalBits.W))

    val expected = Input(UInt(totalBits.W))
    val actual = Output(UInt(totalBits.W))

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val positFMA = Module(new PositFMA(totalBits, es))
  positFMA.io.num1 := io.num1
  positFMA.io.num2 := io.num2
  positFMA.io.num3 := 0.U
  positFMA.io.sub := false.B
  positFMA.io.negate := false.B

  io.actual := positFMA.io.out

  io.check := true.B
  io.pass := (io.expected === io.actual)
}

class EvalPositFMA_mul_16 extends EvalPositFMA_mul(16, 1)

class EvalPositFMA_mul_32 extends EvalPositFMA_mul(32, 2)

class EvalPositFMA_mul_64 extends EvalPositFMA_mul(64, 3)