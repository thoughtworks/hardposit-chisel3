import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}

class PtoIConverterSpec extends FlatSpec with Matchers {

  private class PtoIConverterTest(c: PtoIConverter, posit: Int, unsigned: Boolean, expected: Int) extends PeekPokeTester(c) {
    poke(c.io.posit, posit)
    poke(c.io.unsigned, unsigned)
    step(1)
    expect(c.io.integer, expected)
  }

  def test(totalBits: Int, es: Int, posit: Int, unsigned: Boolean, expected: Int): Boolean = {
    chisel3.iotesters.Driver(() => new PtoIConverter(totalBits, es)) {
      c => new PtoIConverterTest(c, posit, unsigned, expected)
    }
  }

  it should "return unsigned integer value for unsigned posit" in {
    assert(test(8, 0, 0x72, unsigned = true, 5))
  }

  it should "return unsigned integer value for unsigned posit 2" in {
    assert(test(8, 2, 0x3F, unsigned = true, 0))
  }

  it should "return unsigned integer value for signed posit" in {
    assert(test(16, 2, 0x8E4A, unsigned = true, 475))
  }

  it should "return signed integer value for signed posit" in {
    assert(test(8, 0, 0x87, unsigned = false, 0xF6))
  }

  it should "return signed integer value for signed posit 1" in {
    assert(test(16, 2, 0xAC20, unsigned = false, 0xFFFB))
  }
}
