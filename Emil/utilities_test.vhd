LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;
LIBRARY work;
USE work.utilities.ALL;
USE work.io.ALL;


ENTITY utilities_test IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        dig0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        --intout : out integer
    );
END;

ARCHITECTURE bhv OF utilities_test IS
BEGIN
    PROCESS(reset, clk)

        VARIABLE int : INTEGER := 0;
        VARIABLE counter : INTEGER := 0;
        VARIABLE disp : sevensegmentdisptype;
    BEGIN

        IF reset = '0' THEN
            int := 0;
            counter := 0;
            disp := to7segdisplay(INTEGER'image(int));

        ELSIF rising_edge(clk) THEN
            
            counter := counter + 1;

            IF (counter = 25000000) THEN

                disp := to7segdisplay(INTEGER'image(int));

                dig0 <= disp(0);
                dig1 <= disp(1);
                dig2 <= disp(2);
                dig3 <= disp(3);
                dig4 <= disp(4);
                dig5 <= disp(5);

                int := int + 1;
                counter := 0;

            END IF;

            --intout <= int;

        END IF;

    END PROCESS;
END;