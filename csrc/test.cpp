//include in g++ command line

int main()
{
    dut module;

    initialize_dut(module);

    size_t error = 0;
    size_t cnt = 0;

    //Reset module
    for (size_t i = 0; i < 10; i++)
    {
        module.reset = 1;
        module.clock = 0;
        module.eval();
        module.clock = 1;
        module.eval();
    }
    module.reset = 0;

    for (size_t cycle = 0;; cycle++)
    {
        if (!process_inputs(module) || !process_outputs(module))
        {
            printf("Ran %ld tests.\n", cnt);
            if (!error)
                fputs("No errors found.\n", stdout);
            break;
        }

        module.clock = 0;
        module.eval();

        if (module.io_check)
        {
            if ((cnt % 10000 == 0) && cnt)
                printf("Ran %ld tests.\n", cnt);
            if (!module.io_pass)
            {
                error++;
                printf("[%07ld]", cnt);
                // for (size_t i=0; i<inputs.size(); i++) {
                //    printf(" %s", inputs[i]->to_str().c_str());
                // }
                printf(
                    "\n\t=> %#x expected: %#x \n",
                    module.io_actual,
                    module.io_expected);
                if (error == 20)
                {
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