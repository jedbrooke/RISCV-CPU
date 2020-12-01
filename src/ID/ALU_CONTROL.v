`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2020 10:28:50 PM
// Design Name: 
// Module Name: ALU_CONTROL
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


module ALU_CONTROL(
    funct7bit,funct3,ALUOp,ALU_control
    );
`include "parameters.vh"
    input funct7bit;
    input [2:0] funct3;
    input [1:0] ALUOp;
    output reg [3:0] ALU_control;
    /* 
        ALU function: [inverse | function]
        function is just funct3 for arithmetic types
        inverse turns add into sub
        logical shift into arithmetic shift

    */

    reg [3:0] alu_control_branch;

    //we want to apply an alu op such that the relational comparison between the operands to the branch will result in a 0 if it is true
    always @* begin
        case(funct3)
            `BEQ_func3: alu_control_branch = `ALU_XOR; //if rs1 and rs2 are equal, rs1^rs2=0
            `BNE_func3: alu_control_branch = {1'b1,`XOR_func3}; //if rs1 and rs2 are not equal, ~(rs1^rs2) = 0
            `BLT_func3: alu_control_branch = `ALU_SLT;
            `BGE_func3: alu_control_branch = {1'b1,`SLT_func3};
            `BLTU_func3: alu_control_branch = `ALU_SLTU;
            `BGEU_func3: alu_control_branch = {1'b1,`SLTU_func3};
            default: alu_control_branch = `ALU_XOR;
        endcase
    end


    
    always @* begin
        case(ALUOp)
            `ALUOp_jmp: ALU_control = `ALU_JMP;
            `ALUOp_branch: ALU_control = `ALU_SUB;
            `ALUOp_arithmetic: ALU_control = {funct7bit,funct3};
            `ALUOp_ldst: ALU_control = `ALU_ADD;

        endcase
    end
    
    
    
endmodule
