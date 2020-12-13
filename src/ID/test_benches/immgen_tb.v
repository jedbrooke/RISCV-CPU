`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2020 11:07:08 AM
// Design Name: 
// Module Name: immgen_tb
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


module immgen_tb(

    );

    parameter WIDTH = 64;

    reg [31:0] instruction = 0;
    wire [WIDTH-1:0] immediate;

    reg [WIDTH-1:0] PC = 0; 

    reg [7:0] instruction_mem [0:255];
    initial begin
        $readmemh("code.mem",instruction_mem);
    end

    always begin
        #10 PC = PC+4;
        instruction = {instruction_mem[PC],instruction_mem[PC+1],instruction_mem[PC+2],instruction_mem[PC+3]};
    end

    always #150 $finish;


    immediate_generator #(.WIDTH(WIDTH))immgen (
        .instruction(instruction),
        .immediate(immediate)
    );

    

endmodule
