library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_sub is
end tb_sub;

architecture test of tb_sub is
	component sub
		generic (NBIT: integer := 32);

		port (a:  in  std_logic_vector (NBIT-1 downto 0);
		      b:  in  std_logic_vector (NBIT-1 downto 0);
		      s:  out std_logic_vector (NBIT-1 downto 0)
		);
	end component;

	constant NBIT: integer := 32;
	signal a_s, b_s, s_s: std_logic_vector(NBIT-1 downto 0);

begin
	dut: sub
		generic map (NBIT)
		port map (a_s, b_s, s_s);

	process
		begin
		a_s <= "00000000000000000000000000100011";
		b_s <= "00000000000000000000000000000101";

		wait for 10 ns;

		a_s <= "00000000000000000000000000000101";
		b_s <= "00000000000000000000000000100011";

		wait for 10 ns;

		b_s <= "00000000000000000000000000000101";
		a_s <= "00000000000000000000000000100011";

		wait;
	end process;
end test;
