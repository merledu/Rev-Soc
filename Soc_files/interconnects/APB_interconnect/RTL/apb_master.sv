/* APB master will be directly connected from the AXI2APB bridge, 
the main purpose of this module is to select the peripheral on which we have
to read or write */
module apb_master (
  input  logic clk,
  input  logic rst,
  input  logic [11:0] addr_in,   //12 bit address coming from AXI2APB of any particular peripheral
  input  logic wr_in,            //write when 1 and read when 0
  input  logic ready,            // when ready = 1 it shows it is not busy, ready = 0 is a busy state
  input  logic sel,              // positive edgw if this signal will allow to access
  input  logic [31:0] data_in,   
  output logic [2:0] sel_port, // the addresses of peripherals are fixed that are defined below
                             //select port will take last 3 bits from the address to select peripheral
  output logic en,           // when port is selected it enables the peripheral
  output logic wr_out,
  output logic [11:0] addr_out,
  output logic [31:0] data_out
);
  logic [1:0] state;
 
  localparam [1:0]  IDLE    = 2'b00,   // no operation will be performed
                    SETUP   = 2'b01,   //selects port and enables
                    ACCESS  = 2'b10,   //moves data from input to output
                    WAIT    = 2'b11;
                    
                    
  always @(posedge clk)
    begin
      if (rst == 0)        // when reset is 0 no operation will be performed everything will be 0
        begin 
          state    <= IDLE;
          addr_out <= 12'b0;
          data_out <= 32'b0;
          sel_port <= 3'b0;
          en       <= 0;
          wr_out   <= 0;   
        end
    else
      begin
        case (state)   // when reset is high states will be considered according to conditions
          IDLE: begin  
            addr_out   <= 12'b0;
            data_out   <= 32'b0;
            sel_port   <= 3'b0;
            en         <= 0;
            wr_out     <= 0;
            if (sel == 1) begin  // the select signal allows to select the port
              state  <= SETUP;
              end
              else begin
                state <= IDLE;
              end
            end
            
            SETUP: begin      // in this state the port is selected and it gives enable signal      
              sel_port   <= {>>{addr_in[10],addr_in[9],addr_in[8]}};;
              en         <= 1;
              if (sel == 1) begin // the same select signal allows to access
                 state  <= ACCESS;
                end
                  else begin
                  state <= SETUP;
                end
              end
                
            ACCESS: begin
              if (ready == 1)   // ready in high state shows it has done the task and is not busy
                begin
                  wr_out <= wr_in;   // transfers data from input signals to output
                  addr_out <= addr_in;
                  data_out <= data_in;
                  state <= WAIT;
                end
                  else begin
                  state <= ACCESS;
                end
              end
              
            
            WAIT: begin   //disables the enable signal and checks if ready is 0 the moves it back to setup to select anyother peripheral
                 en <= 0;
                if (sel == 1)  //select must be onthe whole time if you have to select any peripheral else it will jump to idle state 
                  begin
                    if (ready == 0)
                      begin
                      state <= SETUP;
                      addr_out   <= 12'b0;
                      data_out   <= 32'b0;
                      sel_port   <= 3'b0;
                      wr_out     <= 0;
                     end
                   else
                     begin
                     state <= WAIT;
                    end
                  end
                else 
                  begin                     
                    state <= IDLE;
                  end
                end

              default: begin
                state <= IDLE;
              end
            endcase
          end
        end
endmodule


/* MEMORY MAPPINBG OF PERIPHERALS
ADDRESS IS OF 12 BITS
0 TI 7 BITS ARE OF OFFSET
8 TO 11 BITS ARE FOR PERIPHERAL SELECTION
GPIO  --->   0x200 = 0010 00000000
UART  --->   0x300 = 0011 00000000
TIMER --->   0x400 = 0100 00000000
I2C   --->   0x500 = 0101 00000000
SPI   --->   0x600 = 0110 00000000
PWM   --->   0x700 = 0111 00000000 */