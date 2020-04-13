#include "../universal/include/universal/posit/posit.hpp"
#include <string>


const int OP_ADD = 1;
const int OP_MUL = 2;

template<size_t nbits, size_t es>
void writeHex_posit(sw::unum::posit<nbits, es> a, char sepChar) {
    fprintf(stdout, "%llx", a);
    if (sepChar) fputc(sepChar, stdout);
}

template<size_t nbits, size_t es>
void genBinaryTestCase(int opcode) {
    const size_t NR_POSITS = (size_t(1) << nbits);
    sw::unum::posit<nbits, es> pa, pb, pexpected;

    for (size_t i = 0; i < NR_POSITS; i++) {
        pa.set_raw_bits(i);
        for (size_t j = 0; j < NR_POSITS; j++) {
            pb.set_raw_bits(j);
            switch (opcode) {
                case OP_ADD:
                    pexpected = pa + pb;
                    break;
                case OP_MUL:
                    pexpected = pa * pb;
                    break;
                default:
                    return;
            }
            writeHex_posit<nbits, es>(pa, '\n');
            writeHex_posit<nbits, es>(pb, '\n');
            writeHex_posit<nbits, es>(pexpected, '\n');
        }
    }
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Invalid option\n");
        return -1;
    }

    if (!strcmp(argv[1], "p16_add")) {            //TODO Improve argument decoding
        genBinaryTestCase<16, 1>(OP_ADD);
    } else if (!strcmp(argv[1], "p16_mul")) {
        genBinaryTestCase<16, 1>(OP_MUL);
    } else if (!strcmp(argv[1], "p32_add")) {
        genBinaryTestCase<32, 2>(OP_ADD);
    } else if (!strcmp(argv[1], "p32_mul")) {
        genBinaryTestCase<32, 2>(OP_MUL);
    } else if (!strcmp(argv[1], "p64_add")) {
        genBinaryTestCase<64, 3>(OP_ADD);
    } else if (!strcmp(argv[1], "p64_mul")) {
        genBinaryTestCase<64, 3>(OP_MUL);
    } else
        fprintf(stderr, "Invalid option\n");       //TODO Print help message

    return 0;
}