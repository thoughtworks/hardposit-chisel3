#ifndef GENTERNARYTEST_HPP
#define GENTERNARYTEST_HPP

#include <vector>
#include <random>

#include "PositTestGenerator.hpp"
#include "WriteCases.hpp"

using namespace sw::unum;

namespace testposit {
    template<size_t nbits, size_t es>
    void genTernaryCaseRef(int opcode, const posit <nbits, es> &pa, const posit <nbits, es> &pb,
            const posit <nbits, es> &pc, posit <nbits, es> &pexpected) {
        switch (opcode) {
            case OP_FMA:
                pexpected = fma(pa, pb, pc);
                break;
            default:
                return;
        }
    }

    template<size_t nbits, size_t es>
    void genRandTernaryTests(int opcode, int nrOfRandoms) {
        const size_t SIZE_STATE_SPACE = nrOfRandoms;
        sw::unum::posit <nbits, es> pa, pb, pc, pexpected;

        // generate the full state space set of valid posit values
        std::random_device rd;     //Get a random seed from the OS entropy device, or whatever
        std::mt19937_64 eng(rd()); //Use the 64-bit Mersenne Twister 19937 generator and seed it with entropy.
        //Define the distribution, by default it goes from 0 to MAX(unsigned long long)
        std::uniform_int_distribution<unsigned long long> distr;

        std::vector<unsigned long long> operand_values(SIZE_STATE_SPACE);
        for (uint32_t i = 0; i < SIZE_STATE_SPACE; i++)
            operand_values[i] = distr(eng);

        unsigned ia, ib, ic;  // random indices for picking operands to test
        for (unsigned i = 0; i <= nrOfRandoms; i++) {
            ia = std::rand() % SIZE_STATE_SPACE;
            pa.set_raw_bits(operand_values[ia]);
            ib = std::rand() % SIZE_STATE_SPACE;
            pb.set_raw_bits(operand_values[ib]);
            ic = std::rand() % SIZE_STATE_SPACE;
            pc.set_raw_bits(operand_values[ic]);
            genTernaryCaseRef(opcode, pa, pb, pc, pexpected);
            writeTernaryTestCase(pa, pb, pc, pexpected);
        }
    }

    template<size_t nbits, size_t es>
    void genAllTernaryTests(int opcode) {
        const size_t NR_POSITS = (size_t(1) << nbits);
        sw::unum::posit <nbits, es> pa, pb, pc, pexpected;

        for (size_t i = 0; i < NR_POSITS; i++) {
            pa.set_raw_bits(i);
            for (size_t j = 0; j < NR_POSITS; j++) {
                pb.set_raw_bits(j);
                for (size_t k = 0; k < NR_POSITS; k++) {
                    pc.set_raw_bits(k);
                    genTernaryCaseRef(opcode, pa, pb, pc, pexpected);
                    writeTernaryTestCase(pa, pb, pc, pexpected);
                }
            }
        }
    }

    template<size_t nbits, size_t es>
    void genTernaryTestCases(int opcode, bool random_test, uint32_t nrOfRandoms) {
        if (random_test)
            genRandTernaryTests<nbits, es>(opcode, nrOfRandoms);
//        else
//            genAllTernaryTests<nbits, es>(opcode);
    }

}

#endif //GENTERNARYTEST_HPP
