LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;
PACKAGE utilities IS

    -- converts binary to decimal
    FUNCTION bin2dec (inp : STD_LOGIC_VECTOR) RETURN NATURAL;

    -- converts binary to hexadecimal
    FUNCTION bin2hex (inp : STD_LOGIC_VECTOR) RETURN STRING;
    FUNCTION extendedbin2hex (inp : STD_LOGIC_VECTOR) RETURN STRING; -- used by bin2hex
    FUNCTION fourbits2hex (inp : STD_LOGIC_VECTOR) RETURN CHARACTER; -- used by bin2hex

    -- converts hexadecimal to binary
    FUNCTION hex2bin (inp : STRING) RETURN STD_LOGIC_VECTOR;
    FUNCTION char2bin(inp : character) RETURN std_logic_vector; -- used by hex2bin 

END PACKAGE utilities;

PACKAGE BODY utilities IS
    FUNCTION bin2dec (inp : STD_LOGIC_VECTOR) RETURN NATURAL IS
        VARIABLE sum : NATURAL := 0;
        VARIABLE inp_align : STD_LOGIC_VECTOR((inp'length - 1) DOWNTO 0) := inp;
    BEGIN
        FOR i IN 0 TO (inp'length - 1) LOOP
            IF inp(i) = '1' THEN
                sum := sum + (2 ** i);
            END IF;
        END LOOP;
        RETURN sum;
    END bin2dec;

    FUNCTION bin2hex (inp : STD_LOGIC_VECTOR) RETURN STRING IS
    BEGIN

        IF ((inp'length MOD 4) /= 0) THEN
            CASE (inp'length MOD 4) IS
                WHEN 1 => RETURN (extendedbin2hex("000" & inp));
                WHEN 2 => RETURN (extendedbin2hex("00" & inp));
                WHEN 3 => RETURN (extendedbin2hex("0" & inp));
                WHEN OTHERS => RETURN (extendedbin2hex(inp));
            END CASE;
        ELSE
            RETURN extendedbin2hex(inp);
        END IF;

    END bin2hex;

    FUNCTION extendedbin2hex (inp : STD_LOGIC_VECTOR) RETURN STRING IS
        VARIABLE inp_align : STD_LOGIC_VECTOR(inp'LENGTH DOWNTO 1) := inp;
        VARIABLE res : STRING(inp_align'LENGTH/4 DOWNTO 1);
    BEGIN
        FOR i IN res'length DOWNTO 1 LOOP
            res(i) := fourbits2hex(inp_align (4 * i DOWNTO 4 * i - 3));
        END LOOP;
        RETURN res;
    END extendedbin2hex;

    -- convert 4 bits to hexadecimal
    FUNCTION fourbits2hex (inp : STD_LOGIC_VECTOR) RETURN CHARACTER IS
        CONSTANT inp_a : STD_LOGIC_VECTOR(3 DOWNTO 0) := inp;
    BEGIN
        CASE inp_a IS
            WHEN "0000" => RETURN '0';
            WHEN "0001" => RETURN '1';
            WHEN "0010" => RETURN '2';
            WHEN "0011" => RETURN '3';
            WHEN "0100" => RETURN '4';
            WHEN "0101" => RETURN '5';
            WHEN "0110" => RETURN '6';
            WHEN "0111" => RETURN '7';
            WHEN "1000" => RETURN '8';
            WHEN "1001" => RETURN '9';
            WHEN "1010" => RETURN 'A';
            WHEN "1011" => RETURN 'B';
            WHEN "1100" => RETURN 'C';
            WHEN "1101" => RETURN 'D';
            WHEN "1110" => RETURN 'E';
            WHEN "1111" => RETURN 'F';
            WHEN OTHERS => RETURN '0';
        END CASE;
    END fourbits2hex;


    FUNCTION char2bin(inp : character) RETURN std_logic_vector IS
    BEGIN
      CASE inp IS
        WHEN '0'    => RETURN "0000";
        WHEN '1'    => RETURN "0001";        
        WHEN '2'    => RETURN "0010";
        WHEN '3'    => RETURN "0011";
        WHEN '4'    => RETURN "0100";
        WHEN '5'    => RETURN "0101";        
        WHEN '6'    => RETURN "0110";
        WHEN '7'    => RETURN "0111";
        WHEN '8'    => RETURN "1000";
        WHEN '9'    => RETURN "1001";        
        WHEN 'A'|'a'=> RETURN "1010";
        WHEN 'B'|'b'=> RETURN "1011";
        WHEN 'C'|'c'=> RETURN "1100";
        WHEN 'D'|'d'=> RETURN "1101";        
        WHEN 'E'|'e'=> RETURN "1110";
        WHEN 'F'|'f'=> RETURN "1111";                        
        WHEN OTHERS => RETURN "XXXX";
      END CASE;    
    END char2bin;


    FUNCTION hex2bin (inp : STRING) RETURN STD_LOGIC_VECTOR IS
        VARIABLE inp_align : STRING(inp'LENGTH DOWNTO 1) := inp;
        VARIABLE res : STD_LOGIC_VECTOR(inp'LENGTH * 4 DOWNTO 1);
    BEGIN
        FOR i IN inp_align'length DOWNTO 1 LOOP
            res (4 * i DOWNTO 4 * i - 3) := char2bin(inp_align(i));
        END LOOP;
        RETURN res;

    END hex2bin;


END PACKAGE BODY utilities;