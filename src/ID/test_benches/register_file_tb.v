`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2020 11:34:45 AM
// Design Name: 
// Module Name: register_file_tb
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


module register_file_tb(

    );
    
    reg clk;
    reg rst;
    parameter WIDTH = 32;
    
    reg [4:0] rs1_addr;
    reg [4:0] rs2_addr;
    reg [4:0] rd_addr;
    reg [WIDTH-1:0] write_data;
    reg regWrite;
    wire [WIDTH-1:0] rs1_data;
    wire [WIDTH-1:0] rs2_data;
    integer i = 0;
    
    register_file #(.WIDTH(WIDTH)) uut (
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .write_data(write_data),
        .regWrite(regWrite),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .clk(clk),
        .rst(rst)
    );
    
    initial begin
        rs1_addr = 0;
        rs2_addr = 0;
        rd_addr = 0;
        write_data = 0;
        regWrite = 0;
        clk = 0;
        rst = 1'b1;
        #10 rst = 1'b0;
        //set regWrite to 1 so we can write to regs
        #10 regWrite = 1'b1;
        //write data to all the addresses so we can read it back later
        for (i = 0; i < 32; i=i+1) begin
            //increment the address every clock cycle
            #10;
            rd_addr = rd_addr + 1'b1;
            write_data = 32'd10 * i;
        end
        #10 regWrite = 1'b0;
        #10 write_data = {WIDTH{1'b0}};
        //this time write_data is 0 so nothing should get written
        for (i = 0; i < 32; i=i+1) begin
            //increment the address every clock cycle
            #10 rd_addr = rd_addr + 1'b1;
        end
        
        //read the data back from all the addresses to rs1 and rs1, should read the data from before and not 0
        for (i = 0; i < 32; i=i+1) begin
            //increment the address every clock cycle
            #10;
            rs1_addr = i;
            rs2_addr = 31 - i;
        end
        
        #10 $finish;
    end
    
    always #5 clk = ~clk;
    
endmodule
