module uart_tx (
   input wire      clk_i,
   input wire      rst_ni,    //active low
   input wire      tx_en,     //when tx_en is high,the data starts to transfer
   input wire [7:0] i_TX_Byte, //contains the data to be transfered
   input wire [15:0]CLKS_PER_BIT,
   //output      o_TX_Active,
   output reg  o_TX_Serial, //outputs the data serially
   output wire     o_TX_Done  //this signal is high when the transfer is done
   );
 
  localparam IDLE         = 3'b000;     //waits for tx_en signal to be high else no operation is performed
  localparam TX_START_BIT = 3'b001;     //start bit is sent in this state
  localparam TX_DATA_BITS = 3'b010;     //data bits are transfered in this state
  localparam TX_STOP_BIT  = 3'b011;     //stop bit is sent in this state, which shows that the data is transfered
  localparam CLEANUP      = 3'b100;     //tx_done signal set to high and moves back to idle state
  
  reg [2:0] r_SM_Main     ;     //contains all the states
  reg [15:0] r_Clock_Count ;    //counts the number of clocks
  reg [2:0] r_Bit_Index   ;     //tells the index of data
  reg [7:0] r_TX_Data     ;     //data is transfered from i_TX_byte to r_TX_data buffer
  reg       r_TX_Done     ;     //this signal is high when the transfer is done
//  reg       r_TX_Active   ;
    
  always @(posedge clk_i)
  begin
    if(~rst_ni) begin     //if reset = 0 then all the signals will be reset
        r_SM_Main     <= 3'b0;
        r_Clock_Count <= 16'b0;
        r_Bit_Index   <= 3'b0;
        r_TX_Data     <= 8'b0;
        r_TX_Done     <= 1'b0;
       // r_TX_Active   = 0;
    end else begin        //if reset = 1 then other operations will be performed
    case (r_SM_Main)      
      IDLE :
        begin
          o_TX_Serial   <= 1'b1;         // Drive Line High for Idle
          r_TX_Done     <= 1'b0;          
          r_Clock_Count <= 16'b0;
          r_Bit_Index   <= 3'b0;
          
          if (tx_en == 1'b1)        //if transfer is enabled 
          begin
           // r_TX_Active <= 1'b1;
            r_TX_Data   <= i_TX_Byte;     //data is transfered to register
            r_SM_Main   <= TX_START_BIT;  //after tx_en is high state will move to START_BIT state
          end
          else          //if tx_en = 0
            r_SM_Main <= IDLE;  //it will jump to IDLE state 
        end // case: IDLE
      
      
      // Send out Start Bit. Start bit = 0
      TX_START_BIT :
        begin
          o_TX_Serial <= 1'b0;      //sends start bit which is equal to 0 , to start the transfer of data
          
          // Wait CLKS_PER_BIT-1 clock cycles for start bit to finish
          if (r_Clock_Count < CLKS_PER_BIT-1)   
          begin
            r_Clock_Count <= r_Clock_Count + 16'b1; //increment in clock count till the condition breaks
            r_SM_Main     <= TX_START_BIT;    //jumps backs to state START_BIT until start bit is finished
          end
          else
          begin
            r_Clock_Count <= 16'b0;   //resets the counter
            r_SM_Main     <= TX_DATA_BITS;    //jumps to DATA_BITS state,where the data is transfered
          end
        end // case: TX_START_BIT
      
      
      // Wait CLKS_PER_BIT-1 clock cycles for data bits to finish         
      TX_DATA_BITS :
        begin
          o_TX_Serial <= r_TX_Data[r_Bit_Index];  //sends the data to output one by one
          
          if (r_Clock_Count < CLKS_PER_BIT-16'b1)
          begin
            r_Clock_Count <= r_Clock_Count + 16'b1; //increment in clock count till the condition breaks
            r_SM_Main     <= TX_DATA_BITS;  //jumps backs to state START_BIT until 1 bit is sent completely
          end
          else    //when 1 bit is sent
          begin
            r_Clock_Count <= 3'b0;  //resets the counter
            
            // Check if we have sent out all bits
            if (r_Bit_Index < 7)  //total index of the register containing data
            begin
              r_Bit_Index <= r_Bit_Index + 3'b1;    //increment in index, so next bit can be transfered
              r_SM_Main   <= TX_DATA_BITS;    //move back to state DATA_BITS to transfer next bit
            end
            else    //when all the bits are transfered
            begin
              r_Bit_Index <= 3'b0;    //reset the index
              r_SM_Main   <= TX_STOP_BIT;   //as all the bits are transfered
            end
          end 
        end // case: TX_DATA_BITS
      
      
      // Send out Stop bit.  Stop bit = 1
      TX_STOP_BIT :
        begin
          o_TX_Serial <= 1'b1;      //sents the stop bit,which show that the data is transfered
          
          // Wait CLKS_PER_BIT-1 clock cycles for Stop bit to finish
          if (r_Clock_Count < CLKS_PER_BIT- 16'b1)
          begin
            r_Clock_Count <= r_Clock_Count + 16'b1;
            r_SM_Main     <= TX_STOP_BIT;
          end
          else
          begin
            r_TX_Done     <= 1'b1;  //this signal is high when the transfer is done
            r_Clock_Count <= 16'b0; //reset the clock count
            r_SM_Main     <= CLEANUP; //move to CLEANUP state
           // r_TX_Active   <= 1'b0;
          end 
        end // case: TX_STOP_BIT
      
      
      // Stay here 1 clock
      CLEANUP :
      begin
          r_TX_Done <= 1'b1;  
          r_SM_Main <= IDLE;    //sent to idle state, to clear the registers
        end
      
      
      default :
        r_SM_Main <= IDLE;  //is none of the case is select,default case is IDLE
      
    endcase
    end 
  end
  
  //assign o_TX_Active = r_TX_Active;
  assign o_TX_Done   = r_TX_Done;     //r_TX_DONE signal is transfered to the output pin.
  
endmodule