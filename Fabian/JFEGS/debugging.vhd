LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY debugging IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC; --key0
        next_instruction_key : IN STD_LOGIC; --key1
        load_address_key : IN STD_LOGIC; --key2
        AMux : OUT STD_LOGIC;
        Cmux : OUT STD_LOGIC;
        sw : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        PCR : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        memory_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DEBUG_NEXT : OUT STD_LOGIC;
	led : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);

        dig0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	address : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
        st : OUT STD_LOGIC;
        b : OUT STD_LOGIC;
        ld : OUT STD_LOGIC



    );
END ENTITY debugging;

ARCHITECTURE structure OF debugging IS

    COMPONENT debugging_facilitators IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC; --key0
            next_instruction_key : IN STD_LOGIC; --key1
            load_address_key : IN STD_LOGIC; --key2
            DEBUG_NEXT : OUT STD_LOGIC;
            LOAD_ADDRESS : OUT STD_LOGIC;

            AMux : IN STD_LOGIC;
            Cmux : IN STD_LOGIC;
            --Output
            wr_status : OUT STD_LOGIC;
            rd_status : OUT STD_LOGIC
        );
    END COMPONENT debugging_facilitators;

    COMPONENT debugging_display IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC; --key0
            sw : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            led : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);

            dig0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            dig1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            dig2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            dig3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            dig4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            dig5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);

            LOAD_ADDRESS : IN STD_LOGIC;
            --output to displays

            wr_status : IN STD_LOGIC;
            rd_status : IN STD_LOGIC;

            --Output
            address : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
            st : OUT STD_LOGIC;
            b : OUT STD_LOGIC;
            ld : OUT STD_LOGIC;
            cmux : OUT STD_LOGIC;
            amux : OUT STD_LOGIC;

            PCR : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            memory_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT debugging_display;

    SIGNAL wr_status : STD_LOGIC;
    SIGNAL rd_status : STD_LOGIC;
    SIGNAL LOAD_ADDRESS : STD_LOGIC;
    SIGNAL AMux_temp : STD_LOGIC;	
    SIGNAL CMux_temp : STD_LOGIC;	

BEGIN

    

    df : debugging_facilitators PORT MAP(clk, reset, next_instruction_key, load_address_key, DEBUG_NEXT, LOAD_ADDRESS, AMux_temp, Cmux_temp, wr_status, rd_status);
    dd : debugging_display PORT MAP(clk, reset, sw, led, dig0, dig1, dig2, dig3, dig4, dig5, LOAD_ADDRESS, wr_status, rd_status, address, st, b, ld, CMux_temp, AMux_temp, PCR, memory_data_out);
    AMux <= AMux_temp; 
    CMux <= CMux_temp;

END structure;