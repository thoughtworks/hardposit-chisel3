import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import hardposit.PositMul

class PositMulSpec extends AnyFlatSpec with ChiselScalatestTester with Matchers {

  def posit_mul_test(nbits: Int, es: Int,num1: Int, num2: Int, expectedPosit: Int, isNaR: Boolean = false) {
    val annos = Seq(WriteVcdAnnotation)
    test(new PositMul(nbits, es)).withAnnotations(annos) { c =>
      c.io.num1.poke(num1)
      c.io.num2.poke(num2)
      c.clock.step(1)
      c.io.isNaR.expect(isNaR)
      c.io.out.expect(expectedPosit)
    }
  }
  it should "return multiplied value signs and exponent signs are positive" in {
    posit_mul_test(16, 1, 0x5A00, 0x6200, 0x7010)
  }

  it should "return multiplied value when signs are different" in {
    posit_mul_test(16, 1, 0xA600, 0x6200, 0x8FF0)
    posit_mul_test(16, 1, 0x6200, 0xA600, 0x8FF0)
  }

  it should "return the zero when one of the number is zero" in {
    posit_mul_test(8, 0, 0x6F, 0x00, 0x00)
    posit_mul_test(8, 0, 0x00, 0x32, 0x00)
  }

  it should "return infinity when one of the number is infinite" in {
    posit_mul_test(8, 1, 0x80, 0x43, 0x80, isNaR = true)
    posit_mul_test(8, 1, 0x43, 0x80, 0x80, isNaR = true)
  }

  it should "return isNan as true when one is zero and another one is infinity" in {
    posit_mul_test(16, 7, 0x8000, 0, 0x8000, isNaR = true)
    posit_mul_test(16, 7, 0, 0x8000, 0x8000, isNaR = true)
  }

  it should "return the positive number when there are two negative numbers multiplied" in {
    posit_mul_test(16, 1, 0xA600, 0x9E00, 0x7010)
  }

  it should "return the correct multiplication when of the number has smallest exponent" in {
    posit_mul_test(8, 2, 0x47, 0x10, 0x14)
  }
}
