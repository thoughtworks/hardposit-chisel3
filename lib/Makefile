all: P16.sv P32.sv P64.sv

%.sv:
	rm -f $(basename $@)/$@
	cat $(basename $@)/*.sv > $(basename $@)/$@

.PHONY = P16.sv P32.sv P64.sv
