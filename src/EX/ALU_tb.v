`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2020 09:57:46 PM
// Design Name: 
// Module Name: ALU
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

module ALU_tb (
    
);
    `include "parameters.vh"

    parameter WIDTH = 32;
    reg [WIDTH-1:0] a = 0;
    reg [WIDTH-1:0] b = 0;
    reg [3:0] control = `ALU_ADD;
    reg clk = 0;
    wire [WIDTH-1:0] out;
    wire zero;
    wire overflow;
    integer i = 0


    reg [15:0] operation [3:0];
    operation[`ALU_ADD] = `ALU_ADD ;
    operation[`ALU_SUB] = `ALU_SUB ;
    operation[`ALU_SLL] = `ALU_SLL ;
    operation[`ALU_XOR] = `ALU_XOR ;
    operation[`ALU_SRL] = `ALU_SRL ;
    operation[`ALU_SRA] = `ALU_SRA ;
    operation[`ALU_OR ] = `ALU_OR  ;
    operation[`ALU_AND] = `ALU_AND ;
    operation[`ALU_SLT] = `ALU_SLT ;
    operation[`ALU_SGE] = `ALU_SGE ;
    operation[`ALU_SLT] = `ALU_SLTU;
    operation[`ALU_SGE] = `ALU_SGEU;
    operation[`ALU_JMP] = `ALU_JMP ;
    operation[`ALU_ERR] = `ALU_ERR ;


    ALU #(.WIDTH(WIDTH)) uut (
        .a(a),
        .b(b),
        .control(control),
        .clk(clk),
        .out(out),
        .zero(zero),
        .overflow(overflow)
    );

    initial begin
        #10;
        #10 a = 10;
        b = 10;
        for (i = 0; i < 16; i = i + 1) begin
            #10 control = operation;
        end
        $finish;

    end

    always #5 clk = ~clk;
    
endmodule