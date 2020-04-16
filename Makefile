default: test-c

./testposit_gen.o: test_generator/testposit_gen.cpp
	g++-8 -I$(UNIVERSAL) -o testposit_gen.o $<

TESTPOSIT_GEN = ./testposit_gen.o

STDERR_VCD = 2> $$@.vcd
VERILATOR_TRACE = --trace
UNIVERSAL = universal/include/universal

VERILATOR = verilator $(VERILATOR_TRACE)

VERILATOR_CFLAGS = -std=c++11 -Icsrc/

tests = \
FMAP16 \
FMAP16_add \
FMAP16_mul \
FMAP32 \
FMAP32_add \
FMAP32_mul \
FMAP64 \
FMAP64_add \
FMAP64_mul \

define arithmeticTest_template

test-$(1)/Eval_$(1).v: src/main/scala/*.scala
	sbt "run $(1) -td test-$(1)"

test-$(1)/dut.mk: test-$(1)/Eval_$(1).v
	$(VERILATOR) -cc --prefix dut --Mdir test-$(1) -CFLAGS "$(VERILATOR_CFLAGS) -include ../csrc/test-$(1).h" test-$(1)/Eval_Posit$(1).v --exe csrc/test.cpp

test-$(1)/dut: test-$(1)/dut.mk
	cd test-$(1) && make -f dut.mk dut

test-c-$(1).log: test-$(1)/dut $(TESTPOSIT_GEN)
	{ $(TESTPOSIT_GEN) $(2) | $$< ;} > $$@ $(STDERR_VCD)

test-c-$(1): \
 test-c-$(1).log \

.PHONY: test-c-$(1)

endef

#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------

$(eval $(call arithmeticTest_template,FMAP16_add,p16_add))
$(eval $(call arithmeticTest_template,FMAP16_mul,p16_mul))
$(eval $(call arithmeticTest_template,FMAP16,p16_mulAdd))
$(eval $(call arithmeticTest_template,FMAP32_add,p32_add))
$(eval $(call arithmeticTest_template,FMAP32_mul,p32_mul))
$(eval $(call arithmeticTest_template,FMAP32,p32_mulAdd))
$(eval $(call arithmeticTest_template,FMAP64_add,p64_add))
$(eval $(call arithmeticTest_template,FMAP64_mul,p64_mul))
$(eval $(call arithmeticTest_template,FMAP64,p64_mulAdd))


test-c: $(addprefix test-c-, $(tests))
	@ if grep -q "expected" test-c-*.log; then \
		echo "some test FAILED!!!"; \
		exit 1; \
	fi


clean:
	rm -rf test-* *.o

.PHONY: test-c clean