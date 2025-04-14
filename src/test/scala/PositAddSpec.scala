import chiseltest._
import hardposit.PositAdd
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers

class PositAddSpec extends AnyFlatSpec with ChiselScalatestTester with Matchers {

  def posit_add_test(nbits: Int, es: Int, num1: Int, num2: Int, expectedPosit: Int, sub: Boolean = false, isNaR: Boolean = false) {
    val annos = Seq(WriteVcdAnnotation)
    test(new PositAdd(nbits, es)).withAnnotations(annos) { c =>
      c.io.num1.poke(num1)
      c.io.num2.poke(num2)
      c.io.sub.poke(sub)
      c.clock.step(1)
      c.io.out.expect(expectedPosit)
      c.io.isNaR.expect(isNaR)
    }
  }

  it should "return added value when both exponent and signs are equal" in {
    posit_add_test(8, 0, 0x6C, 0x62, 0x74)
  }

  it should "return added value when both exponent and signs are equal1" in {
    posit_add_test(8, 0, 0x6D, 0x6A, 0x76)
  }

  it should "return added value when both exponent and signs are equal2" in {
    posit_add_test(8, 1, 0x5D, 0x5B, 0x66)
  }

  it should "return added value when both exponents are not equal but sign is positive" in {
    posit_add_test(16, 1, 0x6D00, 0x5B00, 0x7018)
  }

  it should "return added value when both exponent and signs are equal3" in {
    posit_add_test(8, 0, 0x94, 0x9E, 0x8C)
  }

  it should "return the subtracted value when first one is lesser and positive" in {
    posit_add_test(8, 1, 0x42, 0xAC, 0xBA)
  }

  it should "return the subtracted value when first one is greater and positive" in {
    posit_add_test(8, 1, 0x54, 0xBE, 0x46)
  }

  it should "return the zero when both values are equal and different signs" in {
    posit_add_test(8, 0, 0x9D, 0x63, 0x00)
    posit_add_test(8, 1, 0x9D, 0x63, 0x00)
    posit_add_test(8, 2, 0x9D, 0x63, 0x00)
  }

  it should "return the subtracted value when first one is greater and positive1" in {
    posit_add_test(16, 2, 0x64AF, 0xAF44, 0x6423)
  }

  it should "return the subtracted value when first one is lesser and negative1" in {
    posit_add_test(16, 2, 0xAF44, 0x64AF, 0x6423)
  }

  it should "return the subtracted value when first one is greater and negative" in {
    posit_add_test(16, 2, 0x9B51, 0x50BC, 0x9BDD)
  }

  it should "return the maxpos when the exponent are at max" in {
    posit_add_test(8, 0, 0x7F, 0x7F, 0x7F)
  }

  it should "return the other number when one of it is zero" in {
    posit_add_test(8, 2, 0, 0x64, 0x64)
    posit_add_test(8, 2, 0x73, 0, 0x73)
  }

  it should "return infinite number when one of it is infinite" in {
    posit_add_test(8, 1, 0x80, 0x64, 0x80, isNaR = true)
    posit_add_test(8, 1, 0x74, 0x80, 0x80, isNaR = true)
  }

  it should "return infinite infinity when both are infinity" in {
    posit_add_test(8, 2, 0x80, 0x80, 0x80, isNaR = true)
  }

  it should "return zero when both are zero" in {
    posit_add_test(8, 4, 0, 0, 0)
  }

  it should "for 100MHZ checking in fpga 8 * 0" in {
    posit_add_test(8, 0, 64, 72, 98)
    posit_add_test(8, 0, 98, 76, 109)
    posit_add_test(8, 0, 109, 80, 114)
    posit_add_test(8, 0, 114, 82, 117)
    posit_add_test(8, 0, 117, 84, 120)
    posit_add_test(8, 0, 120, 86, 121)
    posit_add_test(8, 0, 120, 88, 121)
    posit_add_test(8, 0, 120, 89, 121)
    posit_add_test(8, 0, 120, 0xA6, 116)
  }

  it should "for 100MHZ checking in fpga 8 * 2" in {
    posit_add_test(8, 2, 64, 72, 76)
    posit_add_test(8, 2, 76, 76, 84)
    posit_add_test(8, 2, 84, 80, 90)
    posit_add_test(8, 2, 90, 82, 95)
    posit_add_test(8, 2, 95, 84, 97)
    posit_add_test(8, 2, 97, 86, 99)
    posit_add_test(8, 2, 98, 88, 100)
    posit_add_test(8, 2, 100, 89, 101)
    posit_add_test(8, 2, 0xA6, 101, 100)
  }

  it should "for 100MHZ checking in 16*1" in {
    posit_add_test(16, 1, 0x4000, 0x5000, 0x5800)
    posit_add_test(16, 1, 0x5800, 0x5800, 0x6400)
    posit_add_test(16, 1, 0x6400, 0x6000, 0x6A00)
    posit_add_test(16, 1, 0x6A00, 0x6200, 0x6F00)
    posit_add_test(16, 1, 0x6F00, 0x6400, 0x7140)
    posit_add_test(16, 1, 0x7140, 0x6600, 0x7300)
    posit_add_test(16, 1, 0x7300, 0x6800, 0x7480)
    posit_add_test(16, 1, 0x7480, 0x6900, 0x75A0)
    posit_add_test(16, 1, 0x75A0, 0x9600, 0x7460)
  }

  it should "return zero for the same posit numbers" in {
    posit_add_test(8, 1, 0x93, 0x93, 0x00, sub = true)
  }

  it should "return isNaN as true when both are infinity" in {
    posit_add_test(8, 4, 0x80, 0x80, 0x80, sub = true, isNaR = true)
  }

  it should "return infinity when one of it is infinity" in {
    posit_add_test(16, 2, 0x8000, 0x7543, 0x8000, sub = true, isNaR = true)
    posit_add_test(16, 2, 0x7543, 0x8000, 0x8000, sub = true, isNaR = true)
  }

  it should "return the first number when the second number is zero" in {
    posit_add_test(8, 3, 0x64, 0x00, 0x64, sub = true)
  }

  it should "return the negative of second number when the first number is zero" in {
    posit_add_test(8, 3, 0, 0x45, 0xBB, sub = true)
  }

  it should "return the addition when both are having different signs" in {
    posit_add_test(8, 1, 0x5D, 0xA5, 0x66, sub = true)
  }

  it should "return the positive number when both are of same sign and first number is larger" in {
    posit_add_test(8, 1, 0x54, 0x42, 0x46, sub = true)
    posit_add_test(8, 1, 0xBE, 0xAC, 0x46, sub = true)
  }

  it should "return the negative number when both are of same sign and second number is larger" in {
    posit_add_test(8, 1, 0x42, 0x54, 0xBA, sub = true)
    posit_add_test(8, 1, 0xAC, 0xBE, 0xBA, sub = true)
  }

  it should "return posit" in {
    posit_add_test(32, 2, 1442843648, 1442840576, 2101346304, sub=true)
  }
}
