import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}

class ItoPConverterSpec extends FlatSpec with Matchers {

  private class ItoPConverterTest(c: ItoPConverter, integer: Int, unsigned: Boolean, expected: Int) extends PeekPokeTester(c) {
    poke(c.io.integer, integer)
    poke(c.io.unsigned, unsigned)
    step(1)
    expect(c.io.posit, expected)
  }

  def test(totalBits: Int, es: Int, integer: Int, unsigned: Boolean, expected: Int): Boolean = {
    chisel3.iotesters.Driver(() => new ItoPConverter(totalBits, es)) {
      c => new ItoPConverterTest(c, integer, unsigned, expected)
    }
  }

  it should "return posit value for unsigned integer" in {
    assert(test(8, 0, 2, unsigned = true, 0x60))
  }

  it should "return posit value for unsigned integer 2" in {
    assert(test(8, 2, 5, unsigned = true, 0x52))
  }

  it should "return posit value for unsigned integer 3" in {
    assert(test(16, 2, 475, unsigned = true, 0x71B6))
  }

  it should "return posit value for signed integer" in {
    assert(test(8, 0, 0xF6, unsigned = false, 0x87))
  }

  it should "return posit value for signed integer 2" in {
    assert(test(8,2,0xB0,unsigned = false, 0x97))
  }
}
