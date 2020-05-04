package hardposit

import chisel3._
import chisel3.util.{Decoupled, Queue}

class DivIO(totalBits: Int, es: Int) extends Bundle {
  val num1 = UInt(totalBits.W)
  val num2 = UInt(totalBits.W)
  val expected = UInt(totalBits.W)

  override def cloneType =
    new DivIO(totalBits, es).asInstanceOf[this.type]
}

class Eval_PositDivSqrt_div(totalBits: Int, es: Int) extends Module {

  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new DivIO(totalBits, es)))

    val out = new Bundle {
      val num1 = Output(UInt(totalBits.W))
      val num2 = Output(UInt(totalBits.W))
    }

    val expected = Output(UInt(totalBits.W))
    val actual = Output(UInt(totalBits.W))

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val positDivSqrt = Module(new PositDivSqrt(totalBits, es))
  val inq = Module(new Queue(new DivIO(totalBits, es), 5))

  inq.io.enq.valid := io.in.valid && positDivSqrt.io.readyIn
  inq.io.enq.bits := io.in.bits

  io.in.ready := positDivSqrt.io.readyIn && inq.io.enq.ready
  positDivSqrt.io.validIn := io.in.valid && inq.io.enq.ready
  positDivSqrt.io.num1 := io.in.bits.num1
  positDivSqrt.io.num2 := io.in.bits.num2
  positDivSqrt.io.sqrtOp := false.B

  io.out.num1 := inq.io.deq.bits.num1
  io.out.num2 := inq.io.deq.bits.num2
  io.expected := inq.io.deq.bits.expected
  io.actual := positDivSqrt.io.out
  inq.io.deq.ready := positDivSqrt.io.validOut_div
  io.check := positDivSqrt.io.validOut_div
  val expectedException = Mux(io.out.num2 === 0.U, 8.U, 0.U)

  io.pass := inq.io.deq.valid && (io.expected === io.actual) && (expectedException === positDivSqrt.io.exceptions)
}

class Eval_PositDivSqrtP16_div extends Eval_PositDivSqrt_div(16, 1)

class Eval_PositDivSqrtP32_div extends Eval_PositDivSqrt_div(32, 2)

class Eval_PositDivSqrtP64_div extends Eval_PositDivSqrt_div(64, 3)

class SqrtIO(totalBits: Int, es: Int) extends Bundle {
  val num1 = UInt(totalBits.W)
  val expected = UInt(totalBits.W)

  override def cloneType =
    new SqrtIO(totalBits, es).asInstanceOf[this.type]
}

class Eval_PositDivSqrt_sqrt(totalBits: Int, es: Int) extends Module {

  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new SqrtIO(totalBits, es)))

    val out = new Bundle {
      val num1 = Output(UInt(totalBits.W))
    }

    val expected = Output(UInt(totalBits.W))
    val actual = Output(UInt(totalBits.W))

    val check = Output(Bool())
    val pass = Output(Bool())
  })

  val positDivSqrt = Module(new PositDivSqrt(totalBits, es))
  val inq = Module(new Queue(new SqrtIO(totalBits, es), 5))

  inq.io.enq.valid := io.in.valid && positDivSqrt.io.readyIn
  inq.io.enq.bits := io.in.bits

  io.in.ready := positDivSqrt.io.readyIn && inq.io.enq.ready
  positDivSqrt.io.validIn := io.in.valid && inq.io.enq.ready
  positDivSqrt.io.num1 := io.in.bits.num1
  positDivSqrt.io.num2 := 0.U
  positDivSqrt.io.sqrtOp := true.B

  io.out.num1 := inq.io.deq.bits.num1
  io.expected := inq.io.deq.bits.expected
  io.actual := positDivSqrt.io.out
  inq.io.deq.ready := positDivSqrt.io.validOut_sqrt
  io.check := positDivSqrt.io.validOut_sqrt

  io.pass := inq.io.deq.valid && (io.expected === io.actual)
}

class Eval_PositDivSqrtP16_sqrt extends Eval_PositDivSqrt_sqrt(16, 1)

class Eval_PositDivSqrtP32_sqrt extends Eval_PositDivSqrt_sqrt(32, 2)

class Eval_PositDivSqrtP64_sqrt extends Eval_PositDivSqrt_sqrt(64, 3)