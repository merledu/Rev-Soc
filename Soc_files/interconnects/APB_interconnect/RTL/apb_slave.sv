/* APB Master is then further connected with APB slave, now this slave will take data from APB Master
and will send it to the peripherals  */
module apb_slave (
  input logic  clk,
  input logic  rst,
  input logic  wr_in, //write when 1 and read when 0
  input logic  en,    // comes from APB master
  input logic  [2:0] sel_port,
  input logic  [11:0] addr_in,
  input logic  [31:0] data_in,
  output logic ready,
  output logic wr_out1,wr_out2,wr_out3,wr_out4,wr_out5,wr_out6,
  output logic [11:0] addr_out1,addr_out2,addr_out3,addr_out4,addr_out5,addr_out6,
  output logic [31:0] data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,
  output logic psel1,psel2,psel3,psel4,psel5,psel6   // this signal will be high to select peripheral
  );
  reg [2:0] port,state;
  
  localparam [2:0] INIT = 3'b000,
                   PORT1 = 3'b010,  //GPIO 
                   PORT2 = 3'b011,  //UART
                   PORT3 = 3'b100,  //TIMER
                   PORT4 = 3'b101,  //I2C
                   PORT5 = 3'b110,  //SPI
                   PORT6 = 3'b111;  //PWM
  
  localparam [2:0]  IDLE    = 3'b000,
                    SETUP   = 3'b001,
                    ACCESS  = 3'b010,
                    WAIT    = 3'b101;
                    
                      
  always @(posedge clk)
    begin
      if (rst == 0)   // IDLE state 
        begin 
          state    <= IDLE;
          ready    <= 0;
          port     <= INIT;
        end
    else
      begin
        case (state) 
          IDLE : begin      
            ready    <= 1;  //free state
            port <= INIT;
            if (en == 1) // this signal will come from master when port is selected and sends to setup state
              begin
                state <= SETUP;
              end
            else
              begin
                state <= IDLE;
              end
            end
            
            SETUP: begin
              ready <= 1;  // comes out from busy state and starts accessing 
              state <= ACCESS;
              end
              
             ACCESS: begin
               case (sel_port) //peripheral selection port
                PORT1: begin  // selection of GPIO
                  wr_out1 <=  wr_in; // all the inputs will be transfered to first peripherls signals
                  wr_out2 <= 0;
                  wr_out3 <= 0;
                  wr_out4 <= 0;
                  wr_out5 <= 0;
                  wr_out6 <= 0;
                  addr_out1 <= addr_in;
                  addr_out2 <= 12'b0;
                  addr_out3 <= 12'b0;
                  addr_out4 <= 12'b0;
                  addr_out5 <= 12'b0;
                  addr_out6 <= 12'b0;
                  data_out1 <= data_in;
                  data_out2 <= 32'b0;
                  data_out3 <= 32'b0;
                  data_out4 <= 32'b0;
                  data_out5 <= 32'b0;
                  data_out6 <= 32'b0;
                  psel1 <= 1;
                  psel2 <= 0;
                  psel3 <= 0;
                  psel4 <= 0; 
                  psel5 <= 0; 
                  psel6 <= 0;
                 end
                 /* as i mentioned of GPIO in the same manner other peripherals will receive the data */
                PORT2: begin
                     wr_out1 <= 0;
                     wr_out2 <= wr_in;
                     wr_out3 <= 0;
                     wr_out4 <= 0;
                     wr_out5 <= 0;
                     wr_out6 <= 0;
                    addr_out1 <= 12'b0;
                    addr_out2 <= addr_in;
                    addr_out3 <= 12'b0;
                    addr_out4 <= 12'b0;
                    addr_out5 <= 12'b0;
                    addr_out6 <= 12'b0;
                    data_out1 <= 32'b0;
                    data_out2 <= data_in;
                    data_out3 <= 32'b0;
                    data_out4 <= 32'b0; 
                    data_out5 <= 32'b0;
                    data_out6 <= 32'b0; 
                    psel1 <= 0;
                    psel2 <= 1;
                    psel3 <= 0;
                    psel4 <= 0; 
                    psel5 <= 0; 
                    psel6 <= 0;
                  end   
                     
                PORT3: begin
                    wr_out1 <= 0;
                    wr_out2 <= 0;
                    wr_out3 <= wr_in;
                    wr_out4 <= 0;
                    wr_out5 <= 0;
                    wr_out6 <= 0;
                    addr_out1 <= 12'b0;
                    addr_out2 <= 12'b0;
                    addr_out3 <= addr_in;
                    addr_out4 <= 12'b0;
                    addr_out5 <= 12'b0;
                    addr_out6 <= 12'b0;
                    data_out1 <= 32'b0;
                    data_out2 <= 32'b0;
                    data_out3 <= data_in;
                    data_out4 <= 32'b0;
                    data_out5 <= 32'b0;
                    data_out6 <= 32'b0;
                    psel1 <= 0;
                    psel2 <= 0;
                    psel3 <= 1;
                    psel4 <= 0; 
                    psel5 <= 0; 
                    psel6 <= 0;
                  end
                  
                PORT4: begin
                    wr_out1 <= 0;
                    wr_out2 <= 0;
                    wr_out3 <= 0;
                    wr_out4 <= wr_in;
                    wr_out5 <= 0;
                    wr_out6 <= 0;
                    addr_out1 <= 12'b0;
                    addr_out2 <= 12'b0;
                    addr_out3 <= 12'b0;
                    addr_out4 <= addr_in;
                    addr_out5 <= 12'b0;
                    addr_out6 <= 12'b0;
                    data_out1 <= 32'b0;
                    data_out2 <= 32'b0;
                    data_out3 <= 32'b0;
                    data_out4 <= data_in;
                    data_out5 <= 32'b0;
                    data_out6 <= 32'b0;
                    psel1 <= 0;
                    psel2 <= 0;
                    psel3 <= 0;
                    psel4 <= 1; 
                    psel5 <= 0; 
                    psel6 <= 0;
                  end

                PORT5: begin
                    wr_out1 <= 0;
                    wr_out2 <= 0;
                    wr_out3 <= 0;
                    wr_out4 <= 0;
                    wr_out5 <= wr_in;
                    wr_out6 <= 0;
                    addr_out1 <= 12'b0;
                    addr_out2 <= 12'b0;
                    addr_out3 <= 12'b0;
                    addr_out4 <= 12'b0;
                    addr_out5 <= addr_in;
                    addr_out6 <= 12'b0;
                    data_out1 <= 32'b0;
                    data_out2 <= 32'b0;
                    data_out3 <= 32'b0;
                    data_out4 <= 32'b0;
                    data_out5 <= data_in;
                    data_out6 <= 32'b0;
                    psel1 <= 0;
                    psel2 <= 0;
                    psel3 <= 0;
                    psel4 <= 0; 
                    psel5 <= 1; 
                    psel6 <= 0;
                  end
                PORT6: begin
                    wr_out1 <= 0;
                    wr_out2 <= 0;
                    wr_out3 <= 0;
                    wr_out4 <= 0;
                    wr_out5 <= 0;
                    wr_out6 <= wr_in;
                    addr_out1 <= 12'b0;
                    addr_out2 <= 12'b0;
                    addr_out3 <= 12'b0;
                    addr_out4 <= 12'b0;
                    addr_out5 <= 12'b0;
                    addr_out6 <= addr_in;
                    data_out1 <= 32'b0;
                    data_out2 <= 32'b0;
                    data_out3 <= 32'b0;
                    data_out4 <= 32'b0;
                    data_out5 <= 32'b0;
                    data_out6 <= data_in;
                    psel1 <= 0;
                    psel2 <= 0;
                    psel3 <= 0;
                    psel4 <= 0; 
                    psel5 <= 0; 
                    psel6 <= 1;
                  end
                  
                default:begin
                    wr_out1 <= 0;
                    wr_out2 <= 0;
                    wr_out3 <= 0;
                    wr_out4 <= 0;
                    wr_out5 <= 0;
                    wr_out6 <= 0;
                    addr_out1 <= 12'b0;
                    addr_out2 <= 12'b0;
                    addr_out3 <= 12'b0;
                    addr_out4 <= 12'b0;
                    addr_out5 <= 12'b0;
                    addr_out6 <= 12'b0;
                    data_out1 <= 32'b0;
                    data_out2 <= 32'b0;
                    data_out3 <= 32'b0;
                    data_out4 <= 32'b0;
                    data_out5 <= 32'b0;
                    data_out6 <= 32'b0;
                    psel1 <= 0;
                    psel2 <= 0;
                    psel3 <= 0;
                    psel4 <= 0; 
                    psel5 <= 0; 
                    psel6 <= 0;
                  end 
              endcase
               state <= WAIT;
             end
             
             WAIT: begin
               ready <= 0;
               if (en == 0)
                 begin
                   state <= IDLE;
                 end
               else
                 begin
                   state <= WAIT;
                 end
               end


                default: begin

                  state <= IDLE;

                end



             endcase
           end
         end

endmodule   
           