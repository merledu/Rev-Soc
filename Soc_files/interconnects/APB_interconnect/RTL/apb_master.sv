module apb_master (clk,rst,addr_in,wr_in,ready,sel,
        data_in,sel_port,en,wr_out,addr_out,data_out);
  input clk;
  input rst;
  input [11:0] addr_in;
  input wr_in; //write when 1 and read when 0
  input ready;
  input sel;
  input [31:0] data_in;
  output reg [2:0] sel_port;
  output reg en;
  output reg wr_out;
  output reg [11:0] addr_out;
  output reg [31:0] data_out;
  
  reg [1:0] state;
 
  localparam [1:0]  IDLE    = 2'b00,
                    SETUP   = 2'b01,
                    ACCESS  = 2'b10,
                    WAIT    = 2'b11;
                    
                    
  always @(posedge clk)
    begin
      if (rst == 0) 
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
        case (state)
          IDLE: begin
            addr_out   <= 12'b0;
            data_out   <= 32'b0;
            sel_port   <= 3'b0;
            en         <= 0;
            wr_out     <= 0;
            if (sel == 1) begin
              state  <= SETUP;
              end
              else begin
                state <= IDLE;
              end
            end
            
            SETUP: begin           
              sel_port   <= {>>{addr_in[10],addr_in[9],addr_in[8]}};;
              en         <= 1;
              if (sel == 1) begin
                 state  <= ACCESS;
                end
                  else begin
                  state <= SETUP;
                end
              end
                
            ACCESS: begin
              if (ready == 1)
                begin
                  wr_out <= wr_in;
                  addr_out <= addr_in;
                  data_out <= data_in;
                  state <= WAIT;
                end
                  else begin
                  state <= ACCESS;
                end
              end
              
            
            WAIT: begin
                 en <= 0;
                if (sel == 1)
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