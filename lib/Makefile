all: posit_16.sv posit_32.sv posit_64.sv

posit_%.sv: P%
	rm -f $@
	cat $</*.sv > $@

.PHONY = posit_16.sv posit_32.sv posit_64.sv
