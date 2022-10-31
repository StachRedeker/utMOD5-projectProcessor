restart -f -nowave
add wave *
force reset 0, 1 10ns
force clk 0 , 1 10 ns -repeat 20 ns
force 
force pulse_length 0, 400 200ns, 0 1000ns, 600 30000ns, 0 60000ns
run 75000ns