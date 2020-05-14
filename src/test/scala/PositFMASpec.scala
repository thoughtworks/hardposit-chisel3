import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester}
import hardposit.PositFMA

class PositFMASpec extends ChiselFlatSpec {

  private class PositFMATest(c: PositFMA, num1: Int, num2: Int, num3: Int, sub: Boolean, negate: Boolean, expectedPosit: Int, isNaR: Boolean) extends PeekPokeTester(c) {
    poke(c.io.num1, num1)
    poke(c.io.num2, num2)
    poke(c.io.num3, num3)
    poke(c.io.sub, sub)
    poke(c.io.negate, negate)
    step(1)
    print(peek(c.io.isNaR))
    expect(c.io.isNaR, isNaR)
    if (!isNaR) {
      expect(c.io.out, expectedPosit)
    }
  }

  private def test(totalBits: Int, es: Int, num1: Int, num2: Int, num3: Int, sub: Boolean, negate: Boolean, expectedPosit: Int, isNaR: Boolean = false): Boolean = {
//    chisel3.iotesters.Driver.execute(Array("--generate-vcd-output", "on", "--target-dir", "test_run_dir/fma", "--top-name", "fma"), () => new PositFMA(totalBits, es)) {
//      c => new PositFMATest(c, num1, num2, num3, sub, negate, expectedPosit, isNaR)
//    }

    chisel3.iotesters.Driver(() => new PositFMA(totalBits, es)) {
      c => new PositFMATest(c, num1, num2, num3, sub, negate, expectedPosit, isNaR)
    }
  }

  it should "return product when addend is zero" in {
    assert(test(8, 0, 0x70, 0x70, 0x0, sub = false, negate = false, 0x7C)) //(4 * 4) + 0 == 16
  }

  it should "return product when addend is zero 2" in {
    assert(test(16, 1, 0x5A00, 0x6200, 0x0, sub = false, negate = false, 0x7010)) //(3.25 * 5) + 0 == 16.25
  }

  it should "return product when addend is zero 3" in {
    assert(test(8, 2, 0x47, 0x10, 0x0, sub = false, negate = false, 0x14)) //(1.875 * 0.00390) + 0 == 0.007324
  }

  it should "return sum when multiplier is one" in {
    assert(test(8, 0, 0x7F, 0x7F, 0x70, sub = false, negate = false, 0x7F, isNaR = false)) //(64 * 1) + 64 == NaR
  }

  it should "return sum when multiplier is one 2" in {
    assert(test(8, 0, 0x70, 0x40, 0x70, sub = false, negate = false, 0x78)) //(4 * 1) + 4 == 8
  }

  it should "return sum when multiplier is one 3" in {
    assert(test(16, 2, 0x64AF, 0x4000, 0xAF44, sub = false, negate = false, 0x6423)) //(37.46875 * 1) + -4.3671875 == 33.09375
  }

  it should "return difference when multiplier is one and sub is true" in {
    assert(test(8, 0, 0x70, 0x40, 0x70, sub = true, negate = false, 0x0)) //(4 * 1) - 4 == 0
  }

  it should "return difference when multiplier is one and sub is true 2" in {
    assert(test(16, 2, 0x64AF, 0x4000, 0x50BC, sub = true, negate = false, 0x6423)) //(37.46875 * 1) - 4.3671875 == 33.09375
  }

  it should "return fused multiply-add result" in {
    assert(test(8, 2, 0x50, 0x48, 0x50, sub = false, negate = false, 0x5C)) //(4 * 2) + 4 == 12
  }

  it should "return fused multiply-add result 2" in {
    assert(test(8, 0, 0x38, 0x60, 0x4C, sub = false, negate = false, 0x69)) //(0.875 * 2) + 1.375 == 3.125
  }

  it should "return negated fused multiply-subtract result when subtract true" in {
    assert(test(8, 0, 0x38, 0x60, 0x4C, sub = true, negate = false, 0x18)) //(0.875 * 2) - 1.375 == 0.375
  }

  it should "return negated fused multiply-add when negate true" in {
    assert(test(8, 0, 0x38, 0x60, 0x4C, sub = false, negate = true, 0x97)) //-(0.875 * 2) - 1.375 == -3.125
  }

  it should "return negated fused multiply-subtract when negate and sub true" in {
    assert(test(8, 0, 0x38, 0x60, 0x4C, sub = true, negate = true, 0xE8)) //-(0.875 * 2) + 1.375 == -0.375
  }

  it should "return NaR when one of the inputs is NaR" in {
    assert(test(8, 0, 0x80, 0x60, 0x4C, sub = false, negate = false, 0x80, isNaR = true)) //(NaR * 2) + 1.375 == NaR
  }
}
