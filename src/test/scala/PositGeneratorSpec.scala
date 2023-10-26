import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import hardposit.PositGenerator

class PositGeneratorSpec extends AnyFlatSpec with ChiselScalatestTester with Matchers {

  behavior of "Posit Generator"

  def posit_generator_test(nbits: Int, es: Int, sign: Boolean, exponent: Int, fraction: Int, expectedPosit: Int) {
    val annos = Seq(WriteVcdAnnotation)
    test(new PositGenerator(nbits, es)).withAnnotations(annos) { c =>
      c.io.in.sign.poke(sign)
      c.io.in.exponent.poke(exponent)
      c.io.in.fraction.poke(fraction)
      c.io.in.isNaR.poke(false)
      c.io.in.isZero.poke(false)
      c.clock.step(1)
      c.io.out.expect(expectedPosit & 0xFF)
    }
  }
  
  it should "represent zero when both decimal and fraction are zero" in {
    posit_generator_test(8, 0, false, 5, 0, 0)
    posit_generator_test(8, 0, true, 5, 0, 0)
    posit_generator_test(8, 1, true, 2, 0, 0)
  }

  it should "not underflow when the exponent too less" in {
    posit_generator_test(8, 0, false, -7, 0xF, 0x01)
    posit_generator_test(8, 0, false, -6, 0x7, 0x01)
  }

  it should "represent maxpos when the exponent is high then it fits" in {
    posit_generator_test(8, 0, false, 8, 0x1F, 0x7F)
  }

  it should "extract the positive regime" in {
    posit_generator_test(8, 1, sign = false, 3, 0x16, 0x6B)
  }

  it should "extract the negative regime" in {
    posit_generator_test(8, 1, true, 3, 0x16, -0x6B)
  }

}
