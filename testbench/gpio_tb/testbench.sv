`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2022 19:24:23
// Design Name: 
// Module Name: gpio_testbech
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


module gpio_testbench#(
    // parameters
    GPIO_PINS  = 32, // Must be a multiple of 8
    PADDR_SIZE = 4,
    STAGES     = 2   // Steges to add more stability to inputs
) (
   // ports
   input                           HCLK,
   output  logic [GPIO_PINS-1:0]   gpio_i=0,
   input   logic                   HRESETn,
   output  logic                   PSEL=0,
   output  logic                   PENABLE=0,
   output  logic [PADDR_SIZE-1:0]  PADDR=0,
   output  logic                   PWRITE=0,
   output  logic [GPIO_PINS-1:0]   PWDATA=0,
   output  logic [GPIO_PINS/8-1:0] PSTRB=4'b1111,
   
   input   logic                    PREADY,
   input   logic [GPIO_PINS-1:0]    PRDATA,
   input   logic                    PSLVERR,
   input   logic                    irq_o,
   input   logic [GPIO_PINS-1:0]    gpio_o=0,
                                  gpio_oe=0
);

     enum  {MODE,DIRECTION,OUTPUT,INPUT,TR_TYPE,TR_LVL0,TR_LVL1,TR_STAT ,IRQ_EN}ADDR; // Adresses for configuration registers

                
    logic [GPIO_PINS - 1 : 0]   actual_data     = 32'd0,       // Actual data register 
                                expected_data   = 32'd0,      // Expected data register
                                expected_data_d = 32'd0,    // delay expected data register
                                expected_data_1 = 32'd0,    // delay expected data register
                                errors          = 32'd0,           // Mismatch count register
                                Output_data     = 32'd0,
                                Output_enable   = 32'd0;

        task automatic reset_all();                  // Reset default value functions
            @(posedge HCLK) begin
                PSEL      = 1'b0;
                PENABLE   = 1'b0;
                PADDR     = 'h0;
                PWDATA    = 'h0;
                PWRITE    = 'h0;
            end
        endtask
        
        task automatic write (                          // Write data function
                input [PADDR_SIZE  -1:0] address,
                input [GPIO_PINS   -1:0] data
        );
            @(posedge HCLK) begin
                PSEL       = 1'b1;
                PENABLE    = 1'b1;
                PADDR      = address;
                PWDATA     = data;
                PWRITE     = 1'b1;
                expected_data <= data; 
            end
        endtask
  
        function  logic [ GPIO_PINS -1 : 0] read_data(   // read data function
            input  [PADDR_SIZE -1:0] address
        );
            PSEL         = 1'b1;
            PADDR        = address;
            PWDATA       = {32{1'b0}};
            PWRITE       = 1'b0;
            read_data    = PRDATA;
            PENABLE      = 1'b1;
        endfunction


        task automatic  clear_gpio(   // GPIO clear Task 
        );
            write(MODE,0);
            reset_all();
            write(DIRECTION,0);
            reset_all();
            write(OUTPUT,0);
            reset_all();
            write(TR_TYPE,0);
            reset_all();
            write(TR_LVL0,0);
            reset_all();
            write(TR_LVL1,0);
            reset_all();
            write(IRQ_EN,0);
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
        
        int seed=0,x =0;
    
        task randomized_stimulus( input int seed);
            ADDR = MODE;
            write(ADDR,32'd0);  // Setting Mode register to zero for Enabling Push pull mode for All gpios
            reset_all(); // Reseting all signals to default values
            actual_data = read_data(ADDR);
            if(actual_data !== expected_data_d) begin // comparing actual data and delayed expected data
                errors++;
            end

            ADDR = DIRECTION;
    //        Output_enable = 32'hFFFF_FFFF;
            Output_enable = $urandom(seed+100); 

            write(ADDR,Output_enable);
            reset_all();
            actual_data = read_data(ADDR);
            if(actual_data !== expected_data_d) begin
                errors++;
            end
            ADDR = OUTPUT;
            //Output_data = 32'b0000_0000_0000_0000_0000_0000_1000_1000; // Data state for all GPIO pins
            Output_data = $urandom(seed);
            write(ADDR,Output_data);
            reset_all();
            actual_data = read_data(ADDR);
            if(actual_data !== expected_data_d) begin
                errors++;
            end
            ADDR = TR_TYPE;
            write(ADDR,32'b1111_1111_1111_1111_1111_1111_1111_1111);
            reset_all();
            actual_data = read_data(ADDR);
            if(actual_data !== expected_data_d) begin
                errors++;
            end
            ADDR = TR_LVL0;
            write(ADDR,32'd0);
            reset_all();
            actual_data = read_data(ADDR);
            if(actual_data !== expected_data_d) begin
                errors++;
            end
            ADDR = TR_LVL1;
            write(ADDR,32'd0);
            reset_all();
            actual_data = read_data(ADDR);
            if(actual_data !== expected_data_d) begin
                errors++;
            end
            ADDR = IRQ_EN;
            write(ADDR,32'd0);
            reset_all();
            actual_data = read_data(ADDR);
            
            if(actual_data !== expected_data_d) begin
                errors++;
            end

            
            if ((gpio_o & gpio_oe) !== (Output_data & Output_enable)) begin
            errors++;
            end

            clear_gpio();
    
        endtask
    
        initial begin
            
            reset_all();
            Welcome_screen();

            while (x<=10000) begin
                randomized_stimulus(x);
                x++;
            end           

            if(errors == 0 ) begin
                finish_text_PASSED();
            end
            else begin
                finish_text_FAILED();
            end
            $finish();
        end
        
        always_ff @(posedge HCLK) begin // Delaying signal one clock cycle for making right comparison
            expected_data_1 <= expected_data;
            expected_data_d <= expected_data_1;
        end 
      
    endmodule
