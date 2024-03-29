//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.12.2021 15:48:27
// Designer Name: Rehan Ejaz 
// Designe Name: APB timer Peripheral
// Module Name: apb_timer
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


module apb_timer
#(parameter APB_ADDR_WIDTH = 12,
  APB_DATA_WIDTH = 32 )(
  input  logic                      HCLK,
  input  logic                      HRESETn,
  input  logic [APB_ADDR_WIDTH-1:0] PADDR,
  input  logic               [31:0] PWDATA,
  input  logic                      PWRITE,
  input  logic                      PSEL,
  input  logic                      PENABLE,
  output logic               [31:0] PRDATA,
  output logic                      PREADY,
  output logic                      PSLVERR,
  output reg                 irq_o //  cmp interrupt
  );

    // Wires to connect wicth the peripheral
   
    logic [APB_ADDR_WIDTH-1:0] PADDR_p;
    logic               [31:0] PWDATA_p;
    logic                      PWRITE_p;
    logic               [31:0] PRDATA_p;
    logic                      PREADY_p;
    logic                      PSLVERR_p;
    logic interrupt;
    
    rv_timer #(
      .AW(APB_ADDR_WIDTH),
      .DW(APB_DATA_WIDTH)
    ) timer_instance (
      .clk_i(HCLK),
      .rst_ni(HRESETn),
      .reg_we(PWRITE),
      .reg_re(~PWRITE),
      .reg_addr(PADDR_p),
      .reg_wdata(PWDATA_p),
      .reg_be(4'b1111),
      .reg_rdata(PRDATA_p),
      .reg_error(PSLVERR_p),
//      .intr_timer_expired_0_0_o()//irq_o)
      .intr_timer_expired_0_0_o(interrupt)
    );
    assign PREADY =1'b1;
   assign irq_o = interrupt;
   assign PRDATA = (PADDR_p == 32'h200 )? {31'd0,interrupt} : PADDR_p;
   
//   logic [3:0] count;
//   always @(posedge HCLK or negedge HRESETn) begin
//       if(HRESETn == 1'd0) begin
//         irq_o <= 1'd0;
//         count <=0;
//         end
//       else if( PWRITE == 1'b1) begin
//         count <= count+1;
//         end
//       else begin
//        if(count == 4'd8)
//         irq_o <= 1'd1;
//         else
//         irq_o <= irq_o;
//         end
//       end
       
//        always @(posedge HCLK) begin
//          if(PWDATA == 32'd32)
//             irq_o <= 1'd1;
//             end
   
    always_comb begin
      if(PSEL == 1'b1 && PENABLE == 1'b1 )begin
        PADDR_p   = PADDR    ;
        PWDATA_p  = PWDATA   ;
        PSLVERR   = PSLVERR_p;
      end
      else begin
        PADDR_p   = 0;
        PWDATA_p  = 0;
        PSLVERR   = 0;
      end
    end    
  endmodule
