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
`include "parameters.vh"
    always @* begin
        case(opcode) //ALUSrc
            `R_OPCODE: ALUSrc = 1'b0; 
            `IA_OPCODE: ALUSrc = 1'b1;
            `IL_OPCODE: ALUSrc = 1'b1;
            `S_OPCODE: ALUSrc = 1'b1;
            `B_OPCODE: ALUSrc = 1'b0;
            default: ALUSrc = ALUSrc;       
        endcase
        
        // only write from mem to reg on loads
        case(opcode) //memToReg
            `IL_OPCODE: memToReg = 1'b1;
            default: memToReg = 1'b0;
        endcase
        
        //write to reg for reg and imm types, but not for stores and branch
        case(opcode) //regWrite
            `R_OPCODE: regWrite = 1'b1;
            `IA_OPCODE: regWrite = 1'b1;
            `IL_OPCODE: regWrite = 1'b1;
            `S_OPCODE: regWrite = 1'b0;
            `B_OPCODE: regWrite = 1'b0;
        endcase
        
        // only read from mem on load instructions
        case(opcode) //memRead
            `IL_OPCODE: memRead = 1'b1;
            default: memRead = 1'b0;
        endcase
        
        // only write to mem on store instructions
        case(opcode) //memWrite
            `S_OPCODE: memWrite = 1'b1;
            default: memWrite = 1'b0;
        endcase
        
        // only brand on branch instructions
        case(opcode) //branch
            `B_OPCODE: branch = 1'b1;
            `J_OPCODE: branch = 1'b1;
            default: branch = 1'b0;
        endcase
        
        // for each instruction type tell the ALU to do the right thing
        case(opcode) //ALUOp
            `R_OPCODE: ALUOp = `ALUOp_arithmetic;
            `IA_OPCODE: ALUOp = `ALUOp_arithmetic;
            `IL_OPCODE: ALUOp = `ALUOp_ldst;
            `S_OPCODE: ALUOp = `ALUOp_ldst;
            `B_OPCODE: ALUOp = `ALUOp_branch;
            `J_OPCODE: ALUOp = `ALUOp_jmp;
            default: ALUOp = 2'b00;
        endcase
        
    end
    
    
endmodule
