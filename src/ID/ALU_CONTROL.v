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
    instruction,ALUOp,ALU_control
    );
`include "parameters.vh"
    input [31:0] instruction;
    input [1:0] ALUOp;
    output reg [3:0] ALU_control;
    /* 
        ALU function: [inverse | function]
        function is just funct3 for arithmetic types
        inverse turns add into sub
        logical shift into arithmetic shift

    */
    wire funct7bit = instruction[30];
    wire [2:0] funct3 = instruction[14:12];
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
            `ALUOp_branch: ALU_control = alu_control_branch;
            `ALUOp_arithmetic: ALU_control = {(instruction[6:0] == `R_OPCODE) ? funct7bit : 1'b0,funct3};
            `ALUOp_ldst: ALU_control = `ALU_ADD;

        endcase
    end
    
    
    
endmodule
