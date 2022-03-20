/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:        MICRO-ELECTRONICS RESEARCH LABORATORY                                               //
//                                                                                                     //
// Engineers:      Wishah Naseer - Hardware Designer                                                   //
//                                                                                                     //
// Additional contributions by:  Rehan Ejaz, M. Uzair Qureshi                                          //
//                                                                                                     //
// Create Date:    01-MARCH-2022                                                                       //
// Design Name:    APB interface for PWM                                                               //
// Module Name:    apb_pwm.sv                                                                          //
// Project Name:   ReV-SoC                                                                             //
// Language:       SystemVerilog                                                                       //
//                                                                                                     //
// Description:                                                                                        //
//     Pulse width modulation (PWM) is a modulation technique that generates variable-width	pulses     //
// 	   to represent the amplitude of an analog input signal.                                           //
//       .....                                                                                         //
//                                                                                                     //
// Revision Date:                                                                                      //
//                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////

module	apb_pwm #(parameter DATA_WIDTH = 32,ADDR_WIDTH = 8)
(
	input   logic	     								PCLK_i,		// CLK signal
	input   logic	     								PRST_ni,	// Active low reset
	input   logic	     								PWRITE_i,	// write =1 => write : write =0 => read
	input   logic [ADDR_WIDTH -1:0]  	PADDR_i,	// Adress of register to set/modify
	input   logic [DATA_WIDTH -1:0]  	PWDATA_i, // Peripheral write data
	input   logic        							PSEL_i,		// Peripheral select signal
	input   logic											PENABLE_i,// Peripheral enable signal
	output  logic [DATA_WIDTH -1:0] 	PRDATA_o, // read channel
  output  logic      				  			o_pwm_1, 	// PWM output of 1st channel
 	output  logic       		 					o_pwm_2, 	// PWM output of 2nd channel
	output  logic     	 							oe_pwm1, 	// PWM valid indication
	output  logic     	 							oe_pwm2, 	// PWM valid indication
	output  logic       							PSLVERR_o,// Error Signal
	output  logic											PREADY_o 	// Ready Signal
);

logic [DATA_WIDTH -1 :0] 	wdata;
logic [ADDR_WIDTH -1 :0] 	addr;
logic 										write;

pwm #(
	.DATA_WIDTH(DATA_WIDTH),
	.ADDR_WIDTH(ADDR_WIDTH) ) 
PWM_peripheral (
	.clk_i		(PCLK_i),
	.rst_ni		(PRST_ni),
	.w_en_i		(write),
	.rd_en_i	(~write),
	.wdata_i	(wdata),
	.addr_i		(addr),
	.rdata_o	(PRDATA_o),
	.o_pwm_1	(o_pwm_1),
	.o_pwm_2	(o_pwm_2),
	.oe_pwm1	(oe_pwm1),
	.oe_pwm2	(oe_pwm2)
);

assign wdata 	= ((PSEL_i) && (PENABLE_i)) ? PWDATA_i 	:'d0;
assign addr  	= ((PSEL_i) && (PENABLE_i)) ? PADDR_i  	:'d0;
assign write  = ((PSEL_i) && (PENABLE_i)) ? PWRITE_i  :'d0;

assign PSLVERR_o = 1'b0;
assign PREADY_o	 = 1'b1;

endmodule
