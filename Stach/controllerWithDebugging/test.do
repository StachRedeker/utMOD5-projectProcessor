restart -f -nowave
add wave *
force reset 0, 1 10 ns
force clk 0 , 1 10 ns -repeat 20 ns 

# NO DEBUG, NO BUTTON PRESS
# THIS SHOULD RUN THE OPERATION NORMALLY
force DEBUG 0
force MemString 16#0000FF80 100 ns
force MemString 16#00000000 200 ns

# NO DEBUG, BUTTON PRESS
# THIS SHOULD RUN THE OPERATION NORMALLY
force DEBUG_NEXT 0, 1 340 ns, 0 360 ns 
force MemString 16#0000FF80 300 ns
force MemString 16#00000000 400 ns

# DEBUG, NO BUTTON PRESS
# THIS SHOULD STOP THE PROGRAM, SO NO EXCECUTION
force DEBUG 1 450 ns
force MemString 16#0000FF80 500 ns
force MemString 16#00000000 600 ns

# DEBUG, BUTTON PRESS
# THIS SHOULD ALLOW FOR ONE INSTRUCTION (ONE CLOCK CYCLE) TO BE EXCETUTED
force DEBUG_NEXT 0, 1 640 ns, 0 660 ns 
force MemString 16#0000FF80 600 ns
force MemString 16#00000000 700 ns

run 800 ns 