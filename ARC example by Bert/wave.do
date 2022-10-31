onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /processor_with_memory/clk
add wave -noupdate -format Logic /processor_with_memory/reset
add wave -noupdate -format Logic /processor_with_memory/rd_m
add wave -noupdate -format Logic /processor_with_memory/wr_m
add wave -noupdate -divider CPU
add wave -noupdate -format Literal -radix hexadecimal /processor_with_memory/cpu/datain
add wave -noupdate -format Literal /processor_with_memory/cpu/dout
add wave -noupdate -format Literal -radix hexadecimal /processor_with_memory/cpu/address
add wave -noupdate -divider DP
add wave -noupdate -format Literal -radix unsigned /processor_with_memory/cpu/dp/a
add wave -noupdate -format Logic /processor_with_memory/cpu/dp/amux
add wave -noupdate -format Literal -radix unsigned /processor_with_memory/cpu/dp/b
add wave -noupdate -format Logic /processor_with_memory/cpu/dp/bmux
add wave -noupdate -format Literal -radix unsigned /processor_with_memory/cpu/dp/c
add wave -noupdate -format Logic /processor_with_memory/cpu/dp/cmux
add wave -noupdate -format Logic /processor_with_memory/cpu/dp/rd_m
add wave -noupdate -format Literal /processor_with_memory/cpu/dp/f
add wave -noupdate -format Logic /processor_with_memory/cpu/dp/set_cc
add wave -noupdate -format Literal /processor_with_memory/cpu/dp/cc
add wave -noupdate -format Literal /processor_with_memory/cpu/dp/op
add wave -noupdate -format Literal /processor_with_memory/cpu/dp/op3
add wave -noupdate -format Logic /processor_with_memory/cpu/dp/bit13
add wave -noupdate -format Literal -radix hexadecimal /processor_with_memory/cpu/dp/busa
add wave -noupdate -format Literal -radix hexadecimal /processor_with_memory/cpu/dp/busb
add wave -noupdate -format Literal -radix hexadecimal /processor_with_memory/cpu/dp/busc
add wave -noupdate -format Literal /processor_with_memory/cpu/dp/ir
add wave -noupdate -format Literal -radix unsigned /processor_with_memory/cpu/dp/sela
add wave -noupdate -format Literal -radix unsigned /processor_with_memory/cpu/dp/selb
add wave -noupdate -format Literal -radix unsigned /processor_with_memory/cpu/dp/selc
add wave -noupdate -format Literal /processor_with_memory/cpu/dp/alu_outp_with_carry
add wave -noupdate -format Literal /processor_with_memory/cpu/dp/rd
add wave -noupdate -format Literal /processor_with_memory/cpu/dp/rs1
add wave -noupdate -format Literal /processor_with_memory/cpu/dp/rs2
add wave -noupdate -format Logic /processor_with_memory/cpu/dp/cc_c
add wave -noupdate -format Logic /processor_with_memory/cpu/dp/cc_v
add wave -noupdate -format Logic /processor_with_memory/cpu/dp/cc_z
add wave -noupdate -format Logic /processor_with_memory/cpu/dp/cc_n
add wave -noupdate -divider control
add wave -noupdate -format Literal /processor_with_memory/cpu/ctrl/microinst
add wave -noupdate -format Literal -radix unsigned /processor_with_memory/cpu/ctrl/address
add wave -noupdate -format Literal /processor_with_memory/cpu/ctrl/csai_inc
add wave -noupdate -format Literal /processor_with_memory/cpu/ctrl/sel_na
add wave -noupdate -format Literal /processor_with_memory/cpu/ctrl/imir
add wave -noupdate -format Literal /processor_with_memory/cpu/ctrl/psr
add wave -noupdate -format Literal /processor_with_memory/cpu/ctrl/jmpa
add wave -noupdate -format Literal /processor_with_memory/cpu/ctrl/cond
TreeUpdate [SetDefaultTree]
configure wave -namecolwidth 281
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
update
WaveRestoreZoom {0 ns} {732 ns}
