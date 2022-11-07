LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;
LIBRARY work;
USE work.utilities.ALL;
PACKAGE io IS
    -- type used for displaying on the 7-segment displays
    TYPE sevensegmentdisptype IS ARRAY(5 DOWNTO 0) OF STD_LOGIC_VECTOR(6 DOWNTO 0);

    -- used for displaying content, enter the content that should be displayed and the signals that should
    -- display the content.
    PROCEDURE displaycontent(
        content : IN STRING;
        SIGNAL dig0 : OUT STD_LOGIC_VECTOR;
        SIGNAL dig1 : OUT STD_LOGIC_VECTOR;
        SIGNAL dig2 : OUT STD_LOGIC_VECTOR;
        SIGNAL dig3 : OUT STD_LOGIC_VECTOR;
        SIGNAL dig4 : OUT STD_LOGIC_VECTOR;
        SIGNAL dig5 : OUT STD_LOGIC_VECTOR);
    FUNCTION to7segdisplay (inp : STRING) RETURN sevensegmentdisptype; -- used by display content to generate display output
    FUNCTION char2sevensegment (inp : CHARACTER) RETURN STD_LOGIC_VECTOR; -- used by to7segdisplay
    FUNCTION disp_overflow(inp : sevensegmentdisptype) RETURN sevensegmentdisptype; -- used by to7segdisplay if content is too large

END PACKAGE io;

PACKAGE BODY io IS

    FUNCTION char2sevensegment (inp : CHARACTER) RETURN STD_LOGIC_VECTOR IS
        VARIABLE n : STD_LOGIC_VECTOR(3 DOWNTO 0);
    BEGIN

        n := char2bin(inp);

        CASE n IS -- gfedcba; low active
            WHEN "0000" => RETURN NOT "0111111"; -- 0
            WHEN "0001" => RETURN NOT "0000110"; -- 1
            WHEN "0010" => RETURN NOT "1011011"; -- 2
            WHEN "0011" => RETURN NOT "1001111"; -- 3
            WHEN "0100" => RETURN NOT "1100110"; -- 4
            WHEN "0101" => RETURN NOT "1101101"; -- 5
            WHEN "0110" => RETURN NOT "1111101"; -- 6
            WHEN "0111" => RETURN NOT "0000111"; -- 7
            WHEN "1000" => RETURN NOT "1111111"; -- 8
            WHEN "1001" => RETURN NOT "1101111"; -- 9
            WHEN "1010" => RETURN NOT "1110111"; -- A
            WHEN "1011" => RETURN NOT "1111100"; -- b
            WHEN "1100" => RETURN NOT "0111001"; -- C
            WHEN "1101" => RETURN NOT "1011110"; -- d
            WHEN "1110" => RETURN NOT "1111001"; -- E
            WHEN "1111" => RETURN NOT "1110001"; -- F
            WHEN OTHERS => RETURN NOT "1000000"; -- -
        END CASE;
    END char2sevensegment;

    FUNCTION disp_overflow(inp : sevensegmentdisptype) RETURN sevensegmentdisptype IS
        VARIABLE disp : sevensegmentdisptype;

    BEGIN
        disp(5) := NOT "1111001"; --E
        disp(4) := NOT "1010000"; --r
        disp(3) := NOT "1010000"; --r
        disp(2) := NOT "1011100"; --o
        disp(1) := NOT "1010000"; --r
        disp(0) := NOT "0000000"; --empty

        RETURN disp;

    END disp_overflow;
    FUNCTION to7segdisplay (inp : STRING) RETURN sevensegmentdisptype IS
        VARIABLE disp : sevensegmentdisptype;
        VARIABLE inp_align : STRING(inp'LENGTH DOWNTO 1) := inp;

    BEGIN
        -- fills the disp type with 1's (turning all the segments off) if the number is too short
        FOR i IN 5 DOWNTO 0 LOOP
            disp(i) := "1111111";
        END LOOP;

        FOR i IN inp_align'length DOWNTO 1 LOOP
            IF (inp_align'length - 1 < 6) THEN
                disp(i - 1) := char2sevensegment(inp_align(i));
            ELSE
                disp := disp_overflow(disp);
            END IF;
        END LOOP;
        RETURN disp;

    END to7segdisplay;
    PROCEDURE displaycontent(
        content : IN STRING;
        SIGNAL dig0 : OUT STD_LOGIC_VECTOR;
        SIGNAL dig1 : OUT STD_LOGIC_VECTOR;
        SIGNAL dig2 : OUT STD_LOGIC_VECTOR;
        SIGNAL dig3 : OUT STD_LOGIC_VECTOR;
        SIGNAL dig4 : OUT STD_LOGIC_VECTOR;
        SIGNAL dig5 : OUT STD_LOGIC_VECTOR) IS
        VARIABLE disp : sevensegmentdisptype;
    BEGIN

        disp := to7segdisplay(content);
        dig0 <= disp(0);
        dig1 <= disp(1);
        dig2 <= disp(2);
        dig3 <= disp(3);
        dig4 <= disp(4);
        dig5 <= disp(5);

    END displaycontent;

    
       
END PACKAGE BODY io;