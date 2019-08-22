import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}

class PositGeneratorWrapperSpec extends FlatSpec with Matchers {

  behavior of "Posit Generator Wrapper"

  private class PositGeneratorWrapperTest(c: PositGeneratorWrapper, sign: Boolean, exponent: Int, decimal: Boolean, fraction: Int, expectedPosit: Int) extends PeekPokeTester(c) {
    poke(c.io.sign, sign)
    poke(c.io.exponent, exponent)
    poke(c.io.decimal, decimal)
    poke(c.io.fraction, fraction)
    step(1)
    expect(c.io.posit, expectedPosit & 0xFF)
  }

  private def test(totalBits: Int, es: Int, sign: Boolean, exponent: Int, decimal: Boolean, fraction: Int, expectedPosit: Int): Boolean = {
    chisel3.iotesters.Driver(() => new PositGeneratorWrapper(totalBits, es)) {
      c => new PositGeneratorWrapperTest(c, sign, exponent, decimal, fraction, expectedPosit)
    }
  }

  it should "represent zero when both decimal and fraction are zero" in {
    assert(test(8, 0, false, 5, false, 0, 0))
    assert(test(8, 0, true, 5, false, 0, 0))
    assert(test(8, 1, true, 2, false, 0, 0))
  }

  it should "represent infinity when the exponent after adjusting is more than it fit" in {
    assert(test(8, 0, false, -7, false, 0xFF, 0x80))
    assert(test(8, 0, false, -6, false, 0x7F, 0x80))
  }

  it should "extract the positive regime" in {
    assert(test(8, 1, sign = false, 3, true, 0x60, 0x6B))
  }

  it should "extract the negative regime" in {
    assert(test(8, 1, true, 3, true, 0x60, -0x6B))
  }

}
