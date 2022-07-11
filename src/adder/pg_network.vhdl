library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity pg_network is
	generic (NBIT: integer := 32);

	port (a:  in  std_logic_vector(NBIT-1 downto 0);
              b:  in  std_logic_vector(NBIT-1 downto 0);
              ci: in  std_logic;
              p:  out std_logic_vector(NBIT-1 downto 0);
              g:  out std_logic_vector(NBIT-1 downto 0)
	);
end entity;

architecture behavioral of pg_network is
begin
	gen0: for i in 0 to NBIT-1 generate

		gen1: if i = 0 generate
			p(i) <= a(i) xor b(i);
			g(i) <= (a(i) and b(i)) or ((a(i) xor b(i)) and ci) ;
		end generate;
		
		gen2: if i > 0 generate
			p(i) <= a(i) xor b(i);
			g(i) <= a(i) and b(i);
		end generate;
	end generate;
end behavioral;
