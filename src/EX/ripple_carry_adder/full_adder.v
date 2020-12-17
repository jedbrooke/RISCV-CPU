`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2020 11:49:12 AM
// Design Name: 
// Module Name: full_adder
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
module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );
    
    wire c1;
    wire c2;
    wire s1;
    half_adder h1( .a(a), .b(b), .cout(c1), .sum(s1) );
    half_adder h2( .a(s1), .b(cin), .cout(c2), .sum(sum) );
    assign cout = c1 | c2;
    
    
endmodule
