`timescale 1ns/1ns
module pwm_tb;
	logic clk_i;
	logic rst_ni;
	logic write;									
	logic  [7:0]    addr_i;											
	logic  [31:0]   wdata_i;																			
	logic  [31:0]  	rdata_o;																								
  	logic         	o_pwm;
	logic         	o_pwm_2;
	logic     		oe_pwm1;
	logic     		oe_pwm2;
	
pwm pwm_dut(.*);

always begin
    #10;
    clk_i=1'b0;
    #10;
    clk_i=1'b1;
end

initial begin

	rst_ni = 1'b0;
	@(posedge clk_i);
	write = 1'b0;
	rst_ni = 1'b1;
	// control (channel 1)
	@(posedge clk_i);
	addr_i = 8'd0;
	@(posedge clk_i);
	wdata_i = 32'd7;
	@(posedge clk_i);
	write = 1'b1;
	@(posedge clk_i);
	write = 1'b0;
	//divisor (channel 1)
	@(posedge clk_i);
	addr_i = 8'd4;
	@(posedge clk_i);
	wdata_i = 32'd2;
	@(posedge clk_i);
	write = 1'b1;
	@(posedge clk_i);
	write = 1'b0;
	//period (channel 1)
	@(posedge clk_i);
	addr_i = 8'd8;
	@(posedge clk_i);
	wdata_i = 32'd3;
	@(posedge clk_i);
	write = 1'b1;
	@(posedge clk_i);
	write = 1'b0;
	//DC (channel 1)
	@(posedge clk_i);
	addr_i = 8'd12;
	@(posedge clk_i);
	wdata_i = 32'd5;
	@(posedge clk_i);
	write = 1'b1;
	@(posedge clk_i);
	write = 1'b0;


	// control (channel 2)
	@(posedge clk_i);
	addr_i = 8'd16;
	@(posedge clk_i);
	wdata_i = 32'd7;
	@(posedge clk_i);
	write = 1'b1;
	@(posedge clk_i);
	write = 1'b0;
	//divisor (channel 2)
	@(posedge clk_i);
	addr_i = 8'd20;
	@(posedge clk_i);
	wdata_i = 32'd2;
	@(posedge clk_i);
	write = 1'b1;
	@(posedge clk_i);
	write = 1'b0;
	//period (channel 2)
	@(posedge clk_i);
	addr_i = 8'd24;
	@(posedge clk_i);
	wdata_i = 32'd3;
	@(posedge clk_i);
	write = 1'b1;
	@(posedge clk_i);
	write = 1'b0;
	//DC (channel 2)
	@(posedge clk_i);
	addr_i = 8'd28;
	@(posedge clk_i);
	wdata_i = 32'd5;
	@(posedge clk_i);
	write = 1'b1;
	@(posedge clk_i);
	write = 1'b0;

end 
endmodule 