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
   	
   	/*
   	    clock period in test bench is 10ns = 100Mhz
   	*/
   	
   	initial begin
   	   //send reset signal to clear initial values
   	   #5 rst = 1'b1;
   	   #10 rst = 1'b0;
   	   
   	   //let PC count up normally for 10 cycles
   	   #100;
   	   
   	   //set branch signal high, ALU signal low, branch should not be taken
   	   PC_JMP = 32'd20; //jump to instruction 5, at byte adress (4 * 5) = 20
   	   branch = 1'b1;
   	   //wait 2 clock cycles to show that it doesn't take the branch
   	   #20;
   	   //set ALU_zero high but branch low, branch should still not be taken
   	   branch = 1'b0;
   	   ALU_zero = 1'b1;
   	   //wait 2 clock cycle to show it doesn't take
   	   #20;
   	   //set ALU_zero high and branch high so that we take the branch
   	   branch = 1'b1;
   	   ALU_zero = 1'b1;
   	   //should jump to instr 5 at addr 20
   	   //wait one clock cycle to show it takes the branch
   	   #10;
   	   //set branch to 0 to show execution resuming from the branch
   	   branch = 1'b0;
   	   //wait 5 more clock cycles
   	   #50 $finish;
   	end
   	always #5 clk = ~clk;


    
    
    
endmodule
