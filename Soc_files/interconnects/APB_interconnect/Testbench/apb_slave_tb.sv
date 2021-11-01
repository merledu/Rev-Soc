`timescale 1ns/1ns
module apb_slave_tb;
	logic clk;
  logic rst;
  logic wr_in; //write when 1 and read when 0
  logic en;
  logic [2:0] sel_port;
  logic [11:0] addr_in;
  logic [31:0] data_in;
  logic ready;
  logic wr_out1,wr_out2,wr_out3,wr_out4,wr_out5,wr_out6;
  logic [11:0] addr_out1,addr_out2,addr_out3,addr_out4,addr_out5,addr_out6;
  logic [31:0] data_out1,data_out2,data_out3,data_out4,data_out5,data_out6;
  
apb_slave apb_slave_dut(.*);

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
    en=1'b1;
    sel_port=3'b011;
     
end 
endmodule 