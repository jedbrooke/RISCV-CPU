`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2020 12:41:43 AM
// Design Name: 
// Module Name: CPU
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


module CPU #(parameter WIDTH = 64) (
    clk,rst,write_data
    );
    
    input clk;
    input rst;
    wire [31:0] instruction;
    output [WIDTH-1:0] write_data;
    wire [WIDTH-1:0] immediate;
    wire [WIDTH-1:0] rs1_data;
    wire [WIDTH-1:0] rs2_data;
    wire branch;
    wire memRead;
    wire memToReg;
    wire [3:0] ALUControl;
    wire memWrite;
    wire ALUSrc;
    wire [2:0] memControl;

    wire [WIDTH-1:0] pc;
    wire zero;
    wire [WIDTH-1:0] data1;
    wire [WIDTH-1:0] data2;
    wire [WIDTH-1:0] pc_in;
    wire [WIDTH-1:0] pc_out;
    

    wire [WIDTH-1:0] data_read;


    IF #(.WIDTH(WIDTH)) IF_stage(
        .PC_JMP(pc_out),
        .ALU_zero(zero),
        .branch(branch),
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .PC(pc_in)
    );
    
    ID #(.WIDTH(WIDTH)) ID_stage(
        .instruction(instruction),
    	.write_data(write_data),
    	.immediate(immediate),
    	.rs1_data(rs1_data),
    	.rs2_data(rs2_data),
    	.branch(branch),
    	.memRead(memRead),
    	.memToReg(memToReg),
    	.ALUControl(ALUControl),
    	.memWrite(memWrite),
    	.ALUSrc(ALUSrc),
    	.memControl(memControl),
    	.clk(clk)
    );
    
    EX #(.WIDTH(WIDTH)) EX_stage(
    	.immediate(immediate),
    	.rs1(rs1_data),
    	.rs2(rs2_data),
    	.pc(pc_in),
    	.alu_src(ALUSrc),
    	.alu_func(ALUControl),
    	.zero(zero),
    	.data1(data1),
    	.data2(data2),
    	.pc_out(pc_out),
    	.clk(clk)
    );
    
    MEM #(.WIDTH(WIDTH)) MEM_stage(
        .byte_address(data1),
        .data_write(data2),
        .MemWrite(memWrite),
        .MemRead(memRead),
        .memControl(memControl),
        .clk(clk),
        .rst(rst),
        .data_read(data_read)
    );

    WB #(.WIDTH(WIDTH)) WB_stage(
        .data_read(data_read),
        .alu_data(data1),
        .memToReg(memToReg),
        .writeback_data(write_data)
    );
    
    
endmodule
