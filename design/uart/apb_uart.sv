module apb_uart (
    input logic pclk_i,
    input logic prst_ni,
    input logic [31:0] pwdata_i,
    input logic [11:0] paddr_i,
    input logic psel_i,
    input logic pwrite_i,
    input logic penable_i,
    input logic rx_i,
    output logic pslverr_o,
    output logic [31:0] prdata_o,
    output logic pready_o,
    output logic tx_o,
    output logic intr_tx,
    output logic intr_rx,
    output logic intr_tx_level,
    output logic intr_rx_timeout,
    output logic intr_tx_full,
    output logic intr_tx_empty,
    output logic intr_rx_full,
    output logic intr_rx_empty  
);

logic [11:0] paddr_p;
logic [31:0] pwdata_p;


uart_core utc(
		.clk_i(pclk_i),
		.rst_ni(prst_ni), 
		.reg_we(pwrite_i),
		.reg_re(~pwrite_i),
		.reg_wdata(pwdata_p),
		.reg_rdata(prdata_o),
		.reg_addr(paddr_p),   
		.tx_o(tx_o),
		.rx_i(tx_o),
		.intr_tx(intr_tx),
		.intr_rx(intr_rx),
		.intr_tx_level(intr_tx_level),
		.intr_rx_timeout(intr_rx_timeout),
		.intr_tx_full(intr_tx_full),
		.intr_rx_full(intr_rx_full),
		.intr_rx_empty(intr_rx_empty),
		.intr_tx_empty(intr_tx_empty)
);

always_comb begin
    if(psel_i == 1'b1 && penable_i == 1'b1 )begin
    paddr_p   = paddr_i    ;
    pwdata_p  = pwdata_i   ;
    end
    else
    paddr_p   = 0    ;
    pwdata_p  = 0    ;
end 

assign pslverr_o = 1'b0;
assign pready_o = 1'b1;

endmodule