`timescale 1ns/1ns
module uart_rx_tb(); 
    
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

        //baud rate
        @(posedge clk_i);
        addr = 8'd0;
        @(posedge clk_i);
        wdata = 32'd87;
        @(posedge clk_i);
        we = 1'b1;
        @(posedge clk_i);
        we = 1'b0;
        
        //rx_en
        @(posedge clk_i);
        addr = 8'd12;
        @(posedge clk_i);
        wdata = 1'b1;
        rx_i = 1'b0;            //first bit
         @(posedge clk_i);
        we = 1'b1;
        @(posedge clk_i);
        we = 1'b0;
        repeat (87) begin
            @(posedge clk_i);
        end
       
        
        @(posedge clk_i);
        rx_i = 1'b1;            //second bit
        repeat (87) begin
            @(posedge clk_i);
        end
        @(posedge clk_i);
        we = 1'b1;
        @(posedge clk_i);
        we = 1'b0;

        @(posedge clk_i);
        rx_i = 1'b0;            //third bit
        repeat (87) begin
            @(posedge clk_i);
        end
        @(posedge clk_i);
        we = 1'b1;
        @(posedge clk_i);
        we = 1'b0;

        @(posedge clk_i);
        rx_i = 1'b1;            //fourth bit
        repeat (87) begin
            @(posedge clk_i);
        end
        @(posedge clk_i);
        we = 1'b1;              
        @(posedge clk_i);
        we = 1'b0;

        @(posedge clk_i);
        rx_i = 1'b0;            //fifth bit
        repeat (87) begin
            @(posedge clk_i);
        end
        @(posedge clk_i);
        we = 1'b1;
        @(posedge clk_i);
        we = 1'b0;

        @(posedge clk_i);
        rx_i = 1'b1;            //SIXTH BIT
        repeat (87) begin
            @(posedge clk_i);
        end
        @(posedge clk_i);
        we = 1'b1;
        @(posedge clk_i);
        we = 1'b0;

        @(posedge clk_i);
        rx_i = 1'b0;            //7th bit
        repeat (87) begin
            @(posedge clk_i);
        end
        @(posedge clk_i);
        we = 1'b1;
        @(posedge clk_i);
        we = 1'b0;

        @(posedge clk_i);
        rx_i = 1'b1;            //8th bit
        repeat (87) begin
            @(posedge clk_i);
        end
        @(posedge clk_i);
        we = 1'b1;
        @(posedge clk_i);
        we = 1'b0;

        @(posedge clk_i);
        rx_i = 1'b0;            //9th bit
        repeat (87) begin
            @(posedge clk_i);
        end
        @(posedge clk_i);
        we = 1'b1;
        @(posedge clk_i);
        we = 1'b0;
        
        @(posedge clk_i);
        rx_i = 1'b1;            //10th
        repeat (87) begin
            @(posedge clk_i);
        end
        @(posedge clk_i);
        we = 1'b1;
        @(posedge clk_i);
        we = 1'b0;

        @(posedge clk_i);
        addr = 8'd8;
	    repeat (87) begin
            @(posedge clk_i);
        end
        
        @(posedge clk_i);
        addr = 8'd20;
        
        
end
endmodule 