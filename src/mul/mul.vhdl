library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mul is
	generic (NBIT: integer := 32);

	port (a: in  std_logic_vector(NBIT-1 downto 0);
	      b: in  std_logic_vector(NBIT-1 downto 0);
	      p: out std_logic_vector(2 * NBIT-1 downto 0)
	);
end mul;

architecture structural of mul is
	component boothmul
		generic (NBIT: integer := 32);

		port (a: in  std_logic_vector(NBIT-1 downto 0);
		      b: in  std_logic_vector(NBIT-1 downto 0);
		      p: out std_logic_vector(2 * NBIT-1 downto 0)
		);
	end component;

begin
	mutiplier: boothmul
		generic map (NBIT)
		port map (a, b, p);
end structural;
