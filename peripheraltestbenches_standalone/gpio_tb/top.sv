`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2022 20:16:54
// Design Name: 
// Module Name: top
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


module top#(  // parameters
    GPIO_PINS  = 32, // Must be a multiple of 8
    PADDR_SIZE = 4,
    STAGES     = 2   // Steges to add more stability to input)(
 )
 ( output logic HCLK=0,
  output logic HRESETn=0);
 
        always begin : clk_gen
            #10 HCLK = ~HCLK;
        end
        initial begin
            #20 HRESETn = 1'b1;
        
        end
    
        logic [GPIO_PINS-1:0]   gpio_i;
        logic                   PSEL;
        logic                   PENABLE;
        logic [PADDR_SIZE-1:0]  PADDR;
        logic                   PWRITE;
        logic [GPIO_PINS-1:0]   PWDATA;
        logic [GPIO_PINS/8-1:0] PSTRB;
        
        logic                    PREADY;
        logic [GPIO_PINS-1:0]    PRDATA;
        logic                    PSLVERR;
        logic                    irq_o;
        logic [GPIO_PINS-1:0]    gpio_o,
                                        gpio_oe;
                                    
        rev_gpio #(
        .GPIO_PINS(GPIO_PINS),
        .PADDR_SIZE(PADDR_SIZE),
        .STAGES(STAGES)
        ) dut (
        
        .pclk(HCLK),
        .gpio_i(gpio_i),
        .prstn(HRESETn),
        .psel(PSEL),
        .paddr(PADDR),
        .penable(PENABLE),
        .pwrite(PWRITE),
        .pwrdata(PWDATA),
        .prddata(PRDATA),
        .pstrb(PSTRB),
        .pready(PREADY),
        .pslverr(PSLVERR),
        .irq_o(irq_o),
        .gpio_o(gpio_o),
        .gpio_oe(gpio_oe)
        
        );    
        gpio_testbench #(.GPIO_PINS(GPIO_PINS),
            .PADDR_SIZE(PADDR_SIZE),
            .STAGES(STAGES)  )
        tb(.*);                           
                                        
    endmodule


