#! /bin/bash
set -e

sbt "runMain FloatOperation"

QUARTUS_PATH=~/intelFPGA_pro/18.1/quartus/bin
DEVICE=arria10
if [ ${1} -e 'de10' ]
then
    QUARTUS_PATH=~/intelFPGA_lite/18.1/quartus/bin
    DEVICE=de10
fi

cd soc/${DEVICE}
:
${QUARTUS_PATH}/quartus_sh --flow compile Posit
