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

		-- (10 + 35 = 45)dec (a + 23 = 2d)hex
		a_s <= "00000000000000000000000000001010";
		b_s <= "00000000000000000000000000100011";
		op_s <= ADDS;

		wait for 10 ns;

		-- (10 * 35 = 350)dec (a * 23 = 15e)hex
		a_s <= "00000000000000000000000000001010";
		b_s <= "00000000000000000000000000100011";
		op_s <= MULTI;

		wait for 10 ns;

		a_s <= "00000000000000000000000000001010";
		b_s <= "00000000000000000000000000100011";
		op_s <= ADDS;

		wait;
	end process;
end test;
