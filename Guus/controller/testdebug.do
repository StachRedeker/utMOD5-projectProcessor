restart -f -nowave
add wave *
force reset 0, 1 10 ns
force clk 0 , 1 10 ns -repeat 20 ns 
force ACK_data 1

# NO DEBUG, NO BUTTON PRESS
# THIS SHOULD RUN THE OPERATION NORMALLY
force TEST_PHASE 00
force DEBUG 0
force MemString 16#000D8000
force NewInstruction 0, 1 20ns, 0 40ns
run 200ns

# NO DEBUG, BUTTON PRESS
# THIS SHOULD RUN THE OPERATION NORMALLY
force TEST_PHASE 01
force DEBUG_NEXT 0, 1 20 ns, 0 40 ns 
force MemString 16#000A24FF
force NewInstruction 0, 1 20ns, 0 40ns
run 200ns

# DEBUG, NO BUTTON PRESS
# THIS SHOULD STOP THE PROGRAM, SO NO EXCECUTION
force TEST_PHASE 10
force DEBUG
force MemString 16#00086240
force NewInstruction 0, 1 20ns, 0 40ns
run 200ns

# DEBUG, BUTTON PRESS
# THIS SHOULD ALLOW FOR ONE INSTRUCTION (ONE CLOCK CYCLE) TO BE EXECUTED
force TEST_PHASE 11
force DEBUG_NEXT 0, 1 20 ns, 0 40 ns 
force MemString 16#00053E48
force NewInstruction 0, 1 20ns, 0 40ns
run 200ns