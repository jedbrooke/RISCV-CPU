`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2020 12:06:40 PM
// Design Name: 
// Module Name: add_and_subtract
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

module add_and_subtract(
   a,b,cout,sum,subtract
    );
    parameter WIDTH = 32;
    input [WIDTH-1:0] a;
    input [WIDTH-1:0] b;
    output cout;
    output [WIDTH-1:0] sum;
    input subtract;
    
    wire [WIDTH-1:0] carry;
    assign carry[0] = subtract;
    generate
        genvar i;
        for (i = 0; i < WIDTH; i=i+1) begin
            if( i == WIDTH - 1) begin
                full_adder fa(.a(a[i]), .b(b[i] ^ subtract), .cin(carry[i]), .cout(cout),       .sum(sum[i]) );
            end else begin
                full_adder fa(.a(a[i]), .b(b[i] ^ subtract), .cin(carry[i]), .cout(carry[i+1]), .sum(sum[i]) );
            end 
        end
    endgenerate
    
endmodule
