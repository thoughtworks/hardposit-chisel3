import chisel3.iotesters.PeekPokeTester

class PositAddTest(c: PositAdd) extends PeekPokeTester(c) {
//  poke(c.io.num1,2)
//  poke(c.io.num2,0x5B)
//  expect(c.io.out,0)

}

object PositAddTest extends App {
  chisel3.iotesters.Driver(() => new PositAdd(8,0)) {
    c => new PositAddTest(c)
  }
}
