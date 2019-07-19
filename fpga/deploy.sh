#! /bin/bash

QUARTUS_PATH=~/intelFPGA_pro/18.1/quartus/bin
DEVICE=arria10
if [ ${1} -e 'de10' ]
then
    QUARTUS_PATH=~/intelFPGA_lite/18.1/quartus/bin
    DEVICE=de10
fi
${QUARTUS_PATH}/quartus_pgm -m jtag -o "p;soc/${DEVICE}/output_files/Posit.sof@1"
