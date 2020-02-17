package hardposit

import chisel3._
import chisel3.util.log2Ceil

class PositSqrt(totalBits: Int, es: Int) extends Module {
  val io = IO(new Bundle {
    val num = Input(UInt(totalBits.W))
    val valid = Input(Bool())
    val out = Output(UInt(totalBits.W))
    val isNaR = Output(Bool())
    val ready = Output(Bool())
  })
  private val NaR = 1.U << (totalBits - 1)

  val validNum = RegInit(0.U(totalBits.W))
  val start = RegInit(0.U(2.W))
  val ready = RegInit(true.B)
  val finalRoot = RegInit(0.U((totalBits + 2).W))
  val finalExponent = RegInit(0.S((log2Ceil(math.pow(2, es).toInt * totalBits) + es + 2).W))

  io.ready := ready

  private val numExtractor = Module(new PositExtractor(totalBits, es))
  numExtractor.io.in := io.num
  private val num = numExtractor.io.out

  io.isNaR := num.sign || num.isNaR

  when(io.valid && ready) {
    validNum := io.num
    start := 1.U
    ready := false.B
    finalRoot := 0.U
    finalExponent := 0.S
  }

  val rootExponent = num.exponent >> 1
  val radicand = Mux(num.exponent(0).asBool(), num.fraction << 1, num.fraction)

  when(start === 1.U) {
    start := 2.U
  }

  val remHi = RegInit(0.U((totalBits + 2).W))
  val remLo = RegInit(0.U((totalBits + 2).W))
  val root = RegInit(0.U((totalBits + 2).W))
  val testDiv = RegInit(0.U((totalBits + 2).W))
  val count = RegInit((totalBits + 1).U)

  when(start === 2.U) {
    val next_remHi = Mux(remHi >= testDiv, remHi - testDiv, remHi)
    val next_root = Mux(remHi >= testDiv && count <= totalBits.U, root + 1.U, root)

    remHi := (next_remHi << 2).asUInt() | (remLo >> totalBits).asUInt()
    remLo := remLo << 2
    root := next_root << 1
    testDiv := (next_root << 2).asUInt() + 1.U
    count := count - 1.U
  }.otherwise {
    remHi := 0.U
    remLo := radicand
    root := 0.U
    testDiv := 0.U
    count := (totalBits + 1).U
  }

  when(count === 0.U) {
    start := 3.U
    finalRoot := root
    finalExponent := rootExponent
  }

  when(start === 3.U) {
    ready := true.B
    start := 0.U
  }

  private val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.decimal := finalRoot(totalBits + 1, totalBits)
  positGenerator.io.fraction := finalRoot(totalBits - 1, 0)
  positGenerator.io.exponent := finalExponent
  positGenerator.io.sign := 0.U

  io.out := Mux(io.isNaR, NaR, positGenerator.io.posit)
}
