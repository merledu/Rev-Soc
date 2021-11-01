`timescale 1ns / 1ps
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

// Set Parameter CLKS_PER_BIT as follows:
// CLKS_PER_BIT = (Frequency of i_Clock)/(Frequency of UART)
// Example: 10 MHz Clock, 115200 baud UART
// (10000000)/(115200) = 87
  
module uart_rx (
   input  wire       clk_i,
   input  wire       rst_ni,
   input  wire       i_Rx_Serial,                 //serial input
   input  wire [15:0] CLKS_PER_BIT,               
   output wire        o_Rx_DV,                    //high when the data is recieved
   output wire  [7:0] o_Rx_Byte                   //Outputs Data recieved
   );
    
  parameter s_IDLE         = 3'b000;              //First state i.e. IDLE
  parameter s_RX_START_BIT = 3'b001;              //Second state i.e. START_BIT
  parameter s_RX_DATA_BITS = 3'b010;              //Third state i.e. DATA_BITS
  parameter s_RX_STOP_BIT  = 3'b011;              //Fourth state i.e. STOP_BIT
  parameter s_CLEANUP      = 3'b100;              //Fifth state i.e. CLEANUP
   
  reg           r_Rx_Data_R ;                 
  reg           r_Rx_Data   ;
   
  reg [15:0]     r_Clock_Count ;
  reg [2:0]     r_Bit_Index  ;                    //8 bits total
  reg [7:0]     r_Rx_Byte   ;
  reg           r_Rx_DV     ;
  reg [2:0]     r_SM_Main   ;
   
  // Purpose: Double-register the incoming data.
  // This allows it to be used in the UART RX Clock Domain.
  // (It removes problems caused by metastability)
  always @(posedge clk_i)
    begin
    if (~rst_ni) begin                            //when reset = 0, it reset the registers as reset is active low 
      r_Rx_Data_R <= 1'b1;                        
      r_Rx_Data   <= 1'b1;
    end else begin                                //if reset = 1
      r_Rx_Data_R <= i_Rx_Serial;                 //1st bit is trasnferd in buffer
      r_Rx_Data   <= r_Rx_Data_R;                 
    end
  end
   
   
  // Purpose: Control RX state machine
  always @(posedge clk_i or negedge rst_ni)
    begin
      if (~rst_ni) begin                          //if reset = 0 
        r_SM_Main <= s_IDLE;                      //Starts jumps to IDLE
        r_Rx_DV       <= 1'b0;                    //Done signal resets
        r_Clock_Count <= 16'b0;                   //Clock count resets
        r_Bit_Index   <= 3'b0;                    //resets index
	      r_Rx_Byte     <= 8'b0;            
      end else begin                              //when reset = 1
      case (r_SM_Main)                            
        s_IDLE :
          begin
            r_Rx_DV       <= 1'b0;                
            r_Clock_Count <= 16'b0;
            r_Bit_Index   <= 3'b0;
            r_Rx_Byte     <= 8'b0; 
            if (r_Rx_Data == 1'b0)                 // Start bit detected
              r_SM_Main <= s_RX_START_BIT;         //state change to START_BIT
            else
              r_SM_Main <= s_IDLE;                //if start bit is detected, state jumps back to IDLE
          end
         
        // Check middle of start bit to make sure it's still low
        s_RX_START_BIT :
          begin
            if (r_Clock_Count == ((CLKS_PER_BIT-1)>>1))   //shifts 1 bit towards right i.e. divide by two , to check the middle of start bit if it's still low 
              begin
                if (r_Rx_Data == 1'b0)                    //start bit detected i.e. equal to 0
                  begin
                    r_Clock_Count <= 16'b0;               // reset counter, found the middle
                    r_SM_Main     <= s_RX_DATA_BITS;      //when start bit is detected,state shifts to  DATA_BITS
                  end
                else
                  r_SM_Main <= s_IDLE;                    //If start bit is not there,then it jumps back to IDLE state 31
              end
            else
              begin
                r_Clock_Count <= r_Clock_Count + 16'b1;   //increment in clock count until the middle of the start bit
                r_SM_Main     <= s_RX_START_BIT;          //jumps to start bit until the middle of start bit
              end
          end // case: s_RX_START_BIT
         
         
        // Wait CLKS_PER_BIT-1 clock cycles to sample serial data
        s_RX_DATA_BITS :                                  
          begin
            if (r_Clock_Count < CLKS_PER_BIT-1)           
              begin
                r_Clock_Count <= r_Clock_Count + 16'b1;    //Increments clock counts until next bit 
                r_SM_Main     <= s_RX_DATA_BITS;           //jumps to state bit until next bit
              end
            else                                           
              begin
                r_Clock_Count          <= 16'b0;           //when 1 bit recieved, it reset the clock count
                r_Rx_Byte[r_Bit_Index] <= r_Rx_Data;       //transfers the serial bit
                 
                // Check if we have received all bits
                if (r_Bit_Index < 7)                      //as 8 bit have to be transfered
                  begin
                    r_Bit_Index <= r_Bit_Index + 3'b1;      //increment in index till 8 bits are transfered
                    r_SM_Main   <= s_RX_DATA_BITS;          //jump back to DATA_BIT state till all the bits are transfered
                  end
                else
                  begin
                    r_Bit_Index <= 3'b0;                    //resets index
                    r_SM_Main   <= s_RX_STOP_BIT;           //jump to STOP_BIT state
                  end
              end
          end // case: s_RX_DATA_BITS
     
     
        // Receive Stop bit.  Stop bit = 1
        s_RX_STOP_BIT :
          begin
            // Wait CLKS_PER_BIT-1 clock cycles for Stop bit to finish
            if (r_Clock_Count < CLKS_PER_BIT-1)
              begin
                r_Clock_Count <= r_Clock_Count + 16'b1;       //increment till the stop bit finishes
                r_SM_Main     <= s_RX_STOP_BIT;               //jumps back to STOP_BIT state
              end
            else
              begin
                r_Rx_DV       <= 1'b1;                      //once the data is recieved this signal is high
                r_Clock_Count <= 16'b0;                     //clock count resets once the data is recived
                r_SM_Main     <= s_CLEANUP;                 //jumps to CLEANUP state
              end
          end // case: s_RX_STOP_BIT
     
         
        // Stay here 1 clock
        s_CLEANUP :
          begin
            r_SM_Main <= s_IDLE;                          //jumps back to IDLE state to reset the registers
            r_Rx_DV   <= 1'b0;                            //resets the signal after one cycle
          end
         
         
        default :
          r_SM_Main <= s_IDLE;                            //Default state is set to IDLE
         
      endcase
      end
    end   
   
  assign o_Rx_DV   = r_Rx_DV;                              //signal outputs from register to output pin
  assign o_Rx_Byte = r_Rx_Byte;                            //data outputs from register to output pin
   
endmodule // uart_rx
