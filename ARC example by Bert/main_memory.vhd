--------------------------------------------------------------
-- Project          : VHDL description of ARC processor (chapter 5)
--                    "Computer Architecture and Organisation" (ISBN 978-0-471-73388-1) by Murdocca and Heuring
-- 
-- File             : main_memory.vhd
--
-- Related File(s)  : conversion_utilites.vhd
--
-- Author           : E. Molenkamp, University of Twente, the Netherlands
-- Email            : e.molenkamp@utwente.nl
-- 
-- Project          : Computer Organization
-- Creation Date    : 27 June 2008
-- 
-- Contents         : Entity of main memory.
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
USE work.conversion_utilities.ALL;
ENTITY main_memory IS
  GENERIC (max_address : integer := 400;
           program : string := "program.bin");
  PORT (
    DataIn  : IN  std_logic_vector(31 DOWNTO 0);
    Dout    : OUT std_logic_vector(31 DOWNTO 0);
    Address : IN  std_logic_vector(31 DOWNTO 0);
    Rd_M    : IN  std_logic;
    Wr_M    : IN  std_logic;
    Ack     : OUT std_logic;
    clk     : IN  std_logic
  );
END ENTITY main_memory;
