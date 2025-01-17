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

(* KEEP_HIERARCHY = "YES" *) 
module MEM #(parameter WIDTH = 64) (
    byte_address,
    data_write,
    MemWrite,
    MemRead,
    clk,
    rst,
    data_read,
    memControl
    );
`include "parameters.vh"
	input [WIDTH-1:0] byte_address;
	input [WIDTH-1:0] data_write;
	input MemWrite;
	input MemRead;
	input [2:0] memControl;
	input clk;
	input rst;
	output reg [WIDTH-1:0] data_read;
	`define mem_size 1024
	reg [WIDTH-1:0] data_memory [0:`mem_size-1];
	integer i;
	
	initial begin
	   //read in the file
	   for(i = 0; i < `mem_size; i = i + 1) begin
	       data_memory[i] = {{WIDTH{1'b0}}}; 
	   end
	   $readmemh("data_in.mem",data_memory);
	end
	
	wire [WIDTH-4:0] dword_addr = byte_address[WIDTH-1:3];
	wire [3:0] byte_offset = byte_address[2:0]; //byte 0-7 of the dword 
	wire [2:0] halfword_offset = byte_address[2:1]; //halfword 0-3
	wire word_offset = byte_address[2];
    wire [WIDTH-1:0] read_dword = data_memory[dword_addr];
	
	// all data reads will be rounded down to be aligned
	wire [7:0] read_byte = read_dword >> (WIDTH - (8 * (byte_offset + 1)));
	wire [15:0] read_halfword = read_dword >> (WIDTH - (16 * (halfword_offset + 1)));
	wire [31:0] read_word = read_dword >> (word_offset ? 0 : 32);
	//reads must be aligned
	// except bytes, they can be anywhere byte aligned
	// halfword must be 0-15, 16-31, 32-47, or 48-63
	// word must be 0-31, or 32-63
	//dword must be  64bit aligned
	always @(*) begin
	   if(rst) begin
	       data_read <= 0;
	   end
	   else if(MemRead) begin
            case(memControl)
                `MEM_BYTE: data_read <= {{(WIDTH-8){read_byte[7]}},read_byte};
                `MEM_BYTE_U: data_read <= {{(WIDTH-8){1'b0}},read_byte};
                `MEM_HALFWORD: data_read <= {{(WIDTH-16){read_halfword[15]}},read_halfword};
                `MEM_HALFWORD_U: data_read <= {{(WIDTH-16){1'b0}},read_halfword};
                `MEM_WORD: data_read <= {{(WIDTH-32){read_word[31]}},read_word};
                `MEM_WORD_U: data_read <= {{(WIDTH-32){1'b0}},read_word};
                `MEM_DWORD: data_read <= read_dword;
                default: data_read <= 0;
            endcase
		end
	end
    reg [WIDTH-1:0] temp_write;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
	       temp_write = {{WIDTH{1'b0}}};
	    end else begin
            case(memControl[1:0])
                `MEM_BYTE: temp_write = {data_write[7:0],read_dword[WIDTH-9:0]};
                `MEM_HALFWORD: temp_write = {data_write[15:0],read_dword[WIDTH-17:0]};
                `MEM_WORD: temp_write = {data_write[31:0],read_dword[WIDTH-33:0]};
                `MEM_DWORD: temp_write = data_write;
            endcase
        end
    end
	//writes must be 64-bit aligned, bytes, halfwords, words, dwords must all start at the beginning of a dword, at an address % 8 = 0
	always @(posedge clk) begin
	    if (MemWrite) begin		    
			data_memory[dword_addr] = temp_write;
		end
	end	
endmodule
