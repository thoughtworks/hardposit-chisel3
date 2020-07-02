package hardposit

import chisel3._
import chisel3.util.{PriorityEncoder, UIntToOH, log2Ceil}

class unpackedPosit(val nbits: Int, val es: Int) extends Bundle with HasHardPositParams {

  val sign = Bool()
  val exponent = SInt(maxExponentBits.W)
  val fraction = UInt(maxFractionBitsWithHiddenBit.W) //TODO Transfer only fraction bits without hidden bit
  val isZero = Bool()
  val isNaR = Bool()

  override def cloneType =
    new unpackedPosit(nbits, es).asInstanceOf[this.type]
}

object countLeadingZeros {
  def apply(in: UInt): UInt = PriorityEncoder(in.asBools.reverse)
}

object lowerBitMask {
  def apply(in: UInt): UInt = UIntToOH(in) - 1.U
}

object isOnlyMSBSet {
  def apply(num: UInt, n: Int): Bool = num(n - 1) & ~num(n - 2, 0).orR()
}

trait HasHardPositParams {
  val nbits: Int
  val es: Int

  require(nbits > es + 3, s"Posit size $nbits is inadequate for exponent size $es")
  require(trailingBitCount >= 2, "At-least 2 trailing bits required")

  def maxExponentBits: Int = getMaxExponentBits(nbits, es)

  def maxFractionBits: Int = getMaxFractionBits(nbits, es)

  def maxFractionBitsWithHiddenBit: Int = getMaxFractionBitsWithHiddenBit(nbits, es)

  def getMaxExponentBits(n: Int, e: Int): Int = log2Ceil(n) + e + 2

  def getMaxFractionBits(n: Int, e: Int): Int = if (e + 3 >= n) 1 else n - 3 - e

  def getMaxFractionBitsWithHiddenBit(n: Int, e: Int): Int = getMaxFractionBits(n, e) + 1

  def maxAdderFractionBits: Int = maxFractionBitsWithHiddenBit + trailingBitCount + stickyBitCount + 1

  def maxMultiplierFractionBits: Int = 2 * maxFractionBitsWithHiddenBit

  def maxDividerFractionBits: Int = maxFractionBitsWithHiddenBit + trailingBitCount + stickyBitCount + 1

  def NaR: UInt = (1.U << (nbits - 1)).asUInt()

  def zero: UInt = 0.U(nbits.W)

  def isNaR(num: UInt): Bool = isOnlyMSBSet(num, nbits)

  def isZero(num: UInt): Bool = ~num.orR()

  def trailingBitCount = 2

  def stickyBitCount = 1

  def maxRegime: Int = nbits - 2

  def minRegime: Int = -maxRegime

  def maxExponent: Int = maxRegime * (1 << es)

  def minExponent: Int = minRegime * (1 << es)

  def maxSignedInteger(w: Int): Int = (1 << (w - 1)) - 1

  def maxUnsignedInteger(w: Int): Int = (1 << w) - 1
}