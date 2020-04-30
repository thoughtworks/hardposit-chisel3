package hardposit

object EvalTests {

  def main(args: Array[String]): Unit = {
    val testArgs = args.slice(1, args.length).toArray
    args(0) match {
      case "FMAP16_add" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositFMAP16_add)
      case "FMAP16_mul" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositFMAP16_mul)
      case "FMAP16" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositFMAP16)
      case "FMAP32_add" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositFMAP32_add)
      case "FMAP32_mul" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositFMAP32_mul)
      case "FMAP32" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositFMAP32)
      case "FMAP64_add" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositFMAP64_add)
      case "FMAP64_mul" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositFMAP64_mul)
      case "FMAP64" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositFMAP64)
      case "DivSqrtP16_div" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositDivSqrtP16_div)
      case "DivSqrtP32_div" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositDivSqrtP32_div)
      case "DivSqrtP64_div" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositDivSqrtP64_div)
      case "DivSqrtP16_sqrt" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositDivSqrtP16_sqrt)
      case "DivSqrtP32_sqrt" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositDivSqrtP32_sqrt)
      case "DivSqrtP64_sqrt" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositDivSqrtP64_sqrt)
      case "CompareP16_lt" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositCompareP16_lt)
      case "CompareP32_lt" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositCompareP32_lt)
      case "CompareP64_lt" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositCompareP64_lt)
      case "CompareP16_eq" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositCompareP16_eq)
      case "CompareP32_eq" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositCompareP32_eq)
      case "CompareP64_eq" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositCompareP64_eq)
      case "CompareP16_gt" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositCompareP16_gt)
      case "CompareP32_gt" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositCompareP32_gt)
      case "CompareP64_gt" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositCompareP64_gt)
      case "P16toI32" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositP16toI32)
      case "P16toI64" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositP16toI64)
      case "P32toI32" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositP32toI32)
      case "P32toI64" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositP32toI64)
      case "P64toI32" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositP64toI32)
      case "P64toI64" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositP64toI64)
      case "I32toP16" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositI32toP16)
      case "I64toP16" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositI64toP16)
      case "I32toP32" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositI32toP32)
      case "I64toP32" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositI64toP32)
      case "I32toP64" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositI32toP64)
      case "I64toP64" =>
        chisel3.Driver.execute(
          testArgs, () => new Eval_PositI64toP64)
    }
  }
}
