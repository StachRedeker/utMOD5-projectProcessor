LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;
PACKAGE utilities IS

    -- converts binary to decimal
    FUNCTION bin2dec (inp : STD_LOGIC_VECTOR) RETURN NATURAL;
    -- converts binary to hexadecimal
    FUNCTION bin2hex (inp : STD_LOGIC_VECTOR) RETURN STRING;
    -- convert 4 bits to hexadecimal  
    FUNCTION fourbits2hex (inp : STD_LOGIC_VECTOR) RETURN CHARACTER;
END PACKAGE utilities;

PACKAGE BODY utilities IS
    FUNCTION bin2dec (inp : STD_LOGIC_VECTOR) RETURN NATURAL IS
        VARIABLE sum : NATURAL := 0;
    BEGIN
        FOR i IN 0 TO inp'length LOOP
            IF inp(i) = '1' THEN
                sum := sum + (2 ** i);
            END IF;
        END LOOP;
        RETURN sum;
    END bin2dec;

    FUNCTION bin2hex (inp : STD_LOGIC_VECTOR) RETURN STRING IS
        VARIABLE inp_align : STD_LOGIC_VECTOR(inp'LENGTH DOWNTO 1) := inp;
        VARIABLE res : STRING(inp_align'LENGTH/4 DOWNTO 1);
    BEGIN
        ASSERT (inp'LENGTH MOD 4) = 0 REPORT "length not equal to 4 in function stdv2hexv" SEVERITY failure;
        FOR i IN res'length DOWNTO 1 LOOP
            res(i) := fourbits2hex(inp_align (4 * i DOWNTO 4 * i - 3));
        END LOOP;
        RETURN res;
    END bin2hex;

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

END PACKAGE BODY utilities;