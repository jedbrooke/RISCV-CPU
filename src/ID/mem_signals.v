`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2020 01:39:37 AM
// Design Name: 
// Module Name: mem_signals
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


module mem_signals(
    opcode,func3,memControl
    );
`include "parameters.vh"
    input [6:0] opcode;
    input [2:0] func3;
    output reg [2:0] memControl;
    
    reg [2:0] memControl_load;
    reg [2:0] memControl_store;
        
    always @* begin
        case(func3)
            `LB_func3: memControl_load <= `MEM_BYTE;
            `LBU_func3: memControl_load <= `MEM_BYTE_U;
            `LH_func3: memControl_load <= `MEM_HALFWORD;
            `LHU_func3: memControl_load <= `MEM_HALFWORD_U;
            `LW_func3: memControl_load <= `MEM_WORD;
            `LWU_func3: memControl_load <= `MEM_WORD_U;
            `LD_func3: memControl_load <= `MEM_DWORD;
            default: memControl_load <= 3'b0;
        endcase
        
        case(func3)
            `SB_func3: memControl_store <= `MEM_BYTE;
            `SH_func3: memControl_store <= `MEM_HALFWORD;
            `SW_func3: memControl_store <= `MEM_WORD;
            `SD_func3: memControl_store <= `MEM_DWORD;
            default: memControl_store <= 3'b0;
        endcase
        
        case(opcode)
            `IL_OPCODE: memControl <= memControl_load;
            `S_OPCODE: memControl <= memControl_store;
            default: memControl <= 3'b0;
        endcase
    end
    
    
    
    
endmodule
