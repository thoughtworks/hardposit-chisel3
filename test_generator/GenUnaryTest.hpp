#ifndef GENUNARYTEST_HPP
#define GENUNARYTEST_HPP

#include <vector>
#include <random>

#include "testposit_gen.hpp"
#include "WriteCases.hpp"

using namespace sw::unum;

namespace testposit {
    template<size_t nbits, size_t es>
    void genUnaryCaseRef(int opcode, posit <nbits, es> &pa,
                         posit <nbits, es> &pexpected) {
        switch (opcode) {
            case OP_SQRT:
                pexpected = posit<nbits, es>(std::sqrt((long double)pa));
                break;
            default:
                return;
        }
    }

    template<size_t nbits, size_t es>
    void genRandUnaryTests(int opcode, int nrOfRandoms) {
        const size_t SIZE_STATE_SPACE = nrOfRandoms;
        sw::unum::posit <nbits, es> pa, pexpected;

        // generate the full state space set of valid posit values
        std::random_device rd;     //Get a random seed from the OS entropy device, or whatever
        std::mt19937_64 eng(rd()); //Use the 64-bit Mersenne Twister 19937 generator and seed it with entropy.
        //Define the distribution, by default it goes from 0 to MAX(unsigned long long)
        std::uniform_int_distribution<unsigned long long> distr;

        std::vector<unsigned long long> operand_values(SIZE_STATE_SPACE);
        for (uint32_t i = 0; i < SIZE_STATE_SPACE; i++)
            operand_values[i] = distr(eng);

        unsigned ia;  // random indices for picking operands to test
        for (int i = 1; i <= nrOfRandoms; i++) {
            ia = std::rand() % SIZE_STATE_SPACE;
            pa.set_raw_bits(operand_values[ia]);
            genUnaryCaseRef(opcode, pa, pexpected);
            writeUnaryTestCase(pa, pexpected);
        }
    }

    template<size_t nbits, size_t es>
    void genAllUnaryTests(int opcode) {
        const size_t NR_POSITS = (size_t(1) << nbits);
        sw::unum::posit <nbits, es> pa, pexpected;

        for (size_t i = 0; i < NR_POSITS; i++) {
            pa.set_raw_bits(i);
            genUnaryCaseRef(opcode, pa, pexpected);
            writeUnaryTestCase(pa, pexpected);
        }
    }

    template<size_t nbits, size_t es>
    void genUnaryTestCases(int opcode, bool random_test, uint32_t nrOfRandoms) {
        if (random_test)
            genRandUnaryTests<nbits, es>(opcode, nrOfRandoms);
        else
            genAllUnaryTests<nbits, es>(opcode);
    }

}

#endif
