# JFEGS: a virtual processor for the DE1-SoC board
> Yet another revolutionary product that computes the Fibonacci sequence, designed by Joost Buursink, Fabian Widlund, Emil Imhagen, Guus Branderhorst, and Stach Redeker.

This documentation file is part of the final project of Digital Hardware in module 5 of Electrical Engineering, University of Twente.

## Table of contents
  * [Introduction](#introduction)
  * [Instruction format](#instruction-format)
    + [Branch instructions](#branch-instructions)
    + [Memory instructions](#memory-instructions)
    + [Arithmetic instructions](#arithmetic-instructions)
    + [Miscellaneous instructions](#miscellaneous-instructions)
      - [Display: displays a register value on the seven segement displays](#display--displays-a-register-value-on-the-seven-segement-displays)
      - [readIO: reads the current state of the switches and stores it in a register](#readio--reads-the-current-state-of-the-switches-and-stores-it-in-a-register)
      - [halt: stops the program](#halt--stops-the-program)
  * [Example application](#example-application)
  * [Table of used 'global' signals](#table-of-used--global--signals)
  * [Registerfile structure](registerfile-structure)
    
## Introduction



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

#### Display: displays a register value on the seven segement displays
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
							
ld [H], %r4               	! loads whether or not we want half of the result
add %r2, 1, %r2
add %r6, 1, %r6 			! %r6 will contain a permanent 1

start: ld [C], %r5		! keeps track of the iterations
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

ending: orcc %r4, %r0, %r0	! check if we want the full result
be display
andcc %r4, %r6, %r6	 	! check if we want half of the result
bne halving
             

halving: srl %r2, 1, %r2		! divide the result by 2 using a shift right
ba display


display: halt             	! display the result

C: 15                     	! how many times we should run the function
H: 0                     		! H = 0, not halve; H = 1, halve 

.end
```

## Table of used 'global' signals
The following signals are used between multiple processes. To avoid confusion, we try to give the signals the same name in every process.
| Used variables        | Input         | Output    | Small description     |
| :--                   |:--            |:--        |:--                    |
| clk                   |Memory         |           |clock of the FPGA      |
| reset                 |Memory               |           |button0 of the FPGA    |
| b         | Memory               |           | Decides if the load/store command is per byte|
| rd|Memory|| Decides if the memory should place data at dataOut|
| wr|Memory|| Decides if the memory should take data from dataIn|
| address|Memory||Adress of the memory used in rd and wr|
| dataIn|Memory||Input data of the memory|
| dataOut||Memory|Output data of the memory|

## Registerfile structure
|Register 0-13 are general purpose registers|
|Register 14 is Program counter|
|Register 15 is Instruction Register| 
