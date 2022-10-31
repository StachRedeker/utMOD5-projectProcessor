--------------------------------------------------------------
-- Project          : VHDL description of ARC processor (chapter 5)
--                    "Computer Architecture and Organisation" (ISBN 978-0-471-73388-1) by Murdocca and Heuring
-- 
-- File             : utilities.vhd
--
-- Related File(s)  : 
--
-- Author           : E. Molenkamp, University of Twente, the Netherlands
-- Email            : e.molenkamp@utwente.nl
-- 
-- Project          : Computer Organization
-- Creation Date    : 27 June 2008
-- 
-- Contents         : contains decoder
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
PACKAGE utilities IS
  -- Decoder is used to select one of the 38 registers in the registerfile.
  -- In case the index is out-of-range 0 is output (this will not change the contents
  -- of %r0 since this 'register' has constant value 0).
  FUNCTION decoder(s : std_logic_vector) RETURN natural;

END PACKAGE utilities;

PACKAGE BODY utilities IS
  FUNCTION decoder(s : std_logic_vector) RETURN natural IS
    VARIABLE index : natural;
  BEGIN
    index := to_integer(unsigned(s));
    IF index<38 THEN
      RETURN index;
    ELSE
      REPORT "decoder index out of range" SEVERITY warning;
      RETURN 0; -- %r0 is read only, therefore this is a safe return value
    END IF;
  END decoder;

 END PACKAGE BODY utilities;
