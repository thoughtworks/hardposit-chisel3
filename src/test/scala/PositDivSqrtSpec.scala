//import chiseltest._
//import org.scalatest.flatspec.AnyFlatSpec
//import org.scalatest.matchers.should.Matchers
//import hardposit.PositDivSqrt
//
//class PositDivSqrtSpec extends AnyFlatSpec with ChiselScalatestTester with Matchers {
//
//  def posit_divSqrt_test(nbits: Int, es: Int,num1: Int, num2: Int, sqrtOp: Boolean, expect: Int) {
//    val annos = Seq(WriteVcdAnnotation)
//    test(new PositDivSqrt(nbits, es)).withAnnotations(annos) { c =>
//      c.io.num1.poke(num1)
//      c.io.num2.poke(num2)
//      c.io.sqrtOp.poke(sqrtOp)
//      c.io.validIn.poke(true)
//      c.clock.step(1)
//      c.io.validIn.poke(false)
//      while (if (sqrtOp) c.io.validOut_sqrt.peek() == BigInt(0) else c.io.validOut_div.peek() == BigInt(0)) {
//        c.clock.step(1)
//      }
//      c.io.out.expect(expect)
//    }
//  }
//
//  it should "return square root when number is given" in {
//    posit_divSqrt_test(8, 0, 0x7C, 0, sqrtOp = true, 0x70) //16, 4
//  }
//
//  it should "return square root when number is given 2" in {
//    posit_divSqrt_test(8, 0, 0x75, 0, sqrtOp = true, 0x64) //6.5, 2.5
//  }
//
//  it should "return square root when number is given 3" in {
//    posit_divSqrt_test(8, 0, 0x62, 0, sqrtOp = true, 0x50) //2.25, 1.5
//  }
//
//  it should "return square root when number is given 4" in {
//    posit_divSqrt_test(8, 2, 0x30, 0, sqrtOp = true, 0x38) //0.25, 0.5
//  }
//
//  it should "return NaR when input is negative" in {
//    posit_divSqrt_test(8, 0, 0x90, 0, sqrtOp = true, 0x80) //-4, NaR
//  }
//
//  it should "return NaR when input is NaR" in {
//    posit_divSqrt_test(8, 0, 0x80, 0, sqrtOp = true, 0x80) //NaR, NaR
//  }
//
//  it should "return positive value when signs are equal" in {
//    posit_divSqrt_test(16, 1, 0x5A00, 0x1E00, sqrtOp = false, 0x6EDB)
//    posit_divSqrt_test(16, 1, 0xA600, 0xE200, sqrtOp = false, 0x6EDB)
//  }
//
//  it should "return negative value when signs are not equal" in {
//    posit_divSqrt_test(16, 1, 0x5A00, 0xE200, sqrtOp = false, 0x9125)
//  }
//
//  it should "return zero when the dividend is zero and divisor is not equal zero" in {
//    posit_divSqrt_test(8, 2, 0, 0x32, sqrtOp = false, 0)
//  }
//
//  it should "return NaR when the divisor is zero and dividend is not equal zero" in {
//    posit_divSqrt_test(8, 2, 0x34, 0, sqrtOp = false, 0x80)
//  }
//
//  it should "return NaR when the dividend is NaR and divisor is not equal NaR" in {
//    posit_divSqrt_test(8, 1, 0x80, 0x42, sqrtOp = false, 0x80)
//    posit_divSqrt_test(8, 1, 0x80, 0, sqrtOp = false, 0x80)
//  }
//
//  it should "return NaR when the divisor is NaR and dividend is not NaR" in {
//    posit_divSqrt_test(8, 4, 0x76, 0x80, sqrtOp = false, 0x80)
//    posit_divSqrt_test(8, 4, 0, 0x80, sqrtOp = false, 0x80)
//  }
//
//  it should "return NaR when both dividend and divisor are zero or NaR" in {
//    posit_divSqrt_test(8, 3, 0, 0, sqrtOp = false, 0x80)
//    posit_divSqrt_test(8, 3, 0x80, 0x80, sqrtOp = false, 0x80)
//  }
//}
