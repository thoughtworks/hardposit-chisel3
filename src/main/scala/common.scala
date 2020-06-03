package hardposit

import chisel3._
import chisel3.util.{PriorityEncoder, UIntToOH, log2Ceil}

class unpackedPosit(val totalBits: Int, val es: Int) extends Bundle with HasHardPositParams {

  val sign = Bool()
  val exponent = SInt(maxExponentBits.W)
  val fraction = UInt(maxFractionBitsWithHiddenBit.W) //TODO Transfer only fraction bits without hidden bit
  val isZero = Bool()
  val isNaR = Bool()

  override def cloneType =
    new unpackedPosit(totalBits, es).asInstanceOf[this.type]
}

object countLeadingZeros
{
  def apply(in: UInt): UInt = PriorityEncoder(in.asBools.reverse)
}

object lowerBitMask
{
  def apply(in: UInt): UInt = UIntToOH(in) - 1.U
}

trait HasHardPositParams {
  val totalBits: Int
  val es: Int

  require(totalBits > es + 3, s"Posit size $totalBits is inadequate for exponent size $es")
  require(trailingBitCount >= 2, "At-least 2 trailing bits required")

  def maxExponentBits: Int = getMaxExponentBits(totalBits, es)

  def maxFractionBits: Int = getMaxFractionBits(totalBits, es)

  def maxFractionBitsWithHiddenBit: Int = getMaxFractionBitsWithHiddenBit(totalBits, es)

  def getMaxExponentBits(p: Int, e: Int): Int = log2Ceil(p) + e + 2

  def getMaxFractionBits(p: Int, e: Int): Int = if (e + 3 >= p) 1 else p - 3 - e

  def getMaxFractionBitsWithHiddenBit(p: Int, e: Int): Int = getMaxFractionBits(p, e) + 1

  def maxAdderFractionBits: Int = maxFractionBitsWithHiddenBit + trailingBitCount + stickyBitCount + 1

  def maxMultiplierFractionBits: Int = 2 * maxFractionBitsWithHiddenBit

  def maxDividerFractionBits: Int = maxFractionBitsWithHiddenBit + trailingBitCount + stickyBitCount + 1

  def NaR: UInt = (1.U << (totalBits - 1)).asUInt()

  def zero: UInt = 0.U(totalBits.W)

  def isNaR(num: UInt): Bool = num(totalBits - 1) & ~num(totalBits - 2, 0).orR()

  def isZero(num: UInt): Bool = ~num.orR()

  def trailingBitCount = 2

  def stickyBitCount = 1

  def maxSignedInteger(w: Int): UInt = (1.U << (w - 1)) - 1.U

  def maxUnsignedInteger(w: Int): UInt = (1.U << w) - 1.U
}