LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY work;
USE work.utilities.ALL;
USE work.io.ALL;

ENTITY debugging_facilitator IS
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
        address : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
        wr : OUT STD_LOGIC;
        b : OUT STD_LOGIC;
        rd : OUT STD_LOGIC;
        cmux : OUT STD_LOGIC;
        amux : OUT STD_LOGIC;

        PCR : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

        memory_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0)

    );
END;

ARCHITECTURE bhv OF debugging_facilitator IS
BEGIN
    PROCESS (clk, reset, sw, memory_data_out, PCR, wr_status, rd_status, LOAD_ADDRESS)

    BEGIN

        IF reset = '0' THEN

            --reset stuff

        ELSIF rising_edge(clk) THEN

            IF LOAD_ADDRESS = '1' THEN

                address <= sw(9 DOWNTO 0); --values of the switches
                wr <= '0';
                b <= '0';
                rd <= '1';
                cmux <= '1';
                amux <= '0';

            END IF;

            displaycontent(bin2hex(memory_data_out(19 DOWNTO 0)), dig0, dig1, dig2, dig3, dig4, dig5);

            led(3) <= PCR(3);
            led(2) <= PCR(2);
            led(1) <= PCR(1);
            led(0) <= PCR(0);

            led(4) <= rd_status;
            led(5) <= wr_status;
        END IF;
    END PROCESS;
END;