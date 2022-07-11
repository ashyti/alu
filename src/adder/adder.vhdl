library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity adder is
	generic (NBIT: integer := 32);

	port (a:  in  std_logic_vector (NBIT-1 downto 0);
	      b:  in  std_logic_vector (NBIT-1 downto 0);
	      s:  out std_logic_vector (NBIT-1 downto 0);
	      ci: in  std_logic;
	      co: out std_logic
	);
end entity;

architecture structural of adder is
	component p4_adder
		generic (NBIT: integer := 32);

		port (a:  in  std_logic_vector (NBIT-1 downto 0);
		      b:  in  std_logic_vector (NBIT-1 downto 0);
		      s:  out std_logic_vector (NBIT-1 downto 0);
		      ci: in  std_logic;
		      co: out std_logic
		);
	end component;

begin
	sum: p4_adder
		generic map (NBIT)
		port map (a, b, s, ci, co);
end structural;
