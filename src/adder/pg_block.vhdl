library ieee;
use ieee.std_logic_1164.all;

entity pg_block is
	port (p1:    in  std_logic;
              p2:    in  std_logic;
              g1:    in  std_logic;
              g2:    in  std_logic;
              p_out: out std_logic;
              g_out: out std_logic
	);
end entity;

architecture behavioral of pg_block is
begin 
	p_out <= p2 and p1;
	g_out <= g2 or (p2 and g1);
end behavioral;
