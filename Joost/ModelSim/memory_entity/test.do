restart -f -nowave
add wave *
force reset 0, 1 10 ns
force clk 0 , 1 10 ns -repeat 20 ns
force dataIn 10000000000000000000100001100100
force address 000000111
force b 0, 1 100 ns
force rd 0, 1 100 ns
force wr 1, 0 100 ns
run 200 ns
force reset 1
run 20 ns
force reset 0
run 20 ns
