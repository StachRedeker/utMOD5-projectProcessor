onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /controller/clk
add wave -noupdate /controller/reset
add wave -noupdate /controller/DEBUG
add wave -noupdate /controller/DEBUG_NEXT
add wave -noupdate /controller/ACK_data
add wave -noupdate /controller/NewInstruction
add wave -noupdate /controller/PCR
add wave -noupdate /controller/ALU
add wave -noupdate /controller/MEM
add wave -noupdate -radix unsigned /controller/rs
add wave -noupdate -radix unsigned /controller/rd
add wave -noupdate -radix unsigned /controller/SIMM10
add wave -noupdate /controller/IO
add wave -noupdate /controller/rr
add wave -noupdate /controller/Amux
add wave -noupdate /controller/Cmux
add wave -noupdate /controller/memory_data_out
add wave -noupdate /controller/PC
add wave -noupdate /controller/address
add wave -noupdate /controller/halt
add wave -noupdate /controller/addressfield
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1110591 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {2772 ns}
