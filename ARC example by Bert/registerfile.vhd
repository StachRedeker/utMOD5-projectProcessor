--------------------------------------------------------------
-- Project          : VHDL description of ARC processor (chapter 5)
--                    "Computer Architecture and Organisation" (ISBN 978-0-471-73388-1) by Murdocca and Heuring
-- 
-- File             : registerfile.vhd
--
-- Related File(s)  : utilities.vhd
--
-- Author           : E. Molenkamp, University of Twente, the Netherlands
-- Email            : e.molenkamp@utwente.nl
-- 
-- Project          : Computer Organization
-- Creation Date    : 27 June 2008
-- 
-- Contents         : registerfile
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
USE work.utilities.ALL;
ENTITY registerfile IS
  PORT (
    Clk : IN std_logic;

    BusA : OUT std_logic_vector(31 DOWNTO 0);
    SelA : IN  std_logic_vector( 5 DOWNTO 0);  
    BusB : OUT std_logic_vector(31 DOWNTO 0);
    SelB : IN  std_logic_vector( 5 DOWNTO 0);  
    BusC : IN  std_logic_vector(31 DOWNTO 0);
    SelC : IN  std_logic_vector( 5 DOWNTO 0);
  IR   : OUT std_logic_vector(31 DOWNTO 0)
  );
END ENTITY registerfile;

ARCHITECTURE three_port OF registerfile IS

  TYPE reg_file_type IS ARRAY (37 DOWNTO 0) OF std_logic_vector(31 DOWNTO 0);
  SIGNAL reg_file : reg_file_type := (OTHERS=>(OTHERS=>'0'));
  ATTRIBUTE ram_block: boolean;
  ATTRIBUTE ram_block OF reg_file: SIGNAL IS true;  
 
BEGIN

  -- check that register file does not have enable in signals
  registers:PROCESS(clk)
    VARIABLE index : natural;
  BEGIN
    IF falling_edge(clk) THEN  
    reg_file(0) <= (OTHERS=>'0');  --%r0 constant zero
      index := decoder(SelC);
      IF index>0 THEN
        reg_file(index)<= BusC;
      END IF;
    END IF;
  END PROCESS registers;

  BusA <= reg_file(to_integer(unsigned(SelA)));
  BusB <= reg_file(to_integer(unsigned(SelB)));  
 
  IR  <= reg_file(37);
    
END ARCHITECTURE three_port;
