-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

-- DATE "11/04/2022 11:57:25"

-- 
-- Device: Altera 5CSEMA5F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	controller IS
    PORT (
	clk : IN std_logic;
	reset : IN std_logic;
	NewInstruction : IN std_logic;
	PSR : IN std_logic_vector(3 DOWNTO 0);
	ALU : OUT std_logic_vector(2 DOWNTO 0);
	MEM : OUT std_logic_vector(2 DOWNTO 0);
	rs : OUT std_logic_vector(3 DOWNTO 0);
	rd : OUT std_logic_vector(3 DOWNTO 0);
	SIMM10 : OUT std_logic_vector(9 DOWNTO 0);
	IO : OUT std_logic_vector(1 DOWNTO 0);
	rr : OUT std_logic;
	Amux : OUT std_logic;
	Cmux : OUT std_logic;
	MemString : IN std_logic_vector(31 DOWNTO 0)
	);
END controller;

-- Design Ports Information
-- PSR[0]	=>  Location: PIN_Y16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PSR[1]	=>  Location: PIN_G13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PSR[2]	=>  Location: PIN_AB13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PSR[3]	=>  Location: PIN_AF11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU[0]	=>  Location: PIN_W22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU[1]	=>  Location: PIN_AB21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ALU[2]	=>  Location: PIN_Y21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MEM[0]	=>  Location: PIN_AF20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MEM[1]	=>  Location: PIN_AE26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MEM[2]	=>  Location: PIN_W20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rs[0]	=>  Location: PIN_AK24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rs[1]	=>  Location: PIN_AK26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rs[2]	=>  Location: PIN_AJ26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rs[3]	=>  Location: PIN_AJ24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rd[0]	=>  Location: PIN_AF24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rd[1]	=>  Location: PIN_AC20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rd[2]	=>  Location: PIN_AK23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rd[3]	=>  Location: PIN_AD19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SIMM10[0]	=>  Location: PIN_AC22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SIMM10[1]	=>  Location: PIN_AG26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SIMM10[2]	=>  Location: PIN_Y19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SIMM10[3]	=>  Location: PIN_AC23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SIMM10[4]	=>  Location: PIN_AD20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SIMM10[5]	=>  Location: PIN_W21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SIMM10[6]	=>  Location: PIN_AD21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SIMM10[7]	=>  Location: PIN_AE22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SIMM10[8]	=>  Location: PIN_AF25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- SIMM10[9]	=>  Location: PIN_AA20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- IO[0]	=>  Location: PIN_AA21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- IO[1]	=>  Location: PIN_AD24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rr	=>  Location: PIN_AE24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Amux	=>  Location: PIN_AD27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Cmux	=>  Location: PIN_AJ22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[20]	=>  Location: PIN_A11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[21]	=>  Location: PIN_G8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[22]	=>  Location: PIN_AG11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[23]	=>  Location: PIN_AK22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[24]	=>  Location: PIN_C9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[25]	=>  Location: PIN_B12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[26]	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[27]	=>  Location: PIN_W17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[28]	=>  Location: PIN_AH2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[29]	=>  Location: PIN_V25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[30]	=>  Location: PIN_AG22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[31]	=>  Location: PIN_H12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- NewInstruction	=>  Location: PIN_AH29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[16]	=>  Location: PIN_AH27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[15]	=>  Location: PIN_AB22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[17]	=>  Location: PIN_AD25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_Y27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[18]	=>  Location: PIN_AH28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[19]	=>  Location: PIN_AG27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_AK29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[12]	=>  Location: PIN_Y18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[3]	=>  Location: PIN_V18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[10]	=>  Location: PIN_AF23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[14]	=>  Location: PIN_AK28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[13]	=>  Location: PIN_AJ25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[4]	=>  Location: PIN_W19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[11]	=>  Location: PIN_AA19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[5]	=>  Location: PIN_AC25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[6]	=>  Location: PIN_AK27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[7]	=>  Location: PIN_AH25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[8]	=>  Location: PIN_AJ27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[9]	=>  Location: PIN_AE23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[0]	=>  Location: PIN_AF26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[1]	=>  Location: PIN_AG25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- MemString[2]	=>  Location: PIN_AJ29,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF controller IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL ww_NewInstruction : std_logic;
SIGNAL ww_PSR : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_ALU : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_MEM : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_rs : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_rd : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_SIMM10 : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_IO : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_rr : std_logic;
SIGNAL ww_Amux : std_logic;
SIGNAL ww_Cmux : std_logic;
SIGNAL ww_MemString : std_logic_vector(31 DOWNTO 0);
SIGNAL \PSR[0]~input_o\ : std_logic;
SIGNAL \PSR[1]~input_o\ : std_logic;
SIGNAL \PSR[2]~input_o\ : std_logic;
SIGNAL \PSR[3]~input_o\ : std_logic;
SIGNAL \MemString[20]~input_o\ : std_logic;
SIGNAL \MemString[21]~input_o\ : std_logic;
SIGNAL \MemString[22]~input_o\ : std_logic;
SIGNAL \MemString[23]~input_o\ : std_logic;
SIGNAL \MemString[24]~input_o\ : std_logic;
SIGNAL \MemString[25]~input_o\ : std_logic;
SIGNAL \MemString[26]~input_o\ : std_logic;
SIGNAL \MemString[27]~input_o\ : std_logic;
SIGNAL \MemString[28]~input_o\ : std_logic;
SIGNAL \MemString[29]~input_o\ : std_logic;
SIGNAL \MemString[30]~input_o\ : std_logic;
SIGNAL \MemString[31]~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputCLKENA0_outclk\ : std_logic;
SIGNAL \MemString[17]~input_o\ : std_logic;
SIGNAL \NewInstruction~input_o\ : std_logic;
SIGNAL \MemString[16]~input_o\ : std_logic;
SIGNAL \MemString[15]~input_o\ : std_logic;
SIGNAL \ALU~0_combout\ : std_logic;
SIGNAL \MemString[19]~input_o\ : std_logic;
SIGNAL \MemString[18]~input_o\ : std_logic;
SIGNAL \Equal2~0_combout\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \cntstop~0_combout\ : std_logic;
SIGNAL \decode:cntstop~q\ : std_logic;
SIGNAL \halt~0_combout\ : std_logic;
SIGNAL \halt~1_combout\ : std_logic;
SIGNAL \halt~2_combout\ : std_logic;
SIGNAL \halt~q\ : std_logic;
SIGNAL \ALU[0]~1_combout\ : std_logic;
SIGNAL \ALU[0]~2_combout\ : std_logic;
SIGNAL \ALU[0]~reg0_q\ : std_logic;
SIGNAL \ALU~3_combout\ : std_logic;
SIGNAL \ALU[1]~reg0_q\ : std_logic;
SIGNAL \ALU~4_combout\ : std_logic;
SIGNAL \rd[3]~0_combout\ : std_logic;
SIGNAL \ALU[2]~reg0_q\ : std_logic;
SIGNAL \Cmux~0_combout\ : std_logic;
SIGNAL \Cmux~reg0_q\ : std_logic;
SIGNAL \Amux~0_combout\ : std_logic;
SIGNAL \Amux~1_combout\ : std_logic;
SIGNAL \Amux~reg0_q\ : std_logic;
SIGNAL \MEM~0_combout\ : std_logic;
SIGNAL \MEM[2]~reg0_q\ : std_logic;
SIGNAL \MemString[10]~input_o\ : std_logic;
SIGNAL \MemString[3]~input_o\ : std_logic;
SIGNAL \MemString[12]~input_o\ : std_logic;
SIGNAL \rs~0_combout\ : std_logic;
SIGNAL \MemString[14]~input_o\ : std_logic;
SIGNAL \rs[0]~5_combout\ : std_logic;
SIGNAL \rs[0]~1_combout\ : std_logic;
SIGNAL \rs[0]~reg0_q\ : std_logic;
SIGNAL \MemString[11]~input_o\ : std_logic;
SIGNAL \MemString[4]~input_o\ : std_logic;
SIGNAL \MemString[13]~input_o\ : std_logic;
SIGNAL \rs~2_combout\ : std_logic;
SIGNAL \rs[1]~reg0_q\ : std_logic;
SIGNAL \MemString[5]~input_o\ : std_logic;
SIGNAL \rs~3_combout\ : std_logic;
SIGNAL \rs[2]~reg0_q\ : std_logic;
SIGNAL \MemString[6]~input_o\ : std_logic;
SIGNAL \rs~4_combout\ : std_logic;
SIGNAL \rs[3]~reg0_q\ : std_logic;
SIGNAL \rd[0]~1_combout\ : std_logic;
SIGNAL \rd~2_combout\ : std_logic;
SIGNAL \rd[0]~7_combout\ : std_logic;
SIGNAL \rd[0]~3_combout\ : std_logic;
SIGNAL \rd[0]~reg0_q\ : std_logic;
SIGNAL \MemString[7]~input_o\ : std_logic;
SIGNAL \rd~4_combout\ : std_logic;
SIGNAL \rd[1]~reg0_q\ : std_logic;
SIGNAL \MemString[8]~input_o\ : std_logic;
SIGNAL \rd~5_combout\ : std_logic;
SIGNAL \rd[2]~reg0_q\ : std_logic;
SIGNAL \MemString[9]~input_o\ : std_logic;
SIGNAL \rd~6_combout\ : std_logic;
SIGNAL \rd[3]~reg0_q\ : std_logic;
SIGNAL \MemString[0]~input_o\ : std_logic;
SIGNAL \SIMM10[0]~0_combout\ : std_logic;
SIGNAL \SIMM10[0]~reg0_q\ : std_logic;
SIGNAL \MemString[1]~input_o\ : std_logic;
SIGNAL \SIMM10[1]~reg0_q\ : std_logic;
SIGNAL \MemString[2]~input_o\ : std_logic;
SIGNAL \SIMM10[2]~reg0_q\ : std_logic;
SIGNAL \SIMM10[3]~reg0feeder_combout\ : std_logic;
SIGNAL \SIMM10[3]~reg0_q\ : std_logic;
SIGNAL \SIMM10[4]~reg0_q\ : std_logic;
SIGNAL \SIMM10[5]~reg0_q\ : std_logic;
SIGNAL \SIMM10[6]~reg0_q\ : std_logic;
SIGNAL \SIMM10[7]~reg0feeder_combout\ : std_logic;
SIGNAL \SIMM10[7]~reg0_q\ : std_logic;
SIGNAL \SIMM10[8]~reg0_q\ : std_logic;
SIGNAL \SIMM10[9]~reg0_q\ : std_logic;
SIGNAL \IO[0]~1_combout\ : std_logic;
SIGNAL \IO[0]~0_combout\ : std_logic;
SIGNAL \IO[0]~reg0_q\ : std_logic;
SIGNAL \IO[1]~reg0_q\ : std_logic;
SIGNAL \rr~0_combout\ : std_logic;
SIGNAL \rr~reg0_q\ : std_logic;
SIGNAL \ALT_INV_MemString[9]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[8]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[11]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[13]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[14]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[10]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[12]~input_o\ : std_logic;
SIGNAL \ALT_INV_reset~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[19]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[18]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[17]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[15]~input_o\ : std_logic;
SIGNAL \ALT_INV_MemString[16]~input_o\ : std_logic;
SIGNAL \ALT_INV_NewInstruction~input_o\ : std_logic;
SIGNAL \ALT_INV_rd[0]~7_combout\ : std_logic;
SIGNAL \ALT_INV_rs[0]~5_combout\ : std_logic;
SIGNAL \ALT_INV_halt~1_combout\ : std_logic;
SIGNAL \ALT_INV_rd[0]~1_combout\ : std_logic;
SIGNAL \ALT_INV_halt~0_combout\ : std_logic;
SIGNAL \ALT_INV_ALU[0]~1_combout\ : std_logic;
SIGNAL \ALT_INV_halt~q\ : std_logic;
SIGNAL \ALT_INV_Equal2~0_combout\ : std_logic;
SIGNAL \ALT_INV_decode:cntstop~q\ : std_logic;
SIGNAL \ALT_INV_rr~reg0_q\ : std_logic;
SIGNAL \ALT_INV_Cmux~reg0_q\ : std_logic;
SIGNAL \ALT_INV_ALU[2]~reg0_q\ : std_logic;

BEGIN

ww_clk <= clk;
ww_reset <= reset;
ww_NewInstruction <= NewInstruction;
ww_PSR <= PSR;
ALU <= ww_ALU;
MEM <= ww_MEM;
rs <= ww_rs;
rd <= ww_rd;
SIMM10 <= ww_SIMM10;
IO <= ww_IO;
rr <= ww_rr;
Amux <= ww_Amux;
Cmux <= ww_Cmux;
ww_MemString <= MemString;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_MemString[9]~input_o\ <= NOT \MemString[9]~input_o\;
\ALT_INV_MemString[8]~input_o\ <= NOT \MemString[8]~input_o\;
\ALT_INV_MemString[7]~input_o\ <= NOT \MemString[7]~input_o\;
\ALT_INV_MemString[6]~input_o\ <= NOT \MemString[6]~input_o\;
\ALT_INV_MemString[5]~input_o\ <= NOT \MemString[5]~input_o\;
\ALT_INV_MemString[11]~input_o\ <= NOT \MemString[11]~input_o\;
\ALT_INV_MemString[4]~input_o\ <= NOT \MemString[4]~input_o\;
\ALT_INV_MemString[13]~input_o\ <= NOT \MemString[13]~input_o\;
\ALT_INV_MemString[14]~input_o\ <= NOT \MemString[14]~input_o\;
\ALT_INV_MemString[10]~input_o\ <= NOT \MemString[10]~input_o\;
\ALT_INV_MemString[3]~input_o\ <= NOT \MemString[3]~input_o\;
\ALT_INV_MemString[12]~input_o\ <= NOT \MemString[12]~input_o\;
\ALT_INV_reset~input_o\ <= NOT \reset~input_o\;
\ALT_INV_MemString[19]~input_o\ <= NOT \MemString[19]~input_o\;
\ALT_INV_MemString[18]~input_o\ <= NOT \MemString[18]~input_o\;
\ALT_INV_MemString[17]~input_o\ <= NOT \MemString[17]~input_o\;
\ALT_INV_MemString[15]~input_o\ <= NOT \MemString[15]~input_o\;
\ALT_INV_MemString[16]~input_o\ <= NOT \MemString[16]~input_o\;
\ALT_INV_NewInstruction~input_o\ <= NOT \NewInstruction~input_o\;
\ALT_INV_rd[0]~7_combout\ <= NOT \rd[0]~7_combout\;
\ALT_INV_rs[0]~5_combout\ <= NOT \rs[0]~5_combout\;
\ALT_INV_halt~1_combout\ <= NOT \halt~1_combout\;
\ALT_INV_rd[0]~1_combout\ <= NOT \rd[0]~1_combout\;
\ALT_INV_halt~0_combout\ <= NOT \halt~0_combout\;
\ALT_INV_ALU[0]~1_combout\ <= NOT \ALU[0]~1_combout\;
\ALT_INV_halt~q\ <= NOT \halt~q\;
\ALT_INV_Equal2~0_combout\ <= NOT \Equal2~0_combout\;
\ALT_INV_decode:cntstop~q\ <= NOT \decode:cntstop~q\;
\ALT_INV_rr~reg0_q\ <= NOT \rr~reg0_q\;
\ALT_INV_Cmux~reg0_q\ <= NOT \Cmux~reg0_q\;
\ALT_INV_ALU[2]~reg0_q\ <= NOT \ALU[2]~reg0_q\;

-- Location: IOOBUF_X89_Y8_N22
\ALU[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALU[0]~reg0_q\,
	devoe => ww_devoe,
	o => ww_ALU(0));

-- Location: IOOBUF_X88_Y0_N20
\ALU[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALU[1]~reg0_q\,
	devoe => ww_devoe,
	o => ww_ALU(1));

-- Location: IOOBUF_X89_Y6_N22
\ALU[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ALU[2]~reg0_q\,
	devoe => ww_devoe,
	o => ww_ALU(2));

-- Location: IOOBUF_X70_Y0_N2
\MEM[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Cmux~reg0_q\,
	devoe => ww_devoe,
	o => ww_MEM(0));

-- Location: IOOBUF_X89_Y8_N39
\MEM[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Amux~reg0_q\,
	devoe => ww_devoe,
	o => ww_MEM(1));

-- Location: IOOBUF_X89_Y6_N5
\MEM[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \MEM[2]~reg0_q\,
	devoe => ww_devoe,
	o => ww_MEM(2));

-- Location: IOOBUF_X72_Y0_N53
\rs[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rs[0]~reg0_q\,
	devoe => ww_devoe,
	o => ww_rs(0));

-- Location: IOOBUF_X76_Y0_N53
\rs[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rs[1]~reg0_q\,
	devoe => ww_devoe,
	o => ww_rs(1));

-- Location: IOOBUF_X76_Y0_N36
\rs[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rs[2]~reg0_q\,
	devoe => ww_devoe,
	o => ww_rs(2));

-- Location: IOOBUF_X74_Y0_N76
\rs[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rs[3]~reg0_q\,
	devoe => ww_devoe,
	o => ww_rs(3));

-- Location: IOOBUF_X74_Y0_N59
\rd[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rd[0]~reg0_q\,
	devoe => ww_devoe,
	o => ww_rd(0));

-- Location: IOOBUF_X76_Y0_N2
\rd[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rd[1]~reg0_q\,
	devoe => ww_devoe,
	o => ww_rd(1));

-- Location: IOOBUF_X72_Y0_N36
\rd[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rd[2]~reg0_q\,
	devoe => ww_devoe,
	o => ww_rd(2));

-- Location: IOOBUF_X76_Y0_N19
\rd[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rd[3]~reg0_q\,
	devoe => ww_devoe,
	o => ww_rd(3));

-- Location: IOOBUF_X86_Y0_N2
\SIMM10[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SIMM10[0]~reg0_q\,
	devoe => ww_devoe,
	o => ww_SIMM10(0));

-- Location: IOOBUF_X84_Y0_N36
\SIMM10[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SIMM10[1]~reg0_q\,
	devoe => ww_devoe,
	o => ww_SIMM10(1));

-- Location: IOOBUF_X84_Y0_N2
\SIMM10[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SIMM10[2]~reg0_q\,
	devoe => ww_devoe,
	o => ww_SIMM10(2));

-- Location: IOOBUF_X86_Y0_N19
\SIMM10[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SIMM10[3]~reg0_q\,
	devoe => ww_devoe,
	o => ww_SIMM10(3));

-- Location: IOOBUF_X82_Y0_N42
\SIMM10[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SIMM10[4]~reg0_q\,
	devoe => ww_devoe,
	o => ww_SIMM10(4));

-- Location: IOOBUF_X89_Y8_N5
\SIMM10[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SIMM10[5]~reg0_q\,
	devoe => ww_devoe,
	o => ww_SIMM10(5));

-- Location: IOOBUF_X82_Y0_N59
\SIMM10[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SIMM10[6]~reg0_q\,
	devoe => ww_devoe,
	o => ww_SIMM10(6));

-- Location: IOOBUF_X78_Y0_N2
\SIMM10[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SIMM10[7]~reg0_q\,
	devoe => ww_devoe,
	o => ww_SIMM10(7));

-- Location: IOOBUF_X86_Y0_N36
\SIMM10[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SIMM10[8]~reg0_q\,
	devoe => ww_devoe,
	o => ww_SIMM10(8));

-- Location: IOOBUF_X84_Y0_N19
\SIMM10[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \SIMM10[9]~reg0_q\,
	devoe => ww_devoe,
	o => ww_SIMM10(9));

-- Location: IOOBUF_X88_Y0_N3
\IO[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \IO[0]~reg0_q\,
	devoe => ww_devoe,
	o => ww_IO(0));

-- Location: IOOBUF_X88_Y0_N37
\IO[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \IO[1]~reg0_q\,
	devoe => ww_devoe,
	o => ww_IO(1));

-- Location: IOOBUF_X88_Y0_N54
\rr~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \rr~reg0_q\,
	devoe => ww_devoe,
	o => ww_rr);

-- Location: IOOBUF_X89_Y8_N56
\Amux~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Amux~reg0_q\,
	devoe => ww_devoe,
	o => ww_Amux);

-- Location: IOOBUF_X70_Y0_N53
\Cmux~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Cmux~reg0_q\,
	devoe => ww_devoe,
	o => ww_Cmux);

-- Location: IOIBUF_X89_Y25_N21
\clk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G10
\clk~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \clk~input_o\,
	outclk => \clk~inputCLKENA0_outclk\);

-- Location: IOIBUF_X89_Y4_N44
\MemString[17]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(17),
	o => \MemString[17]~input_o\);

-- Location: IOIBUF_X89_Y6_N55
\NewInstruction~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_NewInstruction,
	o => \NewInstruction~input_o\);

-- Location: IOIBUF_X84_Y0_N52
\MemString[16]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(16),
	o => \MemString[16]~input_o\);

-- Location: IOIBUF_X89_Y9_N4
\MemString[15]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(15),
	o => \MemString[15]~input_o\);

-- Location: MLABCELL_X82_Y4_N45
\ALU~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \ALU~0_combout\ = ( \MemString[15]~input_o\ & ( (!\NewInstruction~input_o\) # ((!\MemString[17]~input_o\ & \MemString[16]~input_o\)) ) ) # ( !\MemString[15]~input_o\ & ( (!\NewInstruction~input_o\) # (\MemString[16]~input_o\) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1100111111001111110011111100111111001110110011101100111011001110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_MemString[17]~input_o\,
	datab => \ALT_INV_NewInstruction~input_o\,
	datac => \ALT_INV_MemString[16]~input_o\,
	dataf => \ALT_INV_MemString[15]~input_o\,
	combout => \ALU~0_combout\);

-- Location: IOIBUF_X89_Y4_N78
\MemString[19]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(19),
	o => \MemString[19]~input_o\);

-- Location: IOIBUF_X89_Y4_N95
\MemString[18]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(18),
	o => \MemString[18]~input_o\);

-- Location: LABCELL_X80_Y4_N39
\Equal2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal2~0_combout\ = ( !\MemString[18]~input_o\ & ( \MemString[19]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_MemString[19]~input_o\,
	dataf => \ALT_INV_MemString[18]~input_o\,
	combout => \Equal2~0_combout\);

-- Location: IOIBUF_X82_Y0_N92
\reset~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset,
	o => \reset~input_o\);

-- Location: LABCELL_X81_Y4_N12
\cntstop~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \cntstop~0_combout\ = ( \decode:cntstop~q\ & ( \NewInstruction~input_o\ ) ) # ( !\decode:cntstop~q\ & ( \NewInstruction~input_o\ ) ) # ( \decode:cntstop~q\ & ( !\NewInstruction~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \ALT_INV_decode:cntstop~q\,
	dataf => \ALT_INV_NewInstruction~input_o\,
	combout => \cntstop~0_combout\);

-- Location: FF_X81_Y4_N14
\decode:cntstop\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \cntstop~0_combout\,
	clrn => \reset~input_o\,
	sclr => \ALT_INV_NewInstruction~input_o\,
	ena => \ALT_INV_halt~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \decode:cntstop~q\);

-- Location: LABCELL_X81_Y4_N51
\halt~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \halt~0_combout\ = ( \MemString[17]~input_o\ & ( \MemString[16]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_MemString[16]~input_o\,
	dataf => \ALT_INV_MemString[17]~input_o\,
	combout => \halt~0_combout\);

-- Location: MLABCELL_X82_Y4_N21
\halt~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \halt~1_combout\ = ( \MemString[18]~input_o\ & ( \MemString[19]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \ALT_INV_MemString[18]~input_o\,
	dataf => \ALT_INV_MemString[19]~input_o\,
	combout => \halt~1_combout\);

-- Location: LABCELL_X81_Y4_N42
\halt~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \halt~2_combout\ = ( \halt~1_combout\ & ( ((\NewInstruction~input_o\ & (!\decode:cntstop~q\ & \halt~0_combout\))) # (\halt~q\) ) ) # ( !\halt~1_combout\ & ( \halt~q\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100000100111111110000010011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_NewInstruction~input_o\,
	datab => \ALT_INV_decode:cntstop~q\,
	datac => \ALT_INV_halt~0_combout\,
	datad => \ALT_INV_halt~q\,
	dataf => \ALT_INV_halt~1_combout\,
	combout => \halt~2_combout\);

-- Location: FF_X81_Y4_N44
halt : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \halt~2_combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \halt~q\);

-- Location: LABCELL_X81_Y4_N45
\ALU[0]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \ALU[0]~1_combout\ = ( \MemString[17]~input_o\ & ( (\NewInstruction~input_o\ & (\MemString[15]~input_o\ & \MemString[16]~input_o\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000001010000000000000101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_NewInstruction~input_o\,
	datac => \ALT_INV_MemString[15]~input_o\,
	datad => \ALT_INV_MemString[16]~input_o\,
	dataf => \ALT_INV_MemString[17]~input_o\,
	combout => \ALU[0]~1_combout\);

-- Location: LABCELL_X81_Y4_N18
\ALU[0]~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \ALU[0]~2_combout\ = ( !\ALU[0]~1_combout\ & ( \decode:cntstop~q\ & ( (!\NewInstruction~input_o\ & (\reset~input_o\ & !\halt~q\)) ) ) ) # ( !\ALU[0]~1_combout\ & ( !\decode:cntstop~q\ & ( (\reset~input_o\ & (!\halt~q\ & ((!\NewInstruction~input_o\) # 
-- (\Equal2~0_combout\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110100000000000000000000000000001100000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal2~0_combout\,
	datab => \ALT_INV_NewInstruction~input_o\,
	datac => \ALT_INV_reset~input_o\,
	datad => \ALT_INV_halt~q\,
	datae => \ALT_INV_ALU[0]~1_combout\,
	dataf => \ALT_INV_decode:cntstop~q\,
	combout => \ALU[0]~2_combout\);

-- Location: FF_X82_Y4_N46
\ALU[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \ALU~0_combout\,
	ena => \ALU[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ALU[0]~reg0_q\);

-- Location: MLABCELL_X82_Y4_N12
\ALU~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \ALU~3_combout\ = ( \NewInstruction~input_o\ & ( \MemString[17]~input_o\ ) ) # ( !\NewInstruction~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_MemString[17]~input_o\,
	dataf => \ALT_INV_NewInstruction~input_o\,
	combout => \ALU~3_combout\);

-- Location: FF_X82_Y4_N13
\ALU[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \ALU~3_combout\,
	ena => \ALU[0]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ALU[1]~reg0_q\);

-- Location: LABCELL_X83_Y4_N24
\ALU~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \ALU~4_combout\ = ( \ALU[2]~reg0_q\ & ( \decode:cntstop~q\ ) ) # ( \ALU[2]~reg0_q\ & ( !\decode:cntstop~q\ & ( (!\NewInstruction~input_o\) # ((!\Equal2~0_combout\) # (\MemString[15]~input_o\)) ) ) ) # ( !\ALU[2]~reg0_q\ & ( !\decode:cntstop~q\ & ( 
-- (\NewInstruction~input_o\ & (\MemString[15]~input_o\ & (\Equal2~0_combout\ & !\halt~0_combout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000000111110111111101100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_NewInstruction~input_o\,
	datab => \ALT_INV_MemString[15]~input_o\,
	datac => \ALT_INV_Equal2~0_combout\,
	datad => \ALT_INV_halt~0_combout\,
	datae => \ALT_INV_ALU[2]~reg0_q\,
	dataf => \ALT_INV_decode:cntstop~q\,
	combout => \ALU~4_combout\);

-- Location: MLABCELL_X82_Y4_N48
\rd[3]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \rd[3]~0_combout\ = ( !\halt~q\ & ( \reset~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110011001100110011001100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_reset~input_o\,
	dataf => \ALT_INV_halt~q\,
	combout => \rd[3]~0_combout\);

-- Location: FF_X83_Y4_N25
\ALU[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \ALU~4_combout\,
	asdata => VCC,
	sload => \ALT_INV_NewInstruction~input_o\,
	ena => \rd[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ALU[2]~reg0_q\);

-- Location: LABCELL_X83_Y4_N42
\Cmux~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Cmux~0_combout\ = ( \Cmux~reg0_q\ & ( \decode:cntstop~q\ ) ) # ( \Cmux~reg0_q\ & ( !\decode:cntstop~q\ & ( (!\NewInstruction~input_o\) # ((!\MemString[19]~input_o\ & (\MemString[18]~input_o\ & !\MemString[16]~input_o\))) ) ) ) # ( !\Cmux~reg0_q\ & ( 
-- !\decode:cntstop~q\ & ( (!\MemString[19]~input_o\ & (\MemString[18]~input_o\ & (\NewInstruction~input_o\ & !\MemString[16]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001000000000111100101111000000000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_MemString[19]~input_o\,
	datab => \ALT_INV_MemString[18]~input_o\,
	datac => \ALT_INV_NewInstruction~input_o\,
	datad => \ALT_INV_MemString[16]~input_o\,
	datae => \ALT_INV_Cmux~reg0_q\,
	dataf => \ALT_INV_decode:cntstop~q\,
	combout => \Cmux~0_combout\);

-- Location: FF_X83_Y4_N44
\Cmux~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Cmux~0_combout\,
	asdata => VCC,
	sload => \ALT_INV_NewInstruction~input_o\,
	ena => \rd[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \Cmux~reg0_q\);

-- Location: LABCELL_X83_Y4_N12
\Amux~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Amux~0_combout\ = ( \NewInstruction~input_o\ & ( (\MemString[16]~input_o\ & (\MemString[18]~input_o\ & !\MemString[19]~input_o\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000100000001000000000000000000000001000000010000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_MemString[16]~input_o\,
	datab => \ALT_INV_MemString[18]~input_o\,
	datac => \ALT_INV_MemString[19]~input_o\,
	datae => \ALT_INV_NewInstruction~input_o\,
	combout => \Amux~0_combout\);

-- Location: MLABCELL_X82_Y4_N57
\Amux~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Amux~1_combout\ = ( !\halt~q\ & ( \decode:cntstop~q\ & ( (!\NewInstruction~input_o\ & \reset~input_o\) ) ) ) # ( !\halt~q\ & ( !\decode:cntstop~q\ & ( \reset~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000000000000000000001100000011000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_NewInstruction~input_o\,
	datac => \ALT_INV_reset~input_o\,
	datae => \ALT_INV_halt~q\,
	dataf => \ALT_INV_decode:cntstop~q\,
	combout => \Amux~1_combout\);

-- Location: FF_X83_Y4_N14
\Amux~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \Amux~0_combout\,
	ena => \Amux~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \Amux~reg0_q\);

-- Location: LABCELL_X83_Y4_N33
\MEM~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \MEM~0_combout\ = ( \NewInstruction~input_o\ & ( (!\MemString[19]~input_o\ & (\MemString[18]~input_o\ & \MemString[17]~input_o\)) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000101000000000000000000000000000001010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_MemString[19]~input_o\,
	datac => \ALT_INV_MemString[18]~input_o\,
	datad => \ALT_INV_MemString[17]~input_o\,
	datae => \ALT_INV_NewInstruction~input_o\,
	combout => \MEM~0_combout\);

-- Location: FF_X83_Y4_N34
\MEM[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \MEM~0_combout\,
	ena => \Amux~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \MEM[2]~reg0_q\);

-- Location: IOIBUF_X74_Y0_N41
\MemString[10]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(10),
	o => \MemString[10]~input_o\);

-- Location: IOIBUF_X80_Y0_N1
\MemString[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(3),
	o => \MemString[3]~input_o\);

-- Location: IOIBUF_X72_Y0_N1
\MemString[12]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(12),
	o => \MemString[12]~input_o\);

-- Location: LABCELL_X80_Y4_N0
\rs~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \rs~0_combout\ = ( \MemString[12]~input_o\ & ( \NewInstruction~input_o\ & ( (!\MemString[18]~input_o\ & ((!\MemString[19]~input_o\) # ((\MemString[10]~input_o\)))) # (\MemString[18]~input_o\ & (((\MemString[3]~input_o\)) # (\MemString[19]~input_o\))) ) ) 
-- ) # ( !\MemString[12]~input_o\ & ( \NewInstruction~input_o\ & ( (!\MemString[18]~input_o\ & (\MemString[19]~input_o\ & (\MemString[10]~input_o\))) # (\MemString[18]~input_o\ & (!\MemString[19]~input_o\ & ((\MemString[3]~input_o\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000010010001101001101111011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_MemString[18]~input_o\,
	datab => \ALT_INV_MemString[19]~input_o\,
	datac => \ALT_INV_MemString[10]~input_o\,
	datad => \ALT_INV_MemString[3]~input_o\,
	datae => \ALT_INV_MemString[12]~input_o\,
	dataf => \ALT_INV_NewInstruction~input_o\,
	combout => \rs~0_combout\);

-- Location: IOIBUF_X82_Y0_N75
\MemString[14]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(14),
	o => \MemString[14]~input_o\);

-- Location: MLABCELL_X82_Y4_N33
\rs[0]~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \rs[0]~5_combout\ = ( \MemString[18]~input_o\ & ( \MemString[19]~input_o\ & ( (!\MemString[16]~input_o\ & !\MemString[17]~input_o\) ) ) ) # ( !\MemString[18]~input_o\ & ( \MemString[19]~input_o\ & ( \MemString[14]~input_o\ ) ) ) # ( 
-- \MemString[18]~input_o\ & ( !\MemString[19]~input_o\ & ( \MemString[16]~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000011110000111101010101010101011111000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_MemString[14]~input_o\,
	datac => \ALT_INV_MemString[16]~input_o\,
	datad => \ALT_INV_MemString[17]~input_o\,
	datae => \ALT_INV_MemString[18]~input_o\,
	dataf => \ALT_INV_MemString[19]~input_o\,
	combout => \rs[0]~5_combout\);

-- Location: LABCELL_X81_Y4_N3
\rs[0]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \rs[0]~1_combout\ = ( !\NewInstruction~input_o\ & ( \decode:cntstop~q\ & ( (\reset~input_o\ & !\halt~q\) ) ) ) # ( \NewInstruction~input_o\ & ( !\decode:cntstop~q\ & ( (\rs[0]~5_combout\ & (\reset~input_o\ & !\halt~q\)) ) ) ) # ( !\NewInstruction~input_o\ 
-- & ( !\decode:cntstop~q\ & ( (\reset~input_o\ & !\halt~q\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011000000110000000100000001000000110000001100000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rs[0]~5_combout\,
	datab => \ALT_INV_reset~input_o\,
	datac => \ALT_INV_halt~q\,
	datae => \ALT_INV_NewInstruction~input_o\,
	dataf => \ALT_INV_decode:cntstop~q\,
	combout => \rs[0]~1_combout\);

-- Location: FF_X80_Y4_N1
\rs[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \rs~0_combout\,
	ena => \rs[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rs[0]~reg0_q\);

-- Location: IOIBUF_X72_Y0_N18
\MemString[11]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(11),
	o => \MemString[11]~input_o\);

-- Location: IOIBUF_X80_Y0_N18
\MemString[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(4),
	o => \MemString[4]~input_o\);

-- Location: IOIBUF_X74_Y0_N92
\MemString[13]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(13),
	o => \MemString[13]~input_o\);

-- Location: LABCELL_X80_Y4_N42
\rs~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \rs~2_combout\ = ( \MemString[13]~input_o\ & ( \NewInstruction~input_o\ & ( (!\MemString[18]~input_o\ & ((!\MemString[19]~input_o\) # ((\MemString[11]~input_o\)))) # (\MemString[18]~input_o\ & (((\MemString[4]~input_o\)) # (\MemString[19]~input_o\))) ) ) 
-- ) # ( !\MemString[13]~input_o\ & ( \NewInstruction~input_o\ & ( (!\MemString[18]~input_o\ & (\MemString[19]~input_o\ & (\MemString[11]~input_o\))) # (\MemString[18]~input_o\ & (!\MemString[19]~input_o\ & ((\MemString[4]~input_o\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000010010001101001101111011111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_MemString[18]~input_o\,
	datab => \ALT_INV_MemString[19]~input_o\,
	datac => \ALT_INV_MemString[11]~input_o\,
	datad => \ALT_INV_MemString[4]~input_o\,
	datae => \ALT_INV_MemString[13]~input_o\,
	dataf => \ALT_INV_NewInstruction~input_o\,
	combout => \rs~2_combout\);

-- Location: FF_X80_Y4_N43
\rs[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \rs~2_combout\,
	ena => \rs[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rs[1]~reg0_q\);

-- Location: IOIBUF_X89_Y4_N61
\MemString[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(5),
	o => \MemString[5]~input_o\);

-- Location: LABCELL_X80_Y4_N24
\rs~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \rs~3_combout\ = ( \MemString[12]~input_o\ & ( \MemString[14]~input_o\ & ( (\NewInstruction~input_o\ & (((!\MemString[18]~input_o\) # (\MemString[19]~input_o\)) # (\MemString[5]~input_o\))) ) ) ) # ( !\MemString[12]~input_o\ & ( \MemString[14]~input_o\ & 
-- ( (\NewInstruction~input_o\ & ((!\MemString[19]~input_o\ & ((!\MemString[18]~input_o\) # (\MemString[5]~input_o\))) # (\MemString[19]~input_o\ & ((\MemString[18]~input_o\))))) ) ) ) # ( \MemString[12]~input_o\ & ( !\MemString[14]~input_o\ & ( 
-- (\NewInstruction~input_o\ & ((!\MemString[19]~input_o\ & (\MemString[5]~input_o\ & \MemString[18]~input_o\)) # (\MemString[19]~input_o\ & ((!\MemString[18]~input_o\))))) ) ) ) # ( !\MemString[12]~input_o\ & ( !\MemString[14]~input_o\ & ( 
-- (\MemString[5]~input_o\ & (!\MemString[19]~input_o\ & (\MemString[18]~input_o\ & \NewInstruction~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000100000000000011010000000000110001110000000011110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_MemString[5]~input_o\,
	datab => \ALT_INV_MemString[19]~input_o\,
	datac => \ALT_INV_MemString[18]~input_o\,
	datad => \ALT_INV_NewInstruction~input_o\,
	datae => \ALT_INV_MemString[12]~input_o\,
	dataf => \ALT_INV_MemString[14]~input_o\,
	combout => \rs~3_combout\);

-- Location: FF_X80_Y4_N25
\rs[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \rs~3_combout\,
	ena => \rs[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rs[2]~reg0_q\);

-- Location: IOIBUF_X80_Y0_N52
\MemString[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(6),
	o => \MemString[6]~input_o\);

-- Location: LABCELL_X80_Y4_N54
\rs~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \rs~4_combout\ = ( \MemString[15]~input_o\ & ( \NewInstruction~input_o\ & ( (!\MemString[18]~input_o\ & (((!\MemString[19]~input_o\)) # (\MemString[13]~input_o\))) # (\MemString[18]~input_o\ & (((\MemString[19]~input_o\) # (\MemString[6]~input_o\)))) ) ) 
-- ) # ( !\MemString[15]~input_o\ & ( \NewInstruction~input_o\ & ( (!\MemString[18]~input_o\ & (\MemString[13]~input_o\ & ((\MemString[19]~input_o\)))) # (\MemString[18]~input_o\ & (((\MemString[6]~input_o\ & !\MemString[19]~input_o\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000101001000101010111101110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_MemString[18]~input_o\,
	datab => \ALT_INV_MemString[13]~input_o\,
	datac => \ALT_INV_MemString[6]~input_o\,
	datad => \ALT_INV_MemString[19]~input_o\,
	datae => \ALT_INV_MemString[15]~input_o\,
	dataf => \ALT_INV_NewInstruction~input_o\,
	combout => \rs~4_combout\);

-- Location: FF_X80_Y4_N55
\rs[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \rs~4_combout\,
	ena => \rs[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rs[3]~reg0_q\);

-- Location: LABCELL_X83_Y4_N48
\rd[0]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \rd[0]~1_combout\ = ( !\MemString[19]~input_o\ & ( \MemString[18]~input_o\ ) ) # ( \MemString[19]~input_o\ & ( !\MemString[18]~input_o\ & ( !\MemString[14]~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000110011001100110011111111111111110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_MemString[14]~input_o\,
	datae => \ALT_INV_MemString[19]~input_o\,
	dataf => \ALT_INV_MemString[18]~input_o\,
	combout => \rd[0]~1_combout\);

-- Location: LABCELL_X80_Y4_N48
\rd~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \rd~2_combout\ = ( \MemString[12]~input_o\ & ( \rd[0]~1_combout\ & ( (!\Equal2~0_combout\ & (\MemString[3]~input_o\)) # (\Equal2~0_combout\ & ((\MemString[10]~input_o\))) ) ) ) # ( !\MemString[12]~input_o\ & ( \rd[0]~1_combout\ & ( (!\Equal2~0_combout\ & 
-- (\MemString[3]~input_o\)) # (\Equal2~0_combout\ & ((\MemString[10]~input_o\))) ) ) ) # ( \MemString[12]~input_o\ & ( !\rd[0]~1_combout\ & ( (!\Equal2~0_combout\) # (\MemString[6]~input_o\) ) ) ) # ( !\MemString[12]~input_o\ & ( !\rd[0]~1_combout\ & ( 
-- (\MemString[6]~input_o\ & \Equal2~0_combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000001010101111111110101010100110011000011110011001100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_MemString[6]~input_o\,
	datab => \ALT_INV_MemString[3]~input_o\,
	datac => \ALT_INV_MemString[10]~input_o\,
	datad => \ALT_INV_Equal2~0_combout\,
	datae => \ALT_INV_MemString[12]~input_o\,
	dataf => \ALT_INV_rd[0]~1_combout\,
	combout => \rd~2_combout\);

-- Location: LABCELL_X83_Y4_N6
\rd[0]~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \rd[0]~7_combout\ = ( \MemString[16]~input_o\ & ( \MemString[18]~input_o\ & ( (\MemString[19]~input_o\ & !\MemString[17]~input_o\) ) ) ) # ( !\MemString[16]~input_o\ & ( \MemString[18]~input_o\ & ( !\MemString[19]~input_o\ ) ) ) # ( 
-- \MemString[16]~input_o\ & ( !\MemString[18]~input_o\ & ( \MemString[19]~input_o\ ) ) ) # ( !\MemString[16]~input_o\ & ( !\MemString[18]~input_o\ & ( \MemString[19]~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101010101010101010110101010101010100101000001010000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_MemString[19]~input_o\,
	datac => \ALT_INV_MemString[17]~input_o\,
	datae => \ALT_INV_MemString[16]~input_o\,
	dataf => \ALT_INV_MemString[18]~input_o\,
	combout => \rd[0]~7_combout\);

-- Location: LABCELL_X81_Y4_N57
\rd[0]~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \rd[0]~3_combout\ = ( !\NewInstruction~input_o\ & ( \decode:cntstop~q\ & ( (\reset~input_o\ & !\halt~q\) ) ) ) # ( \NewInstruction~input_o\ & ( !\decode:cntstop~q\ & ( (\reset~input_o\ & (\rd[0]~7_combout\ & !\halt~q\)) ) ) ) # ( !\NewInstruction~input_o\ 
-- & ( !\decode:cntstop~q\ & ( (\reset~input_o\ & !\halt~q\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101000001010000000100000001000001010000010100000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_reset~input_o\,
	datab => \ALT_INV_rd[0]~7_combout\,
	datac => \ALT_INV_halt~q\,
	datae => \ALT_INV_NewInstruction~input_o\,
	dataf => \ALT_INV_decode:cntstop~q\,
	combout => \rd[0]~3_combout\);

-- Location: FF_X80_Y4_N49
\rd[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \rd~2_combout\,
	asdata => VCC,
	sload => \ALT_INV_NewInstruction~input_o\,
	ena => \rd[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rd[0]~reg0_q\);

-- Location: IOIBUF_X78_Y0_N52
\MemString[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(7),
	o => \MemString[7]~input_o\);

-- Location: LABCELL_X80_Y4_N18
\rd~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \rd~4_combout\ = ( \MemString[7]~input_o\ & ( \Equal2~0_combout\ & ( (!\rd[0]~1_combout\) # (\MemString[11]~input_o\) ) ) ) # ( !\MemString[7]~input_o\ & ( \Equal2~0_combout\ & ( (\rd[0]~1_combout\ & \MemString[11]~input_o\) ) ) ) # ( 
-- \MemString[7]~input_o\ & ( !\Equal2~0_combout\ & ( (!\rd[0]~1_combout\ & ((\MemString[13]~input_o\))) # (\rd[0]~1_combout\ & (\MemString[4]~input_o\)) ) ) ) # ( !\MemString[7]~input_o\ & ( !\Equal2~0_combout\ & ( (!\rd[0]~1_combout\ & 
-- ((\MemString[13]~input_o\))) # (\rd[0]~1_combout\ & (\MemString[4]~input_o\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001000110111011000100011011101100000101000001011010111110101111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_rd[0]~1_combout\,
	datab => \ALT_INV_MemString[4]~input_o\,
	datac => \ALT_INV_MemString[11]~input_o\,
	datad => \ALT_INV_MemString[13]~input_o\,
	datae => \ALT_INV_MemString[7]~input_o\,
	dataf => \ALT_INV_Equal2~0_combout\,
	combout => \rd~4_combout\);

-- Location: FF_X80_Y4_N19
\rd[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \rd~4_combout\,
	asdata => VCC,
	sload => \ALT_INV_NewInstruction~input_o\,
	ena => \rd[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rd[1]~reg0_q\);

-- Location: IOIBUF_X80_Y0_N35
\MemString[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(8),
	o => \MemString[8]~input_o\);

-- Location: LABCELL_X80_Y4_N12
\rd~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \rd~5_combout\ = ( \MemString[8]~input_o\ & ( \MemString[18]~input_o\ & ( (!\MemString[19]~input_o\ & (\MemString[5]~input_o\)) # (\MemString[19]~input_o\ & ((\MemString[14]~input_o\))) ) ) ) # ( !\MemString[8]~input_o\ & ( \MemString[18]~input_o\ & ( 
-- (!\MemString[19]~input_o\ & (\MemString[5]~input_o\)) # (\MemString[19]~input_o\ & ((\MemString[14]~input_o\))) ) ) ) # ( \MemString[8]~input_o\ & ( !\MemString[18]~input_o\ & ( ((\MemString[19]~input_o\ & \MemString[12]~input_o\)) # 
-- (\MemString[14]~input_o\) ) ) ) # ( !\MemString[8]~input_o\ & ( !\MemString[18]~input_o\ & ( (!\MemString[19]~input_o\ & (\MemString[14]~input_o\)) # (\MemString[19]~input_o\ & (!\MemString[14]~input_o\ & \MemString[12]~input_o\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000111100000011110011111101000111010001110100011101000111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_MemString[5]~input_o\,
	datab => \ALT_INV_MemString[19]~input_o\,
	datac => \ALT_INV_MemString[14]~input_o\,
	datad => \ALT_INV_MemString[12]~input_o\,
	datae => \ALT_INV_MemString[8]~input_o\,
	dataf => \ALT_INV_MemString[18]~input_o\,
	combout => \rd~5_combout\);

-- Location: FF_X80_Y4_N13
\rd[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \rd~5_combout\,
	asdata => VCC,
	sload => \ALT_INV_NewInstruction~input_o\,
	ena => \rd[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rd[2]~reg0_q\);

-- Location: IOIBUF_X78_Y0_N18
\MemString[9]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(9),
	o => \MemString[9]~input_o\);

-- Location: LABCELL_X80_Y4_N30
\rd~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \rd~6_combout\ = ( \MemString[9]~input_o\ & ( \rd[0]~1_combout\ & ( (!\Equal2~0_combout\ & (\MemString[6]~input_o\)) # (\Equal2~0_combout\ & ((\MemString[13]~input_o\))) ) ) ) # ( !\MemString[9]~input_o\ & ( \rd[0]~1_combout\ & ( (!\Equal2~0_combout\ & 
-- (\MemString[6]~input_o\)) # (\Equal2~0_combout\ & ((\MemString[13]~input_o\))) ) ) ) # ( \MemString[9]~input_o\ & ( !\rd[0]~1_combout\ & ( (\Equal2~0_combout\) # (\MemString[15]~input_o\) ) ) ) # ( !\MemString[9]~input_o\ & ( !\rd[0]~1_combout\ & ( 
-- (\MemString[15]~input_o\ & !\Equal2~0_combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100000000000011111111111101010101001100110101010100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_MemString[6]~input_o\,
	datab => \ALT_INV_MemString[13]~input_o\,
	datac => \ALT_INV_MemString[15]~input_o\,
	datad => \ALT_INV_Equal2~0_combout\,
	datae => \ALT_INV_MemString[9]~input_o\,
	dataf => \ALT_INV_rd[0]~1_combout\,
	combout => \rd~6_combout\);

-- Location: FF_X80_Y4_N31
\rd[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \rd~6_combout\,
	asdata => VCC,
	sload => \ALT_INV_NewInstruction~input_o\,
	ena => \rd[0]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rd[3]~reg0_q\);

-- Location: IOIBUF_X86_Y0_N52
\MemString[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(0),
	o => \MemString[0]~input_o\);

-- Location: LABCELL_X81_Y4_N27
\SIMM10[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \SIMM10[0]~0_combout\ = ( !\MemString[14]~input_o\ & ( !\decode:cntstop~q\ & ( (\Equal2~0_combout\ & (\NewInstruction~input_o\ & (!\halt~q\ & \reset~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000010000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_Equal2~0_combout\,
	datab => \ALT_INV_NewInstruction~input_o\,
	datac => \ALT_INV_halt~q\,
	datad => \ALT_INV_reset~input_o\,
	datae => \ALT_INV_MemString[14]~input_o\,
	dataf => \ALT_INV_decode:cntstop~q\,
	combout => \SIMM10[0]~0_combout\);

-- Location: FF_X81_Y4_N28
\SIMM10[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \MemString[0]~input_o\,
	sload => VCC,
	ena => \SIMM10[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMM10[0]~reg0_q\);

-- Location: IOIBUF_X78_Y0_N35
\MemString[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(1),
	o => \MemString[1]~input_o\);

-- Location: FF_X81_Y4_N31
\SIMM10[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \MemString[1]~input_o\,
	sload => VCC,
	ena => \SIMM10[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMM10[1]~reg0_q\);

-- Location: IOIBUF_X89_Y6_N38
\MemString[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(2),
	o => \MemString[2]~input_o\);

-- Location: FF_X81_Y4_N25
\SIMM10[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \MemString[2]~input_o\,
	sload => VCC,
	ena => \SIMM10[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMM10[2]~reg0_q\);

-- Location: LABCELL_X81_Y4_N33
\SIMM10[3]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \SIMM10[3]~reg0feeder_combout\ = ( \MemString[3]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_MemString[3]~input_o\,
	combout => \SIMM10[3]~reg0feeder_combout\);

-- Location: FF_X81_Y4_N34
\SIMM10[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \SIMM10[3]~reg0feeder_combout\,
	ena => \SIMM10[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMM10[3]~reg0_q\);

-- Location: FF_X81_Y4_N49
\SIMM10[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \MemString[4]~input_o\,
	sload => VCC,
	ena => \SIMM10[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMM10[4]~reg0_q\);

-- Location: FF_X81_Y4_N52
\SIMM10[5]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \MemString[5]~input_o\,
	sload => VCC,
	ena => \SIMM10[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMM10[5]~reg0_q\);

-- Location: FF_X81_Y4_N1
\SIMM10[6]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \MemString[6]~input_o\,
	sload => VCC,
	ena => \SIMM10[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMM10[6]~reg0_q\);

-- Location: LABCELL_X81_Y4_N6
\SIMM10[7]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \SIMM10[7]~reg0feeder_combout\ = ( \MemString[7]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_MemString[7]~input_o\,
	combout => \SIMM10[7]~reg0feeder_combout\);

-- Location: FF_X81_Y4_N7
\SIMM10[7]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \SIMM10[7]~reg0feeder_combout\,
	ena => \SIMM10[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMM10[7]~reg0_q\);

-- Location: FF_X81_Y4_N10
\SIMM10[8]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \MemString[8]~input_o\,
	sload => VCC,
	ena => \SIMM10[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMM10[8]~reg0_q\);

-- Location: FF_X81_Y4_N22
\SIMM10[9]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \MemString[9]~input_o\,
	sload => VCC,
	ena => \SIMM10[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SIMM10[9]~reg0_q\);

-- Location: MLABCELL_X82_Y4_N0
\IO[0]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \IO[0]~1_combout\ = ( !\MemString[16]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_MemString[16]~input_o\,
	combout => \IO[0]~1_combout\);

-- Location: MLABCELL_X82_Y4_N36
\IO[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \IO[0]~0_combout\ = ( !\decode:cntstop~q\ & ( !\halt~q\ & ( (\halt~1_combout\ & (!\MemString[17]~input_o\ & (\NewInstruction~input_o\ & \reset~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000100000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_halt~1_combout\,
	datab => \ALT_INV_MemString[17]~input_o\,
	datac => \ALT_INV_NewInstruction~input_o\,
	datad => \ALT_INV_reset~input_o\,
	datae => \ALT_INV_decode:cntstop~q\,
	dataf => \ALT_INV_halt~q\,
	combout => \IO[0]~0_combout\);

-- Location: FF_X82_Y4_N1
\IO[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \IO[0]~1_combout\,
	ena => \IO[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \IO[0]~reg0_q\);

-- Location: FF_X82_Y4_N37
\IO[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	asdata => \MemString[16]~input_o\,
	sload => VCC,
	ena => \IO[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \IO[1]~reg0_q\);

-- Location: MLABCELL_X82_Y4_N24
\rr~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \rr~0_combout\ = ( \rr~reg0_q\ & ( \decode:cntstop~q\ ) ) # ( \rr~reg0_q\ & ( !\decode:cntstop~q\ & ( (!\NewInstruction~input_o\) # (((!\MemString[19]~input_o\) # (\MemString[14]~input_o\)) # (\MemString[18]~input_o\)) ) ) ) # ( !\rr~reg0_q\ & ( 
-- !\decode:cntstop~q\ & ( (\NewInstruction~input_o\ & (!\MemString[18]~input_o\ & (\MemString[14]~input_o\ & \MemString[19]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000100111111111011111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_NewInstruction~input_o\,
	datab => \ALT_INV_MemString[18]~input_o\,
	datac => \ALT_INV_MemString[14]~input_o\,
	datad => \ALT_INV_MemString[19]~input_o\,
	datae => \ALT_INV_rr~reg0_q\,
	dataf => \ALT_INV_decode:cntstop~q\,
	combout => \rr~0_combout\);

-- Location: FF_X82_Y4_N25
\rr~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputCLKENA0_outclk\,
	d => \rr~0_combout\,
	sclr => \ALT_INV_NewInstruction~input_o\,
	ena => \rd[3]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \rr~reg0_q\);

-- Location: IOIBUF_X40_Y0_N18
\PSR[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_PSR(0),
	o => \PSR[0]~input_o\);

-- Location: IOIBUF_X28_Y81_N18
\PSR[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_PSR(1),
	o => \PSR[1]~input_o\);

-- Location: IOIBUF_X20_Y0_N18
\PSR[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_PSR(2),
	o => \PSR[2]~input_o\);

-- Location: IOIBUF_X18_Y0_N41
\PSR[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_PSR(3),
	o => \PSR[3]~input_o\);

-- Location: IOIBUF_X38_Y81_N35
\MemString[20]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(20),
	o => \MemString[20]~input_o\);

-- Location: IOIBUF_X24_Y81_N18
\MemString[21]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(21),
	o => \MemString[21]~input_o\);

-- Location: IOIBUF_X18_Y0_N58
\MemString[22]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(22),
	o => \MemString[22]~input_o\);

-- Location: IOIBUF_X68_Y0_N52
\MemString[23]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(23),
	o => \MemString[23]~input_o\);

-- Location: IOIBUF_X28_Y81_N52
\MemString[24]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(24),
	o => \MemString[24]~input_o\);

-- Location: IOIBUF_X38_Y81_N18
\MemString[25]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(25),
	o => \MemString[25]~input_o\);

-- Location: IOIBUF_X16_Y81_N1
\MemString[26]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(26),
	o => \MemString[26]~input_o\);

-- Location: IOIBUF_X60_Y0_N18
\MemString[27]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(27),
	o => \MemString[27]~input_o\);

-- Location: IOIBUF_X10_Y0_N58
\MemString[28]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(28),
	o => \MemString[28]~input_o\);

-- Location: IOIBUF_X89_Y20_N61
\MemString[29]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(29),
	o => \MemString[29]~input_o\);

-- Location: IOIBUF_X66_Y0_N75
\MemString[30]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(30),
	o => \MemString[30]~input_o\);

-- Location: IOIBUF_X20_Y81_N18
\MemString[31]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_MemString(31),
	o => \MemString[31]~input_o\);

-- Location: LABCELL_X51_Y19_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


