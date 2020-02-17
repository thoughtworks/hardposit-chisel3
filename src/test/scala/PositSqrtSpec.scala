import chisel3.iotesters._
import hardposit.PositSqrt

class PositSqrtSpec extends ChiselFlatSpec {

  private class PositSqrtTest(c: PositSqrt, num: Int, expect: Int) extends PeekPokeTester(c) {
    poke(c.io.num, num)
    poke(c.io.valid, true)
    step(1)
    poke(c.io.valid, false)
    while (peek(c.io.ready) == BigInt(0)) {
      step(1)
    }
    print(peek(c.io.out))
    expect(c.io.out, expect)
  }

  private def test(totalBits: Int, es: Int, num: Int, expect: Int): Boolean = {
    //        val manager = new TesterOptionsManager {
    //          testerOptions = testerOptions.copy(backendName = "firrtl", testerSeed = 7L)
    //          interpreterOptions = interpreterOptions.copy(setVerbose = false, writeVCD = true)
    //        }
    //        chisel3.iotesters.Driver.execute(() => new PositSqrt(totalBits, es), manager) {
    //          c => new PositSqrtTest(c, num, expect)
    //        }

    chisel3.iotesters.Driver(() => new PositSqrt(totalBits, es)) {
      c =>
        new PositSqrtTest(c, num, expect)
    }
  }

  it should "return square root when number is given" in {
    assert(test(8, 0, 0x7C, 0x70)) //16, 4
  }

  it should "return square root when number is given 2" in {
    assert(test(8, 0, 0x75, 0x64)) //6.5, 2.5
  }

  it should "return square root when number is given 3" in {
    assert(test(8, 0, 0x62, 0x50)) //2.25, 1.5
  }

  it should "return square root when number is given 4" in {
    assert(test(8, 2, 0x30, 0x38)) //0.25, 0.5
  }

  it should "return NaR when input is negative" in {
    assert(test(8, 0, 0x90, 0x80)) //-4, NaR
  }

  it should "return NaR when input is NaR" in {
    assert(test(8, 0, 0x80, 0x80)) //NaR, NaR
  }
}
