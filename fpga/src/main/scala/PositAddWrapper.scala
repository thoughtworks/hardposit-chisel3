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
    val address_to_access = Output(UInt(12.W))
    val completed = Output(Bool())
  })

  private val numbersToRead = 10
  private val maxCount = numbersToRead + 2

  private val num1 = RegInit(0.U(totalBits.W))
  private val num2 = RegInit(0.U(totalBits.W))
  private val result = RegInit(0.U(totalBits.W))
  private val positAdd = Module(new PositAdd(totalBits, es))
  positAdd.io.num1 := num1
  positAdd.io.num2 := num2
  result := positAdd.io.out

  private val counter = RegInit(0.U(totalBits.W))


  io.completed := counter === maxCount.U

  when(io.start) {
    counter := Mux(counter === maxCount.U, counter, counter + 1.U)
  }.otherwise {
    counter := 0.U
  }

  num1 := Mux(io.start && counter <= maxCount.U,result,0.U)
  num2 := Mux(counter < numbersToRead.U && io.start,io.read_data,0.U)

  io.address_to_access := Mux(counter < numbersToRead.U, io.starting_address + counter, io.result_address)
  io.write_data := result
  io.write_enable := counter === (numbersToRead + 1).U
}


object PositAddWrapper extends App {
  val optionsManager = new ExecutionOptionsManager("chisel3") with HasChiselExecutionOptions with HasFirrtlOptions
  optionsManager.setTargetDirName("soc/chisel_output")
  Driver.execute(optionsManager, () => new PositAddWrapper(8, 2))
}