ENTITY JFEGS IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC; --key0
        next_instruction_key : IN STD_LOGIC; --key1
        load_address_key : IN STD_LOGIC; --key2 
        sw : IN STD_LOGIC_VECTOR(9 DOWNTO 0); --sw 9-0

        --outputs
    );
END ENTITY JFEGS;

ARCHITECTURE structure OF JFEGS IS

    COMPONENT controller IS

        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            DEBUG : IN STD_LOGIC;
            DEBUG_NEXT : IN STD_LOGIC;
            ACK_data : IN STD_LOGIC;
            NewInstruction : IN STD_LOGIC;
            PCR : IN STD_LOGIC_VECTOR (3 DOWNTO 0); --(n,z,v,c)
            ALU : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            MEM : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            rs : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            rd : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            SIMM10 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
            IO : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            rr : OUT STD_LOGIC;
            Amux : OUT STD_LOGIC;
            Cmux : OUT STD_LOGIC;
            memory_data_out : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            address : IN STD_LOGIC_VECTOR(8 DOWNTO 0)
        );
    END COMPONENT controller;

    COMPONENT memory IS
        PORT (
            rd_bit : IN STD_LOGIC; -- if 1 you are reading
            wr_bit : IN STD_LOGIC; -- if 1 you are writing
            b : IN STD_LOGIC; -- if 1 you are addressing bytes seperately
            address : IN STD_LOGIC_VECTOR(8 DOWNTO 0); -- 7 bits for 128 blocks + 2 bits for 4 bytes per block
            memory_data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- input to the memory
            reset : IN STD_LOGIC; -- button 0 of FPGA
            clk : IN STD_LOGIC; -- clock of FPGA
            memory_data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output of the memory
        );
    END COMPONENT memory;

    COMPONENT datapath IS
        PORT (
            clk : IN STD_LOGIC;
            memory_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- from the data memory
            reset : IN STD_LOGIC;
            -- from the control unit
            rd : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            AMux : IN STD_LOGIC;
            rs : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            CMux : IN STD_LOGIC;
            IO : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            ALU : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            rr : IN STD_LOGIC;
            SIMM10 : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            -- to the control unit
            PCR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- N, Z, V, C resp. 3 downto 0
            --Op1 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            --Op2 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            ACK_data : OUT STD_LOGIC;
            -- to the data memory
            memory_data_in : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

            NewInstruction : OUT STD_LOGIC;
        );
    END COMPONENT datapath;

    COMPONENT debugging IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC; --key0
            next_instruction_key : IN STD_LOGIC; --key1
            load_address_key : IN STD_LOGIC; --key2
            AMux : IN STD_LOGIC;
            Cmux : IN STD_LOGIC;
            sw : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            PCR : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            memory_data_out : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            DEBUG_NEXT : OUT STD_LOGIC;
        );
    END COMPONENT debugging;

    SIGNAL DEBUG_NEXT : STD_LOGIC;
    SIGNAL ACK_data : STD_LOGIC;
    SIGNAL NewInstruction : STD_LOGIC;
    SIGNAL PCR : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL ALU : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL MEM : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL rd_bit : STD_LOGIC;
    SIGNAL wr_bit : STD_LOGIC;
    SIGNAL b : STD_LOGIC;
    SIGNAL rs : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL rd : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL SIMM10 : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL IO : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL rr : STD_LOGIC;
    SIGNAL AMux : STD_LOGIC;
    SIGNAL CMux : STD_LOGIC;
    SIGNAL memory_data_out : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL memory_data_in : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL address : STD_LOGIC_VECTOR(8 DOWNTO 0);
BEGIN

    cntr : controller PORT MAP(clk, reset, DEBUG, DEBUG_NEXT, ACK_data, NewInstruction, PCR, ALU, MEM, rs, rd, SIMM10, IO, rr, Amux, Cmux, memory_data_out, address );
    b <= MEM(2);
    wr_bit <= MEM(1);
    rd_bit <= MEM(0);
    memo : memory PORT MAP(rd_bit, wr_bit, b, address, memory_data_in, reset, clk, memory_data_out);
    
    dp : datapath PORT MAP(clk, dataIn, reset, rd, AMux, rs, CMux, IO, ALU, rr, SIMM10, PCR, ACK_data, dataMemoryOut, NewInstruction);
    db : debugging PORT MAP(clk, reset, next_instruction_key, load_address_key, AMux, Cmux, sw, PCR, memory_data_out, DEBUG_NEXT);

    
    
    

END structure;