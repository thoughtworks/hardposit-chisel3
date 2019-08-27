import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}

class PositGeneratorSpec extends FlatSpec with Matchers {
  behavior of "Posit Generator"

  private class PositGeneratorTest(c: PositGenerator, sign: Boolean, exponent: Int, fraction: Int, expectedPosit: Int) extends PeekPokeTester(c) {
    poke(c.io.sign, sign)
    poke(c.io.exponent, exponent)
    poke(c.io.fraction, fraction)
    step(1)
    expect(c.io.posit, expectedPosit & 0xFF)
  }

  private def test(totalBits: Int, es: Int, sign: Boolean, exponent: Int, fraction: Int, expectedPosit: Int): Boolean = {
    chisel3.iotesters.Driver(() => new PositGenerator(totalBits, es)) {
      c => new PositGeneratorTest(c, sign, exponent, fraction, expectedPosit)
    }
  }

  it should "extract the positive regime" in {
    assert(test(8,1,sign = false, 3, 0x60, 0x6B))
  }

  it should "extract the negative regime" in {
    assert(test(8,1,true,3,0x60,-0x6B))
  }

  it should "extract the posit for zero exponent and positive sign" in {
    assert(test(8,2,false,0,0xB3,0x45))
  }

  it should "extract the posit for zero exponent bits and positive sign" in {
    assert(test(8,0,false,2,0xB3,0x75))
    assert(test(8,0,false,-2,0xB3,0x1B))
  }

  it should "extract" in {
    assert(test(8,2,false,-8,0xFF,0x13))
  }

  it should "extract the posit for bigger numbers" in {
    assert(test(8,0,false,7,0xFF,0x7f))
    assert(test(8,0,false,6,0xFF,0x7f))
    assert(test(8,0,false,-6,0xFF,0x01))
    assert(test(8,0,true,-6,0xFF,0xFF))
  }
}
