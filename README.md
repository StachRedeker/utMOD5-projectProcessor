# JFEGS: a virtual processor for the DE1-SoC board
> Yet another revolutionary product that computes the Fibonacci sequence, designed by Joost Buursink, Fabian Widlund, Emil Imhagen, Guus Branderhorst, and Stach Redeker.

This documentation file is part of the final project of Digital Hardware in module 5 of Electrical Engineering, University of Twente.

## Table of contents
  * [Table of used variables](#table-of-used-variables)
  * [Instruction Format](#instruction-format)
    + [Branch instructions](#branch-instructions)
    + [Memory instructions](#memory-instructions)
    + [Arithmetic instructions](#arithmetic-instructions)

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

The minimal instruction length to cover all the wanted instructions is 15 bits. In order to be able to convert the instructions into hexadecimal, we shall use an instruction length of 16 bits.


### Branch instructions
| Op1 | Op2 | Address (7 bits) | unused (9 bits) |
| :--  |:-- |:--  |:-- |
| 00 | XX | MMMMMMM | 000000000 |

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

### Display instruction
| Op1 | Op2 | %rs (4 bits) | unused (12 bits) |
| :--  |:-- |:--  |:-- |
| 11 | -- | RRRR | 00000000 |
