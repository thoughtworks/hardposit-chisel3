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
    }
  }
}
