restart -f -nowave
add wave *
force reset 0, 1 10 ns
force clk 0 , 1 10 ns -repeat 20 ns
force dataIn 00000000000000000000100001100100
force address 000000111
force b 0, 1 100 ns
force rd 0, 1 100 ns
force wr 1, 0 100 ns
run 200 ns
