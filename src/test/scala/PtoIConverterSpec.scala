import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester}
import hardposit.PtoIConverter

class PtoIConverterSpec extends ChiselFlatSpec {

  private class PtoIConverterTest(c: PtoIConverter, posit: Int, unsigned: Boolean, expected: Int, roundingMode: Boolean) extends PeekPokeTester(c) {
    poke(c.io.posit, posit)
    poke(c.io.unsignedOut, unsigned)
    poke(c.io.roundingMode, roundingMode)
    step(1)
    expect(c.io.integer, expected)
  }

  def test(totalBits: Int, es: Int, posit: Int, unsigned: Boolean, expected: Int, intWidth: Int, roundingMode: Boolean = false): Boolean = {
    chisel3.iotesters.Driver(() => new PtoIConverter(totalBits, es, intWidth)) {
      c => new PtoIConverterTest(c, posit, unsigned, expected, roundingMode)
    }
  }

  it should "return unsigned integer value for unsigned posit" in {
    assert(test(8, 0, 0x72, unsigned = true, 5, 8))
  }

  it should "return unsigned integer value for unsigned posit 2" in {
    assert(test(8, 2, 0x3F, unsigned = true, 0, 8))
  }

  it should "return zero for signed posit" in {
    assert(test(16, 2, 0x8E4A, unsigned = true, 0, 16))
  }

  it should "return signed integer value for signed posit" in {
    assert(test(8, 0, 0x87, unsigned = false, 0xF6, 8))
  }

  it should "return signed integer value for signed posit 1" in {
    assert(test(16, 2, 0xAC20, unsigned = false, 0xFFFA, 16))
  }

  it should "return signed integer value for smaller integer width" in {
    assert(test(16, 2, 0xAC20, unsigned = false, 0xFA, 8))
  }

  it should "return highest value for smaller integer width" in {
    assert(test(16, 2, 0x7FFF, unsigned = false, 0x7F, 8))
  }

  it should "return integer value for larger integer width" in {
    assert(test(16, 2, 0x7F9D, unsigned = true, 973078528, 32))
  }

  it should "return highest signed value for NaR" in {
    assert(test(16, 2, 0x8000, unsigned = false, 0x7FFF, 16))
  }

  it should "return highest unsigned value for NaR" in {
    assert(test(16, 2, 0x8000, unsigned = true, 0xFFFF, 16))
  }
}
