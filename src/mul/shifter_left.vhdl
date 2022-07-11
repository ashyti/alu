--Function:
--Shift left R1 by R2 amount

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity shifter_left is
	generic (NBIT: integer:= 64);

	port (a: in  std_logic_vector(NBIT-1 downto 0);
	      b: in  std_logic_vector(4 downto 0);
	      y: out std_logic_vector(NBIT-1 downto 0)
	);
end shifter_left;

--Define Architecture
architecture behavioral of shifter_left is
begin
	--IFDEF 4 bits   
	gen_4bits: if NBIT = 8 generate
		process(a, b)
		begin
			case b is
			when "00000" => y <= a;
			when "00010" => y <= a(NBIT-3 downto 0) & "00";
			when others  => y <= a;
			end case;
		end process;
	end generate;

	--IFDEF 8 bits
	gen_8bits: if NBIT = 16 generate
		process(a, b)
		begin
			case b is
			when "00000" => y <= a;
			when "00010" => y <= a(NBIT-3 downto 0) & "00";
			when "00100" => y <= a(NBIT-5 downto 0) & "0000";
			when "00110" => y <= a(NBIT-7 downto 0) & "000000";
			when others  => y <= a;
			end case;
		end process;
	end generate;

	--IFDEF 16 bits
	gen_16bits: if NBIT = 32 generate
		process(a, b)
		begin
			case b is
			when "00000" => y <= a;
			when "00010" => y <= a(NBIT-3 downto 0) & "00";
			when "00100" => y <= a(NBIT-5 downto 0) & "0000";
			when "00110" => y <= a(NBIT-7 downto 0) & "000000";
			when "01000" => y <= a(NBIT-9 downto 0) & "00000000";
			when "01010" => y <= a(NBIT-11 downto 0) & "0000000000";
			when "01100" => y <= a(NBIT-13 downto 0) & "000000000000";
			when "01110" => y <= a(NBIT-15 downto 0) & "00000000000000";
			when others  => y <= a;
			end case;
		end process;
	end generate;

	--IFDEF 32 bits
	gen_32bits: if NBIT = 64 generate
		process(a, b)
		begin
			case b is
			when "00000" => y <= a;
			when "00010" => y <= a(NBIT-3 downto 0) & "00";
			when "00100" => y <= a(NBIT-5 downto 0) & "0000";
			when "00110" => y <= a(NBIT-7 downto 0) & "000000";
			when "01000" => y <= a(NBIT-9 downto 0) & "00000000";
			when "01010" => y <= a(NBIT-11 downto 0) & "0000000000";
			when "01100" => y <= a(NBIT-13 downto 0) & "000000000000";
			when "01110" => y <= a(NBIT-15 downto 0) & "00000000000000";
			when "10000" => y <= a(NBIT-17 downto 0) & "0000000000000000";
			when "10010" => y <= a(NBIT-19 downto 0) & "000000000000000000";
			when "10100" => y <= a(NBIT-21 downto 0) & "00000000000000000000";
			when "10110" => y <= a(NBIT-23 downto 0) & "0000000000000000000000";
			when "11000" => y <= a(NBIT-25 downto 0) & "000000000000000000000000";
			when "11010" => y <= a(NBIT-27 downto 0) & "00000000000000000000000000";
			when "11100" => y <= a(NBIT-29 downto 0) & "0000000000000000000000000000";
			when "11110" => y <= a(NBIT-31 downto 0) & "000000000000000000000000000000";
			when others  => y <= a;
			end case;
		end process;
	end generate;
end behavioral;
