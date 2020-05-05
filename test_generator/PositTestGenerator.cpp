#include <string>

#include "../universal/include/universal/posit/posit.hpp"
#include "PositTestGenerator.hpp"
#include "GenUnaryTest.hpp"
#include "GenBinaryTest.hpp"
#include "GenTernaryTest.hpp"
#include "GenCompareTest.hpp"
#include "GenConversionTest.hpp"

int main(int argc, char *argv[]) {
    using namespace testposit;

    bool random_test = true;
    int funcArgIndex = 1;
    if (argc < 2) {
        fprintf(stderr, "Invalid option\n");
        return -1;
    }

    if (argc == 3) {
        if (!strcmp(argv[1], "-a")) {
            random_test = false;
            funcArgIndex = 2;
        } else {
            fprintf(stderr, "Invalid option\n");
            return -1;
        }
    }

    if (!strcmp(argv[funcArgIndex], "p16_add")) {            //TODO Improve argument decoding
        genBinaryTestCases<16, 1>(OP_ADD, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p16_mul")) {
        genBinaryTestCases<16, 1>(OP_MUL, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p32_add")) {
        genBinaryTestCases<32, 2>(OP_ADD, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p32_mul")) {
        genBinaryTestCases<32, 2>(OP_MUL, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p64_add")) {
        genBinaryTestCases<64, 3>(OP_ADD, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p64_mul")) {
        genBinaryTestCases<64, 3>(OP_MUL, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p16_mulAdd")) {
        genTernaryTestCases<16, 1>(OP_FMA, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p32_mulAdd")) {
        genTernaryTestCases<32, 2>(OP_FMA, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p64_mulAdd")) {
        genTernaryTestCases<64, 3>(OP_FMA, random_test, RND_TEST_CASES);
    }
    else if (!strcmp(argv[funcArgIndex], "p16_div")) {
        genBinaryTestCases<16, 1>(OP_DIV, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p32_div")) {
        genBinaryTestCases<32, 2>(OP_DIV, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p64_div")) {
        genBinaryTestCases<64, 3>(OP_DIV, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p16_sqrt")) {
        genUnaryTestCases<16, 1>(OP_SQRT, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p32_sqrt")) {
        genUnaryTestCases<32, 2>(OP_SQRT, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p64_sqrt")) {
        genUnaryTestCases<64, 3>(OP_SQRT, random_test, RND_TEST_CASES);
    }
    else if (!strcmp(argv[funcArgIndex], "p16_lt")) {
        genCompareTestCases<16, 1>(OP_LT, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p32_lt")) {
        genCompareTestCases<32, 2>(OP_LT, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p64_lt")) {
        genCompareTestCases<64, 3>(OP_LT, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p16_eq")) {
        genCompareTestCases<16, 1>(OP_EQ, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p32_eq")) {
        genCompareTestCases<32, 2>(OP_EQ, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p64_eq")) {
        genCompareTestCases<64, 3>(OP_EQ, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p16_gt")) {
        genCompareTestCases<16, 1>(OP_GT, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p32_gt")) {
        genCompareTestCases<32, 2>(OP_GT, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p64_gt")) {
        genCompareTestCases<64, 3>(OP_GT, RND_TEST_CASES);
    }
    else if (!strcmp(argv[funcArgIndex], "p16_i32")) {
        genP2ITestCases<16, 1, 32>(RND_TEST_CASES, false);
    } else if (!strcmp(argv[funcArgIndex], "p16_i64")) {
        genP2ITestCases<16, 1, 64>(RND_TEST_CASES, false);
    } else if (!strcmp(argv[funcArgIndex], "p32_i32")) {
        genP2ITestCases<32, 2, 32>(RND_TEST_CASES, false);
    } else if (!strcmp(argv[funcArgIndex], "p32_i64")) {
        genP2ITestCases<32, 2, 64>(RND_TEST_CASES, false);
    } else if (!strcmp(argv[funcArgIndex], "p64_i32")) {
        genP2ITestCases<64, 3, 32>(RND_TEST_CASES, false);
    } else if (!strcmp(argv[funcArgIndex], "p64_i64")) {
        genP2ITestCases<64, 3, 64>(RND_TEST_CASES, false);
    }
    else if (!strcmp(argv[funcArgIndex], "p16_ui32")) {
        genP2ITestCases<16, 1, 32>(RND_TEST_CASES, true);
    } else if (!strcmp(argv[funcArgIndex], "p16_ui64")) {
        genP2ITestCases<16, 1, 64>(RND_TEST_CASES, true);
    } else if (!strcmp(argv[funcArgIndex], "p32_ui32")) {
        genP2ITestCases<32, 2, 32>(RND_TEST_CASES, true);
    } else if (!strcmp(argv[funcArgIndex], "p32_ui64")) {
        genP2ITestCases<32, 2, 64>(RND_TEST_CASES, true);
    } else if (!strcmp(argv[funcArgIndex], "p64_ui32")) {
        genP2ITestCases<64, 3, 32>(RND_TEST_CASES, true);
    } else if (!strcmp(argv[funcArgIndex], "p64_ui64")) {
        genP2ITestCases<64, 3, 64>(RND_TEST_CASES, true);
    }
    else if (!strcmp(argv[funcArgIndex], "i32_p16")) {
        genI2PTestCases<16, 1, 32>(RND_TEST_CASES, false);
    } else if (!strcmp(argv[funcArgIndex], "i64_p16")) {
        genI2PTestCases<16, 1, 64>(RND_TEST_CASES, false);
    } else if (!strcmp(argv[funcArgIndex], "i32_p32")) {
        genI2PTestCases<32, 2, 32>(RND_TEST_CASES, false);
    } else if (!strcmp(argv[funcArgIndex], "i64_p32")) {
        genI2PTestCases<32, 2, 64>(RND_TEST_CASES, false);
    } else if (!strcmp(argv[funcArgIndex], "i32_p64")) {
        genI2PTestCases<64, 3, 32>(RND_TEST_CASES, false);
    } else if (!strcmp(argv[funcArgIndex], "i64_p64")) {
        genI2PTestCases<64, 3, 64>(RND_TEST_CASES, false);
    }
    else if (!strcmp(argv[funcArgIndex], "ui32_p16")) {
        genI2PTestCases<16, 1, 32>(RND_TEST_CASES, true);
    } else if (!strcmp(argv[funcArgIndex], "ui64_p16")) {
        genI2PTestCases<16, 1, 64>(RND_TEST_CASES, true);
    } else if (!strcmp(argv[funcArgIndex], "ui32_p32")) {
        genI2PTestCases<32, 2, 32>(RND_TEST_CASES, true);
    } else if (!strcmp(argv[funcArgIndex], "ui64_p32")) {
        genI2PTestCases<32, 2, 64>(RND_TEST_CASES, true);
    } else if (!strcmp(argv[funcArgIndex], "ui32_p64")) {
        genI2PTestCases<64, 3, 32>(RND_TEST_CASES, true);
    } else if (!strcmp(argv[funcArgIndex], "ui64_p64")) {
        genI2PTestCases<64, 3, 64>(RND_TEST_CASES, true);
    }
    else if (!strcmp(argv[funcArgIndex], "p16_p32")) {
        genP2PTestCases<16, 1, 32, 2>(RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p16_p64")) {
        genP2PTestCases<16, 1, 64, 3>(RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p32_p16")) {
        genP2PTestCases<32, 2, 16, 1>(RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p32_p64")) {
        genP2PTestCases<32, 2, 64, 3>(RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p64_p16")) {
        genP2PTestCases<64, 3, 16, 1>(RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p64_p32")) {
        genP2PTestCases<64, 3, 32, 2>(RND_TEST_CASES);
    }
    else {
        fprintf(stderr, "Invalid function\n");              //TODO Print help message
        return -1;
    }

    return 0;
}