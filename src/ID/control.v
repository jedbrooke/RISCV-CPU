`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2020 12:20:20 PM
// Design Name: 
// Module Name: control
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


module control(
    input [6:0] opcode,
    output reg branch,
    output reg memRead,
    output reg memToReg,
    output reg [1:0] ALUOp,
    output reg memWrite,
    output reg ALUSrc,
    output reg regWrite
    );
    parameter R_OPCODE = 7'b0110011;
    parameter I_OPCODE = 7'b0000011;
    parameter S_OPCODE = 7'b0100011;
    parameter B_OPCODE = 7'b1100111;
    parameter U_OPCODE = 7'b0110111;
    parameter J_OPCODE = 7'b1101111;
    
    always @* begin
        case(opcode) //ALUSrc
            R_OPCODE: ALUSrc = 1'b0; 
            I_OPCODE: ALUSrc = 1'b1;
            S_OPCODE: ALUSrc = 1'b1;
            B_OPCODE: ALUSrc = 1'b0;       
        endcase
        
        case(opcode) //memToReg
            R_OPCODE: memToReg = 1'b0;
            I_OPCODE: memToReg = 1'b1;
            default: memToReg = memToReg;
        endcase
        
        case(opcode) //regWrite
            R_OPCODE: regWrite = 1'b1;
            I_OPCODE: regWrite = 1'b1;
            S_OPCODE: regWrite = 1'b0;
            B_OPCODE: regWrite = 1'b0;
        endcase
        
        case(opcode) //memRead
            I_OPCODE: memRead = 1'b1;
            default: memRead = 1'b0;
        endcase
        
        case(opcode) //memWrite
            S_OPCODE: memWrite = 1'b1;
            default: memWrite = 1'b0;
        endcase
        
        case(opcode) //branch
            B_OPCODE: branch = 1'b1;
            default: branch = 1'b0;
        endcase
        
        case(opcode) //ALUOp
            R_OPCODE: ALUOp = 2'b10;
            B_OPCODE: ALUOp = 2'b01;
            default: ALUOp = 2'b00;
        endcase
        
    end
    
    
endmodule
