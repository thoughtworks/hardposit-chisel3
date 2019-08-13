import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}

class FieldsExtractorSpec extends FlatSpec with Matchers {

  private class FieldsExtractorTest(c: FieldsExtractor, num: Int, sign: Boolean, exponent: Int, fraction: Int) extends PeekPokeTester(c) {
    poke(c.io.num, num)
    expect(c.io.sign, sign)
    expect(c.io.exponent, exponent)
    expect(c.io.fraction, fraction)
  }

  private def test(totalBits: Int, es: Int, num: Int, sign: Boolean, exponent: Int, fraction: Int): Boolean = {
    chisel3.iotesters.Driver(() => new FieldsExtractor(totalBits,es)){
      c => new FieldsExtractorTest(c,num,sign,exponent,fraction)
    }
  }

  it should "return the sign, exponent, fraction as expected for positive number" in {
    assert(test(8,2,0x36,sign = false,-2,0xC0))
  }

  it should "return the sign, exponent, fraction as expected for negative number" in {
    assert(test(8,1,0xB2,sign = true,0,0xE0))
  }
}
