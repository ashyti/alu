library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity g_block is
	port (p2:    in  std_logic;
	      g1:    in  std_logic;
	      g2:    in  std_logic;
	      g_out: out std_logic
	);
end entity;

architecture behavioral of g_block is
begin 
	g_out <= g2 or (p2 and g1);
end BEHAVIORAL;
