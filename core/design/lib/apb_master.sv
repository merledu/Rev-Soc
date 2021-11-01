module apb_master (
  input  logic clk,
  input  logic rst,
  input  logic [11:0] addr_in,
  input  logic wr_in, //write when 1 and read when 0
  input  logic ready,
  input  logic sel,
  input  logic [31:0] data_in,
  output logic en,
  output logic wr_out,
  output logic [11:0] addr_out,
  output logic [2:0] sel_port,
  output logic [31:0] data_out
  );
   logic [1:0] state;
 
   localparam [1:0]  IDLE    = 2'b00,
                    SETUP   = 2'b01,
                    ACCESS  = 2'b10,
                    WAIT    = 2'b11;
                    
                    
   always @(posedge clk)
    begin
      if (rst == 0) 
        begin 
          state    <= IDLE;
          addr_out <= 8'b0;
          data_out <= 32'b0;
          sel_port <= 3'b0;
          en       <= 0;
          wr_out   <= 0;   
        end
    else
      begin
        case (state)
          IDLE: begin
            addr_out   <= 8'b0;
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
                      addr_out   <= 8'b0;
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