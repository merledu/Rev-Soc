`timescale 1ns/1ns
module apb_master_tb;
	logic clk;
  logic rst;
	logic [11:0] addr_in;
  logic wr_in; //write when 1 and read when 0
 	logic ready;
	logic sel;
 	logic [31:0] data_in;
 	logic [2:0] sel_port;
	logic en;
	logic wr_out;
	logic [11:0] addr_out;
 	logic [31:0] data_out;

apb_master apb_master_dut(.*);

always begin
    #10;
    clk=1'b0;
    #10;
    clk=1'b1;
end

initial begin
    rst=0;
    @(posedge clk)
    rst=1;
    addr_in = 12'b001100000000; 
    wr_in = 1;
    data_in = 32'd13;
    sel=1;
    ready =1; 
end 
endmodule 