#include "dut.h"

static void initialize_dut(dut &m) {
    m.io_in_valid = 1;
}

static int process_inputs(dut &m) {
    char value[64];

    if (!m.io_in_ready) {
        return 1;
    }

    if (scanf("%s", value) != 1) {
        return 0;
    }
    m.io_in_bits_num1 = strtoull(value, NULL, 16);

    return 1;
}

static int process_outputs(dut &m) {
    char value[64];

    if (!m.io_in_ready) {
        return 1;
    }

    // output
    if (scanf("%s", value) != 1) {
        return 0;
    }
    m.io_in_bits_expected = strtoull(value, NULL, 16);

    return 1;
}

