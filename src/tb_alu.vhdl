library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals.all;

entity tb_alu is
end tb_alu;

architecture test of tb_alu is
	component alu
		generic (NBIT: integer := 32);

		port (a:      in  std_logic_vector (NBIT-1 downto 0);
		      b:      in  std_logic_vector (NBIT-1 downto 0);
		      o:      out std_logic_vector (NBIT-1 downto 0);
		      op:     in aluop;
		      ovrflw: out std_logic
		);
	end component;

	constant NBIT: integer := 32;
	signal a_s, b_s, o_s: std_logic_vector(NBIT-1 downto 0);
	signal ovrflw_s: std_logic;
	signal op_s: aluop;

begin
	dut: alu
		generic map (NBIT)
		port map (a_s, b_s, o_s, op_s, ovrflw_s);

	process
		begin

		a_s <= "11001010010100100100101011100100";
		b_s <= "00000000000000000000000000001011";
		op_s <= OP_AND;

		wait for 10 ns;

		a_s <= "11001010010100100100101011100100";
		b_s <= "00000000000000000000000000001011";
		op_s <= OP_OR;

		wait for 10 ns;

		a_s <= "11001010010100100100101011100100";
		b_s <= "00000000000000000000000000001011";
		op_s <= OP_XOR;

		wait for 10 ns;

		-- (35 << 11 = 71680)dec (23 << b = 11800)hex
		a_s <= "00000000000000000000000000100011";
		b_s <= "00000000000000000000000000001011";
		op_s <= OP_SLL;

		wait for 10 ns;

		-- (73853 >> 11 = 35)dec (118ad >> b = 23)hex
		a_s <= "00000000000000000000000000100011";
		b_s <= "00000000000000000000000000001011";
		op_s <= OP_SRA;

		wait for 10 ns;

		-- (3394390756 >> 11 = ?)dec (ca524ae4 >> b = ?)hex
		a_s <= "11001010010100100100101011100100";
		b_s <= "00000000000000000000000000001011";
		op_s <= OP_SRL;

		wait for 10 ns;

		-- (10 + 35 = 45)dec (a + 23 = 2d)hex
		a_s <= "00000000000000000000000000001010";
		b_s <= "00000000000000000000000000100011";
		op_s <= OP_ADDS;

		wait for 10 ns;

		-- (10 * 35 = 350)dec (a * 23 = 15e)hex
		a_s <= "00000000000000000000000000001010";
		b_s <= "00000000000000000000000000100011";
		op_s <= OP_MULTI;

		wait for 10 ns;

		a_s <= "00000000000000000000000000001010";
		b_s <= "00000000000000000000000000100011";
		op_s <= OP_ADDS;

		wait;
	end process;
end test;
