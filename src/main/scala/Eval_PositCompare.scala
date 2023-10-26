package hardposit

import chisel3._

class Eval_PositCompare_lt(nbits: Int, es: Int) extends Module {

  val io = IO(new Bundle {
    val num1 = Input(UInt(nbits.W))
    val num2 = Input(UInt(nbits.W))

    val expected = Input(Bool())
    val actual = Output(Bool())

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val positCompare = Module(new PositCompare(nbits, es))
  positCompare.io.num1 := io.num1.asSInt
  positCompare.io.num2 := io.num2.asSInt

  io.actual := positCompare.io.lt

  io.check := true.B
  io.pass := (io.expected === io.actual)
}

class Eval_PositCompareP16_lt extends Eval_PositCompare_lt(16, 1)

class Eval_PositCompareP32_lt extends Eval_PositCompare_lt(32, 2)

class Eval_PositCompareP64_lt extends Eval_PositCompare_lt(64, 3)

class Eval_PositCompare_eq(nbits: Int, es: Int) extends Module {

  val io = IO(new Bundle {
    val num1 = Input(UInt(nbits.W))
    val num2 = Input(UInt(nbits.W))

    val expected = Input(Bool())
    val actual = Output(Bool())

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val positCompare = Module(new PositCompare(nbits, es))
  positCompare.io.num1 := io.num1.asSInt
  positCompare.io.num2 := io.num2.asSInt

  io.actual := positCompare.io.eq

  io.check := true.B
  io.pass := (io.expected === io.actual)
}

class Eval_PositCompareP16_eq extends Eval_PositCompare_eq(16, 1)

class Eval_PositCompareP32_eq extends Eval_PositCompare_eq(32, 2)

class Eval_PositCompareP64_eq extends Eval_PositCompare_eq(64, 3)

class Eval_PositCompare_gt(nbits: Int, es: Int) extends Module {

  val io = IO(new Bundle {
    val num1 = Input(UInt(nbits.W))
    val num2 = Input(UInt(nbits.W))

    val expected = Input(Bool())
    val actual = Output(Bool())

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val positCompare = Module(new PositCompare(nbits, es))
  positCompare.io.num1 := io.num1.asSInt
  positCompare.io.num2 := io.num2.asSInt

  io.actual := positCompare.io.gt

  io.check := true.B
  io.pass := (io.expected === io.actual)
}

class Eval_PositCompareP16_gt extends Eval_PositCompare_gt(16, 1)

class Eval_PositCompareP32_gt extends Eval_PositCompare_gt(32, 2)

class Eval_PositCompareP64_gt extends Eval_PositCompare_gt(64, 3)