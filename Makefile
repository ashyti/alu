GHDL_CMD = ghdl
GHDL_FLAGS = -fsynopsys -Wbinding

SRCDIR = src
WORKDIR = work
LIB = $(SRCDIR)/lib
ADDER = $(SRCDIR)/adder
MUL = $(SRCDIR)/mul

ENTITY = tb_adder
WAVE = $(WORKDIR)/$(ENTITY).ghw

SRC = $(ADDER)/pg_network.vhdl
SRC += $(ADDER)/g_block.vhdl
SRC += $(ADDER)/pg_block.vhdl
SRC += $(LIB)/mux21.vhdl
SRC += $(LIB)/full_adder.vhdl
SRC += $(LIB)/rca.vhdl
SRC += $(LIB)/shifter.vhdl
SRC += $(ADDER)/carry_generator.vhdl
SRC += $(ADDER)/sum_generator.vhdl
SRC += $(ADDER)/p4_adder.vhdl
SRC += $(ADDER)/adder.vhdl
SRC += $(ADDER)/sub.vhdl

SRC += $(ADDER)/tb_carry_generator.vhdl
SRC += $(ADDER)/tb_p4_adder.vhdl
SRC += $(ADDER)/tb_adder.vhdl
SRC += $(ADDER)/tb_sub.vhdl

SRC += $(LIB)/tb_mux21.vhdl
SRC += $(LIB)/tb_full_adder.vhdl
SRC += $(LIB)/tb_rca.vhdl

SRC += $(MUL)/booth_encoder.vhdl
SRC += $(MUL)/boothmul.vhdl
SRC += $(MUL)/mul.vhdl

SRC += $(MUL)/tb_boothmul.vhdl
SRC += $(MUL)/tb_mul.vhdl

SRC += $(SRCDIR)/globals.vhdl
SRC += $(SRCDIR)/alu_mux.vhdl
SRC += $(SRCDIR)/alu.vhdl

SRC += $(SRCDIR)/tb_alu.vhdl

all: compile

compile:
	@mkdir -p $(WORKDIR)
	@$(GHDL_CMD) -a $(GHDL_FLAGS) --workdir=$(WORKDIR) $(SRC)
	@$(GHDL_CMD) -e $(GHDL_FLAGS) --workdir=$(WORKDIR) $(ENTITY)

test:
	@$(GHDL_CMD) -r $(ENTITY) --wave=$(WAVE)

draw:
	@gtkwave $(WAVE)

clean:
	@$(GHDL_CMD) --remove --workdir=$(WORKDIR)
	@rm -rf $(WORKDIR)

.PHONY: clean
