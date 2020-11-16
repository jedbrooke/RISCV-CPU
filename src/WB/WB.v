`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2020 11:12:13 AM
// Design Name: 
// Module Name: WB
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


module WB #(parameter WIDTH = 32) (
    data_read,
    alu_data,
    memToReg,
    writeback_data
    );

	input [WIDTH-1:0] data_read;
	input [WIDTH-1:0] alu_data;
	input memToReg;
	output [WIDTH-1:0] writeback_data;

	assign writeback_data = memToReg ? data_read : alu_data;

endmodule
