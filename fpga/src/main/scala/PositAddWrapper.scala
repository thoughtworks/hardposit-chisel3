import chisel3._
import firrtl.{ExecutionOptionsManager, HasFirrtlOptions}

class PositAddWrapper(totalBits: Int, es: Int) extends Module {

  val io = IO(new Bundle {
    val starting_address = Input(UInt(12.W))
    val result_address = Input(UInt(12.W))
    val start = Input(Bool())
    val read_data = Input(UInt(8.W))

    val write_enable = Output(Bool())
    val write_data = Output(UInt(8.W))
    val address_to_read = Output(UInt(12.W))
    val address_to_write = Output(UInt(12.W))
    val completed = Output(Bool())
    val result = Output(UInt(totalBits.W))
  })

  private val numbersToRead = 10
  private val maxCount = numbersToRead + 2

  private val num1 = RegInit(0.U(totalBits.W))
  private val num2 = WireInit(0.U(totalBits.W))
  private val result = RegInit(0.U(totalBits.W))
  private val positAdd = Module(new PositAdd(totalBits, es))
  positAdd.io.num1 := num1
  positAdd.io.num2 := num2

  private val counter = RegInit(0.U(totalBits.W))

  io.completed := counter === maxCount.U

  private val incrementedCounter: UInt = counter + 1.U
  counter := Mux(io.start,Mux(counter < maxCount.U, incrementedCounter,counter),0.U)

  num1 := Mux(counter > 0.U && counter <= maxCount.U && io.start,positAdd.io.out,0.U)
  num2 := Mux(counter < (numbersToRead+1).U && io.start,io.read_data,0.U)

  io.address_to_read := io.starting_address + counter
  io.address_to_write := io.starting_address + counter
  io.write_data := positAdd.io.out
  io.write_enable := true.B

  io.result := positAdd.io.out
}


object PositAddWrapper extends App {
  val optionsManager = new ExecutionOptionsManager("chisel3") with HasChiselExecutionOptions with HasFirrtlOptions
  optionsManager.setTargetDirName("soc/chisel_output")
  Driver.execute(optionsManager, () => new PositAddWrapper(8, 2))
}