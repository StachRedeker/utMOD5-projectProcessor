LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
ENTITY memory IS
  PORT (rd      	: IN std_logic;
        wr		: IN std_logic;
	b		: IN std_logic;
	adress		: IN std_logic_vector(8 DOWNTO 0); -- 7 bits for 128 blocks .
	dataIn	        : IN std_logic_vector(31 DOWNTO 0);
	reset		: IN std_logic;
	clk		: IN std_logic;
        dataOut	 	: OUT std_logic_vector(31 DOWNTO 0)
	);
END memory;

ARCHITECTURE structure OF memory IS
TYPE memory_store IS ARRAY (127 DOWNTO 0, 3 DOWNTO 0) OF std_logic_vector(7 DOWNTO 0);
SIGNAL memory_store_adr : memory_store;
SIGNAL temp0 : std_logic_vector(7 DOWNTO 0);
SIGNAL temp1 : std_logic_vector(7 DOWNTO 0);
SIGNAL temp2 : std_logic_vector(7 DOWNTO 0);
SIGNAL temp3 : std_logic_vector(7 DOWNTO 0);
BEGIN
	PROCESS(clk, reset)
	BEGIN
	IF reset = '0' THEN
		dataOut <= (OTHERS =>'0');
		-- change program counter to 0
	ELSIF rising_edge(clk) THEN
		-- Make byte adressable memory and have the rest be adress +1, +2, +3
		-- other option is making extra instructions for byte adressing 
		IF (rd ='1') AND (to_integer(unsigned(adress(8 DOWNTO 2)))<=100) THEN
			temp0 <= memory_store_adr(to_integer(unsigned(adress(8 DOWNTO 2))), 0);
			temp1 <= memory_store_adr(to_integer(unsigned(adress(8 DOWNTO 2))), 1);
			temp2 <= memory_store_adr(to_integer(unsigned(adress(8 DOWNTO 2))), 2);
			temp3 <= memory_store_adr(to_integer(unsigned(adress(8 DOWNTO 2))), 3);
			dataOut <= temp3 & temp2 & temp1 & temp0;
		ELSIF (rd ='1') AND (to_integer(unsigned(adress(8 DOWNTO 2)))> 100) THEN
			dataOut <= memory_store_adr(to_integer(unsigned(adress(8 DOWNTO 2))), to_integer(unsigned(adress(1 DOWNTO 0))));
		ELSIF (wr ='1') AND (to_integer(unsigned(adress(8 DOWNTO 2)))> 100) THEN
			memory_store_adr(to_integer(unsigned(adress(8 DOWNTO 2))), to_integer(unsigned(adress(1 DOWNTO 0)))) <= dataIn;		
		END IF;
	END IF;
	END PROCESS;
END structure;
