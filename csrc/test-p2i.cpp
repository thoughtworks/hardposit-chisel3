#include "dut.h"

static int process_inputs(dut &m) {
    char value[64];

    if (scanf("%s", value) != 1) return 0;
    m.io_posit = strtoull(value, NULL, 16);

    return 1;
}

static int process_outputs(dut &m) {
    char value[64];

    if (scanf("%s", value) != 1) return 0;
    m.io_expected = strtoull(value, NULL, 16);

    return 1;
}

int main(int argc, char *argv[]) {
    dut module;
    size_t cnt = 0;
    size_t error = 0;

    // reset
    for (size_t i = 0; i < 10; i++) {
        module.reset = 1;
        module.clock = 0;
        module.eval();
        module.clock = 1;
        module.eval();
    }
    module.reset = 0;

    // main operation
    for (;;) {
        if (!process_inputs(module) || !process_outputs(module)) {
            printf("Ran %ld tests.\n", cnt);
            if (!error) fputs("No errors found.\n", stdout);
            break;
        }

        module.clock = 0;
        module.eval();

        if (module.io_check) {
            if ((cnt % 10000 == 0) && cnt) printf("Ran %ld tests.\n", cnt);
            if (!module.io_pass) {
                error++;
                printf("[%07ld]", cnt);
                printf(
                        "%#lx",
                        module.io_posit
                );
                printf(
                        " => %#lx expected: %#lx\n",
                        module.io_actual,
                        module.io_expected
                );
                if (error == 20) {
                    printf("Reached %ld errors. Aborting.\n", error);
                    break;
                }
            }
            cnt++;
        }

        module.clock = 1;
        module.eval();
    }

    return 0;
}

