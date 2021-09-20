  // Imp notes:
    // format of :PADDR =   {7'd0,index[2:0],2'd0}
    // prescaler format: WDATA = {26'd0,presc_bit[5:3],3'd0}
    // to set prescaler we have to write on REG_TIMER_CTRL
    // to set timer we have to write on REG_CMP 
    // irq_o[0] == overflow interrupt
    // irq_o[1] == time reached interrupt
    // zeroth bit of reg timer ctrl is ENABLE BIT
    // if you set value 1 in cmp register then you will recieve interrupt after every clock cycle
    // if you set value 1 in cmp register and 1 value in prescaler bits then you will recieve interrupt after every 10 clock cycles
    // Conclusion prescaler value 1 will slow down the clock ten times and normal number of cycle based delay will be given by value of compare register you set.
    // addr => ctrl  = 12'd4;
     // add =>  cmp   = 12'd8;
     // addr => timer = 12'd0;

     // ctrl = 32'd0 disabled timer no prescaler
     // ctrl = 32'd1 enabled timer no prescaler 
     // ctrl = 32'd8 disabled timer precaler 1 i.e 10 times larger delay
     // ctrl = 32'd9 enabled timer prescaler 1 i.e 10 times lager delay
     // ctrl = 32'd16 disabled timer prescaler 2 i.e 20 times greater delay
     // ctrl = 32'd17 enabled timer prescaler 2 i.e 20 times greater delay
     // ctrl = 32'd24 disabled timer prescaler 3 i.e 30 times greater delay 
     // ctrl = 32'd25 enabled timer prescaler 3 i.e 30 times greater delay
     // ctrl = 32'd32 disabled timer prescaler 4 i.e 40 times greater delay
     // ctrl = 32'd33 enabled timer prescaler 4 i.e 40 times greater delay
     // ctrl = 32'd40 disabled timer prescaler 5 i.e 50 times greater delay
     // ctrl = 32'd41 enabled timer  prescaler 5 i.e 50 times greater delay
     // ctrl = 32'd48 disabled timer prescaler 6 i.e 60 times greater delay
     // ctrl = 32'd49 enabled timer prescaler 6 i.e 60 times greater delay
     // ctrl = 32'd56 disabled timer prescaler 7 i.e 70 times greater delay
     // ctrl = 32'd57 enabled timer prescaler 7 i.e 70 times greater delay
     

     // max value through cmp register = 4294967295 clks

    // FORMULA => delay_time = time_of_one_clk*(cmp value * prescaler_value)
    // max delay_time = time_of_one_clk*(4294967295*70) =  time_of_onc_clk*(300647710650)

module lexicon_timer_tb #(
  parameter APB_ADDR_WIDTH = 12
)
( 
     // ports
    output  logic                      HCLK,
    output  logic                      HRESETn,
    output  logic [APB_ADDR_WIDTH-1:0] PADDR,
    output  logic               [31:0] PWDATA,
    output  logic                      PWRITE,
    output  logic                      PSEL,
    output  logic                      PENABLE,
    
    input logic               [31:0] PRDATA,
    input logic                      PREADY,
    input logic                      PSLVERR,
    input logic                [1:0] irq_o // overflow and cmp interrupt                                  
     );
    
    // Adress 
     localparam TIMER = 12'h0;
     localparam CTRL  = 12'h4;
     localparam CMP   = 12'h8;
    // prescaler values
     localparam PRESCALER_0_DISABLED   = 32'h0; 
     localparam PRESCALER_1_DISABLED = 32'h8; 
     localparam PRESCALER_2_DISABLED = 32'h10; 
     localparam PRESCALER_3_DISABLED = 32'h18; 
     localparam PRESCALER_4_DISABLED = 32'h20; 
     localparam PRESCALER_5_DISABLED = 32'h28; 
     localparam PRESCALER_6_DISABLED = 32'h30; 
     localparam PRESCALER_7_DISABLED = 32'h38; 
     localparam PRESCALER_0_ENABLED  = 32'h1; 
     localparam PRESCALER_1_ENABLED  = 32'h9; 
     localparam PRESCALER_2_ENABLED  = 32'h11; 
     localparam PRESCALER_3_ENABLED  = 32'h19; 
     localparam PRESCALER_4_ENABLED  = 32'h21; 
     localparam PRESCALER_5_ENABLED  = 32'h29; 
     localparam PRESCALER_6_ENABLED  = 32'h31; 
     localparam PRESCALER_7_ENABLED  = 32'h39;
     localparam MAX_CMP              = 32'hFFFF_FFFF;
        



   timer dut (.*);


    always begin : clk_gen
     #10 HCLK = ~HCLK;
     end
    

    task automatic reset_all();
    //Reset AHB Bus
    PSEL      = 1'b0;
    PENABLE   = 1'b0;
    PADDR     = 'hx;
    PWDATA    = 'hx;
    PWRITE    = 'hx;

    @(posedge HRESETn);
  endtask

    task automatic write (
    input [APB_ADDR_WIDTH  -1:0] address,
    input [32              -1:0] data
  );
    PSEL    = 1'b1;
    PADDR   = address;
    PWDATA  = data;
    PWRITE  = 1'b1;
    @(posedge HCLK);

    PENABLE = 1'b1;
     @(posedge HCLK);

    while (!PREADY) @(posedge HCLK);

    PSEL    = 1'b0;
    PADDR   = {12{1'bx}};
    PWDATA  = {32{1'bx}};
    PWRITE  = 1'bx;
    PENABLE = 1'b0;
  endtask

      task automatic read (
    input  [APB_ADDR_WIDTH -1:0] address,
    output [32 -1:0] data
  );
    PSEL    = 1'b1;
    PADDR   = address;
    PWDATA  = {32{1'bx}};
    PWRITE  = 1'b0;
    @(posedge HCLK);

    PENABLE = 1'b1;
    @(posedge HCLK);

    while (!PREADY) @(posedge HCLK);

    data = PRDATA;

    PSEL    = 1'b0;
    PADDR   = {12{1'bx}};
    PWRITE  = 1'bx;
    PENABLE = 1'b0;
  endtask
  task automatic Welcome_screen();
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
  task finish_text();
    begin
        $display ("------------------------------------------------------------");
        $display (" APB 32 BIT TIMER Testbench finished successfully @%0t", $time);
        $display ("------------------------------------------------------------");
    end
  endtask : finish_text


  logic [31:0] data;
    initial begin
 /*    Welcome_screen();
     
     HRESETn =  1'd0;
     
     reset_all();#40;  */
     HCLK = 1'b0;
     HRESETn =  1'd0;#20
     HRESETn =  1'd1;
     Welcome_screen();
     write(CMP,32'h1);
     write(CTRL,PRESCALER_0_DISABLED);
     read(CMP,data);
     read(CTRL,data);
     write(CTRL,PRESCALER_0_ENABLED);#500
     write(CTRL,PRESCALER_0_DISABLED);#500
     write(CMP ,32'h2);
     read(CMP,data);
     write(CTRL,PRESCALER_1_ENABLED);
     read(CTRL,data);#5000;
     write(CTRL,PRESCALER_1_DISABLED);
     write(CTRL,PRESCALER_2_ENABLED);#5000;
     write(CTRL,PRESCALER_1_DISABLED);
     write(CTRL,PRESCALER_3_ENABLED);#5000;
     write(CTRL,PRESCALER_1_DISABLED);
     write(CTRL,PRESCALER_4_ENABLED);#5000;
     write(CTRL,PRESCALER_1_DISABLED);
     write(CTRL,PRESCALER_5_ENABLED);#5000;
     write(CMP ,32'h1);#5000;
     write(CMP ,32'h2);#5000;
     write(CMP ,32'h10);#5000;
     finish_text();
    end

    
 endmodule



 
 
 