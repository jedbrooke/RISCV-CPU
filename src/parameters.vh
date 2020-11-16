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

//U-types
`define LUI_instr {7'b011_0111,3'b000,7'b000_0000}

//ALU CONTROLS
`define ALU_AND {4'b0000}
`define ALU_OR  {4'b0001}
`define ALU_ADD {4'b0010}
`define ALU_SUB {4'b0110}
`define ALU_SLT {4'b1111}
`define ALU_NOR {4'b1100}
`define ALU_ERR {4'b1010}
