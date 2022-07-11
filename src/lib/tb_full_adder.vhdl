library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_full_adder is 
end tb_full_adder; 

architecture test of tb_full_adder is
	component full_adder
		port (a:  in  std_logic;
		      b:  in  std_logic;
		      ci: in  std_logic;
		      s:  out std_logic;
		      co: out std_logic
		);
	end component; 

	signal a_s, b_s, ci_s, s_s, co_s: std_logic;

begin

	dut: full_adder
		port map(a_s, b_s, ci_s, s_s, co_s);

	process
		begin

		a_s <= '0';
		b_s <= '0';
		ci_s <= '0';

		wait for 10 ns;

		a_s <= '0';
		b_s <= '0';
		ci_s <= '1';

		wait for 10 ns;

		a_s <= '0';
		b_s <= '1';
		ci_s <= '0';

		wait for 10 ns;

		a_s <= '0';
		b_s <= '1';
		ci_s <= '1';

		wait for 10 ns;

		a_s <= '1';
		b_s <= '0';
		ci_s <= '0';

		wait for 10 ns;

		a_s <= '1';
		b_s <= '0';
		ci_s <= '1';

		wait for 10 ns;

		a_s <= '1';
		b_s <= '1';
		ci_s <= '0';

		wait for 10 ns;

		a_s <= '1';
		b_s <= '1';
		ci_s <= '1';

		wait;
	end process;
end test;
