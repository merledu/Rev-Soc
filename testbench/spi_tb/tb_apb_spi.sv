  module tb_spi_master #(
  parameter BUFFER_DEPTH   = 10,
  parameter APB_ADDR_WIDTH = 12  //APB slaves are 4KB by default
  )
  (
    output  logic                      HCLK,
    output  logic                      HRESETn,
    output  logic [APB_ADDR_WIDTH-1:0] PADDR,
    output  logic               [31:0] PWDATA,
    output  logic                      PWRITE,
    output  logic                      PSEL,
    output  logic                      PENABLE,
    
    input logic                 [31:0] PRDATA,
    input logic                      PREADY,
    input logic                      PSLVERR,

    input logic                 [1:0] events_o,

    input logic                      spi_clk,
    input logic                      spi_csn0,
    input logic                      spi_csn1,
    input logic                      spi_csn2,
    input logic                      spi_csn3,
    input logic                [1:0] spi_mode,
    input logic                      spi_sdo0,
    input logic                      spi_sdo1,
    input logic                      spi_sdo2,
    input logic                      spi_sdo3,

    output  logic                      spi_sdi0,
    output  logic                      spi_sdi1,
    output  logic                      spi_sdi2,
    output  logic                      spi_sdi3
    );


    localparam LOG_BUFFER_DEPTH = `log2(BUFFER_DEPTH);

 
    initial begin
      HCLK = 1'b0;
      forever #10 HCLK = ~HCLK;
    end

    initial begin
  
  ///    @(HCLK) begin  // Reset and initialization   
        HRESETn  =  1'b0;
        PADDR    = 12'd0;
        PWDATA   = 32'd0;
        PWRITE   =  1'b0;
        PSEL     =  1'b0;
        PENABLE  =  1'b0;
        spi_sdi0 =  1'b0;
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
     // end
 



      @(posedge HCLK) begin   
        HRESETn =  1'b1;   // Reset released
        PADDR   = 12'd0;
        PWDATA  = 32'd0;
        PWRITE  =  1'b0;
        PSEL    =  1'b0;
        PENABLE =  1'b0;
        spi_sdi0 =  1'b0;
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end

      @(posedge HCLK) begin   
        HRESETn =  1'b1;   // Spi Clk Divider set to 1
        PADDR   = 12'h04;
        PWDATA  = 6'd0;
        PWRITE  =  1'b0;
        PSEL    =  1'b1;
        PENABLE =  1'b1;
        spi_sdi0 =  1'b0;
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end

      @(posedge HCLK) begin   
        HRESETn =  1'b1;   // Spi Clk Divider set to 1
        PADDR   = 6'h04;
        PWDATA  = 32'd0;
        PWRITE  =  1'b1;
        PSEL    =  1'b1;
        PENABLE =  1'b1;
        spi_sdi0 =  1'b0;
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end

      @(posedge HCLK) begin   
        HRESETn =  1'b1;  // Data lenth addres length and cmd length config
        PADDR   = 12'h10;
        PWDATA  = {16'd16,2'd0,6'd16,2'd0,6'd16}; // Each length configured to 16 bit
        PWRITE  =  1'b0;      // Write is disabled
        PSEL    =  1'b1;      // Peripheral is sellected
        PENABLE =  1'b1;      // Peripheral enabled
        spi_sdi0 =  1'b0;     
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end

      @(posedge HCLK) begin   
        HRESETn =  1'b1;  // Data lenth addres length and cmd length config
        PADDR   = 12'h10;
        PWDATA  = {16'd32,2'd0,6'd32,2'd0,6'd8}; // Each length configured to 32 bit
        PWRITE  =  1'b1;      // Write is enabled
        PSEL    =  1'b1;      // Peripheral is sellected
        PENABLE =  1'b1;      // Peripheral enabled
        spi_sdi0 =  1'b0;     
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end


      @(posedge HCLK) begin   
        HRESETn =  1'b1;   // Spi CMD set to 1
        PADDR   = 12'h08;
        PWDATA  = 8'd1;
        PWRITE  =  1'b0;
        PSEL    =  1'b1;
        PENABLE =  1'b1;
        spi_sdi0 =  1'b0;
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end

      @(posedge HCLK) begin   
        HRESETn =  1'b1;   // Spi CMD  set to 1
        PADDR   = 12'h04;
        PWDATA  = 8'd1;
        PWRITE  =  1'b1;
        PSEL    =  1'b1;
        PENABLE =  1'b1;
        spi_sdi0 =  1'b0;
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end



       @(posedge HCLK) begin   
        HRESETn =  1'b1;   // Spi Address
        PADDR   = 12'h0C;
        PWDATA  = 32'h0000000F;
        PWRITE  =  1'b0;
        PSEL    =  1'b1;
        PENABLE =  1'b1;
        spi_sdi0 =  1'b0;
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end

       @(posedge HCLK) begin   
        HRESETn =  1'b1;   // Spi Address
        PADDR   = 12'h0C;
        PWDATA  = 32'h0000000F;
        PWRITE  =  1'b1;
        PSEL    =  1'b1;
        PENABLE =  1'b1;
        spi_sdi0 =  1'b0;
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end




      @(posedge HCLK) begin   
        HRESETn =  1'b1;   // Dummy Write cycles configured to 16 and dummy rd cycles also set to 16
        PADDR   = 12'h14;
        PWDATA  = {16'd8,16'd8};
        PWRITE  =  1'b0;
        PSEL    =  1'b1;
        PENABLE =  1'b1;
        spi_sdi0 =  1'b0;
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end

      @(posedge HCLK) begin   
        HRESETn =  1'b1;   // Dummy Write cycles configured to 16 and dummy rd cycles also set to 16
        PADDR   = 12'h14;
        PWDATA  = {16'd8,16'd8};
        PWRITE  =  1'b1;
        PSEL    =  1'b1;
        PENABLE =  1'b1;
        spi_sdi0 =  1'b0;
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end
   

      @(posedge HCLK) begin   
        HRESETn =  1'b1;   // DATA to Write on fifo and then it is gonna transmit
        PADDR   = 12'h18;
        PWDATA  = 32'b1010_1010_1010_1010_1010_1010_1010_1010;
        PWRITE  =  1'b0;
        PSEL    =  1'b1;
        PENABLE =  1'b1;
        spi_sdi0 =  1'b0;
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end

      @(posedge HCLK) begin   
        HRESETn =  1'b1;   // DATA to Write on fifo and then it is gonna transmit
        PADDR   = 12'h18;
        PWDATA  = 32'b1010_1010_1010_1010_1010_1010_1010_1010;
        PWRITE  =  1'b1;
        PSEL    =  1'b1;
        PENABLE =  1'b1;
        spi_sdi0 =  1'b0;
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end




      @(posedge HCLK) begin     // Providing adress of status register and selecting the peripheral
        HRESETn  =  1'b1;
        PADDR    = 12'h00;       // Adress == status reg
        PWDATA   = {23'd0,1'b1,6'd0,2'd2};       // data to enable spi write in standard mode
        PWRITE   =  1'b0;       // write enable signal
        PSEL     =  1'b1;       // periphral sellected
        PENABLE  =  1'b1;       // Peripheral Enabled
        spi_sdi0 =  1'b0;
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end

      @(posedge HCLK) begin     // Providing adress of status register and selecting the peripheral
        HRESETn  =  1'b1;
        PADDR    = 12'h00;       // Adress == status reg
        PWDATA   = {23'd0,1'b1,6'd0,2'd2};       // data to enable spi write in standard mode
        PWRITE   =  1'b1;       // write enable signal
        PSEL     =  1'b1;       // periphral sellected
        PENABLE  =  1'b1;       // Peripheral Enabled
        spi_sdi0 =  1'b0;
        spi_sdi1 =  1'b0;
        spi_sdi2 =  1'b0;
        spi_sdi3 =  1'b0;
      end





    end




  endmodule
