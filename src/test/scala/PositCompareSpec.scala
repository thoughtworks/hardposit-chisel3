//import chiseltest._
//import org.scalatest.flatspec.AnyFlatSpec
//import org.scalatest.matchers.should.Matchers
//import hardposit.PositCompare
//
//class PositCompareSpec extends AnyFlatSpec with ChiselScalatestTester with Matchers {
//
//  def posit_compare_test(nbits: Int, es: Int, num1: Int, num2: Int, expectlt: Boolean, expecteq: Boolean, expectgt: Boolean)  {
//    val annos = Seq(WriteVcdAnnotation)
//    test(new PositCompare(nbits, es)).withAnnotations(annos) { c =>
//      c.io.num1.poke(num1)
//      c.io.num2.poke(num2)
//      c.clock.step(1)
//      c.io.lt.expect(expectlt)
//      c.io.eq.expect(expecteq)
//      c.io.gt.expect(expectgt)
//    }
//  }
//
//  it should "return less than when sign and exponent equal and fraction less" in {
//    posit_compare_test(8, 0, 0x62, 0x6C, expectlt = true, expecteq = false, expectgt = false) //2.25, 3.5
//  }
//
//  it should "return less than when sign one number negative and other is positive" in {
//    posit_compare_test(8, 0, 0xBC, 0x20, expectlt = true, expecteq = false, expectgt = false) //-1.125, 0.5
//  }
//
//  it should "return less than when sign and fraction equal and exponent less" in {
//    posit_compare_test(8, 2, 0x62, 0x66, expectlt = true, expecteq = false, expectgt = false) //24, 48
//  }
//
//  it should "return less than when both numbers negative and magnitude of one number is greater than the other" in {
//    posit_compare_test(8, 2, 0xA6, 0xAD, expectlt = true, expecteq = false, expectgt = false) //-10, -5.5
//  }
//
//  it should "return equal when both numbers are positive and equal" in {
//    posit_compare_test(8, 0, 0x6C, 0x6C, expectlt = false, expecteq = true, expectgt = false) //3.5 ,3.5
//  }
//
//  it should "return equal when both numbers are negative and equal" in {
//    posit_compare_test(8, 0, 0xBC, 0xBC, expectlt = false, expecteq = true, expectgt = false) //-1.125, -1.125
//  }
//
//  it should "return equal when both numbers are zero" in {
//    posit_compare_test(8, 0, 0x00, 0x00, expectlt = false, expecteq = true, expectgt = false) //-1.125, -1.125
//  }
//
//  it should "return greater than when sign and exponent equal and fraction greater" in {
//    posit_compare_test(8, 0, 0x6C, 0x62, expectlt = false, expecteq = false, expectgt = true) //3.5, 2.25
//  }
//
//  it should "return greater than when sign and fraction equal and exponent greater" in {
//    posit_compare_test(8, 2, 0x66, 0x62, expectlt = false, expecteq = false, expectgt = true) //3.5, 2.25
//  }
//}