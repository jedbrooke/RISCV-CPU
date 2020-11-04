`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2020 12:20:20 PM
// Design Name: 
// Module Name: register_file
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


module register_file #(parameter WIDTH=32) (
    rs1_addr, rs2_addr, rd_addr, rs1_data, rs2_data, write_data, regWrite
    );
    input [4:0] rs1_addr;
    input [4:0] rs2_addr;
    input [4:0] rd_addr;
    input [WIDTH-1:0] write_data;
    input regWrite;
    output [WIDTH-1:0] rs1_data;
    output [WIDTH-1:0] rs2_data;
   
    
    reg [WIDTH-1:0] registers[0:30]; //31 since x0 is always 0 so we dont need to bother storing it
    
    assign rs1_data = (rs1_addr == 0) ? {WIDTH{1'b0}} : registers[rs1_addr - 1]; //if address is 0, send in hardcoded 0
    assign rs2_data = (rs2_addr == 0) ? {WIDTH{1'b0}} : registers[rs2_addr - 1]; //otherwise subtract 1 from the address, since reg 1 is at addr 0, reg 2 is at 1, etc
    
    always @* begin
        if (regWrite) begin
            if (rd_addr != 0) begin
                registers[rd_addr - 1] = write_data; 
            end 
        end
    end
    
endmodule
