--------------------------------------------------------------
-- Project          : VHDL description of ARC processor (chapter 5)
--                    "Computer Architecture and Organisation" (ISBN 978-0-471-73388-1) by Murdocca and Heuring
-- 
-- File             : control.vhd
--
-- Related File(s)  : utilities.vhd, microstore.vhd
--
-- Author           : E. Molenkamp, University of Twente, the Netherlands
-- Email            : e.molenkamp@utwente.nl
-- 
-- Project          : Computer Organization
-- Creation Date    : 27 June 2008
-- 
-- Contents         : controller
--
--   -- Discussion; fig. 5-10, p. 161
--   CSAI is not indicated register sensitive to the clock unit.
--   If "Next" (00) is selected then a combinational loop will occur (CASI with "CS address MUX" unit)
--   In this VHDL description CSAI_inc is a register.
-- 
--   If ACK is an asynchronous signal it needs (at least) 2 flipflops in cascade for
--   synchronization, and for  metastability. In this design ACk is ignored, it is assumed that
--   the main memory is fast enough.
--
--   The procedure show_instruction shows the instruction that is executed.
--   The ARCTools generates FFFFFFFF for the HALT instruction=>this is micro address 11111111100= 2044(dec)
--   Simulation will automatically stop. Be sure that this micro address is not used in the microstore.
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
ENTITY Control IS
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
END ENTITY Control;

ARCHITECTURE structure OF Control IS
  COMPONENT microstore IS
    PORT (address : IN std_logic_vector(10 DOWNTO 0);
          microcode : OUT std_logic_vector(40 DOWNTO 0));
  END COMPONENT microstore;
  
  ALIAS op2 : std_logic_vector(2 DOWNTO 0) IS op3(5 DOWNTO 3);
  
  SIGNAL MicroInst : std_logic_vector(40 DOWNTO 0);
  
  ALIAS Cond : std_logic_vector(2 DOWNTO 0) IS MicroInst(13 DOWNTO 11);  
  ALIAS JmpA : std_logic_vector(10 DOWNTO 0) IS MicroInst(10 DOWNTO 0);  
    
  SIGNAL address : std_logic_vector(10 DOWNTO 0);
  SIGNAL CSAI_inc : std_logic_vector(10 DOWNTO 0);
  SIGNAL sel_na  : std_logic_vector(1 DOWNTO 0);

  SIGNAL IMir : std_logic_vector(40 DOWNTO 0);
  SIGNAL PSR  : std_logic_vector(3 DOWNTO 0);
  
  PROCEDURE show_instruction(address : std_logic_vector(10 DOWNTO 0)) IS
    CONSTANT a : integer := to_integer(unsigned(address));
  BEGIN
    CASE a IS
      WHEN  1152 => REPORT "instruction SETHI" SEVERITY note; 
      WHEN  1280 => REPORT "instruction CALL" SEVERITY note; 	  
      WHEN  1600 => REPORT "instruction ADDCC" SEVERITY note; 	  
      WHEN  1604 => REPORT "instruction ANDCC" SEVERITY note; 	  
      WHEN  1608 => REPORT "instruction ORCC" SEVERITY note; 
-- added exercise 5-14
      WHEN  1612 => REPORT "instruction XORCC" SEVERITY note;
-- end added	  
      WHEN  1624 => REPORT "instruction ORNCC" SEVERITY note; 	  
      WHEN  1688 => REPORT "instruction SRL" SEVERITY note; 	  
      WHEN  1760 => REPORT "instruction JMPL" SEVERITY note; 
      WHEN  1792 => REPORT "instruction LD" SEVERITY note; 	  
      WHEN  1808 => REPORT "instruction ST" SEVERITY note;
      WHEN  1088 => REPORT "instruction BRANCH: ba, be, bcs, bvs, bneg" SEVERITY note; 
      WHEN  2044 => REPORT "HALT instruction? simulation stopped" SEVERITY failure; 
                    -- The HALT instruction is FFFFFFFF. Due to the decoding
                    -- rules (fig. 5-13, pag. 163) the address is (2^9-1)*4=2044
                    -- This is a valid microadres! Currently this address is not used.
      WHEN  OTHERS => REPORT "illegal/unknown instruction" SEVERITY warning;
    END CASE;
  END show_instruction;

  SIGNAL Rd_M_i, Wr_M_i : std_logic;
  
BEGIN

  ControlMemory: microstore PORT MAP (address, IMir);
  
  MIR:PROCESS(reset,clk)
  BEGIN
    IF reset='0' THEN
      MicroInst <= (OTHERS=>'0');
    ELSIF falling_edge(clk) THEN
      MicroInst <= IMir;
    END IF;
  END PROCESS;  
  
  A      <= MicroInst(40 DOWNTO 35);
  AMux   <= MicroInst(34);
  B      <= MicroInst(33 DOWNTO 28);
  BMux   <= MicroInst(27);
  C      <= MicroInst(26 DOWNTO 21);
  CMux   <= MicroInst(20);
  Rd_M_i <= MicroInst(19);
  Wr_M_i <= MicroInst(18);
  F      <= MicroInst(17 DOWNTO 14); 

  Rd_M <= Rd_M_i;
  Wr_M <= Wr_M_i;  
  
  CSAI:PROCESS(reset,clk)
  BEGIN
    IF reset='0' THEN
      CSAI_inc <= (OTHERS=>'0');
    ELSIF falling_edge(clk) THEN
      CSAI_inc <= std_logic_vector(unsigned(address)+1);
      -- for debugging only
      IF sel_na="10" THEN show_instruction(address); END IF; -- for debugging; shows name of instruction in transcript window
      -- END FOR debugging only		
    END IF;
  END PROCESS;  
  
  NextAdress:PROCESS(sel_na,CSAI_inc, JmpA,op,op3)
  BEGIN
    CASE sel_na IS
      WHEN "00"   => address <= CSAI_inc;  -- next address
      WHEN "01"   => address <= JmpA; -- jump address;
      WHEN OTHERS => 
        CASE op IS -- fig. 5-13 page 163
          WHEN "00"   => address <= '1' & op & op2 & "000" & "00"; -- sethi/branch
          WHEN "01"   => address <= '1' & op & "000000"    & "00"; -- call 
          WHEN OTHERS => address <= '1' & op & op3         & "00"; -- arith/memory
        END CASE;
    END CASE;
  END PROCESS;  
  
  PSR_reg: PROCESS(reset,clk)
  BEGIN
    IF reset='0' THEN
      PSR <= (OTHERS=>'0');
    ELSIF falling_edge(clk) THEN
      IF set_cc='1' THEN
        PSR <= CC;
      END IF;
    END IF;
  END PROCESS;
  
  CBL:PROCESS(PSR,Cond,bit13)
  BEGIN
    CASE Cond IS
      WHEN "000"  => sel_na <= "00"; -- next address
      WHEN "001"  => IF PSR(3)='1' THEN sel_na<="01"; ELSE sel_na<="00"; END IF; -- jump if N
      WHEN "010"  => IF PSR(2)='1' THEN sel_na<="01"; ELSE sel_na<="00"; END IF; -- jump if Z
      WHEN "011"  => IF PSR(1)='1' THEN sel_na<="01"; ELSE sel_na<="00"; END IF; -- jump if V
      WHEN "100"  => IF PSR(0)='1' THEN sel_na<="01"; ELSE sel_na<="00"; END IF; -- jump if C
      WHEN "101"  => IF bit13 ='1' THEN sel_na<="01"; ELSE sel_na<="00"; END IF; -- jump if immediate
      WHEN "110"  => sel_na<="01"; -- jump always
      WHEN OTHERS => sel_na<="10"; -- decode instruction
    END CASE;
  END PROCESS;
  
END ARCHITECTURE structure;