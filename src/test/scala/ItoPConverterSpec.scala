import chiseltest.{ChiselScalatestTester, _}
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import hardposit.ItoPConverter

class ItoPConverterSpec extends AnyFlatSpec with ChiselScalatestTester with Matchers {

  def itoP_converter_test(nbits: Int, es: Int, integer: Int, unsigned: Boolean, expected: Int, intWidth: Int) {
    val annos = Seq(WriteVcdAnnotation)
    test(new ItoPConverter(nbits, es, intWidth)).withAnnotations(annos) { c =>
      c.io.integer.poke(integer)
      c.io.unsignedIn.poke(unsigned)
      c.clock.step(1)
      c.io.posit.expect(expected)
    }
  }

  it should "return posit value for unsigned integer" in {
    itoP_converter_test(8, 0, 2, unsigned = true, 0x60, 8)
  }

  it should "return posit value for unsigned integer 2" in {
    itoP_converter_test(8, 2, 5, unsigned = true, 0x52, 8)
  }

  it should "return posit value for unsigned integer 3" in {
    itoP_converter_test(16, 2, 475, unsigned = true, 0x71B6, 16)
  }

  it should "return posit value for signed integer" in {
    itoP_converter_test(8, 0, 0xF6, unsigned = false, 0x87, 8)
  }

  it should "return posit value for signed integer 2" in {
    itoP_converter_test(8, 2, 0xB0, unsigned = false, 0x97, 8)
  }

  it should "return posit value for wider unsigned integer " in {
    itoP_converter_test(8, 2, 32896, unsigned = true, 0x7B, 16)
  }

  it should "return posit value for wider signed integer " in {
    itoP_converter_test(8, 2, 0xFFB0, unsigned = false, 0x97, 16)
  }

  it should "return posit value for narrower unsigned integer " in {
    itoP_converter_test(16, 2, 127, unsigned = true, 0x6BF0, 8)
  }

  it should "return posit value for narrower signed integer " in {
    itoP_converter_test(16, 2, 0xB0, unsigned = false, 0x9700, 8)
  }

  it should "return NaR for integer with an MSB of 1 and all other bits 0" in {
    itoP_converter_test(16, 2, 0x80, unsigned = false, 0x8000, 8)
  }
}
