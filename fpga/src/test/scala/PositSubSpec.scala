import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}

class PositSubSpec extends FlatSpec with Matchers {

  private class PositSubTest(c: PositSub, num1: Int, num2: Int, expectedPosit: Int,isNaN: Boolean ) extends PeekPokeTester(c) {
    poke(c.io.num1, num1)
    poke(c.io.num2, num2)
    step(1)
    expect(c.io.isNaN,isNaN)
    if(!isNaN){
      expect(c.io.out, expectedPosit)
    }
  }

  private def test(totalBits: Int, es: Int, num1: Int, num2: Int, expectedPosit: Int,isNaN: Boolean = false): Boolean = {
    chisel3.iotesters.Driver(() => new PositSub(totalBits, es)) {
      c => new PositSubTest(c, num1, num2, expectedPosit,isNaN)
    }
  }

  it should "return zero for the same posit numbers" in {
    assert(test(8,1,0x93,0x93,0x00))
  }

  it should "return isNaN as true when both are infinity" in {
    assert(test(8,4,0x80,0x80,0,true))
  }

  it should "return infinity when one of it is infinity" in {
    assert(test(16,2,0x8000,0x7543,0x8000))
    assert(test(16,2,0x7543,0x8000,0x8000))
  }

  it should "return the first number when the second number is zero" in {
    assert(test(8,3,0x64,0x00,0x64))
  }

  it should "return the negative of second number when the first number is zero" in {
    assert(test(8,3,0,0x45,0xBB))
  }

  it should "return the addition when both are having different signs" in {
    assert(test(8, 1, 0x5D, 0xA5, 0x66))
  }

  it should "return the positive number when both are of same sign and first number is larger" in {
    assert(test(8, 1, 0x54, 0x42, 0x46))
    assert(test(8, 1,  0xBE , 0xAC,0x46))
  }

  it should "return the negative number when both are of same sign and second number is larger" in {
    assert(test(8,1,0x42,0x54,0xBA))
    assert(test(8, 1, 0xAC,0xBE ,0xBA))
  }
}
