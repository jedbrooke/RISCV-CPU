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
    a,b,control,clk,out,zero,overflow
    );
`include "parameters.vh"
    input [WIDTH-1:0] a;
    input [WIDTH-1:0] b;
    input [3:0] control;
    /* 
        ALU function: [inverse | function]
        function is just funct3 for arithmetic types
        inverse turns add into sub
        logical shift into arithmetic shift
        inverts output of xor
        inverts LT to GE

    */
    input clk;
    output reg [WIDTH-1:0] out;
    output zero;
    output overflow;

    wire inverse = control[3];
    wire [2:0] func3 = control[2:0];
  
    
    //shifts
    wire [WIDTH-1:0] SL;
    wire [WIDTH-1:0] SR;
    wire [WIDTH-1:0] SRA;
    
    //arithmetic
    wire [WIDTH-1:0] ADD;

    wire [WIDTH-1:0] LUI;
    
    
    //logical
    wire [WIDTH-1:0] XOR;
    wire [WIDTH-1:0] OR;
    wire [WIDTH-1:0] AND;
    
    //comparison
    wire [WIDTH-1:0] LT;
    wire [WIDTH-1:0] LTU;
    
    assign SL = a << b;
    assign SRA = {{WIDTH{a[WIDTH-1]? 1 : 0}},a} >> b;
    assign SR = inverse ? SRA : a >> b;

    add_and_subtract #(.WIDTH(WIDTH)) adder (.a(a), .b(inverse ? ~b : b), .cout(overflow), .sum(ADD), .subtract(inverse));
    assign LUI = {a[11:0],b[WIDTH-12:0]};
    
    assign XOR = inverse ? ~(a ^ b) : a ^ b;
    assign OR  = inverse ? ~(a | b) : a | b;
    assign AND = inverse ? ~(a & b) : a & b;
    
    
    wire [WIDTH:0] a_LT_temp;
    add_and_subtract #(.WIDTH(WIDTH)) a_temp_adder(.a(a), .b(1 << (WIDTH - 1)), .cout(a_LT_temp[WIDTH]), .sum(a_LT_temp[WIDTH-1:0]), .subtract(1'b0));
    wire [WIDTH:0] b_LT_temp;
    add_and_subtract #(.WIDTH(WIDTH)) b_temp_adder(.a(b), .b(1 << (WIDTH - 1)), .cout(b_LT_temp[WIDTH]), .sum(b_LT_temp[WIDTH-1:0]), .subtract(1'b0));
    
    assign LT = inverse ? ~(a_LT_temp < b_LT_temp) : a_LT_temp < b_LT_temp;
    assign LTU = inverse ? ~(a < b) : a < b;
    
   
    always @(posedge clk) begin
        case(func3)
            `ADD_func3: out <= ADD;
            `SL_func3 : out <= SL;
            `SR_func3 : out <= SR;
            `XOR_func3: out <= XOR;
            `SRA_func3: out <= SRA;
            `OR_func3 : out <= OR;
            `AND_func3: out <= AND;
            `SLT_func3: out <= LT;
            `SLTU_func3: out <= LTU;
            default: out = {WIDTH{1'b0}};
        endcase
    end

    always @* begin
        if(control == `ALU_ERR) begin
            $finish;
        end
    end
   
    // if it's a comparison set it to the result, else set to if result == 0
    assign zero = ((func3 == `SLT_func3 | func3 == `SLTU_func3) ? 
                    (func3 == `SLT_func3) ? LT : LTU
                    :(out == {WIDTH{1'b0}})) | (control == `ALU_JMP);              
endmodule
