# JFEGS: a virtual processor for the DE1-SoC board
> Yet another revolutionary product that computes the Fibonacci sequence, designed by Joost Buursink, Fabian Widlund, Emil Imhagen, Guus Branderhorst, and Stach Redeker.

This documentation file is part of the final project of Digital Hardware in module 5 of Electrical Engineering, University of Twente.

## Table of contents
  * [Table of used variables](#table-of-used-variables)
  * [Instruction Format](#instruction-format)
    + [Branch instructions](#branch-instructions)
    + [Memory instructions](#memory-instructions)
    + [Arithmetic instructions](#arithmetic-instructions)
  * [Registerfile structure](#register-file-structure)

## Table of used variables
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



## Instruction Format

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
| Op1 | Op2 | Address (9 bits) | %rd (4 bits) | unused (3 bits)
| :--  |:-- |:--  |:-- |:-- |
| 01 | YY | MMMMMMMMM | RRRR | 000 |

| Instruction | Op2 |
| --- | --- |
| ld | 00 |
| st | 01 |
| ldb | 10 |
| stb | 11 |

### Arithmetic instructions
| Op1 | Op2 | cc | %rs (4 bits) | %rd (4 bits) | unused (7 bits)
| :--  |:-- |:--  |:-- | :-- | :-- |
| 10 | ZZ | C | RRRR | RRRR | 0000000 |

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
| 11 | 00 | RRRR | 00000000 |

#### readIO: reads the current state of the switches and stores it in a register
| Op1 | Op2 | %rd (4 bits) | unused (12 bits) |
| :--  |:-- |:--  |:-- |
| 11 | 01 | RRRR | 00000000 |

#### halt: stops the program
| Op1 | Op2 | unused 1s (16 bits) |
| :--  |:-- |:-- |
| 11 | 11 | 1111111111111111 |

## Registerfile structure
|Register 0-15 are general purpose registers|
|Register 16 is Program counter|
|Register 17-20 are temporary registers|
|Register 21 is Memory Address Register|
|Register 22 is Memory Data Register|
|Register 23 is Instruction Register| 