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
    reg [3:0] control = 4'b0;
    reg clk = 0;
    wire [WIDTH-1:0] out;
    wire zero;
    wire overflow;
    integer i = 0;


    reg [15:0] operation [3:0];
    operation[4'b0000] = 4'b0000; // ALU_ADD 
    operation[4'b1000] = 4'b1000; // ALU_SUB 
    operation[4'b0001] = 4'b0001; // ALU_SLL 
    operation[4'b0100] = 4'b0100; // ALU_XOR 
    operation[4'b0101] = 4'b0101; // ALU_SRL 
    operation[4'b1101] = 4'b1101; // ALU_SRA 
    operation[4'b0110] = 4'b0110; // ALU_OR  
    operation[4'b0111] = 4'b0111; // ALU_AND 
    operation[4'b0010] = 4'b0010; // ALU_SLT 
    operation[4'b1010] = 4'b1010; // ALU_SGE 
    operation[4'b0011] = 4'b0011; // ALU_SLTU
    operation[4'b1011] = 4'b1011; // ALU_SGEU
    operation[4'b1110] = 4'b1110; // ALU_JMP 
    operation[4'b1111] = 4'b1111; // ALU_ERR 


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
        operation[4'b0000] = 4'b0000;
        operation[4'b1000] = 4'b1000;
        operation[4'b0001] = 4'b0001;
        operation[4'b0100] = 4'b0100;
        operation[4'b0101] = 4'b0101;
        operation[4'b1101] = 4'b1101;
        operation[4'b0110] = 4'b0110;
        operation[4'b0111] = 4'b0111;
        operation[4'b0010] = 4'b0010;
        operation[4'b1010] = 4'b1010;
        operation[4'b0011] = 4'b0011;
        operation[4'b1011] = 4'b1011;
        operation[4'b1110] = 4'b1110;
        operation[4'b1111] = 4'b1111;
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