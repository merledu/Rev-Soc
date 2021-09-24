module	pwm(

	input wire			clk_i,												
	input wire			rst_ni,												
//	input wire			re_i,											
//	input wire			we_i,	
	input wire			write,										
	input wire  [7:0]   addr_i,											
	input wire  [31:0]  wdata_i,											
    //input wire  [3:0]	be_i,										
	output wire [31:0]  rdata_o,																								
  	output wire         o_pwm,
	output wire         o_pwm_2,
	output  reg     	oe_pwm1,
	output  reg     	oe_pwm2

);

////////////////////control logic////////////////////////////
parameter  adr_ctrl_1	=	0,
		   adr_divisor_1=	4,
		   adr_period_1	=	8,
		   adr_DC_1		=	12;

parameter  adr_ctrl_2	=	16,
		   adr_divisor_2=	20,
		   adr_period_2	=	24,
		   adr_DC_2		=	28;

	reg [2:0] ctrl;
	reg [2:0] ctrl_2;
	reg [15:0] period;
	reg [15:0] period_2;
	reg [15:0] DC_1;
	reg [15:0] DC_2;
	reg [15:0] divisor;
	reg [15:0] divisor_2;
//	wire write;
//	assign write = we_i & ~re_i; //pwrite
	always @(posedge clk_i) begin
		if (!rst_ni) begin
			ctrl <= 3'b000;
			ctrl_2 <= 3'b000;
			period <= 16'b0000000000000000;
			period_2 <= 16'b0000000000000000;
			divisor <= 16'b0000000000000000;
			divisor_2 <= 16'b0000000000000000;
			DC_1 <= 16'b0000000000000000;
			DC_2 <= 16'b0000000000000000;
		end
		else if (write) begin
			case (addr_i)
				adr_ctrl_1: ctrl <= wdata_i[2:0];
				adr_ctrl_2: ctrl_2 <= wdata_i[2:0];
				adr_divisor_1: divisor <= wdata_i[15:0];
				adr_divisor_2: divisor_2 <= wdata_i[15:0];
				adr_period_1: period <= wdata_i[15:0];
				adr_period_2: period_2 <= wdata_i[15:0];
				adr_DC_1: DC_1 <= wdata_i[15:0];
				adr_DC_2: DC_2 <= wdata_i[15:0];				
			endcase
		end
	end
	wire pwm_1;
	assign pwm_1 = ctrl[1];
//	wire pwm_2;
	assign pwm_2 = ctrl_2[1];
	reg clock_p1;
	reg clock_p2;
	reg [15:0] counter_p1;
	reg [15:0] counter_p2;
	reg [15:0] period_counter1;
	reg [15:0] period_counter2;
	reg pts;
	reg pts_2;
	always @(posedge clk_i or negedge rst_ni)
		if (~rst_ni) begin
			clock_p1 <= 1'b0;
			clock_p2 <= 1'b0;
			counter_p1 <= 16'b0000000000000000;
			counter_p2 <= 16'b0000000000000000;
		end
		else begin
			if (pwm_1) begin
				counter_p1 <= counter_p1 + 16'b0000000000000001;
				if (counter_p1 == (divisor - 1)) begin
					counter_p1 <= 16'b0000000000000000;
					clock_p1 <= ~clock_p1;
				end
			end
			if (pwm_2) begin
				counter_p2 <= counter_p2 + 16'b0000000000000001;
				if (counter_p2 == (divisor_2 - 1)) begin
					counter_p2 <= 16'b0000000000000000;
					clock_p2 <= ~clock_p2;
				end
			end
		end
	always @(posedge clock_p1 or negedge rst_ni)
		if (!rst_ni) begin
			pts <= 1'b0;
			oe_pwm1 <= 1'b0;
			period_counter1 <= 16'b0000000000000000;
		end
		else if (ctrl[0]) begin
			if (pwm_1) begin
				oe_pwm1 <= 1'b1;
				if (period_counter1 >= period)
					period_counter1 <= 16'b0000000000000000;
				else
					period_counter1 <= period_counter1 + 16'b0000000000000001;
				if (period_counter1 < DC_1)
					pts <= 1'b1;
				else
					pts <= 1'b0;
			end
		end

	always @(posedge clock_p2 or negedge rst_ni)
		if (!rst_ni) begin
			pts_2 <= 1'b0;
			oe_pwm2 <= 1'b0;
			period_counter2 <= 16'b0000000000000000;
		end
		else if (ctrl_2[0]) begin
			if (pwm_2) begin
				oe_pwm2 <= 1'b1;
				if (period_counter2 >= period_2)
					period_counter2 <= 16'b0000000000000000;
				else
					period_counter2 <= period_counter2 + 16'b0000000000000001;
				if (period_counter2 < DC_2)
					pts_2 <= 1'b1;
				else
					pts_2 <= 1'b0;
			end
		end 

	assign o_pwm = (ctrl[2] ? pts : 1'b0);
	assign o_pwm_2 = (ctrl_2[2] ? pts_2 : 1'b0);
	assign rdata_o = (addr_i == adr_ctrl_1 ? {13'h0, ctrl} : (addr_i == adr_divisor_1 ? divisor : (addr_i == adr_period_1 ? period : (addr_i == adr_DC_1 ? DC_1 : (addr_i == adr_DC_2 ? DC_2 : (addr_i == adr_period_2 ? period_2 : (addr_i == adr_divisor_2 ? divisor_2 : (addr_i == adr_ctrl_2 ? {13'h0, ctrl_2} : 32'b00000000000000000000000000000000))))))));
endmodule                                 