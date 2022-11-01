LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY controller IS
   PORT (
	clk : IN std_logic;
	reset : IN std_logic;
	PSR : IN std_logic_vector (3 DOWNTO 0);
	MemString : IN std_logic_vector (31 DOWNTO 0)
        );
END ENTITY controller;

ARCHITECTURE bhv OF controller IS
SIGNAL PC : integer := 0;
SIGNAL halt : std_logic := '0';
SIGNAL rs : std_logic_vector(3 DOWNTO 0);
SIGNAL rd : std_logic_vector(3 DOWNTO 0);
SIGNAL Op1 : std_logic_vector (1 DOWNTO 0) := MemString(19 DOWNTO 18); 
SIGNAL Op2 : std_logic_vector (1 DOWNTO 0) := MemString(17 DOWNTO 16);
SIGNAL cc : std_logic;
BEGIN

decode: PROCESS(clk,reset)
  BEGIN
IF (reset = '0') THEN 
	PC<= 0;
	halt <= '0'; 
ELSIF (rising_edge(clk)) AND (halt = '0') THEN 
	IF (Op1 = "00") THEN --Branch Instructions
		CASE Op2 IS 
			WHEN "00" => PC <= to_integer(unsigned(MemString(15 DOWNTO 9))); --Ba
			WHEN "01" => IF (PSR(2) = '1') THEN --Be is z = 1
					PC <= to_integer(unsigned(MemString(15 DOWNTO 9)));
				     END IF;
			WHEN "10" => IF (PSR(2) = '0') THEN --Bne if z = 0
					PC <= to_integer(unsigned(MemString(15 DOWNTO 9)));
				     END IF;
			WHEN "11" => IF (PSR(3) = '1') THEN --Bneg if n = 1
					PC <= to_integer(unsigned(MemString(15 DOWNTO 9)));
				     END IF;
			WHEN OTHERS => REPORT "Warning, current instruction is unknown" SEVERITY warning;
		END CASE;
	ELSIF (Op1 = "01") THEN --Memory Instructions
		rd <= MemString(6 DOWNTO 3);
		PC <= to_integer(unsigned(MemString(15 DOWNTO 9)));
		CASE Op2 IS
			WHEN "00" => -- ld 
			WHEN "01" => -- st
			WHEN "10" => -- ldb
			WHEN "11" => -- stb
			WHEN OTHERS => REPORT "Warning unknown condition" SEVERITY warning;
		END CASE;
	ELSIF (Op1 = "10") THEN --Arithmetic non status
	cc <= MemString(15);
	rs <= MemString(14 DOWNTO 11);
	rd <= MemString(10 DOWNTO 7);
		IF (cc = '0') THEN 
			CASE Op2 IS 
				WHEN "00" => --AND 
				WHEN "01" => --OR
				WHEN "10" => --ADD
				WHEN "11" => --SHIFT
				WHEN OTHERS => REPORT "Warning unknown condition" SEVERITY warning;
			END CASE;
		ELSIF (cc = '1') THEN
			CASE Op2 IS
				WHEN "00" => --ANDcc
				WHEN "01" => --ORcc
				WHEN "10" => --ADDcc
				WHEN "11" => --SHIFT
				WHEN OTHERS => REPORT "Warning unknown condition" SEVERITY warning;
			END CASE;
		END IF;
	ELSIF (Op1 = "11") THEN --Miscellaneous Instructions
		CASE Op2 IS 
			WHEN "00" => --Display
				rs <= MemString(15 DOWNTO 12);
			WHEN "01" => --ReadI/O
				rd <= MemString(15 DOWNTO 12);
			WHEN "11" => --HALT
				halt <= '1';
			WHEN OTHERS => REPORT "Warning unknown condition" SEVERITY warning;
		END CASE;	
	END IF;
	PC <= PC + 4;
END IF;
  END PROCESS decode;
END ARCHITECTURE bhv;
