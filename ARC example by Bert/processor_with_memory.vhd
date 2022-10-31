--------------------------------------------------------------
-- Project          : VHDL description of ARC processor (chapter 5)
--                    "Computer Architecture and Organisation" (ISBN 978-0-471-73388-1) by Murdocca and Heuring
-- 
-- File             : processor_with_memory.vhd
--
-- Related File(s)  : main_memory.vhd, ARCprocessor.vhd
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
ENTITY processor_with_memory IS
  GENERIC (max_address_main_store : integer := 400;
           ProgramFile : string := "program.bin");
END ENTITY processor_with_memory;

ARCHITECTURE structure OF processor_with_memory IS

  COMPONENT ARC IS
    PORT (
      Clk     : IN  std_logic;
      Reset   : IN  std_logic; -- async, low active
      DataIn  : IN  std_logic_vector(31 DOWNTO 0);
      Dout    : OUT std_logic_vector(31 DOWNTO 0);
      Address : OUT std_logic_vector(31 DOWNTO 0);
      Rd_M    : OUT std_logic;
      Wr_M    : OUT std_logic;
      Ack     : IN  std_logic
    );
  END COMPONENT ARC;

  COMPONENT main_memory IS
    GENERIC (max_address : integer := 100;
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
  END COMPONENT main_memory;
  SIGNAL clk     : std_logic := '1';
  SIGNAL address : std_logic_vector(31 DOWNTO 0);
  SIGNAL cpu2mem : std_logic_vector(31 DOWNTO 0);
  SIGNAL mem2cpu : std_logic_vector(31 DOWNTO 0);
  SIGNAL Rd_M    : std_logic;
  SIGNAL Wr_M    : std_logic;
  SIGNAL Ack     : std_logic;  
  SIGNAL reset   : std_logic := '0';
BEGIN
  cpu:ARC
    PORT MAP (clk, reset, mem2cpu,cpu2mem,address,Rd_m,Wr_m,Ack);
    
  mem:main_memory
    GENERIC MAP (max_address_main_store, ProgramFile)
    PORT MAP (cpu2mem,mem2cpu,address,Rd_m,Wr_m,Ack,clk);

  clk <= NOT clk AFTER 50 ns;
  
  reset <= '0', '1' AFTER 130 ns;  

END structure;
