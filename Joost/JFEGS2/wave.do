onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /jfegs/cntr/clk
add wave -noupdate /jfegs/cntr/reset
add wave -noupdate /jfegs/cntr/sw
add wave -noupdate /jfegs/cntr/DEBUG_NEXT
add wave -noupdate /jfegs/cntr/ACK_data
add wave -noupdate /jfegs/cntr/NewInstruction
add wave -noupdate /jfegs/cntr/PCR
add wave -noupdate /jfegs/cntr/ALU
add wave -noupdate /jfegs/cntr/MEM
add wave -noupdate /jfegs/cntr/rs
add wave -noupdate /jfegs/cntr/rd
add wave -noupdate /jfegs/cntr/SIMM10
add wave -noupdate /jfegs/cntr/IO
add wave -noupdate /jfegs/cntr/rr
add wave -noupdate /jfegs/cntr/address
add wave -noupdate /jfegs/cntr/Amux
add wave -noupdate /jfegs/cntr/Cmux
add wave -noupdate /jfegs/cntr/memory_data_out
add wave -noupdate /jfegs/cntr/PC
add wave -noupdate /jfegs/cntr/halt
add wave -noupdate /jfegs/memo/address
add wave -noupdate /jfegs/memo/memory_data_in
add wave -noupdate /jfegs/memo/reset
add wave -noupdate /jfegs/memo/clk
add wave -noupdate /jfegs/memo/memory_data_out
add wave -noupdate /jfegs/memo/ld
add wave -noupdate /jfegs/memo/st
add wave -noupdate /jfegs/memo/b
add wave -noupdate /jfegs/memo/i
add wave -noupdate /jfegs/memo/j
add wave -noupdate /jfegs/memo/memory_store_adr
add wave -noupdate /jfegs/dp/clk
add wave -noupdate /jfegs/dp/memory_data_out
add wave -noupdate /jfegs/dp/reset
add wave -noupdate /jfegs/dp/rd
add wave -noupdate /jfegs/dp/AMux
add wave -noupdate /jfegs/dp/rs
add wave -noupdate /jfegs/dp/CMux
add wave -noupdate /jfegs/dp/io
add wave -noupdate /jfegs/dp/ALU
add wave -noupdate /jfegs/dp/rr
add wave -noupdate /jfegs/dp/SIMM10
add wave -noupdate /jfegs/dp/PCR
add wave -noupdate /jfegs/dp/ACK_data
add wave -noupdate /jfegs/dp/NewInstruction
add wave -noupdate /jfegs/dp/memory_data_in
add wave -noupdate /jfegs/dp/dig0
add wave -noupdate /jfegs/dp/dig1
add wave -noupdate /jfegs/dp/dig2
add wave -noupdate /jfegs/dp/dig3
add wave -noupdate /jfegs/dp/dig4
add wave -noupdate /jfegs/dp/dig5
add wave -noupdate /jfegs/dp/sw
add wave -noupdate /jfegs/dp/BusA
add wave -noupdate /jfegs/dp/BusC
add wave -noupdate /jfegs/dp/IR
add wave -noupdate /jfegs/dp/Current_A
add wave -noupdate /jfegs/dp/Current_C
add wave -noupdate /jfegs/dp/ALU_output_with_carry
add wave -noupdate /jfegs/dp/CC_C
add wave -noupdate /jfegs/dp/CC_V
add wave -noupdate /jfegs/dp/CC_Z
add wave -noupdate /jfegs/dp/CC_N
add wave -position insertpoint sim:/jfegs/dp/reg_file/*
add wave -noupdate /jfegs/db/clk
add wave -noupdate /jfegs/db/reset
add wave -noupdate /jfegs/db/next_instruction_key
add wave -noupdate /jfegs/db/load_address_key
add wave -noupdate /jfegs/db/AMux
add wave -noupdate /jfegs/db/Cmux
add wave -noupdate /jfegs/db/sw
add wave -noupdate /jfegs/db/PCR
add wave -noupdate /jfegs/db/memory_data_out
add wave -noupdate /jfegs/db/DEBUG_NEXT
add wave -noupdate /jfegs/db/led
add wave -noupdate /jfegs/db/dig0
add wave -noupdate /jfegs/db/dig1
add wave -noupdate /jfegs/db/dig2
add wave -noupdate /jfegs/db/dig3
add wave -noupdate /jfegs/db/dig4
add wave -noupdate /jfegs/db/dig5
add wave -noupdate /jfegs/db/address
add wave -noupdate /jfegs/db/st
add wave -noupdate /jfegs/db/b
add wave -noupdate /jfegs/db/ld
add wave -noupdate /jfegs/db/wr_status
add wave -noupdate /jfegs/db/rd_status
add wave -noupdate /jfegs/db/LOAD_ADDRESS
add wave -noupdate /jfegs/db/AMux_temp
add wave -noupdate /jfegs/db/CMux_temp
add wave -noupdate /jfegs/db/clk
add wave -noupdate /jfegs/db/reset
add wave -noupdate /jfegs/db/next_instruction_key
add wave -noupdate /jfegs/db/load_address_key
add wave -noupdate /jfegs/db/AMux
add wave -noupdate /jfegs/db/Cmux
add wave -noupdate /jfegs/db/sw
add wave -noupdate /jfegs/db/PCR
add wave -noupdate /jfegs/db/memory_data_out
add wave -noupdate /jfegs/db/DEBUG_NEXT
add wave -noupdate /jfegs/db/led
add wave -noupdate /jfegs/db/dig0
add wave -noupdate /jfegs/db/dig1
add wave -noupdate /jfegs/db/dig2
add wave -noupdate /jfegs/db/dig3
add wave -noupdate /jfegs/db/dig4
add wave -noupdate /jfegs/db/dig5
add wave -noupdate /jfegs/db/address
add wave -noupdate /jfegs/db/st
add wave -noupdate /jfegs/db/b
add wave -noupdate /jfegs/db/ld
add wave -noupdate /jfegs/db/wr_status
add wave -noupdate /jfegs/db/rd_status
add wave -noupdate /jfegs/db/LOAD_ADDRESS
add wave -noupdate /jfegs/db/AMux_temp
add wave -noupdate /jfegs/db/CMux_temp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5019489 ps} 0}
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
WaveRestoreZoom {5019050 ps} {5020050 ps}
