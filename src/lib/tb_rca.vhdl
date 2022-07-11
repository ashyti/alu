library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_rca is
end tb_rca;

architecture test of tb_rca is
	component rca
		generic (NBIT: integer := 4);

		port (a:  in  std_logic_vector(NBIT-1 downto 0);
		      b:  in  std_logic_vector(NBIT-1 downto 0);
		      ci: in  std_logic;
		      s:  out std_logic_vector(NBIT-1 downto 0));
	end component;

	constant NBIT: integer := 4;
	signal a_s, b_s, s_s: std_logic_vector(NBIT-1 downto 0);
	signal ci_s: std_logic;

begin

	dut: rca
		generic map (NBIT)
		port map (a_s, b_s, ci_s, s_s);

	process
		begin
		a_s <= "1011";
		b_s <= "1000";
		ci_s <= '1';	

		wait for 10 ns;

		a_s <= "0100";
		b_s <= "1110";
		ci_s <= '0';

		wait for 10 ns;

		a_s <= "1111";
		b_s <= "0000";
		ci_s <= '0';

		wait for 10 ns;

		a_s <= "1111";
		b_s <= "0000";
		ci_s <= '1';

		wait for 10 ns;

		a_s <= "0000";
		b_s <= "0000";
		ci_s <= '1';

		wait;
	end process;
end test;
