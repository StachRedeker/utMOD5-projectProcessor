LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY registerfile IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC; -- button 0 of FPGA
        BusC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Current_C : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Current_A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        BusA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        IR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY registerfile;

ARCHITECTURE bhv OF registerfile IS

    TYPE registerfile_type IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL reg_file : registerfile_type := (OTHERS => (OTHERS => '0'));

    FUNCTION decoder(s : STD_LOGIC_VECTOR) RETURN NATURAL IS
        VARIABLE index : NATURAL;
    BEGIN
        index := to_integer(unsigned(s));
        IF index < 16 THEN
            RETURN index;
        ELSE
            REPORT "decoder index out of range" SEVERITY warning;
            RETURN 0; -- %r0 is read only, therefore this is a safe return value
        END IF;
    END decoder;

BEGIN

--    registers : PROCESS (clk)
--     
--    BEGIN
--        IF rising_edge(clk) THEN
--
--        END IF;
  --  END PROCESS registers;

    PROCESS (clk, BusC, Current_C, Current_A)
  VARIABLE index : NATURAL;
    BEGIN
        IF reset = '0' THEN
            BusA <= (31 DOWNTO 0 => '0');
            IR <= (31 DOWNTO 0 => '0');
            --reg_file <= (OTHERS => (OTHERS => '0'));
        ELSIF rising_edge(clk) THEN
	--	reg_file(0) <= (OTHERS => '0'); --%r0 is constant zero
        	index := decoder(Current_C);
        IF index > 0 THEN
            	reg_file(index) <= BusC;
        END IF;
	END IF;

        BusA <= reg_file(to_integer(unsigned(Current_A)));

        PC <= reg_file(14); --Register 14 is program counter
        IR <= reg_file(15); --Register 15 is instruction register
        --  END IF;
    END PROCESS;
END ARCHITECTURE bhv;