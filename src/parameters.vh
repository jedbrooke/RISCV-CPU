`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2020 12:29:40 PM
// Design Name: 
// Module Name: parameters
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//OPCODES
`define R_OPCODE  {7'b0110011}
`define IA_OPCODE {7'b0010011}
`define IL_OPCODE {7'b0000011}
`define S_OPCODE  {7'b0100011}
`define B_OPCODE  {7'b1100111}
`define U_OPCODE  {7'b0110111}
`define J_OPCODE  {7'b1101111}

//R-types
`define ADD_instr {7'b011_0011,3'b000,7'b000_0000}
`define SUB_instr {7'b011_0011,3'b000,7'b010_0000}
`define SLL_instr {7'b011_0011,3'b001,7'b000_0000}
`define XOR_instr {7'b011_0011,3'b100,7'b000_0000}
`define SRL_instr {7'b011_0011,3'b101,7'b000_0000}
`define SRA_instr {7'b011_0011,3'b101,7'b000_0000}
`define OR_instr  {7'b011_0011,3'b110,7'b000_0000}
`define AND_instr {7'b011_0011,3'b111,7'b000_0000}

//I-types
`define ADDI_instr {7'b001_0011,3'b000,7'b000_0000}
`define SLLI_instr {7'b001_0011,3'b001,7'b000_0000}
`define XORI_instr {7'b001_0011,3'b100,7'b000_0000}
`define SRLI_instr {7'b001_0011,3'b101,7'b000_0000}
`define SRAI_instr {7'b001_0011,3'b001,7'b010_0000}
`define ORI_instr  {7'b001_0011,3'b110,7'b000_0000}
`define ANDI_instr {7'b001_0011,3'b111,7'b000_0000}

//func3 bits:
//R/IA types
`define ADD_func3 {3'b000}
`define SUB_func3 {3'b000}
`define SL_func3  {3'b001}
`define XOR_func3 {3'b100}
`define SR_func3  {3'b101}
`define SRA_func3 {3'b101}
`define OR_func3  {3'b110}
`define AND_func3 {3'b111}
`define SLT_func3 {3'b010}
`define SLTU_func3 {3'b011}

// B-types
`define BEQ_func3  {3'b000}
`define BNE_func3  {3'b001}
`define BLT_func3  {3'b100}
`define BGE_func3  {3'b101}
`define BLTU_func3 {3'b110}
`define BGEU_func3 {3'b111}


//U-types
`define LUI_instr {7'b011_0111,3'b000,7'b000_0000}

//ALUOp controls
`define ALUOp_arithmetic {2'b10}
`define ALUOp_branch {2'b01}
`define ALUOp_ldst {2'b00}
`define ALUOp_jmp {2'b11}

//ALU CONTROLS
`define ALU_ADD {1'b0000}
`define ALU_SUB {1'b1000}
`define ALU_SLL {1'b0001}
`define ALU_XOR {1'b0100}
`define ALU_SRL {1'b0101}
`define ALU_SRA {1'b1101}
`define ALU_OR  {1'b0110}
`define ALU_AND {1'b0111}
`define ALU_SLT {4'b0010}
`define ALU_SGE {4'b1010}
`define ALU_SLTU{4'b0011}
`define ALU_SGEU{4'b1011}
`define ALU_JMP {4'b1110}
`define ALU_ERR {4'b1111}
