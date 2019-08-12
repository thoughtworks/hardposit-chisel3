import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}

class FractionExtractorSpec extends FlatSpec with Matchers {

  class FractionExtractorTest(c: FractionExtractor,noOfUsedBits: Int,num:Int,fraction:Int) extends PeekPokeTester(c){
    poke(c.io.noOfUsedBits,noOfUsedBits)
    poke(c.io.num,num)
    expect(c.io.fraction,fraction)
  }

  private def test(totalBits: Int,noOfUsedBits: Int,num:Int,fraction:Int):Boolean = {
    chisel3.iotesters.Driver(() => new FractionExtractor(totalBits)){
      c => new FractionExtractorTest(c,noOfUsedBits,num,fraction)
    }
  }

  it should "return the fraction starting from 1st bit" in {
    assert(test(8,4,0x3F,0xF0))
  }

  it should "return the fraction as zero when bits are occupied" in {
    assert(test(8,8,0xFF,0))
  }

  it should "return the fraction when there are different types of bits" in {
    assert(test(8,3,0x16,0xB0))
  }
}
