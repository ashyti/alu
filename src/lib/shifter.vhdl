library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity shifter is
	generic (N: integer);

	port (a:            in std_logic_vector(N-1 downto 0);
	      b:            in std_logic_vector(4 downto 0);
	      logic_arith:  in std_logic; -- 0 arithmetic, 1 logic
	      left_right:   in std_logic; -- 0 right, 1 left
	      shift_rotate: in std_logic; -- 0 rotate, 1 shift
	      output:       out std_logic_vector(N-1 downto 0)
	);
end entity shifter;

architecture behavioral of shifter is
begin
	shift: process (a, b, logic_arith, left_right, shift_rotate) is
	begin
		if shift_rotate = '0' then
			if left_right = '0' then
				output <= to_stdLogicvector((to_bitvector(a)) ror (conv_integer(b)));
			else
				output <= to_stdlogicvector((to_bitvector(a)) rol (conv_integer(b)));
			end if;
		else
			if left_right = '0' then
				if logic_arith = '0' then
					output <= to_stdlogicvector((to_bitvector(a)) sra (conv_integer(b)));
				else
					output <= to_stdlogicvector((to_bitvector(a)) srl (conv_integer(b)));
				end if;				
			else
				if logic_arith = '0' then
					output <= to_stdlogicvector((to_bitvector(A)) sla (conv_integer(b)));
				else
					output <= to_stdlogicvector((to_bitvector(a)) sll (conv_integer(b)));
				end if;
			end if;
		end if;
	end process;
end architecture behavioral;
