--------------------------------------------------------------
-- Project          : VHDL description of ARC processor (chapter 5)
--                    "Computer Architecture and Organisation" (ISBN 978-0-471-73388-1) by Murdocca and Heuring
-- 
-- File             : datapath.vhd
--
-- Related File(s)  : utilities.vhd, registerfile.vhd
--
-- Author           : E. Molenkamp, University of Twente, the Netherlands
-- Email            : e.molenkamp@utwente.nl
-- 
-- Project          : Computer Organization
-- Creation Date    : 27 June 2008
-- 
-- Contents         : datapath ARC
--
-- Change Log 
--   Author         : E.Molenkamp
--   Email          : e.molenkamp@utwente.nl
--   Date           : 21 October 2008
--   Changes        : IF ALU_outp_with_carry=(ALU_outp_with_carry'RANGE=>'0') THEN CC_Z<='1'; ELSE CC_Z<= '0'; END IF; is changed in
--                    IF ALU_outp_with_carry(31 DOWNTO 0)=(31 DOWNTO 0=>'0')  THEN CC_Z<='1'; ELSE CC_Z<= '0'; END IF;
--
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.utilities.ALL;
ENTITY datapath IS
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
END ENTITY datapath;

ARCHITECTURE structure OF datapath IS

  COMPONENT registerfile IS
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
  END COMPONENT registerfile;
  
  SIGNAL BusA, BusB, BusC, IR : std_logic_vector(31 DOWNTO 0);
  SIGNAL SelA, SelB, SelC : std_logic_vector(5 DOWNTO 0);
  
  SIGNAL ALU_outp_with_carry : std_logic_vector(32 DOWNTO 0); -- additional bit for carry
  ALIAS CC_N : std_logic IS CC(3);
  ALIAS CC_Z : std_logic IS CC(2);
  ALIAS CC_V : std_logic IS CC(1);
  ALIAS CC_C : std_logic IS CC(0);  
  
  SIGNAL rd  : std_logic_vector(4 DOWNTO 0);
  SIGNAL rs1 : std_logic_vector(4 DOWNTO 0);
  SIGNAL rs2 : std_logic_vector(4 DOWNTO 0);  
BEGIN

  reg_file: registerfile
    PORT MAP(Clk,BusA,SelA,BusB,SelB,BusC,SelC,IR);

  SelA <= ('0'&rs1) WHEN AMux='1' ELSE A;
  SelB <= ('0'&rs2) WHEN BMux='1' ELSE B;  
  SelC <= ('0'&rd)  WHEN CMux='1' ELSE C;

  --- IR fields (alternative is an ALIAS)
  op    <= IR(31 DOWNTO 30);
  rd    <= IR(29 DOWNTO 25);
  op3   <= IR(24 DOWNTO 19);
  rs1   <= IR(18 DOWNTO 14);
  rs2   <= IR( 4 DOWNTO  0);
  bit13 <= IR(13); 
 
  -- functional description of ALU; not written for optimal synthesis result
  ALU:PROCESS(F,BusA,BusB)
  BEGIN
    ALU_outp_with_carry(32)<='0'; -- default case
    CASE F IS
      WHEN "0000" => ALU_outp_with_carry (31 DOWNTO 0)<= BusA AND BusB; 
      WHEN "0001" => ALU_outp_with_carry (31 DOWNTO 0)<= BusA OR BusB; 
      WHEN "0010" => ALU_outp_with_carry (31 DOWNTO 0)<= BusA OR NOT(BusB); 
      WHEN "0011" => ALU_outp_with_carry <= std_logic_vector(resize(signed(BusA),33)+signed(BusB));     
      WHEN "0100" => ALU_outp_with_carry (31 DOWNTO 0)<= std_logic_vector(shift_right(unsigned(BusA),to_integer(unsigned(BusB(4 DOWNTO 0)))));
      WHEN "0101" => ALU_outp_with_carry (31 DOWNTO 0)<= BusA AND BusB; 
      WHEN "0110" => ALU_outp_with_carry (31 DOWNTO 0)<= BusA OR BusB;  
      WHEN "0111" => ALU_outp_with_carry (31 DOWNTO 0)<= BusA OR NOT(BusB);  
      WHEN "1000" => ALU_outp_with_carry <= std_logic_vector(resize(signed(BusA),33)+signed(BusB));  
      WHEN "1001" => ALU_outp_with_carry (31 DOWNTO 0)<= std_logic_vector(shift_left(unsigned(BusA),2));  
      WHEN "1010" => ALU_outp_with_carry (31 DOWNTO 0)<= std_logic_vector(shift_left(unsigned(BusA),10));
      WHEN "1011" => ALU_outp_with_carry (31 DOWNTO 0)<=std_logic_vector(resize(unsigned(BusA(12 DOWNTO 0)),32));
      WHEN "1100" => ALU_outp_with_carry (31 DOWNTO 0)<=std_logic_vector(resize(signed(BusA(12 DOWNTO 0)),32));
      WHEN "1101" => ALU_outp_with_carry <= std_logic_vector(resize(signed(BusA),33)+1);
      WHEN "1110" => ALU_outp_with_carry <= std_logic_vector(resize(signed(BusA),33)+4);
      WHEN OTHERS => ALU_outp_with_carry (31 DOWNTO 0)<= std_logic_vector(shift_right(signed(BusA),5));
    END CASE;
  END PROCESS alu;

  status_bits:PROCESS(ALU_outp_with_carry,F,BusA,BusB)
  BEGIN
    IF to_integer(unsigned(F))<4 THEN -- set CC
      set_CC<='1';
      CC_N <= ALU_outp_with_carry(31); 
      IF ALU_outp_with_carry(31 DOWNTO 0)=(31 DOWNTO 0=>'0') THEN CC_Z<='1'; ELSE CC_Z<= '0'; END IF;
      IF (BusA(31)=BusB(31)) AND (busA(31)/=ALU_outp_with_carry(31)) THEN CC_V <='1'; ELSE CC_V<='0'; END IF;
      CC_C <= ALU_outp_with_carry(32);    
  ELSE
    set_CC<='0';
    CC <= (OTHERS=>'-');
  END IF;
  END PROCESS status_bits;
  
  BusC <= ALU_outp_with_carry(31 DOWNTO 0) WHEN Rd_M='0' ELSE DataIn;
  
  Dout <= BusB;
  Address <= BusA;
    
END ARCHITECTURE structure;
