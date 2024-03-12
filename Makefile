default: test-c

TEST_BUILD_DIR = test_generator/build
TESTPOSIT_GEN = ./PositTestGenerator

$(TEST_BUILD_DIR)/PositTestGenerator:
	mkdir -p $(TEST_BUILD_DIR)
	cd $(TEST_BUILD_DIR) && cmake ..
	$(MAKE) -C $(TEST_BUILD_DIR)

$(TESTPOSIT_GEN): $(TEST_BUILD_DIR)/PositTestGenerator
	cp $(TEST_BUILD_DIR)/PositTestGenerator .

ifeq (,$(vcd))
STDERR_VCD =
VERILATOR_TRACE =
else
STDERR_VCD = 2> $$@.vcd
VERILATOR_TRACE = --trace
endif

UNIVERSAL = universal/include/universal/posit

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
DivSqrtP16_div \
DivSqrtP32_div \
DivSqrtP64_div \
DivSqrtP16_sqrt \
DivSqrtP32_sqrt \
DivSqrtP64_sqrt \
CompareP16_lt \
CompareP32_lt \
CompareP64_lt \
CompareP16_eq \
CompareP32_eq \
CompareP64_eq \
CompareP16_gt \
CompareP32_gt \
CompareP64_gt \
P16toI32 \
P16toI64 \
P32toI32 \
P32toI64 \
P64toI32 \
P64toI64 \
P16toUI32 \
P16toUI64 \
P32toUI32 \
P32toUI64 \
P64toUI32 \
P64toUI64 \
I32toP16 \
I64toP16 \
I32toP32 \
I64toP32 \
I32toP64 \
I64toP64 \
UI32toP16 \
UI64toP16 \
UI32toP32 \
UI64toP32 \
UI32toP64 \
UI64toP64 \
P16toP32 \
P16toP64 \
P32toP16 \
P32toP64 \
P64toP16 \
P64toP32 \

define test_template

test-$(1)/Eval_$(1).v: src/main/scala/*.scala
	sbt "run tb $(1) -td test-$(1)"

test-$(1)/dut.mk: test-$(1)/Eval_$(1).v
	$(VERILATOR) -cc --prefix dut --Mdir test-$(1) -CFLAGS "$(VERILATOR_CFLAGS) -include ../csrc/test-$(1).h" test-$(1)/Eval_Posit$(1).v --exe csrc/test-$(3).cpp

test-$(1)/dut: test-$(1)/dut.mk
	cd test-$(1) && make -f dut.mk dut

test-c-$(1): test-$(1)/dut $(TESTPOSIT_GEN)
	{ $(TESTPOSIT_GEN) $(2) | $$< ;} > $$@.log $(STDERR_VCD)

.PHONY: test-c-$(1)

endef

#-----------------------------------------------------------------------------
#-----------------------------------------------------------------------------

$(eval $(call test_template,FMAP16_add,p16_add,arithmetic))
$(eval $(call test_template,FMAP16_mul,p16_mul,arithmetic))
$(eval $(call test_template,FMAP16,p16_mulAdd,arithmetic))
$(eval $(call test_template,FMAP32_add,p32_add,arithmetic))
$(eval $(call test_template,FMAP32_mul,p32_mul,arithmetic))
$(eval $(call test_template,FMAP32,p32_mulAdd,arithmetic))
$(eval $(call test_template,FMAP64_add,p64_add,arithmetic))
$(eval $(call test_template,FMAP64_mul,p64_mul,arithmetic))
$(eval $(call test_template,FMAP64,p64_mulAdd,arithmetic))

$(eval $(call test_template,DivSqrtP16_div,p16_div,arithmetic))
$(eval $(call test_template,DivSqrtP32_div,p32_div,arithmetic))
$(eval $(call test_template,DivSqrtP64_div,p64_div,arithmetic))
$(eval $(call test_template,DivSqrtP16_sqrt,p16_sqrt,arithmetic))
$(eval $(call test_template,DivSqrtP32_sqrt,p32_sqrt,arithmetic))
$(eval $(call test_template,DivSqrtP64_sqrt,p64_sqrt,arithmetic))

$(eval $(call test_template,CompareP16_lt,p16_lt,compare))
$(eval $(call test_template,CompareP32_lt,p32_lt,compare))
$(eval $(call test_template,CompareP64_lt,p64_lt,compare))
$(eval $(call test_template,CompareP16_eq,p16_eq,compare))
$(eval $(call test_template,CompareP32_eq,p32_eq,compare))
$(eval $(call test_template,CompareP64_eq,p64_eq,compare))
$(eval $(call test_template,CompareP16_gt,p16_gt,compare))
$(eval $(call test_template,CompareP32_gt,p32_gt,compare))
$(eval $(call test_template,CompareP64_gt,p64_gt,compare))

$(eval $(call test_template,P16toI32,p16_i32,convert))
$(eval $(call test_template,P16toI64,p16_i64,convert))
$(eval $(call test_template,P32toI32,p32_i32,convert))
$(eval $(call test_template,P32toI64,p32_i64,convert))
$(eval $(call test_template,P64toI32,p64_i32,convert))
$(eval $(call test_template,P64toI64,p64_i64,convert))

$(eval $(call test_template,P16toUI32,p16_ui32,convert))
$(eval $(call test_template,P16toUI64,p16_ui64,convert))
$(eval $(call test_template,P32toUI32,p32_ui32,convert))
$(eval $(call test_template,P32toUI64,p32_ui64,convert))
$(eval $(call test_template,P64toUI32,p64_ui32,convert))
$(eval $(call test_template,P64toUI64,p64_ui64,convert))

$(eval $(call test_template,I32toP16,i32_p16,convert))
$(eval $(call test_template,I64toP16,i64_p16,convert))
$(eval $(call test_template,I32toP32,i32_p32,convert))
$(eval $(call test_template,I64toP32,i64_p32,convert))
$(eval $(call test_template,I32toP64,i32_p64,convert))
$(eval $(call test_template,I64toP64,i64_p64,convert))

$(eval $(call test_template,UI32toP16,ui32_p16,convert))
$(eval $(call test_template,UI64toP16,ui64_p16,convert))
$(eval $(call test_template,UI32toP32,ui32_p32,convert))
$(eval $(call test_template,UI64toP32,ui64_p32,convert))
$(eval $(call test_template,UI32toP64,ui32_p64,convert))
$(eval $(call test_template,UI64toP64,ui64_p64,convert))

$(eval $(call test_template,P16toP32,p16_p32,convert))
$(eval $(call test_template,P16toP64,p16_p64,convert))
$(eval $(call test_template,P32toP16,p32_p16,convert))
$(eval $(call test_template,P32toP64,p32_p64,convert))
$(eval $(call test_template,P64toP16,p64_p16,convert))
$(eval $(call test_template,P64toP32,p64_p32,convert))

test-c: $(addprefix test-c-, $(tests))
	@ if grep -q "expected" test-c-*.log; then \
		echo "some test(s) FAILED!!!"; \
		exit 1; \
	fi


clean:
	rm -rf $(TEST_BUILD_DIR) test-* $(TESTPOSIT_GEN)

.PHONY: test-c clean