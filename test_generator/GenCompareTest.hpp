#ifndef GENCOMPARETEST_HPP
#define GENCOMPARETEST_HPP

#include <vector>
#include <random>

#include "testposit_gen.hpp"
#include "WriteCases.hpp"

using namespace sw::unum;

namespace testposit {
    template<size_t nbits, size_t es>
    bool genCompareCaseRef(int opcode, const posit <nbits, es> &pa, const posit <nbits, es> &pb) {
        switch (opcode) {
            case OP_LT:
                return pa < pb;
            case OP_EQ:
                return pa == pb;
            case OP_GT:
                return pa > pb;
            default:
                return false;
        }
    }

    template<size_t nbits, size_t es>
    void genCompareTestCases(int opcode, uint32_t nrOfRandoms) {
        const size_t SIZE_STATE_SPACE = nrOfRandoms;
        sw::unum::posit <nbits, es> pa, pb;
        bool expected;

        // generate the full state space set of valid posit values
        std::random_device rd;     //Get a random seed from the OS entropy device, or whatever
        std::mt19937_64 eng(rd()); //Use the 64-bit Mersenne Twister 19937 generator and seed it with entropy.
        //Define the distribution, by default it goes from 0 to MAX(unsigned long long)
        std::uniform_int_distribution<unsigned long long> distr;

        std::vector<unsigned long long> operand_values(SIZE_STATE_SPACE);
        for (uint32_t i = 0; i < SIZE_STATE_SPACE; i++)
            operand_values[i] = distr(eng);

        unsigned ia, ib;  // random indices for picking operands to test
        for (int i = 1; i <= nrOfRandoms; i++) {
            ia = std::rand() % SIZE_STATE_SPACE;
            pa.set_raw_bits(operand_values[ia]);
            ib = std::rand() % SIZE_STATE_SPACE;
            pb.set_raw_bits(operand_values[ib]);
            expected = genCompareCaseRef(opcode, pa, pb);
            writeCompareTestCase(pa, pb, expected);
        }
    }
}

#endif
