/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company: MICRO-ELECTRONICS RESEARCH LABORATORY //
// //
// Engineer: Wishah Naseer - Hardware Designer //
// //
// Additional contributions by: Rehan Ejaz, M. Uzair Qureshi//
// //
// Create Date: 01-MARCH-2022 //
// Design Name: PWM Testbench //
// Module Name: pwm_tb.sv //
// Project Name: ReV-SoC //
// Language: SystemVerilog //
// //
// Description: Pulse width modulation (PWM) is a modulation technique that generates 
// variable-width pulses to represent the amplitude of an analog input signal.//
// //
// //
// Revision Date: //
// //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ns
module pwm_tb;
	logic 				PCLK_i;	//clocksignal
	logic 				PRST_ni;	//active low reset
	logic 				PWRITE_i;	//PWRITE_i enable(when PWRITE_i=1, we can PWRITE_i in our registers)								
	logic  	[7:0]    	PADDR_i;	//address of registers coming from SweRV 										
	logic  	[31:0]   	PWDATA_i; // 32 bits instruction coming from SweRV-> PWRITE_i data																	
	logic  	[31:0]  	PRDATA_o; //read data																								
  	logic         		o_pwm_1;	// output of PWM in the form of pulse (Channel 1)
	logic         		o_pwm_2; // output of PWM in the form of pulse (Channel 2)
	logic     			oe_pwm1;  //output enable pin (channel 1)
	logic     			oe_pwm2;  //output enable pin (channel 2)
	logic           	PSEL_i;	//peripheral Select Pin
	logic 				PENABLE_i; // peripheral enable pin
	logic  				PSLVERR_o; // Slave Error
	logic 				PREADY_o;
	logic 	[31:0]		div;	//variable for storing value of divisor from PWDATA_i
	logic 	[31:0]		per;	//variable for storing value of period from PWDATA_i
	logic 	[31:0]		dc;		//variable for storing value of duty cycle from PWDATA_i
	
apb_pwm pwm_dut(.*);

//Duty cycle is the on time of pwm pulse from total period
//divisor divides clock frequency, and pwm operates on divisor
//peeriod is the total time in which pulse will be created either high or low. when pulse is high it's on-time.

always begin	//clock generation block
    #10;
    	PCLK_i=1'b0;
    #10;
    	PCLK_i=1'b1;
end

//divisor can never be set 0, divisor clock won't be generated
//period can never be set 0, there will be no period
//duty cycle can never be greater than period

initial begin

	PRST_ni 	= 	1'b0;	
	PSEL_i 		= 	1'b1;	
	PENABLE_i 	= 	1'b1;

	@(posedge PCLK_i);

	PRST_ni 	= 	1'b1;					//enable reset(active low) to start operations
	PWRITE_i	= 	1'b1;					//when PWRITE_i is on values of PWDATA_i are assigned to registers according to addresses

	//divisor (channel 1)

	@(posedge PCLK_i);	

	PADDR_i 	= 	8'd4;					//give address of divisor to PWRITE_i on it
	//PWDATA_i 	= 	32'd2;
	PWDATA_i 	= 	$urandom_range(1,20);	//value of divisor is set here
	div 		= 	PWDATA_i;				//divisor value saved in div variable for checker logic

	//period (channel 1)

	@(posedge PCLK_i);

	PADDR_i 	= 	8'd8;					//configure period
	//PWDATA_i 	= 	32'd10;
	PWDATA_i 	= 	$urandom_range(1,20); 	// value of period is set here
	per 		= 	PWDATA_i;				//value of period is saved in per variable for checker logic

	//DC (channel 1)

	@(posedge PCLK_i);

	PADDR_i 	= 	8'd12;					//configure duty cycle
	//PWDATA_i 	= 	32'd6;
	PWDATA_i 	= 	$urandom_range(1,(per-32'd1));	// value for Duty Cycle (must be lesser than period)
	dc 			= 	PWDATA_i; 				//duty cycle's value is saved in dc variable for checker logic

	// control (channel 1)

	@(posedge PCLK_i);

	PADDR_i 	= 	8'd0;					//send addressof control at the end to enable channel
	PWDATA_i	= 	32'd7;					//send 7 to enable channel as all first three bitsof PWDATA_i are used for control logic
	
	@(posedge PCLK_i);

	PWRITE_i 	= 	1'b0;			
end 

//////////////////// CHECKER LOGIC BLOCK ////////////////////////////

logic [31:0] 	counter 			= 0;	//counts original clock pulses
logic [31:0]	one_div 			= 0;	//tells how much original clock pulses the half pulse of divisor contains
logic [31:0]	total_div_clocks 	= 0; 	//tells how much original clock pulses 1 complete pulse of divisor contains
logic [31:0]	total_clocks 		= 0; 	//the numbers of original clocks in total period
logic [31:0]	on_time 			= 0;	// the number of original clocks in Duty Cycle(on-time of period)

always @ (posedge PCLK_i) begin 

	$display("The value of divisor is = ",div);	//printing value of randomly generated divisor 
	$display("The value of period is = ",per);	//printing value of randomly generated period 
	$display("The Duty Cycle is = ",dc);		//printing value of randomly generated Duty Cycle 
	
	one_div = 32'd1 * div;						// half pulse of divisor (one_div) = 1 x divisor
	
	total_div_clocks = one_div + one_div;  		//1 complete pulse of divisor (total_div_clocks) =	one_div + one_div
	$display("The total number of original clocks in 1 complete pulse of divisor clock are = ",total_div_clocks);
	
	total_clocks = total_div_clocks * per;  	//total original clocks calculated (total_clocks) = total_div_clocks x periods
	$display("The total number of original clocks in total divisor clocks according to ",per," periods  are = ",total_clocks);
	
	on_time = dc*total_div_clocks;  			// original clocks in Duty cycle(on-time) = duty cycle * total_div_clocks
	$display("The total on_time is   = ",on_time);
	
	// counter for counting the original clock exactly after when the output enable signal gets high
	
	if (oe_pwm1) begin 
		counter <= counter + 32'd1;
	end
	
	//display text when counter gets equal to the clocks counted for on time and also finds pwm signal high
	
	if (counter == (on_time) && o_pwm_1 == 1'b1) begin 
		$display("on-time is correct according to Duty cycle provided");
	end
	
	//display text when counter gets greater to the clocks counted for on time and lesser then total clocks calculated and also finds pwm signal low
	if (counter > (on_time) && counter < (total_clocks + 32'b1) && o_pwm_1 == 1'b0) begin 
		$display("Off-time is correct according to Duty cycle provided");
	end
	
	//display text when counter equal to total clocks calculated 
	if (counter == total_clocks) begin
		$display("Total period is correct,with correct clock counts according to divider");
		$display("total original clocks counted by checker",counter);
		$stop;
	end
end
endmodule 