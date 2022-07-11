library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals.all;

entity alu is
	generic (NBIT: integer := 32;
		 NBIT_OP: integer := 6
	);

	port (a:      in  std_logic_vector(NBIT-1 downto 0);
	      b:      in  std_logic_vector(NBIT-1 downto 0);
	      o:      out std_logic_vector(NBIT-1 downto 0);
	      op:     in  aluop;
	      ovrflw: out std_logic
	);
end entity;

architecture structural of alu is
	component adder
		generic (NBIT: integer := 32);

		port (a:  in  std_logic_vector(NBIT-1 downto 0);
		      b:  in  std_logic_vector(NBIT-1 downto 0);
		      s:  out std_logic_vector(NBIT-1 downto 0);
		      ci: in  std_logic;
		      co: out std_logic
	);
	end component;

	component mul
		generic (NBIT: integer := 32);

		port (a: in  std_logic_vector(NBIT-1 downto 0);
		      b: in  std_logic_vector(NBIT-1 downto 0);
		      p: out std_logic_vector(2 * NBIT-1 downto 0)
		);
	end component;

	component alu_mux
		generic (NBIT: integer := 32;
			 NBIT_OP: integer := 6
		);

		port (adder:   in std_logic_vector(NBIT-1 downto 0);
		      adder_c: in std_logic;
		      mult:    in std_logic_vector(NBIT-1 downto 0);
		      op:      in aluop;
		      output:  out std_logic_vector(NBIT-1 downto 0);
		      ovrflw:  out std_logic
		);
	end component;

	signal adder_out: std_logic_vector(NBIT-1 downto 0);
	signal adder_c:   std_logic;

	signal mult_out:   std_logic_vector(NBIT-1 downto 0);

begin
	adder0: adder
		generic map (NBIT)
		port map (a, b, adder_out, '0', adder_c);

	mul0: mul
		generic map (NBIT)
		port map (a, b, mult_out);

	mux0: alu_mux
		generic map (NBIT, NBIT_OP)
		port map (adder_out, adder_c, mult_out, op, o, ovrflw);
end structural;
