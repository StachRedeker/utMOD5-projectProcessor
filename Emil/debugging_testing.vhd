LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;
LIBRARY work;
USE work.utilities.ALL;
USE work.io.ALL;

ENTITY debugging_testing IS
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

        --output to displays


        --Output
        address : OUT STD_LOGIC_VECTOR(9 downto 0);
        wr : OUT STD_LOGIC;
        b : OUT STD_LOGIC;
        rd : OUT STD_LOGIC;
        cmux : OUT STD_LOGIC;
        amux : OUT STD_LOGIC;

        PCR : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

        memory_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0)

    );
END;

ARCHITECTURE structure OF debugging_testing IS

COMPONENT debugging_facilitators is
    port (

        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC; --key0
        debug_next_key : IN STD_LOGIC; --key1
        load_address_key : IN STD_LOGIC; --key2
        DEBUG_NEXT : OUT STD_LOGIC;
        LOAD_ADDRESS : OUT STD_LOGIC;

        wr : IN STD_LOGIC;
        rd : IN STD_LOGIC;


        --Output
        wr_status : OUT STD_LOGIC;
        rd_status : OUT STD_LOGIC;
      

        memory_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
    end component debugging_facilitators;

    component debugging_display is
        port (
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
        address : OUT STD_LOGIC_VECTOR(9 downto 0);
        wr : OUT STD_LOGIC;
        b : OUT STD_LOGIC;
        rd : OUT STD_LOGIC;
        cmux : OUT STD_LOGIC;
        amux : OUT STD_LOGIC;

        PCR : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

        memory_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
        end component debugging_display;
BEGIN

        df: debugging_facilitators PORT MAP(clk, reset, debug_next_key, load_address_key, wr, rd);
        dd: debugging_display PORT MAP(clk, reset, sw, memory_data_out, PCR, wr_status, rd_status, LOAD_ADDRESS);

END structure;