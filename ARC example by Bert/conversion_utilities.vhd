--------------------------------------------------------------
-- Project          : VHDL description of ARC processor (chapter 5)
--                    "Computer Architecture and Organisation" (ISBN 978-0-471-73388-1) by Murdocca and Heuring
-- 
-- File             : conversion_utilities.vhd
--
-- Related File(s)  : 
--
-- Author           : E. Molenkamp, University of Twente, the Netherlands
-- Email            : e.molenkamp@utwente.nl
-- 
-- Project          : Computer Organization
-- Creation Date    : 27 June 2008
-- 
-- Contents         : conversion between hex, natural etc.
--
-- Change Log 
--   Author         : 
--   Email          : 
--   Date           :  
--   Changes        :
--

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;
PACKAGE conversion_utilities IS
  -- converts hex vector to natural
  FUNCTION hex2dec (inp : string) RETURN natural;
  
  -- converts hex to binary (std_logic_vector)
  FUNCTION hex2stdv(inp : character) RETURN std_logic_vector;  

  -- convert hex vector to binary vector (std_logic_vector)
  FUNCTION hexv2stdv (inp : string) RETURN std_logic_vector;  
  
  -- convert binary vector (std_logic_vector) to hex vector
  -- input length should be multiple of 4
  FUNCTION stdv2hexv (inp : std_logic_vector) RETURN string;

  -- convert 4 bits to hex  
  FUNCTION nibble2hex (inp : std_logic_vector) RETURN character;


END PACKAGE conversion_utilities;

PACKAGE BODY conversion_utilities IS
  
  FUNCTION hex2dec (inp : string) RETURN natural IS
    VARIABLE res : natural :=0;
  BEGIN
    FOR i IN inp'RANGE LOOP
      res := res*16;
      CASE inp(i) IS
        WHEN '0'    => res := res + 0;
        WHEN '1'    => res := res + 1;        
        WHEN '2'    => res := res + 2;
        WHEN '3'    => res := res + 3;
        WHEN '4'    => res := res + 4;
        WHEN '5'    => res := res + 5;        
        WHEN '6'    => res := res + 6;
        WHEN '7'    => res := res + 7;
        WHEN '8'    => res := res + 8;
        WHEN '9'    => res := res + 9;        
        WHEN 'A'|'a'=> res := res + 10;
        WHEN 'B'|'b'=> res := res + 11;
        WHEN 'C'|'c'=> res := res + 12;
        WHEN 'D'|'d'=> res := res + 13;        
        WHEN 'E'|'e'=> res := res + 14;
        WHEN 'F'|'f'=> res := res + 15;                        
        WHEN OTHERS => REPORT "unexpected character in hex2dec" SEVERITY warning;
      END CASE;
    END LOOP;
    RETURN res;
  END hex2dec;
  
  -- converts hex to binary (std_logic_vector)
  FUNCTION hex2stdv(inp : character) RETURN std_logic_vector IS
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
      WHEN OTHERS => RETURN "XXXX"; REPORT "unexpected character in hex2dec" SEVERITY warning;
    END CASE;    
  END hex2stdv;
  
  -- convert hex vector to binary vector (std_logic_vector)
  FUNCTION hexv2stdv (inp : string) RETURN std_logic_vector IS
    VARIABLE inp_align : string(inp'LENGTH DOWNTO 1) := inp;
    VARIABLE res : std_logic_vector(inp'LENGTH*4 DOWNTO 1);
  BEGIN
    FOR i IN inp_align'length DOWNTO 1 LOOP
      res (4*i DOWNTO 4*i-3) := hex2stdv(inp_align(i));
    END LOOP;
    RETURN res;
  END hexv2stdv;
    
   -- convert binary vector (std_logic_vector) to hex vector
  -- input length should be multiple of 4   
  FUNCTION stdv2hexv (inp : std_logic_vector) RETURN string IS
    VARIABLE inp_align : std_logic_vector(inp'LENGTH DOWNTO 1) := inp;
    VARIABLE res : string(inp_align'LENGTH/4 DOWNTO 1);
  BEGIN
    ASSERT (inp'LENGTH MOD 4)=0 REPORT "length not equal to 4 in function stdv2hexv" SEVERITY failure;
    FOR i IN res'length DOWNTO 1 LOOP
      res(i):= nibble2hex(inp_align (4*i DOWNTO 4*i-3));
    END LOOP;
    RETURN res;
  END stdv2hexv;

  -- convert 4 bits to hex  
  FUNCTION nibble2hex (inp : std_logic_vector) RETURN character IS
    CONSTANT inp_a : std_logic_vector(3 DOWNTO 0) := inp;
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
      WHEN OTHERS => RETURN '0'; REPORT "unexpected string in nibble2hex" SEVERITY warning;
    END CASE;  
  END nibble2hex;
 
END PACKAGE BODY conversion_utilities;