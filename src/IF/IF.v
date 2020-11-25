`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2020 10:24:36 AM
// Design Name: 
// Module Name: IF
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


module IF #(parameter WIDTH = 32) (
    PC_JMP,
    ALU_zero,
    branch,
    rst,
    clk,
    instruction,
    PC
);

	input [WIDTH-1:0] PC_JMP;
    input ALU_zero;
    input branch;
    input rst;
    input clk;
    output [31:0] instruction;
    output reg [WIDTH-1:0] PC;
    
    reg [7:0] instruction_mem [0:255];
    initial begin
        $readmemb("instr_count.mem", instruction_mem);
    end
    
//    generate
//        genvar i;
//        for (i = 0; i < 8; i= i+1) begin
//            instruction_mem[i] = {i};
//        end
//    endgenerate 

    assign instruction = {instruction_mem[PC],instruction_mem[PC+1],instruction_mem[PC+2],instruction_mem[PC+3]};
   
    
    
    always @(posedge clk) begin
        if(rst) begin
            PC = 0;
        end
        else begin
            PC = (branch & ALU_zero) ? PC_JMP : PC + 4;
        end
    end    
    
    
    
endmodule
