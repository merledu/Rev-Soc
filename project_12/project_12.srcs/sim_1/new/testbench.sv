`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2021 19:17:51
// Design Name: 
// Module Name: testbench
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


module testbench(
    output logic core_clk,
    output logic rst_l=0
    );
    logic [31:0] clk_count=0;
    initial begin
    core_clk = 1'b0;
    repeat(20000) #5 core_clk = ~core_clk;
    end
    
    always@(posedge core_clk) begin
    clk_count = clk_count+1'b1;
       rst_l = (clk_count >=5)? 1'b1: 1'b0 ;
    end
    
endmodule
