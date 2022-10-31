LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY debugging IS
    PORT (
        test_pin : IN STD_LOGIC; --What pin will this be?
        clk : IN STD_LOGIC;
        sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9 : IN STD_LOGIC; --The 10 switches
        key0, key1, key2, key3 : IN STD_LOGIC; --The 4 buttons, (key0 will probably be used for reset, cannot be used here then)

        --key0 is reset, key1 is the test_pin, key2 is next_instruction_pin, key3 is load address
        pc : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0); --allowed to handle inout in this way?
        --7 segment display OUT
    );
END;
--sw0..sw9 is used for loading a memory adress. Representation in binary.

ARCHITECTURE behaviour OF debugging IS
    --Temporary PC?
    --Send OP codes to the controller
BEGIN
    PROCESS () --add inputs
        --When test pin is active debugging mode is entered
        IF test_pin = '1' THEN

            --Executes the next instruction
            IF step_mode_pin = '1' THEN
                IF rising_edge(clk) THE --IS THIS ALREADY TAKEN INTO ACCOUNT IN THE CONTROLLER?
                    --Load and execute instruction in PC
                    --Increment PC
                END IF;
            END IF;

            --Loads a memory address from the switches
            IF load_address_key = '1' THEN
                IF rising_edge(clk) THEN --IS THIS ALREADY TAKEN INTO ACCOUNT IN THE CONTROLLER?
                    --Load address sw0..sw9 (tmp variable needed?)
                    --Display content
                END IF;
            END IF;

        END IF;
    END PROCESS;
END ARCHITECTURE behaviour;