import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import hardposit.PtoPConverter
class PtoPConverterSpec extends AnyFlatSpec with ChiselScalatestTester with Matchers {

  def ptoP_converter_test(inWidth: Int, inEs: Int, outWidth: Int, outEs: Int, inPosit: Int, expected: Int) {
    val annos = Seq(WriteVcdAnnotation)
    test(new PtoPConverter(inWidth, inEs, outWidth, outEs)).withAnnotations(annos) { c =>
    c.io.in.poke(inPosit)
    c.clock.step(1)
    c.io.out.expect(expected)
  }
}

  it should "return wide posit for narrow posit with same es" in {
    ptoP_converter_test(8, 2, 16, 2, 0x4F, 0x4F00) //3.75
  }

  it should "return wide posit for narrow posit with different es" in {
    ptoP_converter_test(8, 2, 16, 3, 0x4F, 0x4780)
  }

  it should "return narrow posit for wide posit with same es" in {
    ptoP_converter_test(16, 2, 8, 2, 0x4F00, 0x4F)
  }

  it should "return narrow posit for wide posit with different es" in {
    ptoP_converter_test(16, 3, 8, 2, 0x4780, 0x4F)
  }

  it should "return NaR for wide posit with value outside narrower range" in {
    ptoP_converter_test(16, 3, 8, 0, 0x6200, 0x7F) //512
  }

  it should "return NaR for wider NaR" in {
    ptoP_converter_test(16, 0, 8, 0, 0x8000, 0x80) //NaR
  }

  it should "return NaR for narrower NaR" in {
    ptoP_converter_test(8, 0, 16, 0, 0x80, 0x8000)
  }
}