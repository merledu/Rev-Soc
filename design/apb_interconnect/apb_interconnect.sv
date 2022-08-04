module apb_interconnect (
  input  logic clk,
  input  logic rst,
  input  logic [19:0] addr_in,
  input  logic wr_in, //write when 1 and read when 0
  input  logic sel,PSLVERR_1,PSLVERR_2,PSLVERR_3,PSLVERR_4,PSLVERR_5,PSLVERR_6,
  input  logic PREADY_1,PREADY_2,PREADY_3,PREADY_4,PREADY_5,PREADY_6,
  output logic PENABLE_1,PENABLE_2,PENABLE_3,PENABLE_4,PENABLE_5,PENABLE_6,
  input  logic en_in,
  input  logic [31:0] data_in,rd_data1,rd_data2,rd_data3,rd_data4,rd_data5,rd_data6,
  output logic wr_out1,wr_out2,wr_out3,wr_out4,wr_out5,wr_out6,
  output logic [19:0] addr_out1,addr_out2,addr_out3,addr_out4,addr_out5,addr_out6,
  output logic [31:0] data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,
  output logic psel1,psel2,psel3,psel4,psel5,psel6,
  output logic ready_out,
  output logic [31:0] readdata,
  output logic PSLVERR
  );
    //  assign PSLVERR = 1'b0; // No Error

    logic [2:0] port,state,sel_port;
    localparam [2:0]  INIT = 3'b000,
                      PORT1 = 3'b001,
                      PORT2 = 3'b010,
                      PORT3 = 3'b011,
                      PORT4 = 3'b100,
                      PORT5 = 3'b101,
                      PORT6 = 3'b110;
                
  
    localparam [2:0]  IDLE    = 3'b000,
                      SETUP   = 3'b001,
                      ACCESS  = 3'b010,
                      WAIT    = 3'b101;
    assign sel_port = {addr_in[15],addr_in[14],addr_in[13]};              
                      
    always_comb begin
      case (sel_port)
        INIT: begin
          wr_out1   = 1'b0;
          wr_out2   = 1'b0;
          wr_out3   = 1'b0;
          wr_out4   = 1'b0;
          wr_out5   = 1'b0;
          wr_out6   = 1'b0;
          addr_out1 = 20'd0;
          addr_out2 = 20'd0;
          addr_out3 = 20'd0;
          addr_out4 = 20'd0;
          addr_out5 = 20'd0;
          addr_out6 = 20'd0;
          data_out1 = 32'd0;
          data_out2 = 32'd0;
          data_out3 = 32'd0;
          data_out4 = 32'd0;
          data_out5 = 32'd0;
          data_out6 = 32'd0;
          psel1     = 1'b0;
          psel2     = 1'b0;
          psel3     = 1'b0;
          psel4     = 1'b0;
          psel5     = 1'b0;
          psel6     = 1'b0;
          readdata  = 32'd0;
          PSLVERR   = 1'b0;
          ready_out = 1'b0;
          PENABLE_1 = 1'b0;
          PENABLE_2 = 1'b0;
          PENABLE_3 = 1'b0;
          PENABLE_4 = 1'b0;
          PENABLE_5 = 1'b0;
          PENABLE_6 = 1'b0;
        end
          
        PORT1: begin
          wr_out1   = wr_in;
          wr_out2   = 1'b0;
          wr_out3   = 1'b0;
          wr_out4   = 1'b0;
          wr_out5   = 1'b0;
          wr_out6   = 1'b0;
          addr_out1 = {8'd0,addr_in[11:0]};
          addr_out2 = 12'd0;
          addr_out3 = 12'd0;
          addr_out4 = 20'd0;
          addr_out5 = 20'd0;
          addr_out6 = 20'd0;
          data_out1 = data_in;
          data_out2 = 32'd0;
          data_out3 = 32'd0;
          data_out4 = 32'd0;
          data_out5 = 32'd0;
          data_out6 = 32'd0;
          psel1     = 1'b1;
          psel2     = 1'b0;
          psel3     = 1'b0;
          psel4     = 1'b0;
          psel5     = 1'b0;
          psel6     = 1'b0;
          readdata  = rd_data1;
          PSLVERR   = PSLVERR_1;
          ready_out = PREADY_1;
          PENABLE_1 = en_in;
          PENABLE_2 = 1'b0;
          PENABLE_3 = 1'b0;
          PENABLE_4 = 1'b0;
          PENABLE_5 = 1'b0;
          PENABLE_6 = 1'b0;

        end   
            
        PORT2: begin
          wr_out1 = 1'b0;
          wr_out2 = wr_in;
          wr_out3 = 1'b0;
          wr_out4 = 1'b0;
          wr_out5 = 1'b0;
          wr_out6 = 1'b0;
          addr_out1 = 12'd0;
          addr_out2 = {8'd0,addr_in[11:0]};
          addr_out3 = 12'd0;
          addr_out4 = 12'd0;
          addr_out5 = 12'd0;
          addr_out6 = 12'd0;
          data_out1 = 32'd0;
          data_out2 = data_in;
          data_out3 = 32'd0;
          data_out4 = 32'd0;
          data_out5 = 32'd0;
          data_out6 = 32'd0;
          psel1     = 1'b0;
          psel2     = 1'b1;
          psel3     = 1'b0;
          psel4     = 1'b0;
          psel5     = 1'b0;
          psel6     = 1'b0;
          readdata = rd_data2;
          PSLVERR   = PSLVERR_2;
          ready_out = PREADY_2;
          PENABLE_1 = 1'b0;
          PENABLE_2 = en_in;
          PENABLE_3 = 1'b0;
          PENABLE_4 = 1'b0;
          PENABLE_5 = 1'b0;
          PENABLE_6 = 1'b0;
        end
        
        PORT3: begin
          wr_out1 = 1'b0;
          wr_out2 = 1'b0;
          wr_out3 = wr_in;
          wr_out4 = 1'b0;
          wr_out5 = 1'b0;
          wr_out6 = 1'b0;
          addr_out1 = 12'd0;
          addr_out2 = 12'd0;
          addr_out3 = {8'd0,addr_in[11:0]};
          addr_out4 = 12'd0;
          addr_out5 = 12'd0;
          addr_out6 = 12'd0;
          data_out1 = 32'd0;
          data_out2 = 32'd0;
          data_out3 = data_in;
          data_out4 = 32'd0;
          data_out5 = 32'd0;
          data_out6 = 32'd0;
          psel1     = 1'b0;
          psel2     = 1'b0;
          psel3     = 1'b1;
          psel4     = 1'b0;
          psel5     = 1'b0;
          psel6     = 1'b0;
          readdata = rd_data3;
          PSLVERR   = PSLVERR_3;
          ready_out = PREADY_3;
          PENABLE_1 = 1'b0;
          PENABLE_2 = 1'b0;
          PENABLE_3 = en_in;
          PENABLE_4 = 1'b0;
          PENABLE_5 = 1'b0;
          PENABLE_6 = 1'b0;

        end

        PORT4: begin
          wr_out1 = 1'b0;
          wr_out2 = 1'b0;
          wr_out3 = 1'b0;
          wr_out4 = wr_in;
          wr_out5 = 1'b0;
          wr_out6 = 1'b0;
          addr_out1 = 12'd0;
          addr_out2 = 12'd0;
          addr_out3 = 12'd0;
          addr_out4 = {8'd0,addr_in[11:0]};
          addr_out5 = 12'd0;
          addr_out6 = 12'd0;
          data_out1 = 32'd0;
          data_out2 = 32'd0;
          data_out3 = 32'd0;
          data_out4 = data_in;
          data_out5 = 32'd0;
          data_out6 = 32'd0;
          psel1     = 1'b0;
          psel2     = 1'b0;
          psel3     = 1'b0;
          psel4     = 1'b1;
          psel5     = 1'b0;
          psel6     = 1'b0;
          readdata = rd_data4;
          PSLVERR   = PSLVERR_4;
          ready_out = PREADY_4;
          PENABLE_1 = 1'b0;
          PENABLE_2 = 1'b0;
          PENABLE_3 = 1'b0;
          PENABLE_4 = en_in;
          PENABLE_5 = 1'b0;
          PENABLE_6 = 1'b0;
        end


        PORT5: begin
          wr_out1 = 1'b0;
          wr_out2 = 1'b0;
          wr_out3 = 1'b0;
          wr_out4 = 1'b0;
          wr_out5 = wr_in;
          wr_out6 = 1'b0;
          addr_out1 = 12'd0;
          addr_out2 = 12'd0;
          addr_out3 = 12'd0;
          addr_out4 = 12'd0;
          addr_out5 = {8'd0,addr_in[11:0]};
          addr_out6 = 12'd0;
          data_out1 = 32'd0;
          data_out2 = 32'd0;
          data_out3 = 32'd0;
          data_out4 = 32'd0;
          data_out5 = data_in;
          data_out6 = 32'd0;
          psel1     = 1'b0;
          psel2     = 1'b0;
          psel3     = 1'b0;
          psel4     = 1'b0;
          psel5     = 1'b1;
          psel6     = 1'b0;
          readdata = rd_data5;
          PSLVERR   = PSLVERR_5;
          ready_out = PREADY_5;
          PENABLE_1 = 1'b0;
          PENABLE_2 = 1'b0;
          PENABLE_3 = 1'b0;
          PENABLE_4 = 1'b0;
          PENABLE_5 = en_in;
          PENABLE_6 = 1'b0;

        end
        
        PORT6: begin
          wr_out1 = 1'b0;
          wr_out2 = 1'b0;
          wr_out3 = 1'b0;
          wr_out4 = 1'b0;
          wr_out5 = 1'b0;
          wr_out6 = wr_in;
          addr_out1 = 12'd0;
          addr_out2 = 12'd0;
          addr_out3 = 12'd0;
          addr_out4 = 12'd0;
          addr_out5 = 12'd0;
          addr_out6 = {8'd0,addr_in[11:0]};
          data_out1 = 32'd0;
          data_out2 = 32'd0;
          data_out3 = 32'd0;
          data_out4 = 32'd0;
          data_out5 = 32'd0;
          data_out6 = data_in;
          psel1     = 1'b0;
          psel2     = 1'b0;
          psel3     = 1'b0;
          psel4     = 1'b0;
          psel5     = 1'b0;
          psel6     = 1'b1;
          readdata = rd_data6;
          PSLVERR   = PSLVERR_6;
          ready_out = PREADY_6;
          PENABLE_1 = 1'b0;
          PENABLE_2 = 1'b0;
          PENABLE_3 = 1'b0;
          PENABLE_4 = 1'b0;
          PENABLE_5 = 1'b0;
          PENABLE_6 = en_in;

        end
        
        default:begin
          wr_out1 = 1'b0;
          wr_out2 = 1'b0;
          wr_out3 = 1'b0;
          wr_out4 = 1'b0;
          wr_out5 = 1'b0;
          wr_out6 = 1'b0;
          addr_out1 = 12'd0;
          addr_out2 = 12'd0;
          addr_out3 = 12'd0;
          addr_out4 = 12'd0;
          addr_out5 = 12'd0;
          addr_out6 = 12'd0;
          data_out1 = 32'd0;
          data_out2 = 32'd0;
          data_out3 = 32'd0;
          data_out4 = 32'd0;
          data_out5 = 32'd0;
          data_out6 = 32'd0;
          readdata = 32'd0;
          PSLVERR   = 1'b0;
          ready_out = 1'b1;
          PENABLE_1 = 1'b0;
          PENABLE_2 = 1'b0;
          PENABLE_3 = 1'b0;
          PENABLE_4 = 1'b0;
          PENABLE_5 = 1'b0;
          PENABLE_6 = 1'b0;
          psel1     = 1'b0;
          psel2     = 1'b0;
          psel3     = 1'b0;
          psel4     = 1'b0;
          psel5     = 1'b0;
          psel6     = 1'b0;


        end
      endcase
    end
  endmodule

//0010000000000000 0x2000
//0100000000000000 0x4000
//0110000000000000 0x6000
//1000000000000000 0x8000
//1010000000000000 0xA000
//1100000000000000 0xC000
//1110000000000000 0xE000

//#include "defines.h"
//#define STDOUT     0xd0580000

//#define TIMER_BASE           0x20002000
//#define PWM_BASE             0x20004000
//#define UART_BASE            0x20006000
//#define GPIO_BASE            0x20008000
//#define SPI_BASE             0x2000A000
//#define I2C_BASE             0x2000E000