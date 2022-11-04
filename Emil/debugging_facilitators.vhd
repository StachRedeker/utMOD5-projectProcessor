LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY debugging_facilitator IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC; --key0
        next_instruction_key : IN STD_LOGIC; --key1
        load_address_key : IN STD_LOGIC; --key2
        DEBUG_NEXT : OUT STD_LOGIC;
        LOAD_ADDRESS : OUT STD_LOGIC;

        AMux : IN STD_LOGIC; --writing
        CMux : IN STD_LOGIC; --reading


        --Output
        wr_status : OUT STD_LOGIC;
        rd_status : OUT STD_LOGIC
      


    );
END;

ARCHITECTURE bhv OF debugging_facilitator IS
BEGIN
    PROCESS (clk, reset, next_instruction_key, load_address_key, AMux, CMux)

        VARIABLE previous_next_instruction_key : STD_LOGIC;
        VARIABLE previous_load_address_key : STD_LOGIC;

    BEGIN

        IF reset = '0' THEN
          
            --reset stuff

        ELSIF rising_edge(clk) THEN

            IF next_instruction_key = '0' AND previous_next_instruction_key = '1' THEN
                DEBUG_NEXT <= '1';
            ELSE
                DEBUG_NEXT <= '0';
            END IF;
            previous_next_instruction_key := next_instruction_key;
            
            IF load_address_key = '0' AND previous_load_address_key = '1' THEN
                LOAD_ADDRESS <= '1';
            ELSE
                LOAD_ADDRESS <= '0';
            END IF;
            previous_load_address_key := load_address_key;


            wr_status <= AMux;
            rd_status <= CMux;

            
        END IF;
    END PROCESS;
END;