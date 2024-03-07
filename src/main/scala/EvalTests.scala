package hardposit

object EvalTests {

  def main(args: Array[String]): Unit = {
    val testArgs = args.slice(1, args.length).toArray

    val testDirAbsolutePath = "./td"

    (new chisel3.stage.ChiselStage).emitVerilog( args(0) match {
      case "FMAP16_add" => new Eval_PositFMAP16_add
      case "FMAP16_mul" => new Eval_PositFMAP16_mul
      case "FMAP16" => new Eval_PositFMAP16
      case "FMAP32_add" => new Eval_PositFMAP32_add
      case "FMAP32_mul" => new Eval_PositFMAP32_mul
      case "FMAP32" => new Eval_PositFMAP32
      case "FMAP64_add" => new Eval_PositFMAP64_add
      case "FMAP64_mul" => new Eval_PositFMAP64_mul
      case "FMAP64" => new Eval_PositFMAP64
      case "DivSqrtP16_div" => new Eval_PositDivSqrtP16_div
      case "DivSqrtP32_div" => new Eval_PositDivSqrtP32_div
      case "DivSqrtP64_div" => new Eval_PositDivSqrtP64_div
      case "DivSqrtP16_sqrt" => new Eval_PositDivSqrtP16_sqrt
      case "DivSqrtP32_sqrt" => new Eval_PositDivSqrtP32_sqrt
      case "DivSqrtP64_sqrt" => new Eval_PositDivSqrtP64_sqrt
      case "CompareP16_lt" => new Eval_PositCompareP16_lt
      case "CompareP32_lt" => new Eval_PositCompareP32_lt
      case "CompareP64_lt" => new Eval_PositCompareP64_lt
      case "CompareP16_eq" => new Eval_PositCompareP16_eq
      case "CompareP32_eq" => new Eval_PositCompareP32_eq
      case "CompareP64_eq" => new Eval_PositCompareP64_eq
      case "CompareP16_gt" => new Eval_PositCompareP16_gt
      case "CompareP32_gt" => new Eval_PositCompareP32_gt
      case "CompareP64_gt" => new Eval_PositCompareP64_gt
      case "P16toI32" => new Eval_PositP16toI32
      case "P16toI64" => new Eval_PositP16toI64
      case "P32toI32" => new Eval_PositP32toI32
      case "P32toI64" => new Eval_PositP32toI64
      case "P64toI32" => new Eval_PositP64toI32
      case "P64toI64" => new Eval_PositP64toI64
      case "P16toUI32" => new Eval_PositP16toUI32
      case "P16toUI64" => new Eval_PositP16toUI64
      case "P32toUI32" => new Eval_PositP32toUI32
      case "P32toUI64" => new Eval_PositP32toUI64
      case "P64toUI32" => new Eval_PositP64toUI32
      case "P64toUI64" => new Eval_PositP64toUI64
      case "I32toP16" => new Eval_PositI32toP16
      case "I64toP16" => new Eval_PositI64toP16
      case "I32toP32" => new Eval_PositI32toP32
      case "I64toP32" => new Eval_PositI64toP32
      case "I32toP64" => new Eval_PositI32toP64
      case "I64toP64" => new Eval_PositI64toP64
      case "UI32toP16" => new Eval_PositUI32toP16
      case "UI64toP16" => new Eval_PositUI64toP16
      case "UI32toP32" => new Eval_PositUI32toP32
      case "UI64toP32" => new Eval_PositUI64toP32
      case "UI32toP64" => new Eval_PositUI32toP64
      case "UI64toP64" => new Eval_PositUI64toP64
      case "P16toP32" => new Eval_PositP16toP32
      case "P16toP64" => new Eval_PositP16toP64
      case "P32toP16" => new Eval_PositP32toP16
      case "P32toP64" => new Eval_PositP32toP64
      case "P64toP16" => new Eval_PositP64toP16
      case "P64toP32" => new Eval_PositP64toP32
    },
      Array.concat(args)
    )

    // (new chisel3.stage.ChiselStage).execute(
    //   Array("-X", "verilog"),
    //   Seq(
    //     TargetDirAnnotation(testDirAbsolutePath),
    //     ChiselGeneratorAnnotation(module)
    //   )
    // )
  }
}
