LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY registerfile IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC; -- button 0 of FPGA
        BusC : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Current_C : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
        Current_A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        BusA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        IR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
   --     PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	rr : IN STD_LOGIC;
	SIMM10 : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	Amux : IN STD_LOGIC;
	counter_output : OUT integer := 0
    );
END ENTITY registerfile;

ARCHITECTURE bhv OF registerfile IS
TYPE registerfile_type IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL reg_file : registerfile_type := (OTHERS => (OTHERS => '0')); 

BEGIN
PROCESS (reset, clk)
	VARIABLE counter : integer := 0;
	BEGIN
	IF reset = '0' THEN
		BusA <= (31 DOWNTO 0 => '0');
		BusC <= (31 DOWNTO 0 => '0');
		counter := 0;
		reg_file <= (OTHERS => (OTHERS => '0'));
	ELSIF rising_edge(clk) THEN
		
		IF counter = 0 THEN
			BusA <= (OTHERS => '0');
			BusC <= (OTHERS => '0');
			counter := counter + 1;
		ELSIF counter = 1 THEN
			counter := counter +1;
		ELSIF counter = 2 THEN
			IF rr = '0' AND Amux = '0' THEN
				BusA(9 DOWNTO 0) <= SIMM10;
				IF SIMM10(9) = '1' THEN
				BusA (31 DOWNTO 10) <= (31 DOWNTO 10 => '1');
				ELSE
				BusA (31 DOWNTO 10) <= (31 DOWNTO 10 => '0');
				END IF;
			ELSE
				BusA <= reg_file(to_integer(unsigned(Current_A)));
			END IF;
			BusC <= reg_file(to_integer(unsigned(Current_C)));
        	--	PC <= reg_file(14); --Register 14 is program counter
	        --	IR <= reg_file(15); --Register 15 is instruction register
			
			counter := counter +1;
		ELSIF counter = 3 THEN
			counter := counter +1;
		ELSIF counter = 4 THEN	
			BusC <= (OTHERS => 'Z');
			counter := counter +1;
		ELSIF counter = 5 THEN
			IF Current_C = "1111" THEN
			IR <= BusC;
			END IF;
			reg_file(to_integer(unsigned(Current_C))) <= BusC;
			counter := counter +1;
		ELSE 
			counter := 0;
		END IF;
	
		reg_file(0) <= (OTHERS => '0'); --%r0 is constant zero
		
	END IF;
	counter_output <= counter;
    END PROCESS;
END ARCHITECTURE bhv;