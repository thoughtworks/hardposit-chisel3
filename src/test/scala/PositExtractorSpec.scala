import chiseltest._
import chiseltest.formal.{BoundedCheck, Formal}
import org.scalatest.matchers.should.Matchers
import hardposit.PositExtractor
import org.scalatest.flatspec.AnyFlatSpec

class PositExtractorSpec extends AnyFlatSpec with ChiselScalatestTester with Matchers with Formal {

  def posit_extractor_test(nbits: Int, es: Int,num: Int, sign: Boolean, exponent: Int, fraction: Int) {
    val annos = Seq(WriteVcdAnnotation)
    test(new PositExtractor(nbits, es)).withAnnotations(annos) { c =>
      c.io.in.poke(num)
      c.io.out.sign.expect(sign)
      c.io.out.exponent.expect(exponent)
      c.io.out.fraction.expect(fraction)
    }
  }

  def posit_extractor_formal_verify(nbits: Int, es: Int): Unit = {
    verify(new PositExtractor(nbits,es), Seq(BoundedCheck(20)))
  }

  it should "should formally verify for the posit <8,0> format" in {
    posit_extractor_formal_verify(8, 0)
  }

  it should "should formally verify for the posit <16,1> format" in {
    posit_extractor_formal_verify(16, 1)
  }

  it should "should formally verify for the posit <32,2> format" in {
    posit_extractor_formal_verify(32, 2)
  }

  it should "should formally verify for the posit <64,3> format" in {
    posit_extractor_formal_verify(64, 3)
  }

  it should "return the sign, exponent, fraction as expected for positive number" in {
    posit_extractor_test(8, 2, 0x36, sign = false, -2, 0xE)
  }

  it should "return the sign, exponent, fraction as expected for negative number" in {
    posit_extractor_test(8, 1, 0xB2, sign = true, 0, 0x1E)
  }

}



