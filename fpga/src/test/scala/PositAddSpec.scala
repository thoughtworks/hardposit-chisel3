import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}

class PositAddSpec extends FlatSpec with Matchers {


  private class PositAddTest(c: PositAdd, num1: Int, num2: Int, expectedPosit: Int) extends PeekPokeTester(c) {
      poke(c.io.num1,num1)
      poke(c.io.num2,num2)
      expect(c.io.out,expectedPosit)
  }

  private def test(totalBits: Int, es: Int, num1: Int, num2: Int, expectedPosit: Int): Boolean = {
    chisel3.iotesters.Driver(() => new PositAdd(totalBits, es)) {
      c => new PositAddTest(c,num1,num2,expectedPosit)
    }
  }

  it should "return added value when both exponent and signs are equal" in {
    assert(test(8,0,0x6C,0x62,0x73))
  }

  it should "return added value when both exponent and signs are equal1" in {
    assert(test(8,0,0x6D,0x6A,0x75))
  }

  it should "return added value when both exponent and signs are equal2" in {
    assert(test(8,1,0x5D,0x5B,0x66))
  }

  it should "return added value when both exponents are not equal but sign is positive" in {
    assert(test(16,1,0x6D00,0x5B00,0x7018))
  }

  it should "return added value when both exponent and signs are equal3" in {
    assert(test(8,0,0x94,0x9E,0x8D))
  }
}
