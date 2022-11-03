LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;
LIBRARY work;
USE work.utilities.ALL;
USE work.io.ALL;

ENTITY io_test IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        key1 : IN STD_LOGIC;
        key2 : IN STD_LOGIC;
        dig0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        dig5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        sw0 : IN STD_LOGIC;
        sw1 : IN STD_LOGIC;
        sw2 : IN STD_LOGIC;
        sw3 : IN STD_LOGIC;
        sw4 : IN STD_LOGIC;
        sw5 : IN STD_LOGIC;
        sw6 : IN STD_LOGIC;
        sw7 : IN STD_LOGIC;
        sw8 : IN STD_LOGIC;
        sw9 : IN STD_LOGIC

    );
END;

ARCHITECTURE bhv OF io_test IS

signal swi0 : std_logic;
signal swi1 : std_logic;

BEGIN
    PROCESS (clk, reset, key1, key2, sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7, sw8, sw9)

    variable int : integer := 0;
    BEGIN

    

        if reset = '0' then
            swi0 <= sw0;
            swi1 <= sw1;
            int := switches_value(sw0, sw1,'0','0','0','0','0','0','0','0');
            displaycontent(INTEGER'image(int), dig0, dig1, dig2, dig3, dig4, dig5);

        

        displaycontent(INTEGER'image(000000), dig0, dig1, dig2, dig3, dig4, dig5);

        elsif rising_edge(clk) then

            swi0 <= sw0;
            swi1 <= sw1;


            int := switches_value(sw0, sw1,'0','0','0','0','0','0','0','0');

        

            displaycontent(INTEGER'image(int), dig0, dig1, dig2, dig3, dig4, dig5);



        end if;

        

    END PROCESS;
END;