--Function:
--Implemets encoding of Booth's algorithm based on the following table
--
--| B[i+1] | B[i] | B[i-1] | VP  |
--|--------|------|--------|-----|
--| 0      | 0    | 0      | 0   |
--| 0      | 0    | 1      | A   |
--| 0      | 1    | 0      | A   |
--| 0      | 1    | 1      | 2A  |
--| 1      | 0    | 0      | -2A |
--| 1      | 0    | 1      | -A  |
--| 1      | 1    | 0      | -A  |
--| 1      | 1    | 1      | 0   |

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity booth_encoder is
	generic (NBIT: integer := 32);
	
	port (a:   in  std_logic_vector(2 * NBIT-1 downto 0);
	      sel: in  std_logic_vector(2 downto 0);
	      vp:  out std_logic_vector(2 * NBIT-1 downto 0)
	);
end booth_encoder;

architecture behavioral of booth_encoder is
begin 
	encoding: process(a, sel)
	begin 
	    case sel is 
	        when "000" => vp <= (others => '0');                      -- 0
	        when "001" => vp <= a;                                    -- A
	        when "010" => vp <= a;                                    -- A
	        when "011" => vp <= a(2 * NBIT - 2 downto 0) & '0';       -- 2A
	        when "100" => vp <= 0 - (A(2 * NBIT - 2 downto 0) & '0'); -- -2A
	        when "101" => vp <= 0 - A;                                -- -A
	        when "110" => vp <= 0 - A;                                -- -A
	        when "111" => vp <= (others => '0');                      -- 0
	        when others => vp <= (others => '0');                     -- 0
	    end case;
	end process;
end behavioral;
