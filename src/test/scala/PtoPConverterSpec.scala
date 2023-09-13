//import chisel3.iotesters.{ChiselFlatSpec, PeekPokeTester}
//import hardposit.PtoPConverter
//
//class PtoPConverterSpec extends ChiselFlatSpec {
//
//  private class PtoPConverterTest(c: PtoPConverter, inPosit: Int, expected: Int) extends PeekPokeTester(c) {
//    poke(c.io.in, inPosit)
//    step(1)
//    expect(c.io.out, expected)
//  }
//
//  def test(inWidth: Int, inEs: Int, outWidth: Int, outEs: Int, inPosit: Int, expected: Int): Boolean = {
//    chisel3.iotesters.Driver(() => new PtoPConverter(inWidth, inEs, outWidth, outEs)) {
//      c => new PtoPConverterTest(c, inPosit, expected)
//    }
//  }
//
//  it should "return wide posit for narrow posit with same es" in {
//    assert(test(8, 2, 16, 2, 0x4F, 0x4F00)) //3.75
//  }
//
//  it should "return wide posit for narrow posit with different es" in {
//    assert(test(8, 2, 16, 3, 0x4F, 0x4780))
//  }
//
//  it should "return narrow posit for wide posit with same es" in {
//    assert(test(16, 2, 8, 2, 0x4F00, 0x4F))
//  }
//
//  it should "return narrow posit for wide posit with different es" in {
//    assert(test(16, 3, 8, 2, 0x4780, 0x4F))
//  }
//
//  it should "return NaR for wide posit with value outside narrower range" in {
//    assert(test(16, 3, 8, 0, 0x6200, 0x7F)) //512
//  }
//
//  it should "return NaR for wider NaR" in {
//    assert(test(16, 0, 8, 0, 0x8000, 0x80)) //NaR
//  }
//
//  it should "return NaR for narrower NaR" in {
//    assert(test(8, 0, 16, 0, 0x80, 0x8000))
//  }
//}