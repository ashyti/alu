library ieee;
use ieee.std_logic_1164.all;

entity mux21 is
	generic (NBIT: integer:= 32);

	port (a:   in  std_logic_vector(NBIT-1 downto 0);
	      b:   in  std_logic_vector(NBIT-1 downto 0);
	      sel: in  std_logic;
	      y:   out std_logic_vector(NBIT-1 downto 0)
	);
end mux21;

architecture behavioral of mux21 is
begin
	pmux: process(a, b, sel)
	begin
		if sel = '1' then
			y <= a;
		else
			y <= b;
		end if;
	end process;
end behavioral;
