library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sub is
	generic (NBIT: integer := 32);

	port (a:  in  std_logic_vector (NBIT-1 downto 0);
	      b:  in  std_logic_vector (NBIT-1 downto 0);
	      s:  out std_logic_vector (NBIT-1 downto 0)
	);
end entity;

architecture structural of sub is
	component adder
		generic (NBIT: integer := 32);

		port (a:  in  std_logic_vector (NBIT-1 downto 0);
		      b:  in  std_logic_vector (NBIT-1 downto 0);
		      s:  out std_logic_vector (NBIT-1 downto 0);
		      ci: in  std_logic;
		      co: out std_logic
		);
	end component;

	signal not_b: std_logic_vector(NBIT-1 downto 0);
	signal co_trash: std_logic;
begin
	not_b <= not(b);

	sum: adder
		generic map (NBIT)
		port map (a, not_b, s, '1', co_trash);
end structural;
