LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY datapath IS
    PORT (
        clk : IN STD_LOGIC;
        dataIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- from the data memory
        reset : IN STD_LOGIC;

        -- from the control unit
        rd : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        AMux : IN STD_LOGIC;
        rs : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        CMux : IN STD_LOGIC;
        io : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        ALU : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	rr : IN STD_LOGIC;
	SIMM10 : IN STD_LOGIC_VECTOR(9 DOWNTO 0);

        -- to the control unit
        PCR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- N, Z, V, C resp. 3 downto 0
        Op1 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        Op2 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	ACK_datapath : OUT STD_LOGIC;
        --  bit13 : OUT STD_LOGIC;

        -- to the data memory
        dataMemoryOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

    );
END ENTITY datapath;

ARCHITECTURE structure OF datapath IS

    COMPONENT registerfile IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            BusC : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            Current_C : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Current_A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            BusA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            IR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT registerfile;

    SIGNAL BusA, BusC, IR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- SIGNAL lastDataIn : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Current_A, Current_C : STD_LOGIC_VECTOR(3 DOWNTO 0);

    SIGNAL ALU_output_with_carry : STD_LOGIC_VECTOR(32 DOWNTO 0); -- an additional bit for the carry
    ALIAS CC_N : STD_LOGIC IS PCR(3);
    ALIAS CC_Z : STD_LOGIC IS PCR(2);
    ALIAS CC_V : STD_LOGIC IS PCR(1);
    ALIAS CC_C : STD_LOGIC IS PCR(0);

BEGIN

    reg_file : registerfile
    PORT MAP(clk, reset, BusC, Current_C, Current_A, BusA, IR);

    PROCESS (clk, reset, dataIn, rd, AMux, rs, CMux, io, ALU)
variable counter : integer := 0;
    BEGIN
        IF reset = '0' THEN
            dataMemoryOut <= (OTHERS => '0');
            PCR <= "0000";
            Op1 <= "00";
            Op2 <= "00";
	END IF;
	--ELSIF rising_edge(clk) THEN	
	ACK_datapath <= '0';
	IF counter = 0 THEN

	counter := counter +1;
	ELSIF counter = 1 THEN

	counter := counter +1;
	ELSIF counter = 2 THEN

	counter := counter +1;
	ELSE

	ACK_datapath <= '1';
	counter := 0;
	END IF;
    
	--ACK_datapath <= '1';
        
	--IF Cmux = '1' THEN
	--BusC <= dataIn;
	--END IF;

	--IF Amux = '1' THEN
	--dataMemoryOut <= BusA;
	--END IF;
        --ALU WORKING
        --ALU_output_with_carry(32) <= '0'; -- default case
        --CASE ALU IS
        --    WHEN "100" => ALU_output_with_carry (31 DOWNTO 0) <= BusA AND BusC; --ANDCC
        --    WHEN "101" => ALU_output_with_carry (31 DOWNTO 0) <= BusA OR BusC; --ORCC
        --    WHEN "110" => ALU_output_with_carry <= STD_LOGIC_VECTOR(resize(signed(BusA), 33) + signed(BusC)); --ADDCC
        --    WHEN "010" => ALU_output_with_carry <= STD_LOGIC_VECTOR(resize(signed(BusA), 33) + signed(BusC)); --ADD
        --    WHEN "011" => ALU_output_with_carry (31 DOWNTO 0) <= STD_LOGIC_VECTOR(shift_right(unsigned(BusC), to_integer(unsigned(BusA(4 DOWNTO 0))))); --Shift right
        --    WHEN "000" => ALU_output_with_carry (31 DOWNTO 0) <= BusA AND BusC; --AND
        --    WHEN "001" => ALU_output_with_carry (31 DOWNTO 0) <= BusA OR BusC; --OR
        --    WHEN OTHERS => ALU_output_with_carry (31 DOWNTO 0) <= (31 DOWNTO 0 => '0');
        --END CASE;
        --

        --status bits
        --IF to_integer(unsigned(ALU)) > 3 THEN -- set CC active since ANDCC and ORCC are Operations changing the CC
         --   CC_N <= ALU_output_with_carry(31);
--
        --    IF ALU_output_with_carry(31 DOWNTO 0) = (31 DOWNTO 0 => '0') THEN
        --        CC_Z <= '1';
        --    ELSE
        --        CC_Z <= '0';
        --    END IF;
--
        --    IF (BusA(31) = BusC(31)) AND (BusA(31) /= ALU_output_with_carry(31)) THEN
        --        CC_V <= '1';
        --    ELSE
        --        CC_V <= '0';
        --    END IF;
--
        --    CC_C <= ALU_output_with_carry(32);
        --ELSE
        --    PCR <= (OTHERS => '-');
        --END IF;
        --

        --Multiplexers
       --     Current_A <= rs;
        --    Current_C <= rd;
        --

	--Instruction register
        --Op1 <= IR(19 DOWNTO 18);
        --Op2 <= IR(17 DOWNTO 16);

	--IF (Cmux = '1') OR (Amux = '1') OR (Cmux = 'U') OR (Amux = 'U') THEN
	--rr <= '0';
	--ELSE
	--rr <= '1';
	--END IF;



 --       END IF;
END PROCESS;

END ARCHITECTURE structure;