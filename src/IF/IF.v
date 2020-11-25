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
    
    reg [31:0] instruction_mem [7:0];
    assign instruction = instruction_mem[PC];
   
    
    
    always @(posedge clk) begin
        if(rst) begin
            PC = 0;
        end
        else begin
            PC = (branch & ALU_zero) ? PC_JMP : PC + 4;
        end
    end    
    
    
    
endmodule
