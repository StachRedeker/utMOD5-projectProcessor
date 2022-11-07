LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;
LIBRARY work;
USE work.utilities.ALL;

ENTITY memory IS
  PORT (ld      	: IN std_logic;				-- if 1 you are reading
        st		: IN std_logic;				-- if 1 you are writing
	b		: IN std_logic;				-- if 1 you are addressing bytes seperately
	address		: IN std_logic_vector(8 DOWNTO 0);	-- 7 bits for 128 blocks + 2 bits for 4 bytes per block
	memory_data_in	: IN std_logic_vector(31 DOWNTO 0);	-- input to the memory
	reset		: IN std_logic;				-- button 0 of FPGA
	clk		: IN std_logic;				-- clock of FPGA
        memory_data_out: OUT std_logic_vector(31 DOWNTO 0)	-- output of the memory
	);
END memory;

ARCHITECTURE structure OF memory IS
TYPE memory_store IS ARRAY (0 TO 127, 3 DOWNTO 0) OF std_logic_vector(7 DOWNTO 0);
TYPE program IS ARRAY (0 TO 127) OF string(8 DOWNTO 1);
SIGNAL i,j : integer := 0;
SIGNAL memory_store_adr : memory_store;
CONSTANT program_adr : program := (
0 => "000D8000",
1 => "000A24FF",
2 => "00086240",
3 => "00053E48",
4 => "000B2008",
5 => "00054040",
6 => "00044020",
7 => "000A0801",
8 => "000A1801",
9 => "000A1C01",
10 => "00043E28",
11 => "000A97FF",
12 => "00053E28",
13 => "00032C00",
14 => "000840C0",
15 => "000A48C0",
16 => "000A44C0",
17 => "00084040",
18 => "000A4840",
19 => "00084080",
20 => "000A4C80",
21 => "00001400",
22 => "0009D000",
23 => "00013A00",
24 => "0008D180",
25 => "00023400",
26 => "000849C0",
27 => "000B0801",
28 => "000A5C80",
29 => "000C2000",
30 => "000FFFFF",
31 => "00000000",
32 => "00000000",
OTHERS => "00000000"
);

BEGIN
PROCESS(clk, reset)
--	variable temp_line : line;
--	variable str : string(8 DOWNTO 1);
--	file read_file : text;
	BEGIN
	IF reset = '0' THEN
		memory_data_out <= (OTHERS =>'0');
--		file_open(read_file, "programs\test.txt", read_mode);
forloop1: 	FOR i IN 0 TO 127 LOOP -- stores the program from the defined file in main memory on reset (this would overwrite any changes thus reseting)
--			IF not endfile(read_file) THEN
--				readline(read_file, temp_line);
--				READ(temp_line, str);
--			ELSE
--			str := "00000000";
--			END IF;
forloop2:		FOR j IN 0 TO 3 LOOP
    				CASE j IS   
					WHEN 3 => memory_store_adr(i,j) <= hex2bin(program_adr(i)(8 DOWNTO 7));
					WHEN 2 => memory_store_adr(i,j) <= hex2bin(program_adr(i)(6 DOWNTO 5));
					WHEN 1 => memory_store_adr(i,j) <= hex2bin(program_adr(i)(4 DOWNTO 3));
					WHEN 0 => memory_store_adr(i,j) <= hex2bin(program_adr(i)(2 DOWNTO 1));		
				END CASE;
			END LOOP forloop2;
		END LOOP forloop1;
--		file_close(read_file);
 	ELSIF rising_edge(clk) THEN
		IF (b='1') AND (ld='1') THEN -- stores the selected memory adress in the 8 least significant bits of dataOut
			memory_data_out(7 DOWNTO 0) <= memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), to_integer(unsigned(address(1 DOWNTO 0))));
			memory_data_out(31 DOWNTO 8) <= (OTHERS => '0');
		ELSIF (b='1') AND (st='1') THEN -- stores the 8 least significant bits of dataIn in memory at the selected adress.
			memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), to_integer(unsigned(address(1 DOWNTO 0)))) <= memory_data_in(7 DOWNTO 0);		
		ELSIF (b='0') AND (ld='1') THEN -- stores an entire word from memory in dataOut
			memory_data_out(31 DOWNTO 24) <= memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 3);
			memory_data_out(23 DOWNTO 16) <= memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 2);
			memory_data_out(15 DOWNTO 8) <= memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 1);
			memory_data_out(7 DOWNTO 0) <= memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 0);
		ELSIF (b='0') AND (st='1') THEN -- stores dataIn in 4 sequential bytes in memory
			memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 3) <= memory_data_in(31 DOWNTO 24);
			memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 2) <= memory_data_in(23 DOWNTO 16);
			memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 1) <= memory_data_in(15 DOWNTO 8);
			memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 0) <= memory_data_in(7 DOWNTO 0);
		END IF;
	END IF;
END PROCESS;
END structure;
