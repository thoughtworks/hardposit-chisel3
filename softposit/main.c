#include "softposit.h"

int main(){
    posit8_t pA, pB, pZ;
    pA = castP8(0xF2);
    pB = castP8(0x23);

    pZ = p8_add(pA, pB);

    //To check answer by converting it to double
    double dZ = convertP8ToDouble(pZ);
    printf("dZ: %.15f\n", dZ);

    //To print result in binary
    uint8_t uiZ = castUI(pZ);
    printBinary((uint64_t*)&uiZ, 8);

    return 0;
}