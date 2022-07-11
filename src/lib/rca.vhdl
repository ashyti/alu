library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity rca is
	generic (NBIT: integer := 4);

	port (a:  in  std_logic_vector(NBIT-1 downto 0);
	      b:  in  std_logic_vector(NBIT-1 downto 0);
	      ci: in  std_logic;
	      s:  out std_logic_vector(NBIT-1 downto 0));
end rca;

architecture structural of rca is
	component full_adder
		port (a:  in  std_logic;
		      b:  in  std_logic;
		      ci: in  std_logic;
		      s:  out std_logic;
		      co: out std_logic
		);
	end component; 

	component mux21
		generic (NBIT: integer:= 32);

		port (a:   in  std_logic_vector(NBIT-1 downto 0);
		      b:   in  std_logic_vector(NBIT-1 downto 0);
		      sel: in  std_logic;
		      y:   out std_logic_vector(NBIT-1 downto 0)
		);
	end component;

	signal ci_0: std_logic_vector (NBIT downto 0);
	signal ci_1: std_logic_vector (NBIT downto 0);
	signal s0:   std_logic_vector (NBIT-1 downto 0);
	signal s1:   std_logic_vector (NBIT-1 downto 0);
	signal nci:  std_logic;

begin
	ci_0(0) <= '0';
	ci_1(0) <= '1';

	-- the Ci is negated
	nci <= not(ci);

	rca0: for i in 0 to NBIT-1 generate
		fa0 : full_adder
		port map (a(i), b(i), ci_0(i), s0(i), ci_0(i + 1));
	end generate;

	rca1: for i in 0 to NBIT-1 generate
		fa1 : full_adder
		port map (a(i), b(i), ci_1(i), s1(i), ci_1(i + 1));
	end generate;

	mux : mux21
		generic map (NBIT)
		port map (s0, s1, nci, s);
end structural;
