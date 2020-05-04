package hardposit

import chisel3._
import chisel3.util.{Cat, MuxCase}

class PositAdd(totalBits: Int, es: Int) extends PositArithmeticModule(totalBits) {
  require(totalBits > es)
  require(es >= 0)

  private val num1Extractor = Module(new PositExtractor(totalBits, es))
  num1Extractor.io.in := io.num1
  private val num1 = num1Extractor.io.out

  private val num2Extractor = Module(new PositExtractor(totalBits, es))
  num2Extractor.io.in := io.num2
  private val num2 = num2Extractor.io.out

  private val num1IsHigherExponent = num1.exponent > num2.exponent
  private val result = Wire(new unpackedPosit(totalBits, es))

  private val highestExponent = Mux(num1IsHigherExponent, num1.exponent, num2.exponent)
  private val highestExponentSign = Mux(num1IsHigherExponent, num1.sign, num2.sign)
  private val highestExponentFraction = Mux(num1IsHigherExponent, num1.fraction, num2.fraction)

  private val smallestExponent = Mux(num1IsHigherExponent, num2.exponent, num1.exponent)
  private val smallestExponentSign = Mux(num1IsHigherExponent, num2.sign, num1.sign)
  private val smallestExponentFraction = Mux(num1IsHigherExponent, num2.fraction, num1.fraction)

  private val exponentDifference = highestExponent - smallestExponent

  private val shiftingCombinations = Array.range(0, totalBits + 1).map(index => {
    (exponentDifference.asUInt() === index.U) -> smallestExponentFraction(totalBits, index)
  })

  private val smallestExponentFractionAfterAdjustment = MuxCase(0.U((totalBits + 2).W), shiftingCombinations)

  private val addedFraction = highestExponentFraction + smallestExponentFractionAfterAdjustment
  private val finalAddedDecimal = addedFraction(totalBits + 1)
  private val finalAddedExponent = highestExponent + 1.S
  private val finalAddedFraction = addedFraction(totalBits, 1)

  private val isHighestExponentFractionHigher = highestExponentFraction >= smallestExponentFractionAfterAdjustment(totalBits, 0)
  private val subtractedFraction = Mux(isHighestExponentFractionHigher,
    highestExponentFraction - smallestExponentFractionAfterAdjustment,
    smallestExponentFractionAfterAdjustment - highestExponentFraction
  )
  private val finalSubtractedDecimal = subtractedFraction(totalBits)
  private val finalSubtractedExponent = highestExponent
  private val finalSubtractedFraction = subtractedFraction(totalBits - 1, 0)
  private val finalSubtractedSign = Mux(isHighestExponentFractionHigher, highestExponentSign, smallestExponentSign)

  private val isSameSignAddition = !(highestExponentSign ^ smallestExponentSign)

  result.isNaR := num1.isNaR || num2.isNaR
  result.isZero := num1.isZero && num2.isZero
  result.stickyBit := Mux(isSameSignAddition, addedFraction(0), false.B)
  result.sign := Mux(isSameSignAddition, highestExponentSign, finalSubtractedSign)
  result.exponent := Mux(isSameSignAddition, finalAddedExponent, finalSubtractedExponent)
  result.fraction := Mux(isSameSignAddition, Cat(finalAddedDecimal, finalAddedFraction), Cat(finalSubtractedDecimal, finalSubtractedFraction))

  private val positGenerator = Module(new PositGenerator(totalBits, es))
  positGenerator.io.in <> result

  private val NaR = 1.U << (totalBits - 1)

  private def check(num1: UInt, num2: UInt): Bool = num1 === 0.U || num2 === NaR

  io.out := Mux(check(io.num1, io.num2), io.num2, Mux(check(io.num2, io.num1), io.num1, positGenerator.io.out))
  io.isNaN := false.B
}