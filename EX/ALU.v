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


module ALU #(parameter WIDTH=32)(
    a,b,control,out,zero,overflow
    );
`include "parameters.vh"
    input [WIDTH-1:0] a;
    input [WIDTH-1:0] b;
    input [16:0] control; //{opcode,func3,func6/7}as per RISC-V standard
    output reg [WIDTH-1:0] out;
    output zero;
    output overflow;
  
    
    //shifts
    wire [WIDTH-1:0] SLL;
    wire [WIDTH-1:0] SRL;
    wire [WIDTH-1:0] SRA;
    
    //arithmetic
    wire [WIDTH-1:0] ADD;
    wire ADD_OF;
    wire [WIDTH-1:0] SUB;
    wire SUB_OF;
    wire [WIDTH-1:0] LUI;
    
    
    //logical
    wire [WIDTH-1:0] XOR;
    wire [WIDTH-1:0] OR;
    wire [WIDTH-1:0] AND;
    
    //comparison
    wire [WIDTH-1:0] LT;
    wire [WIDTH-1:0] LTU;
    
    assign SLL = a << b;
    assign SRL = a >> b;
    assign SRA = {{WIDTH{a[WIDTH-1]? 1 : 0}},a} >> b;
    
    add_and_subtract #(.WIDTH(WIDTH)) adder (.a(a), .b(b), .cout(ADD_OF), .sum(ADD), .subtract(1'b0));
    add_and_subtract #(.WIDTH(WIDTH)) suber (.a(a), .b(b), .cout(SUB_OF), .sum(SUB), .subtract(1'b1));
    assign LUI = {a[11:0],b[WIDTH-12:0]};
    
    assign XOR = a ^ b;
    assign OR = a | b;
    assign AND = a & b;
    
    
    wire [WIDTH:0] a_LT_temp;
    add_and_subtract #(.WIDTH(WIDTH)) a_temp_adder(.a(a), .b(1 << (WIDTH - 1)), .cout(a_LT_temp[WIDTH]), .sum(a_LT_temp[WIDTH-1:0]), .subtract(1'b0));
    wire [WIDTH:0] b_LT_temp;
    add_and_subtract #(.WIDTH(WIDTH)) b_temp_adder(.a(b), .b(1 << (WIDTH - 1)), .cout(b_LT_temp[WIDTH]), .sum(b_LT_temp[WIDTH-1:0]), .subtract(1'b0));
    assign LT = a_LT_temp < b_LT_temp;
    assign LTU = a < b;
    
   
    always @* begin
        case(control)
            `ADD_instr:  out = ADD;
            `ADDI_instr: out = ADD;
            `SUB_instr:  out = SUB;
            `SLL_instr:  out = SLL;
            `SLLI_instr: out = SLL;
            `SRL_instr:  out = SRL;
            `SRA_instr:  out = SRA;
            `SRAI_instr: out = SRA;
            `AND_instr:  out = AND;
            `ANDI_instr: out = AND;
            `XOR_instr:  out = XOR;
            `XORI_instr: out = XOR;
            `OR_instr:   out = OR ;
            `ORI_instr:  out = OR ;
            
            default: out = {WIDTH{1'b0}};
        endcase
    end
    
    assign overflow =   (control == `ADD_instr || control == `ADDI_instr || control == `SUB_instr) ?
                        ((control == `ADD_instr || control == `ADDI_instr) ? ADD_OF : SUB_OF): 1'b0;
   
     
    assign zero = (out == {WIDTH{1'b0}});              
endmodule
