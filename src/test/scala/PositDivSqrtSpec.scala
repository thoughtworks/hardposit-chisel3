import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester}
import hardposit.PositDivSqrt

class PositDivSqrtSpec extends ChiselFlatSpec {

  private class PositDivSqrtTest(c: PositDivSqrt, num1: Int, num2: Int, sqrtOp: Boolean, expect: Int) extends PeekPokeTester(c) {
    poke(c.io.num1, num1)
    poke(c.io.num2, num2)
    poke(c.io.sqrtOp, sqrtOp)
    poke(c.io.validIn, true)
    step(1)
    poke(c.io.validIn, false)
    while (if(sqrtOp) peek(c.io.validOut_sqrt) == BigInt(0) else peek(c.io.validOut_div) == BigInt(0)) {
      step(1)
    }
    expect(c.io.out, expect)
  }

  private def test(nbits: Int, es: Int, num1: Int, num2: Int, sqrtOp: Boolean, expect: Int): Boolean = {
//    chisel3.iotesters.Driver.execute(Array("--generate-vcd-output", "on", "--target-dir", "test_run_dir/div_sqrt", "--top-name", "dsvcd"), () => new PositDivSqrt(totalBits, es)) {
//      c => new PositDivSqrtTest(c, num1, num2, sqrtOp, expect)
//    }

      chisel3.iotesters.Driver(() => new PositDivSqrt(nbits, es)) {
        c => new PositDivSqrtTest(c, num1, num2, sqrtOp, expect)
      }
  }

  it should "return square root when number is given" in {
    assert(test(8, 0, 0x7C, 0, sqrtOp = true, 0x70)) //16, 4
  }

  it should "return square root when number is given 2" in {
    assert(test(8, 0, 0x75, 0, sqrtOp = true, 0x64)) //6.5, 2.5
  }

  it should "return square root when number is given 3" in {
    assert(test(8, 0, 0x62, 0, sqrtOp = true, 0x50)) //2.25, 1.5
  }

  it should "return square root when number is given 4" in {
    assert(test(8, 2, 0x30, 0, sqrtOp = true, 0x38)) //0.25, 0.5
  }

  it should "return NaR when input is negative" in {
    assert(test(8, 0, 0x90, 0, sqrtOp = true, 0x80)) //-4, NaR
  }

  it should "return NaR when input is NaR" in {
    assert(test(8, 0, 0x80, 0, sqrtOp = true, 0x80)) //NaR, NaR
  }

  it should "return positive value when signs are equal" in {
    assert(test(16, 1, 0x5A00, 0x1E00, sqrtOp = false, 0x6EDB))
    assert(test(16, 1, 0xA600, 0xE200, sqrtOp = false, 0x6EDB))
  }

  it should "return negative value when signs are not equal" in {
    assert(test(16, 1, 0x5A00, 0xE200, sqrtOp = false, 0x9125))
  }

  it should "return zero when the dividend is zero and divisor is not equal zero" in {
    assert(test(8, 2, 0, 0x32, sqrtOp = false, 0))
  }

  it should "return NaR when the divisor is zero and dividend is not equal zero" in {
    assert(test(8, 2, 0x34, 0, sqrtOp = false, 0x80))
  }

  it should "return NaR when the dividend is NaR and divisor is not equal NaR" in {
    assert(test(8, 1, 0x80, 0x42, sqrtOp = false, 0x80))
    assert(test(8, 1, 0x80, 0, sqrtOp = false, 0x80))
  }

  it should "return NaR when the divisor is NaR and dividend is not NaR" in {
    assert(test(8, 4, 0x76, 0x80, sqrtOp = false, 0x80))
    assert(test(8, 4, 0, 0x80, sqrtOp = false, 0x80))
  }

  it should "return NaR when both dividend and divisor are zero or NaR" in {
    assert(test(8, 3, 0, 0, sqrtOp = false, 0x80))
    assert(test(8, 3, 0x80, 0x80, sqrtOp = false, 0x80))
  }
}
