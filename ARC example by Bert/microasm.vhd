--------------------------------------------------------------
-- Project          : VHDL description of ARC processor (chapter 5)
--                    "Computer Architecture and Organisation" (ISBN 978-0-471-73388-1) by Murdocca and Heuring
-- 
-- File             : microasm.vhd
--
-- Related File(s)  : 
--
-- Author           : E. Molenkamp, University of Twente, the Netherlands
-- Email            : e.molenkamp@utwente.nl
-- 
-- Project          : Computer Organization
-- Creation Date    : 27 June 2008
-- 
-- Contents         :  simple micro assembler
--                    - lines that start with / are comment
--                    - ORG <line counter>; memory location in microstore where the next data
--                       line (=micro instruction) is storen
--                    - a line with at least 41 zero/ones data stored at <line counter> ;  <line counter> is incremented
--                    - MINIMAL error control!!
--                    
--                    Inputfile is generic datafile; generated architecture for microstore is vhdl_architecture; 
-- Notes: 
-- 1.  WRITE (out_line,string'("BEGIN")    the qualification is required because the string is not evaluated during compilation; e.g. als0 bit_vector is then possible!
-- 2.  To print the quotation mark (")  write "" (twice)
--
-- Change Log 
--   Author         : 
--   Email          : 
--   Date           :  
--   Changes        :
--

ENTITY microasm IS
  GENERIC (datafile : string := "MicroStore.asm";
           vhdl_architecture : string := "microstore_bhv.vhd";
           generate_architecture : boolean := TRUE); -- complete archtecture is generated (if false only memory contents)
END microasm;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
ARCHITECTURE bhv OF microasm IS
BEGIN
  PROCESS
    TYPE mem_tp IS ARRAY (0 TO 2047) OF std_logic_vector(40 DOWNTO 0);
    VARIABLE mem : mem_tp := (OTHERS=>(OTHERS=>'-'));
    VARIABLE loc_cnt : NATURAL := 0;
    FILE in_data : text OPEN read_mode IS datafile;
    VARIABLE inp_line : line;
    VARIABLE char : character;
    VARIABLE mword : std_logic_vector(40 DOWNTO 0);
    VARIABLE line_input : integer;

    FILE out_data : text OPEN write_mode IS vhdl_architecture;
    VARIABLE out_line : line;	
	
    FUNCTION char2slv (inp : character) RETURN std_logic IS
    BEGIN
      IF inp='0' THEN RETURN '0'; 
      ELSIF inp='1' THEN RETURN '1';
      ELSE REPORT "error in char2slv" SEVERITY failure; RETURN 'X';
      END IF;
    END char2slv;
	
    FUNCTION slv2string (inp : std_logic_vector) RETURN string IS
      VARIABLE inp_i : std_logic_vector(1 TO inp'LENGTH);
      VARIABLE res   : string (1 TO inp'LENGTH);
    BEGIN
      inp_i := inp;
      FOR i IN inp_i'RANGE LOOP
        IF    inp_i(i)='0' THEN res(i):='0';
        ELSIF inp_i(i)='1' THEN res(i):='1';
        ELSE                    res(i):='-';
        END IF;
      END LOOP;
    RETURN res;
  END slv2string;
	
  FUNCTION integer_img (inp : integer; length : integer := 4) RETURN string IS
    VARIABLE res : string(1 TO length);
    VARIABLE L : integer;
  BEGIN
    l := integer'image(inp)'length;
    IF length>=l THEN
      res := (length-l DOWNTO 1 => ' ')&integer'image(inp);
    ELSE
      res := (OTHERS=>'X');
      REPORT "image integer does not fit!" SEVERITY error;
    END IF;
    RETURN res;
  END integer_img;
	
  BEGIN
    -- READ data from file
	line_input:=0;
    WHILE NOT endfile(in_data) LOOP
      line_input:=line_input+1;	
      READLINE (in_data, inp_line); 
      READ(inp_line,char); -- read first character
      IF char='0' OR char='1' THEN  -- valid microstore
        mword(40) := char2slv(char);
        FOR i IN 39 DOWNTO 0 LOOP  -- no checks included in length
          READ(inp_line,char); mword(i):=char2slv(char);
        END LOOP;
        ASSERT mem(loc_cnt)=(mword'RANGE=>'-') REPORT "overriding microstore address " & integer'image(loc_cnt) SEVERITY warning;
        mem(loc_cnt):=mword;
        loc_cnt := loc_cnt+1;
      ELSIF char = 'O' THEN -- ORG
        READ(inp_line,char); ASSERT char='R' REPORT "line "&integer'image(line_input)& ": Expecting ORG" SEVERITY failure;
        READ(inp_line,char); ASSERT char='G' REPORT "line "&integer'image(line_input)& ": Expecting ORG" SEVERITY failure;		
        READ(inp_line,loc_cnt); -- line number
      ELSIF char = '/' THEN -- comment; ignore line
        NULL;
      ELSE
        REPORT "line "&integer'image(line_input)& ": unexpected input" SEVERITY failure;      
      END IF;
    END LOOP;
    -- WRITE file
    IF generate_architecture THEN
      WRITE (out_line,string'("ARCHITECTURE behaviour OF MicroStore IS")); WRITELINE(out_data,out_line);
      WRITE (out_line,string'("  TYPE CS_type IS ARRAY (0 TO 2047) OF std_logic_vector(40 DOWNTO 0);")); WRITELINE(out_data,out_line);
      WRITE (out_line,string'("  CONSTANT CStore : CS_type := (")); WRITELINE(out_data,out_line);	  
      FOR i IN 0 TO 2046 LOOP
        WRITE(out_line,integer_img(i,8) & " => """ & slv2string(mem(i)) & ""","); WRITELINE(out_data,out_line);
      END LOOP;
      WRITE(out_line,integer_img(2047,8) & " => """ & slv2string(mem(2047)) & """);" ); WRITELINE(out_data,out_line);		  
      WRITE (out_line,string'("BEGIN")); WRITELINE(out_data,out_line);	 
      WRITE (out_line,string'("  microcode <=  CStore(to_integer(unsigned(address)));")); WRITELINE(out_data,out_line);	  
      WRITE (out_line,string'("END ARCHITECTURE behaviour;")); WRITELINE(out_data,out_line);		  
    ELSE
      FOR i IN 0 TO 2047 LOOP
        WRITE(out_line,integer_img(i,8) & " => " & slv2string(mem(i)));	  
        WRITELINE(out_data,out_line);	
      END LOOP;
    END IF;
    WAIT;
  END PROCESS;
END bhv;
