`timescale 1ns / 1ns
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
    output logic clk_in1,
    output logic rst=1
    );
    logic [31:0] clk_count=0;
    initial begin
    clk_in1 = 1'b0;
    repeat(40000) #5 clk_in1 = ~clk_in1;
    end
    
    always@(posedge clk_in1) begin
    
       if(clk_count >=5)
       rst=1'b0;
       clk_count = clk_count+1'b1;
    end
    
endmodule
