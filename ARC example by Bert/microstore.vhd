--------------------------------------------------------------
-- Project          : VHDL description of ARC processor (chapter 5)
--                    "Computer Architecture and Organisation" (ISBN 978-0-471-73388-1) by Murdocca and Heuring
-- 
-- File             : microstore.vhd
--
-- Related File(s)  : 
--
-- Author           : E. Molenkamp, University of Twente, the Netherlands
-- Email            : e.molenkamp@utwente.nl
-- 
-- Project          : Computer Organization
-- Creation Date    : 27 June 2008
-- 
-- Contents         : microstore; actual ROM data is missing!
--                    The content is generated with "Microasm"
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
ENTITY microstore IS
  PORT (address : IN std_logic_vector(10 DOWNTO 0);
        microcode : OUT std_logic_vector(40 DOWNTO 0));
END ENTITY microstore;

ARCHITECTURE behaviour OF microstore IS
  TYPE CS_type IS ARRAY (0 TO 2047) OF std_logic_vector(40 DOWNTO 0);
  CONSTANT CStore : CS_type := (OTHERS=>(OTHERS=>'0'));
BEGIN
  microcode <= CStore(to_integer(unsigned(address)));
END ARCHITECTURE behaviour;
