library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity boothmul is
	generic (NBIT: integer := 32);

	port (a: in  std_logic_vector(NBIT-1 downto 0);
	      b: in  std_logic_vector(NBIT-1 downto 0);
	      p: out std_logic_vector(2 * NBIT-1 downto 0)
	);
end boothmul;

architecture hybrid of boothmul is
	component booth_encoder
		generic (NBIT: integer := 32);
		
		port (a:   in  std_logic_vector(2 * NBIT-1 downto 0);
		      sel: in  std_logic_vector(2 downto 0);
		      vp:  out std_logic_vector(2 * NBIT-1 downto 0)
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

	component rca is
		generic (NBIT: integer := 4);

		port (a:  in  std_logic_vector(NBIT-1 downto 0);
		      b:  in  std_logic_vector(NBIT-1 downto 0);
		      ci: in  std_logic;
		      s:  out std_logic_vector(NBIT-1 downto 0));
	end component;

	--There are NBIT/2 Encoders
	type signal_vector1 is array (NBIT/2 - 1 downto 0) of std_logic_vector(2 * NBIT-1 downto 0);  
	signal a_s: signal_vector1;
	signal a_x: signal_vector1;
	signal vp_s: signal_vector1;
	signal b_0: std_logic_vector(2 downto 0);

	--There are NBIT/2-1 Adders
	type signal_vector2 is array (NBIT/2 - 2 downto 0) of std_logic_vector(2 * NBIT-1 downto 0);    
	signal p_s: signal_vector2;
    
begin 
	--"A" needs to be extended to a bigger size A_s
	process(a)
	begin
		--Extending sign of A to A_s
		for z in 0 to NBIT / 2 - 1 loop
		    if (a(NBIT-1) = '1') then 
			    a_s(z)(2 * NBIT-1 downto 0) <= (others => '1'); 
		    else
			    a_s(z)(2 * NBIT-1 downto 0) <= (others => '0'); 
		    end if;

		    a_s(z)(NBIT-1 downto 0) <= a; 
		end loop;
	end process;

	--First encoder needs B[-1]=0.
	--Creating a new signal with values of B[1,0,-1]
	process(b)
	begin
		b_0 <= b(1 downto 0) & '0';
	end process;

	cycle_shifter: for i in 0 to NBIT / 2 - 1 generate
		shifter_i: shifter
			generic map (NBIT)
			port map (a_s(i),
				  std_logic_vector(to_unsigned(2 * i, 5)),
				  '1', '1', '0', -- shift, left, arithmetic
				  a_x(i));
	end generate cycle_shifter;

	--Generating NBIT/2 Encoders
	cycle_enconder: for i in 0 to NBIT / 2 - 1 generate
		--First Encoder is different: Needs B[-1]=0. Let's use B_0
		first_encoder: if i = 0 generate
			encoder_0: booth_encoder
				generic map (NBIT)
				port map (a_x(i), b_0, vp_s(i));
		end generate first_encoder;

		--Upper Encoders get A_s, B[i+1, i, i-1]
		upper_encoders: if i > 0 generate
			encoder_i: booth_encoder
				generic map (NBIT)
				port map (a_x(i),
					  b(2 * i + 1 downto 2 * i - 1),
					  vp_s(i));
		end generate;
	end generate;

	--Generating NBIT/2-1 ADDERS
	cycle_add: for i in 0 to NBIT / 2 - 2 generate
		--First adders is different: SUMS output of first two encoders
		first_adder: if i = 0 generate
			adder_0: rca
				generic map (2 * NBIT)
				port map (vp_s(i), vp_s(i + 1), '0', p_s(i));
		end generate;

		--Upper adders get A_s(I+1) + P_s(I-1)
		upper_adders: if i > 0 generate
			adder_i: rca
				generic map (2 * NBIT)
				port map (vp_s(i + 1), p_s(i - 1), '0', p_s(i));
		end generate;
	end generate;
	
	--Output is taken from last P_s signal;
	p <= p_s(NBIT / 2 - 2);
end HYBRID;
