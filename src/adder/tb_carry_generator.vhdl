library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tb_carry_generator is 
end tb_carry_generator; 

architecture test of tb_carry_generator is
	component carry_generator
		generic (NBIT:           integer := 32;
			 NBIT_PER_BLOCK: integer :=  4
		);

		port( a:  in  std_logic_vector(NBIT-1 downto 0);
		      b:  in  std_logic_vector(NBIT-1 downto 0);
		      ci: in  std_logic;
		      co: out std_logic_vector(NBIT/NBIT_PER_BLOCK-1 downto 0));
	end component;

	constant NBIT: integer := 32;
	constant NBIT_PER_BLOCK: integer := 4;

	signal a_s, b_s: std_logic_vector(NBIT-1 downto 0);
	signal ci_s: std_logic;
	signal co_s: std_logic_vector(NBIT/NBIT_PER_BLOCK-1 downto 0);

begin

	dut: carry_generator
		generic map (NBIT, NBIT_PER_BLOCK)
		port map(a_s, b_s, ci_s, co_s);

	process
		begin
		ci_s <= '0';
		a_s <= "11111111111111111111111111111111";
		b_s <= "00010001000100010001000100010001";

		wait for 10 ns;

		a_s <= "01110111011101110111011101110111";
		b_s <= "00010001000100010001000100010001";
  
		wait for 10 ns;

		ci_s <= '0';
		a_s <= "11111111111111111111111111111111";
		b_s <= "00000000000000000000000000000000";
		      
		wait for 10 ns;

		ci_s <= '1';
		a_s <= "11111111111111111111111111111111";
		b_s <= "00000000000000000000000000000000";

		wait;
	end process;
end test;
