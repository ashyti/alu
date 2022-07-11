library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_mul is
end tb_mul;

architecture test of tb_mul is
	component mul
		generic (NBIT: integer := 32);
	
		port (a: in  std_logic_vector(NBIT-1 downto 0);
		      b: in  std_logic_vector(NBIT-1 downto 0);
		      p: out std_logic_vector(2 * NBIT-1 downto 0)  --Product
		);
	end component;

	constant NBIT: integer := 16;

	-- input
	signal a_mp_i: std_logic_vector(NBIT-1 downto 0) := (others => '0');
	signal b_mp_i: std_logic_vector(NBIT-1 downto 0) := (others => '0');

	-- output
	signal y_mp_i: std_logic_vector(2 * NBIT-1 downto 0);

begin
	-- MUL instantiation
	multiplier: mul
		generic map (NBIT)
		port map(a_mp_i, b_mp_i, y_mp_i);

	-- PROCESS FOR TESTING TEST - COMLETE CYCLE ---------
	test: process
	begin
		-- cycle for operand A
		numrow: for i in 0 to 2**(NBIT) - 1 loop
			-- cycle for operand B
			numcol: for j in 0 to 2**(NBIT) - 1 loop
				wait for 10 ns;
				b_mp_i <= b_mp_i + '1';
			end loop numcol;
			
			a_mp_i <= a_mp_i + '1'; 	
		end loop numrow;

		wait;          
	end process test;
end test;
