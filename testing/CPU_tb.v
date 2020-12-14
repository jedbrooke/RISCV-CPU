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
    integer f,i;
    CPU uut(.clk(clk), .rst(rst));
    
    initial begin
       #4 rst = 0;      
    end
    always @(posedge clk) begin
        if(uut.instruction == 32'hFFFFFFFF) begin
           f = $fopen("output.mem","w");
           for (i = 0; i < 1023; i = i + 1) begin
                $display("%h",uut.MEM_stage.data_memory[i]);
                $fwrite(f,"%h",uut.MEM_stage.data_memory[i]);
           end
           $fclose(f);
           $finish; 
        end
    end
    
    always #5 clk = ~clk;
endmodule
