`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2020 11:06:48 AM
// Design Name: 
// Module Name: IF_tb
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


module IF_tb();
    
    parameter WIDTH = 32;
    
    reg [WIDTH-1:0] PC_JMP = 0;
    reg ALU_zero = 0;
    reg branch = 0;
    reg rst = 0;
    reg clk = 0;
    wire [31:0] instruction;
    wire [WIDTH-1:0] PC;
    
    IF if_test(
    	.PC_JMP(PC_JMP),
	    .ALU_zero(ALU_zero),
	    .branch(branch),
	    .rst(rst),
	    .clk(clk),
	    .instruction(instruction),
	    .PC(PC)
   	);
   	
   	initial begin
   	   #5 rst = 1'b1;
   	   #10 rst = 1'b0;
   	end
   	
   	always #50 $finish;
   	always #5 clk = ~clk;


    
    
    
endmodule
