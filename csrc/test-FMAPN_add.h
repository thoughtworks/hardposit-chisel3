#include "dut.h"

static void initialize_dut(dut& m)
{
}

static int process_inputs(dut& m)
{
  char value[64];

  if (scanf("%s", value) != 1) {
    return 0;
  }
  m.io_num1 = strtoull(value, NULL, 16);

  if (scanf("%s", value) != 1) {
    return 0;
  }
  m.io_num2 = strtoull(value, NULL, 16);

  return 1;
}

static int process_outputs(dut& m)
{
  char value[64];

  // output
  if (scanf("%s", value) != 1) {
    return 0;
  }
  m.io_expected = strtoull(value, NULL, 16);

  return 1;
}

