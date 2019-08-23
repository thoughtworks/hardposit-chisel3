import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}

class PositMulSpec extends FlatSpec with Matchers {

  private class PositMulTest(c: PositMul, num1: Int, num2: Int, expectedPosit: Int) extends PeekPokeTester(c) {
    poke(c.io.num1,num1)
    poke(c.io.num2,num2)
    step(1)
    expect(c.io.out,expectedPosit)
  }

  private def test(totalBits: Int, es: Int, num1: Int, num2: Int, expectedPosit: Int): Boolean = {
    chisel3.iotesters.Driver(() => new PositMul(totalBits, es)) {
      c => new PositMulTest(c,num1,num2,expectedPosit)
    }
  }

  it should "return added value when both exponent and signs are equal" in {
    assert(test(16,1,0x5A00,0x6200,0x7010))
  }
}
