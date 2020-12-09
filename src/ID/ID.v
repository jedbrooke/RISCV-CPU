`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2020 12:20:20 PM
// Design Name: 
// Module Name: ID
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


module ID #(parameter WIDTH = 32)(
    instruction,
    write_data,
    immediate,
    rs1_data,
    rs2_data,
    branch,
    memRead,
    memToReg,
    ALUControl,
    memWrite,
    ALUSrc,
    memControl,
    clk
    );
    input [31:0] instruction;
    input [WIDTH-1:0] write_data;
    output [WIDTH-1:0] immediate;
    output [WIDTH-1:0] rs1_data;
    output [WIDTH-1:0] rs2_data;
    output branch;
    output memRead;
    output memToReg;
    output [3:0] ALUControl;
    output memWrite;
    output ALUSrc;
    output [2:0] memControl;
    
    input clk;
    
    wire regWrite;
    wire [1:0] ALUOp;
    
    control control(
        .opcode(instruction[6:0]),
        .branch(branch),
        .memRead(memRead),
        .memToReg(memToReg),
        .ALUOp(ALUOp),
        .memWrite(memWrite),
        .ALUSrc(ALUSrc),
        .regWrite(regWrite)
    );
    
    
    register_file #(.WIDTH(WIDTH)) reg_file (
        .rs1_addr(instruction[19:15]),
        .rs2_addr(instruction[24:20]),
        .rd_addr(instruction[11:7]),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .regWrite(regWrite),
        .write_data(write_data),
        .clk(clk)
    );
    
    immediate_generator #(.WIDTH(WIDTH))immgen (
        .instruction(instruction),
        .immediate(immediate)
    );
    
     ALU_CONTROL alu_c(
        .funct7bit(instruction[30]),
        .funct3(instruction[14:12]),
        .ALUOp(ALUOp),
        .ALU_control(ALUControl)
     );
     
     mem_signals ms(
        .opcode(instruction[6:0]),
        .func3(instruction[14:12]),
        .memControl(memControl)
     );
     
    
    
    
endmodule
