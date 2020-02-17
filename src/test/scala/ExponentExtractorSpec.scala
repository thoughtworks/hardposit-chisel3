import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester}
import hardposit.ExponentExtractor

class ExponentExtractorSpec extends ChiselFlatSpec {

  private class ExponentExtractorTest(c: ExponentExtractor, input: Int, expectedLength: Int, exponent: Int) extends PeekPokeTester(c) {
    poke(c.io.num, input)
    expect(c.io.totalLength, expectedLength)
    expect(c.io.exponent, exponent)
  }

  private def test(totalBits: Int, exponentBits: Int, input: Int, expectedLength: Int, exponent: Int): Boolean = {
    chisel3.iotesters.Driver(() => new ExponentExtractor(totalBits, exponentBits)) {
      c => new ExponentExtractorTest(c, input, expectedLength, exponent)
    }
  }

  it should "return the totalLength as regimeLength + exponentLength + 1 when there are exponentBits present in it" in {
    assert(test(8, 1, 0x36, 3, -1))
    assert(test(8, 1, 0x26, 3, -2))
  }

  it should "return the totalLength as regimeLength + 1 when there are max regime bits and 0 es bits" in {
    assert(test(8, 0, 0x35, 2, -1))
  }

  it should "return the exponent and length correctly when there are more than 1 exponent bits" in {
    assert(test(8, 2, 0x36, 4, -2))
  }

  it should "return the exponent as zero when the regime bits occupied all the places" in {
    assert(test(8, 2, 0x7F, 7, 24))
    assert(test(8, 2, 0x7E, 7, 20))
  }

  it should "return the exponent only 1 bit even if es=2 as regime bits occupied the places" in {
    assert(test(8, 2, 0x7C, 7, 16))
    assert(test(8, 2, 0x7D, 7, 18))
  }

  it should "[redundant test just to confirm]return the exponent and exponent length as expected" in {
    assert(test(8, 3, 0x20, 5, -8))
    assert(test(8, 1, 0x40, 3, 0))
    assert(test(8, 3, 0x03, 7, -36))
    assert(test(8, 3, 0x01, 7, -48))
  }
}
