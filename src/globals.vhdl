library ieee;
use ieee.std_logic_1164.all;

package globals is
	type aluop is (
		OP_AND,
		OP_OR,
		OP_XOR,
		OP_SLL,
		OP_SRL,
		OP_SRA,
		OP_ADDS,
		OP_MULTI
	);
end globals;
