onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath/clk
add wave -noupdate /datapath/reset
add wave -noupdate /datapath/memory_data_out
add wave -noupdate /datapath/memory_data_in
add wave -noupdate /datapath/AMux
add wave -noupdate /datapath/CMux
add wave -noupdate -radix decimal /datapath/SIMM10
add wave -noupdate /datapath/rd
add wave -noupdate /datapath/rs
add wave -noupdate /datapath/rr
add wave -noupdate /datapath/ALU
add wave -noupdate /datapath/PCR
add wave -noupdate -radix hexadecimal /datapath/BusA
add wave -noupdate -radix hexadecimal /datapath/BusC
add wave -noupdate -radix hexadecimal /datapath/IR
add wave -noupdate /datapath/Current_A
add wave -noupdate /datapath/Current_C
add wave -noupdate -radix hexadecimal /datapath/ALU_output_with_carry
add wave -noupdate /datapath/ACK_data
add wave -noupdate /datapath/NewInstruction
add wave -noupdate /datapath/counter_test
add wave -noupdate /datapath/reg_file/counter_output
add wave -noupdate -radix hexadecimal -childformat {{/datapath/reg_file/reg_file(0) -radix hexadecimal} {/datapath/reg_file/reg_file(1) -radix hexadecimal} {/datapath/reg_file/reg_file(2) -radix hexadecimal} {/datapath/reg_file/reg_file(3) -radix hexadecimal} {/datapath/reg_file/reg_file(4) -radix hexadecimal} {/datapath/reg_file/reg_file(5) -radix hexadecimal} {/datapath/reg_file/reg_file(6) -radix hexadecimal} {/datapath/reg_file/reg_file(7) -radix hexadecimal} {/datapath/reg_file/reg_file(8) -radix hexadecimal} {/datapath/reg_file/reg_file(9) -radix hexadecimal} {/datapath/reg_file/reg_file(10) -radix hexadecimal} {/datapath/reg_file/reg_file(11) -radix hexadecimal} {/datapath/reg_file/reg_file(12) -radix hexadecimal} {/datapath/reg_file/reg_file(13) -radix hexadecimal} {/datapath/reg_file/reg_file(14) -radix hexadecimal} {/datapath/reg_file/reg_file(15) -radix hexadecimal}} -subitemconfig {/datapath/reg_file/reg_file(0) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(1) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(2) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(3) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(4) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(5) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(6) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(7) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(8) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(9) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(10) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(11) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(12) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(13) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(14) {-height 15 -radix hexadecimal} /datapath/reg_file/reg_file(15) {-height 15 -radix hexadecimal}} /datapath/reg_file/reg_file
add wave -noupdate /datapath/CC_C
add wave -noupdate /datapath/CC_V
add wave -noupdate /datapath/CC_Z
add wave -noupdate /datapath/CC_N
add wave -noupdate /datapath/io
add wave -noupdate /datapath/dig0
add wave -noupdate /datapath/dig1
add wave -noupdate /datapath/dig2
add wave -noupdate /datapath/dig3
add wave -noupdate /datapath/dig4
add wave -noupdate /datapath/dig5
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1597415 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {1162725 ps} {2307225 ps}
