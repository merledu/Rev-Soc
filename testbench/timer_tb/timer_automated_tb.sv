`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Micro Electronics Research Lab
// Engineer:Rehan Ejaz 
// Create Date: 10.03.2022 19:24:23
// Design Name:Timer Automated Testbench
// Module Name:timer_tb
// Project Name:ReV-SoC
// Description: Timer peripheral testbench for automatically checking the results from randomized stimilus
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module timer_tb #(
  parameter APB_ADDR_WIDTH = 12 )( 
    // ports
    output  logic                      HCLK    = 0,   
    output  logic                      HRESETn = 0,
    output  logic [APB_ADDR_WIDTH-1:0] PADDR   = 0,
    output  logic               [31:0] PWDATA  = 0,
    output  logic                      PWRITE  = 0,
    output  logic                      PSEL    = 0,
    output  logic                      PENABLE = 0,
    input   logic               [31:0] PRDATA     ,
    input   logic                      PREADY     ,
    input   logic                      PSLVERR    ,
    input   logic                      irq_o
);

    // Adress 
    localparam  CTRL        = 12'h0  ,
                CFG         = 12'h100,
                TIMER_LOWER = 12'h104,
                TIMER_UPPER = 12'h108,
                CMP_LOWER   = 12'h10C,
                CMP_UPPER   = 12'h110,
                IRQ_EN      = 12'h114;
    
		logic [11:0] ADDR=0;

    apb_timer dut (.*); // APB timer design under test

    always begin : clk_gen
			#10 HCLK = ~HCLK;
    end
    
    initial begin 
			#40 HRESETn = 1'b1;
    end
                
		logic [32 - 1 : 0]  actual_data      = 32'd0             ,// Actual data register 
												expected_data    = 32'h0             ,// Expected data register
												errors           = 32'd0             ,// Mismatch count register
												compare_lower    = 32'hFFFF_FFFF     ,
												compare_upper    = 32'hFFFF_FFFF     ;
		logic [11 : 0]      prescale=0                           ;
		logic [15 : 0]      step = 1                             ; 
		logic [63:0]        expected_cycles_without_prescaler = 0;
		logic               counter_en=0,Test_pass_flag=0        ;
		logic [31:0]        counter_actual=0                     ;

		always_ff @(posedge HCLK) begin
			if(counter_en==1 && irq_o == 0 )
				counter_actual <= counter_actual + 1'b1;
		end

		task automatic reset_all();                 // Reset default value functions
			@(posedge HCLK) begin
				PSEL      = 1'b1;
				PENABLE   = 1'b1;
				PWDATA    = 'h0 ;
				PWRITE    = 'h0 ;
			end
		endtask
        
    task automatic write (                          // Write data function
			input [12  -1:0] address,
			input [32   -1:0] data
    );
			@(posedge HCLK) begin
				PSEL       = 1'b1    ;
				PENABLE    = 1'b1    ;
				PADDR      = address ;
				PWDATA     = data    ;
				PWRITE     = 1'b1    ;
				expected_data <= data;
			end
		endtask
        
		logic [31:0] counter =0  ; 

		function  logic [ 32 -1 : 0] read_data(   // read data function
			input  [12 -1:0] address );
			PSEL         = 1'b1       ;
			PADDR        = address    ;
			PWDATA       = {32{1'b0}} ;
			PWRITE       = 1'b0       ;
			read_data    = PRDATA     ;
			PENABLE      = 1'b1       ;
		endfunction

		task automatic  clear_timer();   // GPIO clear Task 
			write(CTRL,32'd0)          		;
			reset_all()                		;
			write(CFG,{16'd0,16'd0})   		;
			reset_all()                		;
			write(TIMER_LOWER,32'd0)      ;
			reset_all()                   ;
			write(TIMER_UPPER,32'd0)      ;
			reset_all()                   ;
			write(CMP_LOWER,32'hFFFF_FFFF);
			reset_all()										;
			write(CMP_UPPER,32'hFFFF_FFFF);
			reset_all();
			write(IRQ_EN,32'd0);
			reset_all();
		endtask

		task automatic Welcome_screen();  // Welcome Screen
			$display("...................................Testbench Initiated...............................");
			$display(" ....................................................................................");
			$display(".MMMMMMM.......MMMMMMM....EEEEEEEEEEEEEEEEE...RRRRRRRRRRRRRRRR.....RLLLLL............");
			$display(".MMMMMMM.......MMMMMMM....EEEEEEEEEEEEEEEEE...RRRRRRRRRRRRRRRRR....RLLLLL............");
			$display(".MMMMMMM.......MMMMMMM....EEEEEEEEEEEEEEEEE...RRRRRRRRRRRRRRRRRR...RLLLLL............");
			$display(".MMMMMMMM.....MMMMMMMM....EEEEEEEEEEEEEEEEE...RRRRRRRRRRRRRRRRRR...RLLLLL............");
			$display(".MMMMMMMM.....MMMMMMMM....EEEEE...............RRRRR.......RRRRRR...RLLLLL............");
			$display(".MMMMMMMM.....MMMMMMMM....EEEEE...............RRRRR........RRRRRR..RLLLLL............");
			$display(".MMMMMMMMM....MMMMMMMM....EEEEE...............RRRRR........RRRRR...RLLLLL............");
			$display(".MMMMMMMMM...MMMMMMMMM....EEEEE...............RRRRR.......RRRRRR...RLLLLL............");
			$display(".MMMM.MMMM...MMMM.MMMM....EEEEEEEEEEEEEEEE....RRRRR.....RRRRRRRR...RLLLLL............");
			$display(".MMMM.MMMMM..MMMM.MMMM....EEEEEEEEEEEEEEEE....RRRRRRRRRRRRRRRRRR...RLLLLL............");
			$display(".MMMM.MMMMM.MMMMM.MMMM....EEEEEEEEEEEEEEEE....RRRRRRRRRRRRRRRRR....RLLLLL............");
			$display(".MMMM..MMMM.MMMM..MMMM....EEEEEEEEEEEEEEEE....RRRRRRRRRRRRRRR......RLLLLL............");
			$display(".MMMM..MMMM.MMMM..MMMM....EEEEE...............RRRRRRRRRRRRRRR......RLLLLL............");
			$display(".MMMM..MMMMMMMMM..MMMM....EEEEE...............RRRRR....RRRRRRR.....RLLLLL............");
			$display(".MMMM...MMMMMMM...MMMM....EEEEE...............RRRRR.....RRRRRR.....RLLLLL............");
			$display(".MMMM...MMMMMMM...MMMM....EEEEE...............RRRRR......RRRRRR....RLLLLL............");
			$display(".MMMM...MMMMMMM...MMMM....EEEEEEEEEEEEEEEEE...RRRRR......RRRRRRR...RLLLLLLLLLLLLLLL..");
			$display(".MMMM....MMMMM....MMMM....EEEEEEEEEEEEEEEEE...RRRRR.......RRRRRR...RLLLLLLLLLLLLLLL..");
			$display(".MMMM....MMMMM....MMMM....EEEEEEEEEEEEEEEEE...RRRRR........RRRRRR..RLLLLLLLLLLLLLLL..");
			$display(".MMMM....MMMMM....MMMM....EEEEEEEEEEEEEEEEE...RRRRR........RRRRRR..RLLLLLLLLLLLLLLL..");
			$display(".....................................................................................");
			$display(".....................................................................................");
			$display("........................by(Micro Electronics Research Lab)...........................");
			$display("....................................................................................."); 
		endtask 
		
		task finish_text_PASSED(); //  Test pass message function
			begin
					$display ("------------------------------------------------------------");
					$display (" TEST PASSED Testbench finished successfully @%0t", $time);
					$display ("------------------------------------------------------------");
			end
		endtask : finish_text_PASSED
        
		task finish_text_FAILED(); //  Test fail message function
			begin
				$display ("------------------------------------------------------------");
				$display (" TEST FAILED Testbench finished successfully @%0t", $time);
				$display ("------------------------------------------------------------");
			end
		endtask : finish_text_FAILED
        
		task timer_ramdom_stimulus_gen (input int seed);
			ADDR = CTRL      							;
			write(ADDR,32'd0)							;// Setting CTRL register to zero for Disabling timer
			reset_all()      							;// Reseting all signals to default values
			reset_all()          					;// Reseting all signals to default values
			actual_data = read_data(ADDR) ;
			if(actual_data !== expected_data) begin // comparing actual data and delayed expected data
				errors++                    ;
			end

			ADDR     = CFG                 ;
			step     = $urandom_range(20,1); 
			//    step     = 16'h2         ; 
			prescale = $urandom_range(20,0);
			expected_cycles_without_prescaler = ((prescale+1) * {compare_upper,compare_lower})/step;

			//    prescale = 12'h1          ;
			write(ADDR,{step,4'h0,prescale});
			reset_all();
			reset_all();
			actual_data = read_data(ADDR);
			if(actual_data !== expected_data) begin
				errors++;
			end

			ADDR = CMP_LOWER;
			//    compare_lower = 32'h10; // compare value for timer lower 32 bits
			compare_lower = $urandom_range(1,50); // compare value for timer lower 32 bits
			write(ADDR,compare_lower);
			reset_all();
			reset_all();
			actual_data = read_data(ADDR);

			if(actual_data !== expected_data) begin
				errors++;
			end

			ADDR = CMP_UPPER;
			compare_upper = 32'h0; // compare value for timer Upper 32 bits
			write(ADDR,compare_upper);
			reset_all();
			reset_all();
			actual_data = read_data(ADDR);
			if(actual_data !== expected_data) begin
				errors++;
			end            

			ADDR = IRQ_EN;
			write(ADDR,32'd1);
			reset_all();
			reset_all();
			actual_data = read_data(ADDR);
			if(actual_data !== expected_data) begin
				errors++;
			end

			ADDR = CTRL;
			write(ADDR,32'd1);
			reset_all();
			reset_all();
			actual_data = read_data(ADDR);
			if(actual_data !== expected_data) begin
				errors++;
			end

			counter_en = 1;

			expected_cycles_without_prescaler = ((prescale+1) * {compare_upper,compare_lower})/step;
			repeat(expected_cycles_without_prescaler + 200 )  
			@(posedge HCLK);
			$display("Actual Cycle Count=%d and Expected Cycle Count=%d",counter_actual-2 ,expected_cycles_without_prescaler );
			$display("step value=%d and prescaler value=%d compare value=%d",step ,prescale,compare_lower );
			if (expected_cycles_without_prescaler !== counter_actual-2) begin
				errors++;
			end       
			counter_actual = 0;
			counter_en = 0;
			clear_timer();  // reseting all registers of GPIO for another configuration setting
		endtask
    
    
		int X=0;
		initial begin
			reset_all();
			Welcome_screen();

			while(X < 1000) begin
				timer_ramdom_stimulus_gen(X);
				X++;
			end

			if(errors == 0  ) begin  // checking if any error exists and decide either test passed or failed
				finish_text_PASSED();    
			end

			else begin
				finish_text_FAILED();
				$display("Error count=%d Tests passed =%d",errors,1000-errors);
			end

			$finish();
		end
    
    endmodule
 
 
