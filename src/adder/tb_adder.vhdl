library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_adder is
end tb_adder;

architecture test of tb_adder is
	component adder
		generic (NBIT: integer := 32);

		port (a:  in  std_logic_vector (NBIT-1 downto 0);
		      b:  in  std_logic_vector (NBIT-1 downto 0);
		      s:  out std_logic_vector (NBIT-1 downto 0);
		      ci: in  std_logic;
		      co: out std_logic
		);
	end component;

	constant NBIT: integer := 32;
	signal a_s, b_s, s_s: std_logic_vector(NBIT-1 downto 0);
	signal ci_s: std_logic;
	signal co_s: std_logic;

begin
	dut: adder
		generic map (NBIT)
		port map (a_s, b_s, s_s, ci_s, co_s);

	process
		begin

		a_s <= "00000000000000000000000000001010";
		b_s <= "00000000000000000000000000000101";
		ci_s <= '0';

		wait for 2 ns;

		a_s <= "01000010010000010100111011010101";
		a_s <= "00000000000000000000000000001010";
		b_s <= "00000000000000000000000000000101";
		ci_s <= '1';	

		wait for 2 ns;

		a_s <= "01000010010000010100111011010101";
		b_s <= "11101110100111101110010010011111";
		ci_s <= '0';

		wait for 2 ns;

		a_s <= "11111111111111111111111111111111";
		b_s <= "00000000000000000000000000000001";
		ci_s <= '0';

		wait for 2 ns;

		a_s <= "11111111111111111111111111111111";
		b_s <= "00000000000000000000000000000000";
		ci_s <= '1';

		wait for 2 ns;

		a_s <= "00000000000000000000000000000000";
		b_s <= "00000000000000000000000000000000";
		ci_s <= '1';

		wait for 2 ns;

		a_s <= "00000000000000000000000000000000";
		b_s <= "00000000000000000000000000000000";
		ci_s <= '1';

		wait for 2 ns;
	end process;
end test;
