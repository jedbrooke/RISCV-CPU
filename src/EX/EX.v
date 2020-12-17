`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2020 11:00:08 AM
// Design Name: 
// Module Name: EX
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
module EX #(parameter WIDTH=32)(
    immediate,rs1,rs2,pc,alu_src,alu_func,zero,data1,data2,pc_out,clk,rst,overflow
    );
    input [WIDTH-1:0]   immediate;
    input [WIDTH-1:0]   rs1;
    input [WIDTH-1:0]   rs2;
    input [WIDTH-1:0]   pc;
    input               alu_src;
    input [3:0]        alu_func;
    input clk;
    input rst;
   
    output              zero;
    output [WIDTH-1:0]  data1;
    output [WIDTH-1:0]  data2;
    output [WIDTH-1:0]  pc_out;
    output              overflow;
    
    wire [WIDTH-1:0] b = alu_src ? immediate : rs2;
    assign data2 = rs2;
    
    ALU #(.WIDTH(WIDTH)) alu(.clk(clk), .a(rs1), .b(b), .control(alu_func), .out(data1), .zero(zero), .overflow(overflow), .rst(rst));
    
    wire [WIDTH-1:0] imm_shift = immediate << 1'b1;
    add_and_subtract #(.WIDTH(WIDTH)) pc_adder(.a(imm_shift), .b(pc), .sum(pc_out), .subtract(1'b0));
    
    
    
endmodule
