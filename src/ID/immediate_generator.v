`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2020 12:20:20 PM
// Design Name: 
// Module Name: immediate_generator
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


module immediate_generator #(parameter WIDTH=32)(
    input [31:0] instruction,
    output reg [WIDTH-1:0] immediate
    );
    
    wire [6:0] opcode = instruction[6:0];
    parameter R_OPCODE  = 7'b0110011;
    parameter IL_OPCODE = 7'b0000011; //load instrcutions
    parameter IA_OPCODE = 7'b0010011; //arithmetic immdetaite instructions
    parameter S_OPCODE  = 7'b0100011;
    parameter B_OPCODE  = 7'b1100111;
    parameter U_OPCODE  = 7'b0110111;
    parameter J_OPCODE  = 7'b1101111;
    
    wire [WIDTH-1:0] R_imm = {WIDTH{1'b0}};
    wire [WIDTH-1:0] I_imm = {{(WIDTH-12){instruction[31]}},instruction[31:20]};
    wire [WIDTH-1:0] S_imm = {{(WIDTH-12){instruction[31]}},instruction[31:25],instruction[11:7]};
    wire [WIDTH-1:0] B_imm = {{(WIDTH-12){instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8]};
    wire [WIDTH-1:0] U_imm = {instruction[31:12],{(WIDTH-20){1'b0}}};
    wire [WIDTH-1:0] J_imm = {{(WIDTH-20){instruction[31]}},instruction[31],instruction[19:12],instruction[20],instruction[30:21]};
    
    always @* begin
        case(opcode)
            R_OPCODE:  immediate = R_imm;
            IA_OPCODE: immediate = I_imm;
            IL_OPCODE: immediate = I_imm;
            S_OPCODE:  immediate = S_imm;
            B_OPCODE:  immediate = B_imm;
            U_OPCODE:  immediate = U_imm;
            J_OPCODE:  immediate = J_imm;
            
            default: immediate = {WIDTH{1'b0}};
        endcase
    end
endmodule
