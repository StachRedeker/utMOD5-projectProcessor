LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY controller IS
   PORT (
	clk : IN std_logic;
	reset : IN std_logic;
	NewInstruction : IN std_logic; --1 when new instr in reg. 
	PSR : IN std_logic_vector (3 DOWNTO 0);
	ALU : OUT std_logic_vector (2 DOWNTO 0);
	MEM : OUT std_logic_vector (2 DOWNTO 0);
	rs : OUT std_logic_vector(3 DOWNTO 0);
	rd : OUT std_logic_vector(3 DOWNTO 0);
	SIMM10: OUT std_logic_vector(9 DOWNTO 0);
	IO : OUT std_logic_vector(1 DOWNTO 0);
	rrstatus : OUT std_logic;
	Amux : OUT std_logic;
	Cmux : OUT std_logic;
	MemString : IN std_logic_vector (31 DOWNTO 0)
        );
END ENTITY controller;

ARCHITECTURE bhv OF controller IS
SIGNAL PC : natural := 0;
SIGNAL address : natural;
SIGNAL halt : std_logic := '0'; 
SIGNAL addressfield : std_logic_vector (8 DOWNTO 0);
BEGIN

decode: PROCESS(clk,reset)
VARIABLE tempPCjump: natural := 0; 
VARIABLE tempPC: natural := 0;
VARIABLE PCupdate: natural :=0;
VARIABLE set_CC : std_logic;
VARIABLE rr : std_logic;
VARIABLE Op1: std_logic_vector (1 DOWNTO 0);
VARIABLE Op2: std_logic_vector (1 DOWNTO 0);
VARIABLE cntstop : std_logic;
  BEGIN

IF (reset = '0') THEN
	tempPC :=0;
	PCupdate := 0;
	tempPCjump := 0;
	PC<= 0;
	address <= 0;
	halt <= '0'; 
	cntstop := '0';
ELSIF (rising_edge(clk)) AND (halt = '0') THEN 
------------------------------------------------------------------------Fetch
	IF(NewInstruction = '0') THEN
		address <= PC;--(address of the fetchable instruction)
		MEM <= "001"; --(b = 0; wr = 0; rd = 1)
		rd <= "1111"; --(where to store the address)
		Cmux <= '1';  
		Amux <= '0'; 
		cntstop := '0';
		ALU <= "111";
		rrstatus <= '0';
-- ------------------------------------------------------------------------Decode/Execute
	ELSIF (NewInstruction = '1') and (cntstop = '0') THEN 
		Op1 := MemString(19 DOWNTO 18);
		Op2 := MemString(17 DOWNTO 16);
		Amux <= '0';
		Cmux <= '0'; 
		MEM <= "000";
		IF (Op1 = "00") THEN --Branch Instructions
			CASE Op2 IS 
				WHEN "00" =>
						tempPCjump := to_integer(unsigned(MemString(15 DOWNTO 7))); --Ba
						PC <= tempPCjump;
						tempPC := 0;
				WHEN "01" => 
						IF (PSR(2) = '1') THEN --Be if z = 1
							tempPCjump := to_integer(unsigned(MemString(15 DOWNTO 7)));
							PC <= tempPCjump;
							tempPC := 0;
						ELSE 
							tempPC := tempPC + 4; 
							PCupdate := tempPCjump + tempPC;	
							PC <= PCupdate; --output datapath							
					    END IF;
				WHEN "10" => 
						IF (PSR(2) = '0') THEN --Bne if z = 0
							tempPCjump := to_integer(unsigned(MemString(15 DOWNTO 7)));
							PC <= tempPCjump;
							tempPC := 0;
						ELSE 
							tempPC := tempPC + 4; 
							PCupdate := tempPCjump + tempPC;	
							PC <= PCupdate; --output datapath
						END IF;
				WHEN "11" => 
						IF (PSR(3) = '1') THEN --Bneg if n = 1
							tempPCjump := to_integer(unsigned(MemString(15 DOWNTO 7)));
							PC <= tempPCjump;
							tempPC := 0;
						ELSE 
							tempPC := tempPC + 4; 
							PCupdate := tempPCjump + tempPC;	
							PC <= PCupdate; --output datapath
						END IF;
				WHEN OTHERS => 
						REPORT "Warning, current instruction is unknown" SEVERITY warning;
			END CASE;
		ELSIF (Op1 = "01") THEN --Memory Instructions
			addressfield <= MemString(15 DOWNTO 7); --output memory (contains the address)
			CASE Op2 IS 
				WHEN "00" => 
						rd <= MemString(6 DOWNTO 3); --output signal for datapath
						MEM <= "001"; -- ld, we need to read, add the address
						Amux <= '0'; --output datapath
						Cmux <= '1'; --output datapath
				WHEN "01" => 
						rs <= MemString(6 DOWNTO 3); --output signal for datapath
						MEM <= "010"; -- st, we need to write, add the address
						Amux <= '1'; --output datapath
						Cmux <= '0'; --output datapath
				WHEN "10" => 
						MEM <= "101"; -- ldb
						rd <= MemString(6 DOWNTO 3); --output signal for datapath
						Amux <= '0'; --output datapath
						Cmux <= '1'; --output datapath
				WHEN "11" => 
						MEM <= "110"; -- stb
						rs <= MemString(6 DOWNTO 3); --output signal for datapath
						Amux <= '1'; --output datapath
						Cmux <= '0'; --output datapath 
				WHEN OTHERS => 
						REPORT "Warning unknown condition" SEVERITY warning;
			END CASE;
			tempPC := tempPC + 4; 
			PCupdate := tempPCjump + tempPC;	
			PC <= PCupdate; --output datapath
		ELSIF (Op1 = "10") THEN --Arithmetic Instructions
			set_CC := MemString(15);
			rr := MemString(14);
			rrstatus <= rr;
			CASE rr IS
				WHEN '1' => 
		 				rs <= MemString(13 DOWNTO 10); --output signal for datapath
		 				rd <= MemString(9 DOWNTO 6); --output signal for datapath
						IF (set_CC = '0') THEN 
							CASE Op2 IS 
								WHEN "00" => 
										ALU <= "000";--AND 
								WHEN "01" => 
										ALU <= "001";--OR
								WHEN "10" => 
										ALU <= "010";--ADD
								WHEN "11" => 
										ALU <= "011";--SHIFT
								WHEN OTHERS => 
										REPORT "Warning unknown condition" SEVERITY warning;
								END CASE;
						ELSIF (set_CC = '1') THEN
								CASE Op2 IS
									WHEN "00" => 
											ALU <= "100";--ANDcc
									WHEN "01" => 
											ALU <="101";--ORcc
									WHEN "10" => 
											ALU <="110";--ADDcc
									WHEN OTHERS => 
											REPORT "Warning unknown condition" SEVERITY warning;
								END CASE;
						END IF;
				WHEN '0' =>
						rd <= MemString(13 DOWNTO 10); --output signal for datapath
						SIMM10 <= MemString(9 DOWNTO 0); --output signal for datapath
						IF (set_CC = '0') THEN 
							CASE Op2 IS 
								WHEN "00" => 
										ALU <= "000";--AND 
								WHEN "01" => 
										ALU <= "001";--OR
								WHEN "10" => 
										ALU <= "010";--ADD
								WHEN "11" => 
										ALU <= "011";--SHIFT
								WHEN OTHERS => 
										REPORT "Warning unknown condition" SEVERITY warning;
							END CASE;
						ELSIF (set_CC = '1') THEN
							CASE Op2 IS
								WHEN "00" => 
										ALU <= "100";--ANDcc
								WHEN "01" => 
										ALU <="101";--ORcc
								WHEN "10" => 
										ALU <="110";--ADDcc
								WHEN OTHERS => 
										REPORT "Warning unknown condition" SEVERITY warning;
							END CASE;
						END IF;		
				WHEN OTHERS => 
						REPORT "Warning unknown condition" SEVERITY warning;
				END CASE;	
			tempPC := tempPC + 4;
			PCupdate := tempPCjump + tempPC; 	
			PC <= PCupdate; --output datapath
		ELSIF (Op1 = "11") THEN --Miscellaneous Instructions
			CASE Op2 IS 
				WHEN "00" => --Display
						rs <= MemString(15 DOWNTO 12); --output datapath
						IO <= "01"; --output datapath
						tempPC := tempPC + 4;
						PCupdate := tempPCjump + tempPC; 	
						PC <= PCupdate; --output datapath 
				WHEN "01" => --ReadI/O
						rd <= MemString(15 DOWNTO 12); --output datapath
						IO <= "10"; --output datapath
						tempPC := tempPC + 4;
						PCupdate := tempPCjump + tempPC; 	
						PC <= PCupdate; --output datapath 
				WHEN "11" => --HALT
						halt <= '1';
				WHEN OTHERS => 
						REPORT "Warning unknown condition" SEVERITY warning;
			END CASE;	
		END IF;
		cntstop := '1';
	END IF;	
END IF;
-----------------------------------------------------------------------------
  END PROCESS decode;
END ARCHITECTURE bhv;
