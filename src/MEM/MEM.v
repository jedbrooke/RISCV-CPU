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
	output [WIDTH-1:0] data_read;
	
	reg [WIDTH-1:0] data_memory [0:1023];
	
	initial begin
	   $readmemh("data_in_2.mem",data_memory);
	end
	
	wire [63:0] word_address = address >> 3; //divide by 8 for 8 bytes in double word 
	assign  data_read = data_memory[word_address];
	
	always @(posedge clk) begin
	   if (MemWrite) begin
	       data_memory[word_address] = data_write;
	   end
	end
	
endmodule
