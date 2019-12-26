import chisel3.iotesters.PeekPokeTester
import hardposit.PositDiv
import org.scalatest.{FlatSpec, Matchers}

class PositDivSpec extends FlatSpec with Matchers {

  private class PositDivTest(c: PositDiv, num1: Int, num2: Int, expectedPosit: Int, isNan: Boolean) extends PeekPokeTester(c) {
    poke(c.io.num1, num1)
    poke(c.io.num2, num2)
    step(1)
    expect(c.io.out, expectedPosit)
    expect(c.io.isNaN, isNan)
  }

  private def test(totalBits: Int, es: Int, num1: Int, num2: Int, expectedPosit: Int, isNaN: Boolean = false): Boolean = {
    chisel3.iotesters.Driver(() => new PositDiv(totalBits, es)) {
      c => new PositDivTest(c, num1, num2, expectedPosit, isNaN)
    }
  }

  it should "return positive value when signs are equal" in {
    assert(test(16, 1, 0x5A00, 0x1E00, 0x7010))
    assert(test(16, 1, 0xA600, 0xE200, 0x7010))
  }

  it should "return negative value when signs are not equal" in {
    assert(test(16, 1, 0x5A00, 0xE200, 0x8FF0))
  }

  it should "return zero when the dividend is zero and divisor is not equal zero" in {
    assert(test(8,2,0,0x32,0))
  }

  it should "return infinity when the divisor is zero and dividend is not equal zero" in {
    assert(test(8,2,0x34,0,0x80))
  }

  it should "return infinity when the dividend is infinite and divisor is not equal infinity" in {
    assert(test(8,1,0x80,0x42,0x80))
    assert(test(8,1,0x80,0,0x80))
  }

  it should "return zero when the divisor is infinity and dividend is not infinity" in {
    assert(test(8,4,0x76,0x80,0))
    assert(test(8,4,0,0x80,0))
  }

  it should "return isNaN as true when both dividend and divisor are zero or infinite" in {
    assert(test(8,3,0,0,0,isNaN = true))
    assert(test(8,3,0x80,0x80,0,isNaN = true))
  }
}
