--------------------------------------------------------------
-- Project          : VHDL description of ARC processor (chapter 5)
--                    "Computer Architecture and Organisation" (ISBN 978-0-471-73388-1) by Murdocca and Heuring
-- 
-- File             : utlititied.vhd, control. vhd, datapath.vhd
--
-- Related File(s)  : ARCprocessor.vhd
--
-- Author           : E. Molenkamp, University of Twente, the Netherlands
-- Email            : e.molenkamp@utwente.nl
-- 
-- Project          : Computer Organization
-- Creation Date    : 27 June 2008
-- 
-- Contents         : structural description of ARC
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
ENTITY ARC IS
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
END ENTITY ARC;

ARCHITECTURE structure OF ARC IS

  COMPONENT Control IS
    PORT (
      Clk : IN std_logic;
      Reset : IN std_logic; -- async, low active
    -- to datapath
      A    : OUT std_logic_vector(5 DOWNTO 0);
      AMux : OUT std_logic;    
      B    : OUT std_logic_vector(5 DOWNTO 0);
      BMux : OUT std_logic;
      C    : OUT std_logic_vector(5 DOWNTO 0);
      CMux : OUT std_logic;
      Rd_M : OUT std_logic;
      F    : OUT std_logic_vector(3 DOWNTO 0);
    -- from datapath
      set_CC : IN std_logic;
      CC     : IN std_logic_vector(3 DOWNTO 0); -- N, Z, V, C resp. 3 downto 0
    --- instruction fields to control
      op  : IN std_logic_vector(1 DOWNTO 0);
      op3 : IN std_logic_vector(5 DOWNTO 0);
      bit13 : IN std_logic;  
    -- 
      Wr_M : OUT std_logic;
      Ack  : IN  std_logic
    );
  END COMPONENT Control;

  COMPONENT datapath IS
    PORT (
      Clk     : IN std_logic;
      DataIn  : IN std_logic_vector(31 DOWNTO 0);
      Dout    : OUT std_logic_vector(31 DOWNTO 0);
      Address : OUT std_logic_vector(31 DOWNTO 0); 
    -- from control
      A    : IN std_logic_vector(5 DOWNTO 0);
      AMux : IN std_logic;    
      B    : IN std_logic_vector(5 DOWNTO 0);
      BMux : IN std_logic;
      C    : IN std_logic_vector(5 DOWNTO 0);
      CMux : IN std_logic;
      Rd_M : IN std_logic;
      F    : IN std_logic_vector(3 DOWNTO 0);
    -- to control
      set_CC : OUT std_logic;
      CC  : OUT std_logic_vector(3 DOWNTO 0); -- N, Z, V, C resp. 3 downto 0
   --- instruction fields to control
      op  : OUT std_logic_vector(1 DOWNTO 0);
      op3 : OUT std_logic_vector(5 DOWNTO 0);
      bit13 : OUT std_logic  
    );
  END COMPONENT datapath;

  SIGNAL A, B, C : std_logic_vector(5 DOWNTO 0);
  SIGNAL AMux, BMux, CMux : std_logic;  
  SIGNAL Rd_Mi  : std_logic;
  SIGNAL F      : std_logic_vector(3 DOWNTO 0);
  SIGNAL set_CC : std_logic;
  SIGNAL CC     : std_logic_vector(3 DOWNTO 0); -- N, Z, V, C resp. 3 downto 0
  SIGNAL op     : std_logic_vector(1 DOWNTO 0);
  SIGNAL op3    : std_logic_vector(5 DOWNTO 0);  
  SIGNAL bit13  : std_logic;
 
BEGIN

  dp: datapath
    PORT MAP (
      Clk    => Clk,
      DataIn => DataIn,
      Dout   => Dout,
      Address=> Address,
    -- from control
      A      => A,
      AMux   => AMux,    
      B      => B,
      BMux   => BMux,
      C      => C,
      CMux   => CMux,
      Rd_M   => Rd_Mi,
      F      => F,
    -- to control
      set_CC => set_CC,
      CC     => CC,
   --- instruction fields to control
      op     => op,
      op3    => op3,
      bit13  => bit13  
    );
  
  ctrl: Control
    PORT MAP (
      Clk   => Clk,
      Reset => Reset,
      A     => A,
      AMux  => AMux,    
      B     => B,
      BMux  => BMux,
      C     => C,
      CMux  => CMux,
      Rd_M  => Rd_Mi,
      F     => F,
    -- from datapath
      set_CC => set_CC,
      CC     => CC,
    --- instruction fields to control
      op     => op,
      op3    => op3,
      bit13  => bit13,  
    -- 
      Wr_M   => Wr_M,
      Ack    => Ack
    );

  Rd_M <= Rd_Mi;
    
END ARCHITECTURE structure;
