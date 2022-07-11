library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.log2;

entity carry_generator is
	generic (NBIT:           integer := 32;
	         NBIT_PER_BLOCK: integer :=  4
	);

	port( a:  in  std_logic_vector(NBIT-1 downto 0);
	      b:  in  std_logic_vector(NBIT-1 downto 0);
	      ci: in  std_logic;
	      co: out std_logic_vector(NBIT/NBIT_PER_BLOCK-1 downto 0));
end entity;

architecture STRUCTURAL of carry_generator is
	component pg_network
		generic (NBIT: integer := 32);

		port (a:  in  std_logic_vector(NBIT-1 downto 0);
		      b:  in  std_logic_vector(NBIT-1 downto 0);
		      ci: in  std_logic;
		      p:  out std_logic_vector(NBIT-1 downto 0);
		      g:  out std_logic_vector(NBIT-1 downto 0)
		);
	end component;

	component g_block
		port (p2:    in  std_logic;
		      g1:    in  std_logic;
		      g2:    in  std_logic;
		      g_out: out std_logic
		);
	end component;

	component pg_block
		port (p1:    in  std_logic;
		      p2:    in  std_logic;
		      g1:    in  std_logic;
		      g2:    in  std_logic;
		      p_out: out std_logic;
		      g_out: out std_logic
		);
	end component;

	constant ROWS: integer := integer(log2(real(NBIT)));
	constant LOG2_NBIT_PER_BLOCK: integer := integer(log2(real(NBIT_PER_BLOCK)));

	type signalvector is array (ROWS downto 0) of std_logic_vector(NBIT-1 downto 0);

	signal p: signalvector;
	signal g: signalvector;

begin  
	pg_ntw: pg_network
		generic map(NBIT)
		port map(a, b, ci, p(0), g(0));

	-- Loop through all rows, top to bottom
	gen1: for row in 1 to ROWS generate	
		-- Loop through all possible cells of a row
		-- to place (or not) a PG/G block
		gen2: for i in 0 to NBIT-1 generate
			-- These layers are different, only 1 G block per row.
			-- Each block is connected to immediate upper blocks 
			gen3: if (row <= LOG2_NBIT_PER_BLOCK) generate
				-- The cell of the array has a PG/G block,
				-- when the modulo of the cell by 2^row is 0
				gen4: if ((i + 1) mod (2**row) = 0) generate
					-- If cell position is less than 2^row,
					-- place a G block
					gen5: if (i < 2**row) generate
						g_block0 : g_block
							port map (p(row - 1)(i),
								  g(row - 1)(i),
								  g(row - 1)(i - 2**(row - 1)),
								  g(row)(i));
					end generate;

					-- Otherwise place PG blcok
					gen6: if (i >= 2**row) generate
					    pg_block0 : pg_Block
							port map (p(row - 1)(i),
								  g(row - 1)(i),
								  g(row - 1)(i - (2**(row - 1))),
								  p(row - 1)(i - (2**(row - 1))),
								  g(row)(i),
								  p(row)(i));
					
					end generate;
				end generate;
			end generate;

			-- The number of G blocks is doubled on each layer
			-- and connection may go more than one layer apart 
			gen7: if (row > LOG2_NBIT_PER_BLOCK) generate
				-- The cell of the array has a PG/G block,
				-- when the following conditions are met:
				gen8: if(((i mod (2**row)) >= 2**(row - 1)) and (((i+1) mod NBIT_PER_BLOCK) =0)) generate
					-- The cell is a G block when i < 2^row
					gen9: if (i < 2**row) generate
						g_block1 : g_block
							port map (p(row - 1)(i),
								  g(row - 1)(i),
								  g(row - 1)((i / 2**(row - 1)) * 2**(row - 1) - 1),
								  g(row)(i));
					end generate;

					-- Otherwise is a PG block
					gen10: if (i >= 2**row) generate
						pg_block1 : pg_block
							port map (p(row - 1)(i),
								  g(row - 1)(i),
								  g(row - 1)((i / 2**(row - 1)) * 2**(row - 1) - 1),
								  p(row - 1)((i / 2**(row - 1)) * 2**(row - 1) - 1),
								  g(row)(i),
								  p(row)(i));
					end generate;
				end generate;
				
				-- When the g and p signals need to
				-- be propagated without G/PG block
				-- Connect one row with the previous
				-- one, without intermediate blocks
				gen11: if(((i mod (2**row)) < 2**(row - 1)) and (((i + 1) mod NBIT_PER_BLOCK) = 0)) generate
					g(row)(i) <= g(row - 1)(i);
					p(row)(i) <= p(row - 1)(i);
				end generate;
			end generate;
			
			-- For the last row conenct all g signal to the carry out			
			gen12: if (row = ROWS) generate
				gen13: if (((i + 1) mod NBIT_PER_BLOCK) = 0) generate
					co(i / NBIT_PER_BLOCK) <= g(row)(i);
				end generate;
			end generate;
		end generate;
	end generate;
end structural;
