LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
ENTITY datapath IS
    PORT (
        clk : IN STD_LOGIC;
        dataIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        -- from the control unit
        A : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        AMux : IN STD_LOGIC;
        C : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        CMux : IN STD_LOGIC;
        rd : IN STD_LOGIC;
        -- wr : IN STD_LOGIC;
        F : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

        -- to the control unit
        set_CC : OUT STD_LOGIC;
        CC : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- N, Z, V, C resp. 3 downto 0
        op : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        op3 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        --  bit13 : OUT STD_LOGIC;

        dataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        AddressOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY datapath;

ARCHITECTURE structure OF datapath IS

    COMPONENT registerfile IS
        PORT (
            clk : IN STD_LOGIC;
            BusC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            SelC : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            SelA : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
            BusA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            IR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT registerfile;

    SIGNAL BusA, BusC, IR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SelA, SelC : STD_LOGIC_VECTOR(4 DOWNTO 0);

    SIGNAL ALU_output_with_carry : STD_LOGIC_VECTOR(32 DOWNTO 0); -- an additional bit for the carry
    ALIAS CC_N : STD_LOGIC IS CC(3);
    ALIAS CC_Z : STD_LOGIC IS CC(2);
    ALIAS CC_V : STD_LOGIC IS CC(1);
    ALIAS CC_C : STD_LOGIC IS CC(0);

    SIGNAL rd1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL rs1 : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN

    reg_file : registerfile
    PORT MAP(clk, BusC, SelC, SelA, BusA, IR);

    SelA <= (rs1) WHEN AMux = '1' ELSE
        A;
    SelC <= (rd1) WHEN CMux = '1' ELSE
        C;

    op <= IR(31 DOWNTO 30);
    rd1 <= IR(29 DOWNTO 25);
    op3 <= IR(24 DOWNTO 19);
    rs1 <= IR(18 DOWNTO 14);
    -- bit13 <= IR(13);

    --alu working
    ALU : PROCESS (F, BusA, BusC)
    BEGIN
        ALU_output_with_carry(32) <= '0'; -- default case
        CASE F IS
            WHEN "0000" => ALU_output_with_carry (31 DOWNTO 0) <= BusA AND BusC; --ANDCC
            WHEN "0001" => ALU_output_with_carry (31 DOWNTO 0) <= BusA OR BusC; --ORCC
            WHEN "0011" => ALU_output_with_carry <= STD_LOGIC_VECTOR(resize(signed(BusA), 33) + signed(BusC)); --ADD
            WHEN "0100" => ALU_output_with_carry (31 DOWNTO 0) <= STD_LOGIC_VECTOR(shift_right(unsigned(BusA), to_integer(unsigned(BusC(4 DOWNTO 0))))); --Shift right
            WHEN OTHERS => ALU_output_with_carry (31 DOWNTO 0) <= (31 DOWNTO 0 => '0');
        END CASE;
    END PROCESS ALU;

    --assigning the status bits
    status_bits : PROCESS (ALU_output_with_carry, F, BusA, BusC)
    BEGIN
        IF to_integer(unsigned(F)) < 4 THEN -- set CC
            set_CC <= '1';
            CC_N <= ALU_output_with_carry(31);

            IF ALU_output_with_carry(31 DOWNTO 0) = (31 DOWNTO 0 => '0') THEN
                CC_Z <= '1';
            ELSE
                CC_Z <= '0';
            END IF;

            IF (BusA(31) = BusC(31)) AND (BusA(31) /= ALU_output_with_carry(31)) THEN
                CC_V <= '1';
            ELSE
                CC_V <= '0';
            END IF;

            CC_C <= ALU_output_with_carry(32);
        ELSE
            set_CC <= '0';
            CC <= (OTHERS => '-');
        END IF;
    END PROCESS status_bits;

    BusC <= ALU_output_with_carry(31 DOWNTO 0) WHEN rd = '0' ELSE
        dataIn;

    dataOut <= BusC;
    AddressOut <= BusA;

END ARCHITECTURE structure;