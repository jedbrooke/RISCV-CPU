# RISCV CPU

A Functional RISCV core implemented in Verilog rtl<br>
More information in the [presentation]("https://github.com/jedbrooke/RISCV-CPU/blob/main/RISC%20V%20CPU.pdf").
Supported instructions:
Most of RV32/64I
 * Shifts
 * Arithmetic
 * Logical
 * Compare
 * Beanches
 * Jump and Link*
 * Loads
 * Stores

^*^see the [reference sheet]("https://github.com/jedbrooke/RISCV-CPU/blob/main/RISCV-reference-sheet.pdf") for detailed list. green boxes are implemented, red boxes are not

Currently the design is a simple single cycle design, though consideration of future pipelining was made when designing. 

## TODO
 - [ ] create a Makefile to easily build and test the project<br>
 - [ ] add support for missing instructions<br>
 - [ ] implement pipelining<br>

Program used to generate outputs:

code.mem
formatted as bytes, with comments for the assembly instructions

data_in.mem was used to generate output.txt

data_in_2.mem was used to generate output2.txt
