library ieee;
use ieee.std_logic_1164.all;

entity tb_mux21 is
end tb_mux21;

architecture test of tb_mux21 is
	component mux21 is
		generic (NBIT: integer:= 32);

		port (a:   in  std_logic_vector(NBIT-1 downto 0);
		      b:   in  std_logic_vector(NBIT-1 downto 0);
		      sel: in  std_logic;
		      y:   out std_logic_vector(NBIT-1 downto 0)
		);
	end component;

	constant NBIT: integer := 32;
	signal a_s, b_s, y_s: std_logic_vector(NBIT-1 downto 0);
	signal sel_s: std_logic;

begin
	dut: mux21
		generic map (NBIT)
		port map (a_s, b_s, sel_s, y_s);

	process
		begin
		a_s   <= "11111111000000001111111100000000";
		b_s   <= "00000000111111110000000011111111";
		sel_s <= '0';

		wait for 2 ns;

		a_s   <= "11111111000000001111111100000000";
		b_s   <= "00000000111111110000000011111111";
		sel_s <= '1';
		
		wait for 2 ns;

		a_s   <= "11111111000000001111111100000000";
		b_s   <= "00000000111111110000000011111111";
		sel_s <= '0';

		wait for 2 ns;
	end process;
end test;
