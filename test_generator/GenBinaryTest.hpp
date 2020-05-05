#ifndef GENBINARYTEST_HPP
#define GENBINARYTEST_HPP

#include <vector>
#include <random>

#include "PositTestGenerator.hpp"
#include "WriteCases.hpp"

using namespace sw::unum;

namespace testposit {
    template<size_t nbits, size_t es>
    void genBinaryCaseRef(int opcode, const posit <nbits, es> &pa, const posit <nbits, es> &pb,
                          posit <nbits, es> &pexpected) {
        switch (opcode) {
            case OP_ADD:
                pexpected = pa + pb;
                break;
            case OP_MUL:
                pexpected = pa * pb;
                break;
            case OP_DIV:
                pexpected = pa / pb;
            default:
                return;
        }
    }

    template<size_t nbits, size_t es>
    void genRandBinaryTests(int opcode, int nrOfRandoms) {
        const size_t SIZE_STATE_SPACE = nrOfRandoms;
        sw::unum::posit <nbits, es> pa, pb, pexpected;

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
            genBinaryCaseRef(opcode, pa, pb, pexpected);
            writeBinaryTestCase(pa, pb, pexpected);
        }
    }

    template<size_t nbits, size_t es>
    void genAllBinaryTests(int opcode) {
        const size_t NR_POSITS = (size_t(1) << nbits);
        sw::unum::posit <nbits, es> pa, pb, pexpected;

        for (size_t i = 0; i < NR_POSITS; i++) {
            pa.set_raw_bits(i);
            for (size_t j = 0; j < NR_POSITS; j++) {
                pb.set_raw_bits(j);
                genBinaryCaseRef(opcode, pa, pb, pexpected);
                writeBinaryTestCase(pa, pb, pexpected);
            }
        }
    }

    template<size_t nbits, size_t es>
    void genBinaryTestCases(int opcode, bool random_test, uint32_t nrOfRandoms) {
        if (random_test)
            genRandBinaryTests<nbits, es>(opcode, nrOfRandoms);
//        else
//            genAllBinaryTests<nbits, es>(opcode);
    }

}

#endif
