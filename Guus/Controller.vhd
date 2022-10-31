LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY Controller IS
  PORT (
	clk: IN std_logic;
	reset: IN std_logic; -- We deciced on active low.
	-------------------------------------------------
	A : OUT std_logic_vector (3 DOWNTO 0);
	Amux : OUT std_logic;
	C: OUT std_logic_vector (3 DOWNTO 0); --will also be used as input.
	Cmux : OUT std_logic;
	RD : OUT std_logic; 
	WR : OUT std_logic;
	ALU : OUT std_logic_vector (1 DOWNTO 0);
	--------------------------------------------------
	-- the condition field is formed within the controller.
	CC : IN std_logic_vector (3 DOWNTO 0);
	set_CC: IN std_logic; --for the branche conditions.
	---------------------------------------------------
	op : IN std_logic_vector (1 DOWNTO 0); --waiting for final width joost
	--op2 is defined in architecture "struct"
	op3 : IN std_logic_vector (5 DOWNTO 0) --waiting for final width joost
	---------------------------------------------------
       );
END ENTITY Controller;
	
ARCHITECTURE struct OF Controller IS
SIGNAL MicroInstruction : std_logic_vector (27 DOWNTO 0);
-----------------------------------------------------------
ALIAS op2 : std_logic_vector (2 DOWNTO 0) IS op3 (5 DOWNTO 3); --waiting for final width joost
ALIAS jumpadr : std_logic_vector (10 DOWNTO 0) IS MicroInstruction (10 DOWNTO 0); --now it can read jumpadr from MI
ALIAS COND : std_logic_vector (2 DOWNTO 0) IS MicroInstruction (13 DOWNTO 11); --now it can read COND from MI
-----------------------------------------------------------
SIGNAL CSC : std_logic_vector (10 DOWNTO 0);
COMPONENT MicroStore IS
   PORT (
	address : IN std_logic_vector (10 DOWNTO 0);
	InstMIR : OUT std_logic_vector (27 DOWNTO 0)
	);
   END COMPONENT MicroStore;


   BEGIN

	MIRfields:PROCESS(reset,clk)
	BEGIN
	IF (reset = '0') THEN
		MicroInstruction <= (OTHERS => '0'); --there is no microinstruction to be executed anymore
	ELSIF (rising_edge(clk)) THEN
		MicroInstruction <= InstMIR; --output of microstore is stored in microinstruction.
		---------------------------- Might need to put line below outside process, but do not see the problem yet.
		A <= MicroInstruction (27 DOWNTO 24);
		Amux <= MicroInstruction (23);
		C <= MicroInstruction (22 DOWNTO 19);
		Cmux <= MicroInstruction (18);
		RD <= MicroInstruction (17);
		WR <= MicroInstruction (16);
		ALU <= MicroInstruction (15 DOWNTO 14);
		----------------------------
	END IF;
	END PROCESS;


   END ARCHITECTURE struct;