#ifndef TESTPOSIT_GEN_HPP
#define TESTPOSIT_GEN_HPP

namespace testposit {

    //FMA tests
    const int OP_ADD = 1;
    const int OP_MUL = 2;
    const int OP_FMA = 3;

    //DivSqrt Tests
    const int OP_DIV = 4;
    const int OP_SQRT = 5;

    //Compare Tests
    const int OP_LT = 6;
    const int OP_EQ = 7;
    const int OP_GT = 8;

    constexpr size_t RND_TEST_CASES = 500000;
}

#endif
