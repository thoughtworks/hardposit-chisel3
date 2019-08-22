import chisel3._
import chisel3.util.{Cat, MuxCase, log2Ceil}

class PositGeneratorWrapper(totalBits: Int, es:Int) extends Module {
  private val base = math.pow(2, es).toInt
  private val exponentBits = log2Ceil(base * (totalBits - 1)) + 1
  val io = IO(new Bundle{
    val sign = Input(Bool())
    val exponent = Input(SInt(exponentBits.W))
    val decimal = Input(Bool())
    val fraction = Input(UInt(totalBits.W))
    val posit = Output(UInt(totalBits.W))
  })

  private val fractionWithDecimal = Cat(io.decimal,io.fraction)
  
  private val exponentOffsetCombinations = Array.range(0, totalBits + 1).map(index => {
    (fractionWithDecimal(totalBits,totalBits - index) === 1.U) -> index.S
  })

  private val fractionCombinations = Array.range(1, totalBits).map(index => {
    (fractionWithDecimal(totalBits,totalBits - index) === 1.U) -> Cat(fractionWithDecimal(totalBits - index - 1, 0), 0.U(index.W))
  })
  
  private val exponent = io.exponent - MuxCase(0.S,exponentOffsetCombinations)
  private val fraction = MuxCase(fractionWithDecimal(totalBits-1,0),fractionCombinations)
  
  private val positGenerator = Module(new PositGenerator(totalBits,es))
  positGenerator.io.sign := io.sign
  positGenerator.io.exponent := exponent
  positGenerator.io.fraction := fraction
  
  private val infiniteRepresentation: UInt = math.pow(2, totalBits - 1).toInt.U
  private val maxExponent: SInt = (base * (totalBits - 1)).S
  io.posit := Mux(fractionWithDecimal === 0.U,0.U,Mux(exponent.abs() > maxExponent,infiniteRepresentation,positGenerator.io.posit))
}
