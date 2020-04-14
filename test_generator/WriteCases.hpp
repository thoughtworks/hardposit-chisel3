#ifndef WRITECASES_HPP
#define WRITECASES_HPP

#include <cstdio>

namespace testposit {
    using namespace sw::unum;

    template<size_t nbits, size_t es>
    void writeHex_posit(sw::unum::posit <nbits, es> a, char sepChar) {
        fprintf(stdout, "%llx", a);
        if (sepChar) fputc(sepChar, stdout);
    }

    template<size_t nbits, size_t es>
    void writeBinaryTestCase(const posit <nbits, es> &pa, const posit <nbits, es> &pb, posit <nbits, es> &pexpected) {
        writeHex_posit(pa, '\n');
        writeHex_posit(pb, '\n');
        writeHex_posit(pexpected, '\n');
    }
}

#endif
