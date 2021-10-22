`timescale 1ns/1ns

module test_bench();
  reg clk,rst,wr_in,ready,sel;
  reg [11:0] addr_in;
  reg [31:0] data_in;
  wire wr_out1,wr_out2,wr_out3,wr_out4,wr_out5,wr_out6;
  wire [11:0] addr_out1,addr_out2,addr_out3,addr_out4,addr_out5,addr_out6;
  wire [31:0] data_out1,data_out2,data_out3,data_out4,data_out5,data_out6;
  wire psel1,psel2,psel3,psel4,psel5,psel6 ;
  
  top top_test (clk,rst,addr_in,wr_in,sel,data_in,
  wr_out1,addr_out1,data_out1,wr_out2,addr_out2,data_out2,
  wr_out3,addr_out3,data_out3,wr_out4,addr_out4,data_out4,
  wr_out5,addr_out5,data_out5,wr_out6,addr_out6,data_out6,
  psel1,psel2,psel3,psel4,psel5,psel6 );

   always
         begin
          #10 
          clk=0;
          #10 
          clk= 1;
      end
    
  initial 
    begin
    @(posedge clk)
    #5 rst=0;addr_in = 12'b000000000000; wr_in = 1;
    ready =1; sel=1; data_in = 32'd4;
    @(posedge clk)
    #5 rst=1;addr_in = 12'b001100000000; wr_in = 1;
    ready =1; sel=1; data_in = 32'd13;
    @(posedge clk)
    #5 rst=1;addr_in = 12'b010000000000; wr_in = 1;
    ready =0; sel=1; data_in = 32'd18;
    @(posedge clk)
    #5 rst=1;addr_in = 12'b010100000000; wr_in = 0;
    ready =1; sel=1; data_in = 32'd9;
    @(posedge clk)
    #5 rst=1;addr_in = 12'b011000000000; wr_in = 1;
    ready =1;sel=1;data_in = 32'd6;
    end
endmodule
