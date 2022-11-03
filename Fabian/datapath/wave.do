onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath/clk
add wave -noupdate -radix hexadecimal /datapath/dataIn
add wave -noupdate /datapath/reset
add wave -noupdate /datapath/rd
add wave -noupdate /datapath/AMux
add wave -noupdate /datapath/rs
add wave -noupdate /datapath/CMux
add wave -noupdate /datapath/rr
add wave -noupdate /datapath/io
add wave -noupdate /datapath/ALU
add wave -noupdate /datapath/PCR
add wave -noupdate /datapath/Op1
add wave -noupdate /datapath/Op2
add wave -noupdate -radix hexadecimal /datapath/dataMemoryOut
add wave -noupdate -radix hexadecimal /datapath/BusA
add wave -noupdate -radix hexadecimal /datapath/BusC
add wave -noupdate -radix hexadecimal /datapath/IR
add wave -noupdate /datapath/Current_A
add wave -noupdate /datapath/Current_C
add wave -noupdate -radix hexadecimal /datapath/ALU_output_with_carry
add wave -noupdate /datapath/rd1
add wave -noupdate /datapath/rs1
add wave -noupdate /datapath/CC_C
add wave -noupdate /datapath/CC_V
add wave -noupdate /datapath/CC_Z
add wave -noupdate /datapath/CC_N
add wave -noupdate -radix hexadecimal /datapath/reg_file/reg_file
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {118605 ps} 0}
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
WaveRestoreZoom {0 ps} {582750 ps}
