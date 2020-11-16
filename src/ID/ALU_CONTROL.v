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
    
    always @* begin
        case(ALUOp)
            2'b00: ALU_control = `ALU_ADD;
            2'b01: ALU_control = `ALU_SUB;
            2'b10: ALU_control = (funct3 == 3'b000) ? 
                                    (funct7bit ? `ALU_SUB : `ALU_ADD) :
                                    ((funct3 == 3'b111) ? 
                                        (`ALU_AND) : 
                                        ((funct3 == 3'b110) ?
                                            (`ALU_OR) : 
                                            (`ALU_ERR)
                                         )
                                     );
           default: ALU_control = `ALU_ERR;
        endcase
    end
    
    
    
endmodule
