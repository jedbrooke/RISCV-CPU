`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2020 10:50:32 AM
// Design Name: 
// Module Name: MEM
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


module MEM #(parameter WIDTH = 32) (
    address,
    data_write,
    MemWrite,
    MemRead,
    clk,
    data_read
    );

	input [WIDTH-1:0] address;
	input [WIDTH-1:0] data_write;
	input MemWrite;
	input MemRead;
	input clk;
	output reg [WIDTH-1:0] data_read;
	
	reg [WIDTH-1:0] data_memory [0:1023];
	
	always @(posedge clk) begin
	   if (MemRead) begin
	       data_read = data_memory[address];
	   end
	   else if (MemWrite) begin
	       data_memory[address] = data_write;
	   end
	end
	
endmodule
