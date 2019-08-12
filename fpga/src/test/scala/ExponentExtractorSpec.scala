import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}

class ExponentExtractorSpec extends FlatSpec with Matchers {

  private class ExponentExtractorTest(c: ExponentExtractor, input: Int, regimeLength: Int, expectedLength: Int, exponent: Int) extends PeekPokeTester(c) {
    poke(c.io.num,input)
    poke(c.io.regimeLength,regimeLength)
    expect(c.io.totalLength,expectedLength)
    expect(c.io.exponent,exponent)
  }

  private def test(totalBits:Int,exponentBits:Int , input: Int, regimeLength: Int, expectedLength: Int, exponent: Int): Boolean = {
    chisel3.iotesters.Driver(() => new ExponentExtractor(totalBits,exponentBits)){
      c => new ExponentExtractorTest(c,input,regimeLength,expectedLength,exponent)
    }
  }

  it should "return the totalLength as regimeLength + exponentLength + 1 when there are exponentBits present in it" in {
    assert(test(8,1,0x36,1,3,1))
  }

  it should "return the totalLength as regimeLength + 1 when there are max regime bits and 0 es bits" in {
    assert(test(8,0,0x35,1,2,0))
  }

  it should "return the exponent as zero when the regime bits occupied all the places" in {
    assert(test(8,2,0x7F,7,7,0))
    assert(test(8,2,0x7E,6,7,0))
  }

  it should "return the exponent only 1 bit even if es=2 as regime bits occupied the places" in {
    assert(test(8,2,0x7C,5,7,0))
    assert(test(8,2,0x7D,5,7,1))
  }
}
