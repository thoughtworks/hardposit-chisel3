import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester}
import hardposit.ItoPConverter

class ItoPConverterSpec extends ChiselFlatSpec {

  private class ItoPConverterTest(c: ItoPConverter, integer: Int, unsigned: Boolean, expected: Int) extends PeekPokeTester(c) {
    poke(c.io.integer, integer)
    poke(c.io.unsignedIn, unsigned)
    step(1)
    expect(c.io.posit, expected)
  }

  def test(nbits: Int, es: Int, integer: Int, unsigned: Boolean, expected: Int, intWidth: Int): Boolean = {
    chisel3.iotesters.Driver(() => new ItoPConverter(nbits, es, intWidth)) {
      c => new ItoPConverterTest(c, integer, unsigned, expected)
    }
  }

  it should "return posit value for unsigned integer" in {
    assert(test(8, 0, 2, unsigned = true, 0x60, 8))
  }

  it should "return posit value for unsigned integer 2" in {
    assert(test(8, 2, 5, unsigned = true, 0x52, 8))
  }

  it should "return posit value for unsigned integer 3" in {
    assert(test(16, 2, 475, unsigned = true, 0x71B6, 16))
  }

  it should "return posit value for signed integer" in {
    assert(test(8, 0, 0xF6, unsigned = false, 0x87, 8))
  }

  it should "return posit value for signed integer 2" in {
    assert(test(8, 2, 0xB0, unsigned = false, 0x97, 8))
  }

  it should "return posit value for wider unsigned integer " in {
    assert(test(8, 2, 32896, unsigned = true, 0x7B, 16))
  }

  it should "return posit value for wider signed integer " in {
    assert(test(8, 2, 0xFFB0, unsigned = false, 0x97, 16))
  }

  it should "return posit value for narrower unsigned integer " in {
    assert(test(16, 2, 128, unsigned = true, 0x6C00, 8))
  }

  it should "return posit value for narrower signed integer " in {
    assert(test(16, 2, 0xB0, unsigned = false, 0x9700, 8))
  }
}
