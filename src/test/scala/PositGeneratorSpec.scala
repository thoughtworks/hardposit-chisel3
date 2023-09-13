//import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester}
//import hardposit.PositGenerator
//
//class PositGeneratorSpec extends ChiselFlatSpec{
//
//  behavior of "Posit Generator"
//
//  private class PositGeneratorTest(c: PositGenerator, sign: Boolean, exponent: Int, fraction: Int, expectedPosit: Int) extends PeekPokeTester(c) {
//    poke(c.io.in.sign, sign)
//    poke(c.io.in.exponent, exponent)
//    poke(c.io.in.fraction, fraction)
//    poke(c.io.in.isNaR, false)
//    poke(c.io.in.isZero, false)
//    step(1)
//    expect(c.io.out, expectedPosit & 0xFF)
//  }
//
//  private def test(nbits: Int, es: Int, sign: Boolean, exponent: Int, fraction: Int, expectedPosit: Int): Boolean = {
//    chisel3.iotesters.Driver(() => new PositGenerator(nbits, es)) {
//      c => new PositGeneratorTest(c, sign, exponent, fraction, expectedPosit)
//    }
//  }
//
//  it should "represent zero when both decimal and fraction are zero" in {
//    assert(test(8, 0, false, 5, 0, 0))
//    assert(test(8, 0, true, 5, 0, 0))
//    assert(test(8, 1, true, 2, 0, 0))
//  }
//
//  it should "not underflow when the exponent too less" in {
//    assert(test(8, 0, false, -7, 0xF, 0x01))
//    assert(test(8, 0, false, -6, 0x7, 0x01))
//  }
//
//  it should "represent maxpos when the exponent is high then it fits" in {
//    assert(test(8, 0, false, 8, 0x1F, 0x7F))
//  }
//
//  it should "extract the positive regime" in {
//    assert(test(8, 1, sign = false, 3, 0x16, 0x6B))
//  }
//
//  it should "extract the negative regime" in {
//    assert(test(8, 1, true, 3, 0x16, -0x6B))
//  }
//
//}
