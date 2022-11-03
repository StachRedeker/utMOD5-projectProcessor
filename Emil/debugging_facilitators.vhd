LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY debugging_facilitator IS
    PORT (
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
        rd_status : OUT STD_LOGIC
      


    );
END;

ARCHITECTURE bhv OF debugging_facilitator IS
BEGIN
    PROCESS (clk, reset, debug_next_key, load_address_key, wr, rd)

        VARIABLE previous_debug_next_key : STD_LOGIC;
        VARIABLE previous_load_address_key : STD_LOGIC;

    BEGIN

        IF reset = '0' THEN
          
            --reset stuff

        ELSIF falling_edge(clk) THEN

            IF debug_next_key = '0' AND previous_debug_next_key = '1' THEN
                DEBUG_NEXT <= '1';
            ELSE
                DEBUG_NEXT <= '0';
            END IF;
            previous_debug_next_key := debug_next_key;
            
            IF load_address_key = '0' AND previous_load_address_key = '1' THEN
                LOAD_ADDRESS <= '1';
            ELSE
                LOAD_ADDRESS <= '0';
            END IF;
            previous_load_address_key := load_address_key;


            wr_status <= wr;
            rd_status <= rd;

            
        END IF;
    END PROCESS;
END;