import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}

class PositAddSpec extends FlatSpec with Matchers {

  private class PositAddTest(c: PositAdd, num1: Int, num2: Int, expectedPosit: Int) extends PeekPokeTester(c) {
    poke(c.io.num1, num1)
    poke(c.io.num2, num2)
    step(1)
    expect(c.io.out, expectedPosit)
    expect(c.io.isNaN,false)
  }

  private def test(totalBits: Int, es: Int, num1: Int, num2: Int, expectedPosit: Int): Boolean = {
    chisel3.iotesters.Driver(() => new PositAdd(totalBits, es)) {
      c => new PositAddTest(c, num1, num2, expectedPosit)
    }
  }

  it should "return added value when both exponent and signs are equal" in {
    assert(test(8, 0, 0x6C, 0x62, 0x73))
  }

  it should "return added value when both exponent and signs are equal1" in {
    assert(test(8, 0, 0x6D, 0x6A, 0x75))
  }

  it should "return added value when both exponent and signs are equal2" in {
    assert(test(8, 1, 0x5D, 0x5B, 0x66))
  }

  it should "return added value when both exponents are not equal but sign is positive" in {
    assert(test(16, 1, 0x6D00, 0x5B00, 0x7018))
  }

  it should "return added value when both exponent and signs are equal3" in {
    assert(test(8, 0, 0x94, 0x9E, 0x8D))
  }

  it should "return the subtracted value when first one is lesser and positive" in {
    assert(test(8, 1, 0x42, 0xAC, 0xBA))
  }

  it should "return the subtracted value when first one is greater and positive" in {
    assert(test(8, 1, 0x54, 0xBE, 0x46))
  }

  it should "return the zero when both values are equal and different signs" in {
    assert(test(8, 0, 0x9D, 0x63, 0x00))
    assert(test(8, 1, 0x9D, 0x63, 0x00))
    assert(test(8, 2, 0x9D, 0x63, 0x00))
  }

  it should "return the subtracted value when first one is greater and positive1" in {
    assert(test(16, 2, 0x64AF, 0xAF44, 0x6423))
  }

  it should "return the subtracted value when first one is lesser and negative1" in {
    assert(test(16, 2, 0xAF44, 0x64AF, 0x6423))
  }

  it should "return the subtracted value when first one is greater and negative" in {
    assert(test(16, 2, 0x9B51, 0x50BC, 0x9BDD))
  }

  it should "return the infinite when the exponent are at max" in {
    assert(test(8, 0, 0x7F, 0x7F, 0x80))
  }

  it should "return the other number when one of it is zero" in {
    assert(test(8,2,0,0x64,0x64))
    assert(test(8,2,0x73,0,0x73))
  }

  it should "return infinite number when one of it is infinite" in {
    assert(test(8,1,0x80,0x64,0x80))
    assert(test(8,1,0x74,0x80,0x80))
  }

  it should "return infinite infinity when both are infinity" in {
    assert(test(8,2,0x80,0x80,0x80))
  }

  it should "return zero when both are zero" in {
    assert(test(8,4,0,0,0))
  }
}
