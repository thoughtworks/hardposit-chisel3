#include <string>

#include "../universal/include/universal/posit/posit.hpp"
#include "testposit_gen.hpp"
#include "GenBinaryTest.hpp"
#include "GenTernaryTest.hpp"

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
    } else if (!strcmp(argv[funcArgIndex], "p16_div")) {
        genTernaryTestCases<16, 1>(OP_DIV, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p32_div")) {
        genTernaryTestCases<32, 2>(OP_DIV, random_test, RND_TEST_CASES);
    } else if (!strcmp(argv[funcArgIndex], "p64_div")) {
        genTernaryTestCases<64, 3>(OP_DIV, random_test, RND_TEST_CASES);
    } else {
        fprintf(stderr, "Invalid function\n");              //TODO Print help message
        return -1;
    }

    return 0;
}