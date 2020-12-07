`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2020 10:45:38 AM
// Design Name: 
// Module Name: CPU_tb
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


module CPU_tb(

    );
    
    reg clk = 0;
    reg rst = 1;
    
    CPU uut(.clk(clk), .rst(rst));
    
    initial begin
       #4 rst = 0;
       #1500 $finish; 
    end
    
    
    always #5 clk = ~clk;
endmodule
