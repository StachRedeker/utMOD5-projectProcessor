# JFEGS: a virtual processor for the DE1-SoC board
> Yet another revolutionary product that computes the Fibonacci sequence, designed by Joost Buursink, Fabian Widlund, Emil Imhagen, Guus Branderhorst, and Stach Redeker

This documentation file is part of the final project of Digital Hardware in module 5 of Electrical Engineering, University of Twente.

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

Our instructions are 16 bits, following the syntax below.


### Branch instructions
| Op1 | Op2 | Address (7 bits) | unused (5 bits) |
| :--  |:-- |:--  |:-- |
| 00 | XX | MMMMMMM | 00000 |

| Instruction | Op2 |
| --- | --- |
| ba | 00 |
| beq | 01 |
| bne | 10 |

### Memory instructions
| Op1 | Op2 | Address (7 bits) | %rd (4 bits) | unused (1 bit) |
| :--  |:-- |:--  |:-- | :-- |
| 01 | YY | MMMMMMM | RRRR | 0 |

| Instruction | Op2 |
| --- | --- |
| rd | 00 |
| ld | 11 |

### Arithmetic instructions
| Op1 | Op2 | %rs (4 bits) | %rd (4 bits) | unused (4 bits)
| :--  |:-- |:--  |:-- | :-- |
| WW | ZZ | RRRR | RRRR | 0000 |

| Instruction | Op1 | Op2 |
| --- | --- | --- |
| and | 10 | 00 |
| or | 10 | 01 |
| add | 10 | 10 |
| shift | 10 | 11 |
| andcc | 11 | 00 |
| orcc | 11 | 01 |
| addcc | 11 | 10 |
