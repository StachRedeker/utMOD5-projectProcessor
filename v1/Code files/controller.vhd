LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY controller IS
   PORT (
	clk : IN std_logic;
	reset : IN std_logic;
	sw : IN std_logic_vector(9 DOWNTO 0);
	DEBUG_NEXT : IN std_logic;
	ACK_data : IN std_logic;
	NewInstruction : IN std_logic; 
	PCR : IN std_logic_vector (3 DOWNTO 0); --(n,z,v,c)
	ALU : OUT std_logic_vector (2 DOWNTO 0);
	MEM : OUT std_logic_vector (2 DOWNTO 0);
	rs : OUT std_logic_vector(3 DOWNTO 0);
	rd : OUT std_logic_vector(3 DOWNTO 0);
	SIMM10: OUT std_logic_vector(9 DOWNTO 0);
	IO : OUT std_logic_vector(1 DOWNTO 0);
	rr : OUT std_logic;
	address : OUT std_logic_vector(8 DOWNTO 0);
	Amux : OUT std_logic;
	Cmux : OUT std_logic;
	memory_data_out : IN std_logic_vector (31 DOWNTO 0)
        );
END ENTITY controller;

ARCHITECTURE bhv OF controller IS
SIGNAL PC : integer := 0;
SIGNAL halt : std_logic := '0'; 
BEGIN

decode: PROCESS(clk,reset,PCR)
VARIABLE tempPCjump: natural := 0; 
VARIABLE tempPC: natural := 0;
VARIABLE PCupdate: natural :=0;
VARIABLE set_CC : std_logic;
VARIABLE rrstatus : std_logic;
VARIABLE Op1: std_logic_vector (1 DOWNTO 0);
VARIABLE Op2: std_logic_vector (1 DOWNTO 0);
VARIABLE cntstop : std_logic;
  BEGIN

IF (reset = '0') THEN
	assert false report "initalizing" severity note; 
	tempPC :=0;
	PCupdate := 0;
	tempPCjump := 0;
	PC<= 0;
	address <= (others => '0');
	halt <= '0'; 
	cntstop := '0';
	ELSIF (rising_edge(clk)) AND (halt = '0') AND (ACK_data = '1') AND ((sw(9) /= '1') OR (DEBUG_NEXT = '1')) THEN 
--------------------------------------------------------------------------------------------Fetch
	IF(NewInstruction = '0') THEN
		address <= std_logic_vector(to_unsigned(PC,address'length));--(address of the fetchable instruction)
		MEM <= "001"; --(b = 0; wr = 0; rd = 1)
		rd <= "1111"; --(where to store the address)
		rs <= "0000"; --(default value)
		Cmux <= '1';  
		Amux <= '0'; 
		IO <= "00"; --reset value
		cntstop := '0';
		ALU <= "111"; --reset value where it wont perform any operation
		rr <= '0'; --reset value
		SIMM10 <= "0000000000"; --reset value
-- -----------------------------------------------------------------------------------------Decode/Execute
	ELSIF (NewInstruction = '1') and (cntstop = '0') THEN 
		Op1 := memory_data_out(19 DOWNTO 18);
		Op2 := memory_data_out(17 DOWNTO 16);
		Amux <= '0'; --reset value
		Cmux <= '0'; --reset value
		MEM <= "000"; --reset value
		rd <= "0000";
		IF (Op1 = "00") THEN --Branch Instructions
			CASE Op2 IS 
				WHEN "00" => ---------------------------------------------------------------Branch Always
						tempPCjump := to_integer(unsigned(memory_data_out(15 DOWNTO 7)));
						PC <= tempPCjump;
						tempPC := 0;
				WHEN "01" => ---------------------------------------------------------------Branch Equal (IF z = 1)
						IF (PCR(2) = '1') THEN
							tempPCjump := to_integer(unsigned(memory_data_out(15 DOWNTO 7)));
							PC <= tempPCjump;
							tempPC := 0;
						ELSE 
							tempPC := tempPC + 4; 
							PCupdate := tempPCjump + tempPC;	
							PC <= PCupdate; --output datapath							
					    END IF;
				WHEN "10" => ---------------------------------------------------------------Branch Not Equal (IF z = 0)
						IF (PCR(2) = '0') THEN 
							tempPCjump := to_integer(unsigned(memory_data_out(15 DOWNTO 7)));
							PC <= tempPCjump;
							tempPC := 0;
						ELSE 
							tempPC := tempPC + 4; 
							PCupdate := tempPCjump + tempPC;	
							PC <= PCupdate; --output datapath
						END IF;
				WHEN "11" => ---------------------------------------------------------------Branch Negative (IF n = 1)
						IF (PCR(3) = '1') THEN
							tempPCjump := to_integer(unsigned(memory_data_out(15 DOWNTO 7)));
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
			address <= memory_data_out(15 DOWNTO 7); --output memory (contains the address)
			CASE Op2 IS 
				WHEN "00" => ---------------------------------------------------------------Load
						rd <= memory_data_out(6 DOWNTO 3); --output signal for datapath
						MEM <= "001"; -- ld, we need to read, add the address
						Amux <= '0'; --output datapath
						Cmux <= '1'; --output datapath
				WHEN "01" => ---------------------------------------------------------------Store
						rs <= memory_data_out(6 DOWNTO 3); --output signal for datapath
						rd <= "0000";
						MEM <= "010"; -- st, we need to write, add the address
						Amux <= '1'; --output datapath
						Cmux <= '0'; --output datapath
				WHEN "10" => ---------------------------------------------------------------Load Byte
						MEM <= "101"; -- ldb
						rd <= memory_data_out(6 DOWNTO 3); --output signal for datapath
						Amux <= '0'; --output datapath
						Cmux <= '1'; --output datapath
				WHEN "11" => ---------------------------------------------------------------Store Byte
						MEM <= "110"; -- stb
						rs <= memory_data_out(6 DOWNTO 3); --output signal for datapath
						Amux <= '1'; --output datapath
						Cmux <= '0'; --output datapath 
				WHEN OTHERS => 
						REPORT "Warning unknown condition" SEVERITY warning;
			END CASE;
			tempPC := tempPC + 4; 
			PCupdate := tempPCjump + tempPC;	
			PC <= PCupdate; --output datapath
		ELSIF (Op1 = "10") THEN --Arithmetic Instructions
			set_CC := memory_data_out(15);
			rrstatus := memory_data_out(14);
			rr <= rrstatus;
			CASE rrstatus IS
				WHEN '1' => 
		 				rs <= memory_data_out(13 DOWNTO 10); --output signal for datapath
		 				rd <= memory_data_out(9 DOWNTO 6); --output signal for datapath
						IF (set_CC = '0') THEN 
							CASE Op2 IS 
								WHEN "00" => ----------------------------------------------AND
										ALU <= "000"; 
								WHEN "01" => ----------------------------------------------OR
										ALU <= "001";
								WHEN "10" => ----------------------------------------------ADD
										ALU <= "010";
								WHEN "11" => ----------------------------------------------SHIFT RIGHT
										ALU <= "011";
								WHEN OTHERS => 
										REPORT "Warning unknown condition" SEVERITY warning;
								END CASE;
						ELSIF (set_CC = '1') THEN
								CASE Op2 IS
									WHEN "00" => ------------------------------------------ANDcc
											ALU <= "100";
									WHEN "01" => ------------------------------------------ORcc
											ALU <="101";
									WHEN "10" => ------------------------------------------ADDcc
											ALU <="110";
									WHEN OTHERS => 
											REPORT "Warning unknown condition" SEVERITY warning;
								END CASE;
						END IF;
				WHEN '0' =>
						rd <= memory_data_out(13 DOWNTO 10); --output signal for datapath
						SIMM10 <= memory_data_out(9 DOWNTO 0); --output signal for datapath
						IF (set_CC = '0') THEN 
							CASE Op2 IS 
								WHEN "00" => ----------------------------------------------AND
										ALU <= "000"; 
								WHEN "01" => ----------------------------------------------OR
										ALU <= "001";
								WHEN "10" => ----------------------------------------------ADD
										ALU <= "010";
								WHEN "11" => ----------------------------------------------SHIFT RIGHT
										ALU <= "011";
								WHEN OTHERS => 
										REPORT "Warning unknown condition" SEVERITY warning;
							END CASE;
						ELSIF (set_CC = '1') THEN
							CASE Op2 IS
								WHEN "00" => ----------------------------------------------ANDcc
										ALU <= "100";
								WHEN "01" => ----------------------------------------------ORcc
										ALU <="101";
								WHEN "10" => ----------------------------------------------ADDcc
										ALU <="110";
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
				WHEN "00" => --------------------------------------------------------------Display
						rs <= memory_data_out(15 DOWNTO 12); --output datapath
						IO <= "01"; --output datapath
						tempPC := tempPC + 4;
						PCupdate := tempPCjump + tempPC; 	
						PC <= PCupdate; --output datapath 
				WHEN "01" => --------------------------------------------------------------ReadI/O
						rd <= memory_data_out(15 DOWNTO 12); --output datapath
						IO <= "10"; --output datapath
						tempPC := tempPC + 4;
						PCupdate := tempPCjump + tempPC; 	
						PC <= PCupdate; --output datapath 
				WHEN "11" => --------------------------------------------------------------HALT
						halt <= '1';
				WHEN OTHERS => 
						REPORT "Warning unknown condition" SEVERITY warning;
			END CASE;	
		END IF;
		cntstop := '1';
	END IF;	
END IF;
  END PROCESS decode;
END ARCHITECTURE bhv;
