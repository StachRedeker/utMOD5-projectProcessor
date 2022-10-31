# JFEGS: yet another revolutionary product that computes the Fibonacci sequence


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

###


| Op1 | Op2 | | Small description     |
| :--                   |:--            |:--        |:--                    |
