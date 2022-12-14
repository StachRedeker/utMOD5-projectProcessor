restart -f -nowave
add wave *
force reset 0, 1 10 ns
force clk 0 , 1 10 ns -repeat 20 ns

#store hex:12345678 word at address 4
force memory_data_in 00010010001101000101011001111000
force address 000000100
force b 0
force ld 0
force st 1
run 200 ns

#store hex: AB byte at adress 10
force memory_data_in 00000000000000000000000010101011
force address 000001010
force b 1
force ld 0
force st 1
run 200 ns

#read word at adress 8 should show 00AB0000
force address 000001000
force b 0
force ld 1
force st 0
run 200 ns

#read byte at adress 6 should show 34
force address 000000110
force b 1
force ld 1
force st 0
run 200 ns

#read word at adress 0 should show 00ABCDEF
force address 000000010
force b 0
force ld 1
force st 0
run 200 ns
