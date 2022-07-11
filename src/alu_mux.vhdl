library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals.all;

entity alu_mux is
	generic (NBIT: integer := 32;
		 NBIT_OP: integer := 6
	);

	port (a:       in std_logic_vector(NBIT-1 downto 0);
	      b:       in std_logic_vector(NBIT-1 downto 0);
	      sll_in:  in std_logic_vector(NBIT-1 downto 0);
	      srl_in:  in std_logic_vector(NBIT-1 downto 0);
	      sra_in:  in std_logic_vector(NBIT-1 downto 0);
	      adder:   in std_logic_vector(NBIT-1 downto 0);
	      adder_c: in std_logic;
	      mult:    in std_logic_vector(NBIT-1 downto 0);
	      op:      in aluop;
	      output:  out std_logic_vector(NBIT-1 downto 0);
	      ovrflw:  out std_logic
	);
end entity;

architecture behavioral of alu_mux is
begin
	main_algo: process(adder, adder_c, mult, op)
	begin
		case op is
		when OP_AND =>
			output <= a and b;
		when OP_OR =>
			output <= a or b;
		when OP_XOR =>
			output <= a xor b;
		when OP_SLL =>
			output <= sll_in;
		when OP_SRL =>
			output <= srl_in;
		when OP_SRA =>
			output <= sra_in;
		when OP_ADDS =>
			output <= adder;
			ovrflw <= adder_c;
		when OP_MULTI =>
			output <= mult;
		end case;
	end process;
end behavioral;
