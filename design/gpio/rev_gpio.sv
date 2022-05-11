// FILE NAME      : rev_gpio.sv
// DEPARTMENT     :
// AUTHOR         : Rehan Ejaz
// AUTHOR'S EMAIL : rejaz@students.uit.edu
// -----------------------------------------------------------------

/*
 * address  description         comment
 * ------------------------------------------------------------------
 * 0x0      mode register       0=push-pull
 *                              1=open-drain
 * 0x1      direction register  0=input
 *                              1=output
 * 0x2      output register     mode-register=0? 0=drive pad low
 *                                               1=drive pad high
 *                              mode-register=1? 0=drive pad low
 *                                               1=open-drain
 * 0x3      input register      returns data at pad
 * 0x4      trigger type        0=level
 *                              1=edge
 * 0x5      trigger level/edge0 trigger-type=0? 0=no trigger when low
 *                                              1=trigger when low
 *                              trigger-type=1? 0=no trigger on falling edge
 *                                              1=trigger on falling edge
 * 0x6      trigger level/edge1 trigger-type=0? 0=no trigger when high
 *                                              1=trigger when high
 *                              trigger-type=1? 0=no trigger on rising edge
 *                                              1=trigger on rising edge
 * 0x7      trigger status      0=no trigger detected/irq pending
                                1=trigger detected/irq pending
 * 0x8      irq enable          0=disable irq generation
 *                              1=enable irq generation
 */

module rev_gpio #(
    // parameters
    GPIO_PINS  = 32, // Must be a multiple of 8
    PADDR_SIZE = 20,
    STAGES     = 2   // Steges to add more stability to inputs
) (
   // ports
   input                          pclk,
   input  logic [GPIO_PINS-1:0]   gpio_i,
   input  logic                   prstn,
   input  logic                   psel,
   input  logic                   penable,
   input  logic [PADDR_SIZE-1:0]  paddr,
   input  logic                   pwrite,
   input  logic [GPIO_PINS-1:0]   pwrdata,
   input  logic [GPIO_PINS/8-1:0] pstrb,
   output logic                   pready,
   output logic [GPIO_PINS-1:0]   prddata,
   output logic                   pslverr,
   output logic                   irq_o=0,
   output logic [GPIO_PINS-1:0]   gpio_o=0,
                                  gpio_oe=0
);

   localparam MODE      = 0,
              DIRECTION = 4,
              OUTPUT    = 8,
              INPUT     = 12,
              TR_TYPE   = 16,
              TR_LVL0   = 20,
              TR_LVL1   = 24,
              TR_STAT   = 28,
              IRQ_EN    = 32;
              
   
   // CONTROL REGISTERS
   logic [GPIO_PINS-1:0] gpio_mode=0,
                         gpio_direction=0,
                         gpio_output=0,
                         gpio_input=0,
                         gpio_tr_type=0,
                         gpio_tr_lvl0=0,
                         gpio_tr_lvl1=0,
                         gpio_tr_stat=0,
                         gpio_irq_en=0;

  // Trigger registers 
   logic [GPIO_PINS-1:0] tr_rising,
                         tr_falling,
                         tr_status,
                         tr_dly;

  // Input registers to prevent metastability
   logic [GPIO_PINS-1:0] input_reg_stages [STAGES];
 
    assign pslverr = 1'b0;
    assign pready  = 1'b1;
    // FUNCTIONS DEFINATION

    // Read check
    function automatic read_valid();
     return ~pwrite & penable & psel;
    endfunction : read_valid
  
    // Write check
    function automatic write_valid();
     return penable & pwrite & psel;
    endfunction : write_valid 
  
    // valid write to given adress
    // adress is argument
    function automatic write_valid_to_adr(input [PADDR_SIZE-1:0] address);
     return write_valid() & (paddr == address) ;  
    endfunction : write_valid_to_adr
    
    // Decides what data to write and what to mask
    // Handles PSTRB //Takes current value of register as input
    function automatic [GPIO_PINS-1:0] select_write_bytes(input [GPIO_PINS-1:0] current_value);
      for (int n = 0;n < GPIO_PINS/8 ; n++ )
      select_write_bytes[n*8 +: 8] = pstrb[n] ? pwrdata[n*8 +: 8] : current_value[n*8 +: 8] ;        //data[2*8 +: 8] == data[23:16]
    endfunction : select_write_bytes
    // CLear when write 1
    function automatic [GPIO_PINS-1:0] clear_when_write (input [GPIO_PINS-1:0] current_value);
      for(int n = 0; n < GPIO_PINS/8; n++)
      clear_when_write[n*8 +: 8] = pstrb[n] ? current_value[n*8 +: 8] & ~pwrdata[n*8 +: 8] : current_value[n*8 +: 8];
    endfunction


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// MODULE BODY
/////
/////
    always @(posedge pclk , negedge prstn) begin
        if(  !prstn                      )begin
          
          gpio_mode      <= {GPIO_PINS{1'b0}};
          gpio_output    <= {GPIO_PINS{1'b0}};
          gpio_irq_en    <= {GPIO_PINS{1'b0}};
          gpio_direction <= {GPIO_PINS{1'b0}};
          gpio_tr_type   <= {GPIO_PINS{1'b0}};
          gpio_tr_lvl0   <= {GPIO_PINS{1'b0}};
          gpio_tr_lvl1   <= {GPIO_PINS{1'b0}};
          gpio_tr_stat   <= {GPIO_PINS{1'b0}};
        
        end  
        
        else if (write_valid_to_adr(MODE))begin
          gpio_mode      <= select_write_bytes(gpio_mode);
        end
        else if (write_valid_to_adr(DIRECTION))begin
          gpio_direction <= select_write_bytes(gpio_direction);
        end
        else if (write_valid_to_adr(OUTPUT) || write_valid_to_adr(INPUT))begin
          gpio_output <= select_write_bytes(gpio_output);
        end
        else if (write_valid_to_adr(IRQ_EN))begin
          gpio_irq_en <= select_write_bytes(gpio_irq_en);
        end
        else if (write_valid_to_adr(TR_TYPE))begin
          gpio_tr_type <= select_write_bytes(gpio_tr_type);
        end
        else if (write_valid_to_adr(TR_LVL0))begin
          gpio_tr_lvl0 <= select_write_bytes(gpio_tr_lvl0);
        end
        else if (write_valid_to_adr(TR_LVL1))begin
          gpio_tr_lvl1 <= select_write_bytes(gpio_tr_lvl1);
        end
        else if (write_valid_to_adr(TR_STAT))begin
          gpio_tr_stat <= clear_when_write(gpio_tr_stat) | tr_status;
        end
        else
          gpio_tr_stat <= gpio_tr_stat | tr_status;

    end
    always_comb
        if(read_valid())
        case(paddr)
         MODE     : prddata <= gpio_mode;
         DIRECTION: prddata <= gpio_direction;
         OUTPUT   : prddata <= gpio_output;
         INPUT    : prddata <= gpio_input;
         TR_TYPE  : prddata <= gpio_tr_type;
         TR_LVL0  : prddata <= gpio_tr_lvl0;
         TR_LVL1  : prddata <= gpio_tr_lvl1;
         TR_STAT  : prddata <= gpio_tr_stat;
         IRQ_EN   : prddata <= gpio_irq_en;
         default  : prddata <= {GPIO_PINS{1'b0}};
        endcase
    
   //  mode
   //  0 = push-pull  drive output register value to the gpio if output is enabled
   //  1 = open-drain always drive '0' on gpio if output is enabled
    always @(posedge pclk) begin
      for (int n = 0; n<GPIO_PINS; n++) begin
        gpio_o[n] <= gpio_mode[n] ? 1'b0 : gpio_output[n];
      end      
    end

   // direction  mode  
   // 0=input    0=push-pull         gpio_oe =   zero                 input enabled
   // 1=output   0=push-pull         gpio_oe =   always high          output enabled
   // 0=input    1=open-drain        gpio_oe =   zero                 input enabled
   // 1=output   1=open-drain        gpio_oe =   not(gpio_output_reg) no connection 
   always @(posedge pclk) begin
     for (int n = 0; n<GPIO_PINS; n++) begin
       gpio_oe[n] <= gpio_direction[n] & ~(gpio_mode[n] ? gpio_output[n] : 1'b0);
     end
   end

    // Staging logic
    always @(posedge pclk) begin
      for (int n = 0; n < STAGES; n++) begin
       if(n==0) input_reg_stages[n] <= gpio_i;
       else     input_reg_stages[n] <= input_reg_stages[n-1];
      end     
    end
    
    // last stage is assigned to the input register
    always @(posedge pclk or negedge prstn) begin
    if(!prstn)
    gpio_input     <= {GPIO_PINS{1'b0}};
    else
    gpio_input <= input_reg_stages[STAGES-1];
    end
   
   // Trigger logics
   // delay input register
    always @(posedge pclk) begin
     tr_dly <= gpio_input; 
    end
    //  rising edge detection
    always @(posedge pclk , negedge prstn) begin
     if(!prstn) tr_rising <= {GPIO_PINS{1'b0}};
     else       tr_rising <= ~tr_dly & gpio_input;
    end
    //  Falling edge detection
    always @(posedge pclk , negedge prstn) begin
     if(!prstn) tr_falling <= {GPIO_PINS{1'b0}};
     else       tr_falling <= tr_dly & ~gpio_input;
    end

    // Trigger status
    always_comb begin
      for (int n = 0; n<GPIO_PINS; n++) begin
        case(gpio_tr_type[n])
          
          0: tr_status[n] = (gpio_tr_lvl0[n] & ~gpio_input[n]) |
                            (gpio_tr_lvl1[n] &  gpio_input[n]);
          1: tr_status[n] = (gpio_tr_lvl0[n] &  tr_falling[n]) | 
                            (gpio_tr_lvl1[n] &  tr_rising [n]);           
        endcase
      end
    end
    
    
    always @(posedge pclk, negedge prstn) begin
      if(!prstn) irq_o <= 1'b0;
      else       irq_o <= |(gpio_irq_en & gpio_tr_stat);
    end

endmodule