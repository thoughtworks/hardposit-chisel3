import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import hardposit.PositRound

class PositRoundSpec extends AnyFlatSpec with ChiselScalatestTester with Matchers {

  def posit_round_test(nbits: Int, es: Int, inSign: Boolean, inExp: Int, inFrac: Int, inIsNaR: Boolean, inIsZero: Boolean,
                       inTrailingBits: Int, inStickyBit: Boolean, expectExp: Int, expectFrac: Int) {
    val annos = Seq(WriteVcdAnnotation)
    test(new PositRound(nbits, es)).withAnnotations(annos) { c =>
    c.io.in.sign.poke(inSign)
    c.io.in.exponent.poke(inExp)
    c.io.in.fraction.poke(inFrac)
    c.io.in.isNaR.poke(inIsNaR)
    c.io.in.isZero.poke(inIsZero)
    c.io.trailingBits.poke(inTrailingBits)
    c.io.stickyBit.poke(inStickyBit)
    c.clock.step(1)
    c.io.out.exponent.expect(expectExp)
    c.io.out.fraction.expect(expectFrac)
  }
}

  it should "round up the posit 1" in {
    posit_round_test(16, 1, false, 4, 0x0AF4, false, false, 3, true, 4, 0x0AF5)
  }

  it should "round up the posit 2" in {
    posit_round_test(16, 1, false, 4, 0x0AF1, false, false, 2, true, 4, 0x0AF2)
  }

  it should "round down the posit 1" in {
    posit_round_test(16, 1, false, 4, 0x0AF4, false, false, 0, false, 4, 0x0AF4)
  }

  it should "round down the posit 2" in {
    posit_round_test(16, 1, false, 4, 0x0AF4, false, false, 2, false, 4, 0x0AF4)
  }

  it should "fraction overflow must be carried over to exponent" in {
    posit_round_test(16, 1, false, 0x0A, 0x1FFF, false, false, 3, true, 0x0B, 0x1000)
  }

  it should "round to maxpos if overflow" in {
    posit_round_test(16, 1, false, 0x1C, 0x1FFF, false, false, 3, true, 0x1C, 0x1000)
  }

  it should "round to minpos if underflow" in {
    posit_round_test(16, 1, false, -0x1D, 0x1FFF, false, false, 0, false, -0x1C, 0x1000)
  }
}
