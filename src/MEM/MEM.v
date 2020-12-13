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


module MEM #(parameter WIDTH = 64) (
    byte_address,
    data_write,
    MemWrite,
    MemRead,
    clk,
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
	output reg [WIDTH-1:0] data_read;
	
	reg [WIDTH-1:0] data_memory [0:1023];
	
	initial begin
	   //read in the file
	    $readmemh("data_in.mem",data_memory);
	end
	
	wire [WIDTH-1:0] address = byte_address >> 3; //divide byte address by 8 to get dword address
	wire [2:0] byte_offset = byte_address[2:0];
	
	wire [7:0] read_bytes [0:15];
	wire [63:0] read_dwords [0:1];
	assign read_dwords[0] = data_memory[address];
	assign read_dwords[1] = data_memory[address+1];
	genvar i;
	generate
	   for (i = 0; i < 8; i= i+1) begin
	       assign read_bytes[i] = read_dwords[0][(i*8)+7:i*8];
	   end
	   for (i = 0; i < 8; i= i+1) begin
	       assign read_bytes[i+8] = read_dwords[1][(i*8)+7:i*8];
	   end
	endgenerate
	
	wire [15:0] read_halfword = {read_bytes[byte_offset],read_bytes[byte_offset + 1]};
	wire [31:0] read_word = {read_halfword,read_bytes[byte_offset + 2],read_bytes[byte_offset + 3]};
	wire [63:0] read_dword = {read_word,read_bytes[byte_offset + 4],read_bytes[byte_offset + 5],read_bytes[byte_offset + 6],read_bytes[byte_offset + 7]};

	always @* begin
	   case(memControl)
	       `MEM_BYTE: data_read <= {{56{read_bytes[byte_offset][7]}},read_bytes[byte_offset]};
	       `MEM_BYTE_U: data_read <= {56'b0,read_bytes[byte_offset]};
	       `MEM_HALFWORD: data_read <= {{48{read_halfword[31]}},read_halfword};
	       `MEM_HALFWORD_U: data_read <= {48'b0,read_halfword};
	       `MEM_WORD: data_read <= {{48{read_halfword[31]}},read_halfword};
	       `MEM_WORD_U: data_read <= {48'b0,read_halfword};
	       `MEM_DWORD: data_read <= read_dword;
	       default: data_read <= {{WIDTH{1'b0}}};
	   endcase
	end 
	
	reg [(2*WIDTH)-1:0] write_temp; //write up to 64 bits
	reg [(2*WIDTH)-1:0] write_temp_byte;
	reg [(2*WIDTH)-1:0] write_temp_halfword;
	reg [(2*WIDTH)-1:0] write_temp_word;
	reg [(2*WIDTH)-1:0] write_temp_dword;
	

	
	wire [63:0] word_address = address >> 3; //divide by 8 for 8 bytes in double word 
	assign  data_read = data_memory[word_address];
	
	always @(posedge clk) begin //writes must be 64bit aligned, bytes can go anywhere, but if a word, halfword, or doubleword exceeds the bounds of the lower dword of it's address it will get cut off
	   if (MemWrite) begin
	       write_temp[63:0] = read_dwords[0];
	       case(memControl) //zero out the portions of the temp reg to be written to
	           `MEM_BYTE: write_temp = write_temp & (8'b0 >> (byte_offset >> 3)); 
	           `MEM_HALFWORD: write_temp = write_temp & (16'b0 >> (byte_offset >> 3)); 
	           `MEM_WORD: write_temp = write_temp & (32'b0 >> (byte_offset >> 3));
	           `MEM_DWORD: write_temp = write_temp & (64'b0 >> (byte_offset >> 3)); 
	       endcase
	       
	       case(memControl)
	           `MEM_BYTE: write_temp_byte = {data_write[7:0],120'b0} >> (byte_offset >> 3); 
	           `MEM_HALFWORD: write_temp_halfword = {data_write[15:0],112'b0} >> (byte_offset >> 3); 
	           `MEM_WORD: write_temp_word = {data_write[31:0],96'b0} >> (byte_offset >> 3); 
	           `MEM_DWORD: write_temp_dword = {data_write[63:0],64'b0} >> (byte_offset >> 3); 
	       endcase
	       
	       case(memControl)
	           `MEM_BYTE: write_temp = write_temp | write_temp_byte;
	           `MEM_HALFWORD: write_temp = write_temp | write_temp_halfword;
	           `MEM_WORD: write_temp = write_temp | write_temp_word;
	           `MEM_DWORD: write_temp = write_temp | write_temp_dword;
	       endcase
	       
	       data_memory[address] = write_temp[WIDTH-1:0];
	   end
	end
	
endmodule
