LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;
LIBRARY work;
USE work.utilities.ALL;

ENTITY memory IS
  PORT (rd      	: IN std_logic;				-- if 1 you are reading
        wr		: IN std_logic;				-- if 1 you are writing
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
0 => "00abcdef",
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
		IF (b='1') AND (rd='1') THEN -- stores the selected memory adress in the 8 least significant bits of dataOut
			memory_data_out(7 DOWNTO 0) <= memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), to_integer(unsigned(address(1 DOWNTO 0))));
			memory_data_out(31 DOWNTO 8) <= (OTHERS => '0');
		ELSIF (b='1') AND (wr='1') THEN -- stores the 8 least significant bits of dataIn in memory at the selected adress.
			memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), to_integer(unsigned(address(1 DOWNTO 0)))) <= memory_data_in(7 DOWNTO 0);		
		ELSIF (b='0') AND (rd='1') THEN -- stores an entire word from memory in dataOut
			memory_data_out(31 DOWNTO 24) <= memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 3);
			memory_data_out(23 DOWNTO 16) <= memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 2);
			memory_data_out(15 DOWNTO 8) <= memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 1);
			memory_data_out(7 DOWNTO 0) <= memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 0);
		ELSIF (b='0') AND (wr='1') THEN -- stores dataIn in 4 sequential bytes in memory
			memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 3) <= memory_data_in(31 DOWNTO 24);
			memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 2) <= memory_data_in(23 DOWNTO 16);
			memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 1) <= memory_data_in(15 DOWNTO 8);
			memory_store_adr(to_integer(unsigned(address(8 DOWNTO 2))), 0) <= memory_data_in(7 DOWNTO 0);
		END IF;
	END IF;
END PROCESS;
END structure;