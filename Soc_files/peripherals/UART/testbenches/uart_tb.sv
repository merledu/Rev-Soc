`timescale 1ns/1ns
module uart_tb(); 
    
  logic clk_i;
  logic rst_ni; 
  logic ren;
  logic we;
  logic [31:0] wdata;
  logic [31:0] rdata;
  logic [7:0]  addr;    
  logic tx_o;
  logic rx_i;
  logic intr_tx;

uart_core utb (.*);

always begin
    #10;
    clk_i=1'b0;
    #10;
    clk_i=1'b1;
end

initial begin
        rst_ni = 1'b0;
        @(posedge clk_i);
        rst_ni = 1'b1;
        ren = 1'b0;
        we = 1'b0;

        @(posedge clk_i);
        addr = 8'd0;
        @(posedge clk_i);
        wdata = 32'd87;
        @(posedge clk_i);
        we = 1'b1;
        @(posedge clk_i);
        we = 1'b0;
        
        @(posedge clk_i);
        addr = 8'd4;
        @(posedge clk_i);
        wdata = 8'b10101010;
        @(posedge clk_i);
        we = 1'b1;
        @(posedge clk_i);
        we = 1'b0;
        
        @(posedge clk_i);
        addr = 8'd16;
        @(posedge clk_i);
        wdata = 1'b1;
        @(posedge clk_i);
        we = 1'b1;
        @(posedge clk_i);
        we = 1'b0;
        
        @(posedge clk_i);
        addr = 8'd16;
        @(posedge clk_i);
        wdata = 1'b0;
        @(posedge clk_i);
        we = 1'b1;
        @(posedge clk_i);
        we = 1'b0;
        repeat (87) begin
            @(posedge clk_i);
        end


        
end
endmodule 