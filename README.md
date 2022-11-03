# JFEGS: a virtual processor for the DE1-SoC board
> Yet another revolutionary product that computes the Fibonacci sequence, designed by Joost Buursink, Fabian Widlund, Emil Imhagen, Guus Branderhorst, and Stach Redeker.

This documentation file is part of the final project of Digital Hardware in module 5 of Electrical Engineering, University of Twente.

## Table of contents
  * [Introduction](#introduction)
  * [Instruction format](#instruction-format)
  * [Example application](#example-application)
  * [Parts of the processor](#parts-of-the-processor)
  * [Installation and usage](#installation-and-usage)
  * [Future improvements](#future-improvements)
  * [Final words](#final-words)
    
## Introduction
JFEGS is a virtual processor designed in VHDL for the Altera System-on-Chip (SoC) FPGA. The processor can be compiled using ModelSim and syntesized using Quartus. Various requirements were set. We discussed those in our [project plan](/ProjectPlan.pdf).

In this documentation file, we aim to eleborate on the workings of our virtual processor. This document can also serve as a starting point for people who wants to write programs for our system. At first, we discuss the instruction format and our example application. After that, we dig deeper into our processor and give a brief overview of the workings of various important components. Lastly, we provide an installation guide and make recommendations for further improvements.


## Instruction format

The minimal instruction length to cover all the wanted instructions is 17 bits. In order to be able to convert the instructions into hexadecimal, we shall use an instruction length of 20 bits.


### Branch instructions
| Op1 | Op2 | Address (9 bits) | unused (7 bits) |
| :--  |:-- |:--  |:-- |
| 00 | XX | MMMMMMMMM | 0000000 |

| Instruction | Op2 |
| --- | --- |
| ba | 00 |
| beq | 01 |
| bne | 10 |
| bneg | 11 |

### Memory instructions
| Op1 | Op2 | Address (9 bits) | %rd/%rs (4 bits) | unused (3 bits)
| :--  |:-- |:--  |:-- |:-- |
| 01 | YY | MMMMMMMMM | RRRR | 000 |

| Instruction | Op2 |
| --- | --- |
| ld | 00 |
| st | 01 |
| ldb | 10 |
| stb | 11 |

### Arithmetic instructions
| Op1 | Op2 | cc | rr | %rd (4 bits) | simm10 (10 bits)
| :--  |:-- |:--  |:-- | :-- | :-- |
| 10 | ZZ | C | 0 | RRRR | ssssssssss |

| Op1 | Op2 | cc | rr | %rs (4 bits) | %rd (4 bits) | unused (6 bits)
| :--  |:-- |:--  |:-- | :-- | :-- | :-- |
| 10 | ZZ | C | 1 | RRRR | RRRR | 000000 |

| Instruction | Op2 | cc |
| --- | --- | --- |
| and | 00 | 0 |
| or | 01 | 0 |
| add | 10 | 0 |
| shift | 11 | - |
| andcc | 00 | 1 |
| orcc | 01 | 1 |
| addcc | 10 | 1 |

### Miscellaneous instructions

#### Display: displays a register value on the seven segments displays
| Op1 | Op2 | %rs (4 bits) | unused (12 bits) |
| :--  |:-- |:--  |:-- |
| 11 | 00 | RRRR | 000000000000 |

#### readIO: reads the current state of the switches and stores it in a register
| Op1 | Op2 | %rd (4 bits) | unused (12 bits) |
| :--  |:-- |:--  |:-- |
| 11 | 01 | RRRR | 000000000000 |

#### halt: stops the program
| Op1 | Op2 | unused 1s (16 bits) |
| :--  |:-- |:-- |
| 11 | 11 | 1111111111111111 |

## Example application
The processor is able to compute the Fibonacci sequence. The Fibonacci sequence can be defined in assembly as:
```assembly
.begin
.org 0
add %r0, %r0, %r1
add %r0, 1, %r2
fun: add %r1, %r2, %r3
add %r0, %r2, %r1
add %r0, %r3, %r2
ba fun
.end
```
However, to showcase the full potential of our product, we designed an extended Fibonacci application that makes use of the large majority of the functionaility of our instruction set. Also, observe that a two address machine is not able to handle instructions that use three registers. Hence, our application is rewritten such that it only uses at maximum two registers per instruction.

The example program is able to compute the nth Fibonacci number, where n is inputted by the user using the onboard switches. The application can also halve the result, if the user requires so.
```assembly
.begin					
.org 0						
							
ld [H], %r4               		! loads whether or not we want half of the result
add %r2, 1, %r2
add %r6, 1, %r6 			! %r6 will contain a permanent 1

start: ld [C], %r5			! keeps track of the iterations
addcc %r5, -1, %r5
st %r5, [C]
bneg ending

and %r0, %r3, %r3			! clear reg3
add %r2, %r3, %r3			! adds %r1 to %r2 and stores in %r3
add %r1, %r3, %r3			! ^^^^

and %r0, %r1, %r1			! clear reg1
add %r2, %r1, %r1			! stores %r2 in %r1

and %r0, %r2, %r2			! clear reg2
add %r3, %r2, %r2       		! %r2 will contain the result
ba start

ending: orcc %r4, %r0, %r0		! check if we want the full result
be display
andcc %r4, %r6, %r6	 		! check if we want half of the result
bne halving
             

halving: srl %r2, 1, %r2		! divide the result by 2 using a shift right
ba display


display: halt             		! display the result

C: 15                     		! how many times we should run the function
H: 0                     		! H = 0, not halve; H = 1, halve 

.end
```

## Parts of the processor
This chapter gives a brief summary of different processor parts.

### Controller
The controller is the brain of our processor. It is able to perform the fetch-decode-excecute cycle. It fetches the instructions from the memory, stores them in the instruction register, and from there, interprets them (decode). After that, the controller sends signals to the other systems in the processor to make sure that the operation gets correctly excecuted.

We opted for a finite state machine (FSM) over microstore because a FSM is easier and more elegant to implement for smaller instruction sets. Although mircostore allows for a more generalizable instruction set, a FSM should suffice in our case.

![FSM](Stach/FSM.png)

### Datapath and dataflow
The following signals are used between multiple processes. To avoid confusion, we try to give the signals the same name in every process.

[LINK TO EXCEL FILE WITH ALL SIGNALS]

#### Registers
| Register | Function |
| :-- | :-- |
| Register 0-13 | general purpose |
| Register 14 | program counter |
| Register 15 | instruction register | 

#### ALU and status bits

### Memory

### IO
The DE1-SoC board has 10 switches, 10 LEDs, 4 momentary push buttons, and 6 seven segments displays. We connected the following functions to the onboard inputs:
| Input | Function |
| :-- | :-- |
| Button 0 | reset |
| Button 1 | next instruction (used during debugging) |
| Button 2 | load an address (used during debugging) |
| Button 3 | unused |
| Switch 0-8 | input variables for the program (during normal operation), input memory address (during debugging) |
| Switch 9 | activate debugging mode |

And we connected the following functions to the onboard outputs:
| Output | Function |
| :-- | :-- | 
| LED 0 | c |
| LED 1 | v |
| LED 2 | z |
| LED 3 | n |
| LED 4 | rd |
| LED 5 | wr |
| LED 6-9 | unused |
| seven segment displays | output of the application (during operation), memory contents (during debugging) |


### Debugging
In the requirements we stated that we shall implement a debug mode. If the debug mode is active, the user should be able to step through the program one line at a time. Also, the user shall be able to load the contents of a memory adress and display it using the seven segment displays on the FPGA.

Observe that we are able to pauze a program by stopping the controller in its fetch-decode-execute cycle. In order to accomplish this, we replaced
```VHDL
ELSIF (rising_edge(clk)) AND (halt = '0') AND (ACK_data = '1') THEN 
```
with
```VHDL
ELSIF (rising_edge(clk)) AND (halt = '0') AND (ACK_data = '1') AND ((DEBUG /= '1') OR (DEBUG_NEXT = '1')) THEN 
```
It can be seen that we added two new signals. `DEBUG` is 1 if the debug switch is turned on. `DEBUG_NEXT` is 1 for exactly 1 clock cycle when a user presses the 'next line' button.

## Installation and usage

## Contributions overview
| Member | Work |
| :-- | :-- |
| Joost Buursink | |
| Fabian Widlund | | 
| Emil Imhagen | |
| Guus Branderhorst | |
| Stach Redeker| |

## Future improvements

## Final words
