module top (clk,rst,addr_in,wr_in,sel,data_in,
  wr_out1,addr_out1,data_out1,wr_out2,addr_out2,data_out2,
  wr_out3,addr_out3,data_out3,wr_out4,addr_out4,data_out4,
  wr_out5,addr_out5,data_out5,wr_out6,addr_out6,data_out6,
  psel1,psel2,psel3,psel4,psel5,psel6);
  input clk;
  input rst;
  input [11:0] addr_in;
  input wr_in; //write when 1 and read when 0
  input sel;
  input [31:0] data_in;
  output wr_out1,wr_out2,wr_out3,wr_out4,wr_out5,wr_out6;
  output [11:0] addr_out1,addr_out2,addr_out3,addr_out4,addr_out5,addr_out6;
  output [31:0] data_out1,data_out2,data_out3,data_out4,data_out5,data_out6;
  output psel1,psel2,psel3,psel4,psel5,psel6 ;
  
  wire [2:0] sel_port;
  wire en,wr_out,ready;
  wire [11:0] addr_out;
  wire [31:0] data_out;
  
 apb_master apb_m (clk,rst,addr_in,wr_in,ready,sel,
        data_in,sel_port,en,wr_out,addr_out,data_out);
 apb_slave apb_s (clk,rst,wr_in,en,sel_port,addr_in,data_in,ready,
        wr_out1,addr_out1,data_out1,wr_out2,addr_out2,data_out2,
        wr_out3,addr_out3,data_out3,wr_out4,addr_out4,data_out4,
        wr_out5,addr_out5,data_out5,wr_out6,addr_out6,data_out6,
        psel1,psel2,psel3,psel4,psel5,psel6);

endmodule