library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity p4_adder is
	generic (NBIT: integer := 32);

	port (a:  in  std_logic_vector (NBIT-1 downto 0);
	      b:  in  std_logic_vector (NBIT-1 downto 0);
	      s:  out std_logic_vector (NBIT-1 downto 0);
	      ci: in  std_logic;
	      co: out std_logic
	);
end entity;

architecture structural of p4_adder is
	component carry_generator
		generic (NBIT:           integer := 32;
			 NBIT_PER_BLOCK: integer :=  4
		);

		port (a:  in  std_logic_vector(NBIT-1 downto 0);
		      b:  in  std_logic_vector(NBIT-1 downto 0);
		      ci: in  std_logic;
		      co: out std_logic_vector(NBIT/NBIT_PER_BLOCK-1 downto 0)
		);
	end component;

	component sum_generator
		generic (NBIT_PER_BLOCK: integer := 4;
			 NBLOCKS:        integer := 8
		);

		port (a:  in  std_logic_vector(NBLOCKS * NBIT_PER_BLOCK - 1 downto 0);
		      b:  in  std_logic_vector(NBLOCKS * NBIT_PER_BLOCK - 1 downto 0);
		      ci: in  std_logic_vector(NBLOCKS - 1 downto 0);
		      s:  out std_logic_vector(NBLOCKS * NBIT_PER_BLOCK - 1 downto 0);
		      co: out std_logic
		);
	end component;

	constant NBIT_PER_BLOCK: integer := 4;
	constant NBLOCKS: integer := NBIT / NBIT_PER_BLOCK;

	signal carry, carry_through: std_logic_vector(NBLOCKS-1 downto 0);

begin
	cg: carry_generator
		generic map (NBIT, NBIT_PER_BLOCK)
		port map (a, b, ci, carry);

	carry_through <= carry(NBLOCKS-2 downto 0) & ci;

	sg: sum_generator
		generic map (NBIT_PER_BLOCK, NBLOCKS)
		port map (a, b, carry_through, s);

	co <= carry(NBLOCKS-1);
end structural;
