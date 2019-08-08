import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}

class RegimeExtractorTest(c: RegimeExtractor, input: Int, expectedLength: Int, expectedRegime: Int) extends PeekPokeTester(c) {
  poke(c.io.num,input)
  expect(c.io.regimeLength,expectedLength)
  expect(c.io.regime,expectedRegime)
}

class RegimeExtractorSpec extends FlatSpec with Matchers {
  behavior of "Regime Extractor"

  def test(input: Int, expectedLength: Int, expectedRegime: Int) = {
    chisel3.iotesters.Driver(() => new RegimeExtractor(7)){
      c => new RegimeExtractorTest(c, input, expectedLength, expectedRegime)
    } should be(true)
  }

  it should "should extract the positive regime" in {
    test(0x60, 2,1)
  }

  it should "should extract the negative regime" in {
    test(0x0F, 3,-3)
  }
}
