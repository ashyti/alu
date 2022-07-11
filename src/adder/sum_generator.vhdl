library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity sum_generator is
	generic (NBIT_PER_BLOCK: integer := 4;
		 NBLOCKS:        integer := 8
	);

	port (a:  in  std_logic_vector(NBLOCKS * NBIT_PER_BLOCK - 1 downto 0);
	      b:  in  std_logic_vector(NBLOCKS * NBIT_PER_BLOCK - 1 downto 0);
	      ci: in  std_logic_vector(NBLOCKS - 1 downto 0);
	      s:  out std_logic_vector(NBLOCKS * NBIT_PER_BLOCK - 1 downto 0);
	      co: out std_logic
	);
end sum_generator;

architecture structural of sum_generator is
	component rca
		generic (NBIT: integer := 4);

		port (a:  in  std_logic_vector(NBIT-1 downto 0);
		      b:  in  std_logic_vector(NBIT-1 downto 0);
		      ci: in  std_logic;
		      s:  out std_logic_vector(NBIT-1 downto 0));
	end component;

begin
	sg : for i in 0 to NBLOCKS-1 generate
		rca0 : rca
		generic map (NBIT_PER_BLOCK)
		port map (a(i * (NBIT_PER_BLOCK) + NBIT_PER_BLOCK - 1 downto i * (NBIT_PER_BLOCK)),
			  b(i * (NBIT_PER_BLOCK) + NBIT_PER_BLOCK - 1 downto i * (NBIT_PER_BLOCK)),
			  ci(i),
			  s(i * (NBIT_PER_BLOCK) + NBIT_PER_BLOCK - 1 downto i * (NBIT_PER_BLOCK)));
	end generate;
end structural;
