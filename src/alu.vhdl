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

	component shifter
		generic (N: integer);

		port (a:            in std_logic_vector(N-1 downto 0);
		      b:            in std_logic_vector(4 downto 0);
		      logic_arith:  in std_logic; -- 0 arithmetic, 1 logic
		      left_right:   in std_logic; -- 0 right, 1 left
		      shift_rotate: in std_logic; -- 0 rotate, 1 shift
		      output:       out std_logic_vector(N-1 downto 0)
		);
	end component;

	component alu_mux
		generic (NBIT: integer := 32;
			 NBIT_OP: integer := 6
		);

		port (a:       in std_logic_vector(NBIT-1 downto 0);
		      b:       in std_logic_vector(NBIT-1 downto 0);
		      sll_in:  in std_logic_vector(NBIT-1 downto 0);
		      srl_in:  in std_logic_vector(NBIT-1 downto 0);
		      sra_in:  in std_logic_vector(NBIT-1 downto 0);
		      adder:   in std_logic_vector(NBIT-1 downto 0);
		      adder_c: in std_logic;
		      mult:    in std_logic_vector(NBIT-1 downto 0);
		      op:      in aluop;
		      output:  out std_logic_vector(NBIT-1 downto 0);
		      ovrflw:  out std_logic
		);
	end component;

	signal adder_out: std_logic_vector(NBIT-1 downto 0);
	signal adder_c:   std_logic;

	signal mult_out:  std_logic_vector(NBIT-1 downto 0);

	signal sll_out:   std_logic_vector(NBIT-1 downto 0);
	signal srl_out:   std_logic_vector(NBIT-1 downto 0);
	signal sra_out:   std_logic_vector(NBIT-1 downto 0);

begin
	adder0: adder
		generic map (NBIT)
		port map (a, b, adder_out, '0', adder_c);

	mul0: mul
		generic map (NBIT)
		port map (a, b, mult_out);

	sll0: shifter
		generic map (NBIT)
		port map (a, b(4 downto 0), '1', '1', '1', sll_out);

	srl0: shifter
		generic map (NBIT)
		port map (a, b(4 downto 0), '1', '0', '1', srl_out);

	sra0: shifter
		generic map (NBIT)
		port map (a, b(4 downto 0), '1', '0', '0', sra_out);

	mux0: alu_mux
		generic map (NBIT, NBIT_OP)
		port map (a, b, sll_out, srl_out, sra_out,
			  adder_out, adder_c, mult_out, op, o, ovrflw);
end structural;
