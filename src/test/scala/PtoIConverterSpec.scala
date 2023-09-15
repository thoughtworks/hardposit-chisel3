import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import hardposit.PtoIConverter

class PtoIConverterSpec extends AnyFlatSpec with ChiselScalatestTester with Matchers {

  def ptoI_converter_test(nbits: Int, es: Int, posit: Int, unsigned: Boolean, expected: Int, intWidth: Int, roundingMode: Boolean = false) {
    val annos = Seq(WriteVcdAnnotation)
    test(new PtoIConverter(nbits, es, intWidth)).withAnnotations(annos) { c =>
      c.io.posit.poke(posit)
      c.io.unsignedOut.poke(unsigned)
      c.io.roundingMode.poke(roundingMode)
      c.clock.step(1)
      c.io.integer.expect(expected)
    }
  }

  it should "return unsigned integer value for unsigned posit" in {
    ptoI_converter_test(8, 0, 0x72, unsigned = true, 5, 8)
  }

  it should "return unsigned integer value for unsigned posit 2" in {
    ptoI_converter_test(8, 2, 0x3F, unsigned = true, 0, 8)
  }

  it should "return zero for signed posit" in {
    ptoI_converter_test(16, 2, 0x8E4A, unsigned = true, 0, 16)
  }

  it should "return signed integer value for signed posit" in {
    ptoI_converter_test(8, 0, 0x87, unsigned = false, 0xF6, 8)
  }

  it should "return signed integer value for signed posit 1" in {
    ptoI_converter_test(16, 2, 0xAC20, unsigned = false, 0xFFFA, 16)
  }

  it should "return signed integer value for smaller integer width" in {
    ptoI_converter_test(16, 2, 0xAC20, unsigned = false, 0xFA, 8)
  }

  it should "return highest value for smaller integer width" in {
    ptoI_converter_test(16, 2, 0x7FFF, unsigned = false, 0x7F, 8)
  }

  it should "return integer value for larger integer width" in {
    ptoI_converter_test(16, 2, 0x7F9D, unsigned = true, 973078528, 32)
  }

  it should "return highest signed value for NaR" in {
    ptoI_converter_test(16, 2, 0x8000, unsigned = false, 0x7FFF, 16)
  }

  it should "return highest unsigned value for NaR" in {
    ptoI_converter_test(16, 2, 0x8000, unsigned = true, 0xFFFF, 16)
  }
}
