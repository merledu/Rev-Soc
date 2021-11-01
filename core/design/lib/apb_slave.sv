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
  output logic ready,ready_out,
  output logic wr_out1,wr_out2,wr_out3,wr_out4,wr_out5,wr_out6,
  input  logic [31:0] rd_data1,rd_data2,rd_data3,rd_data4,rd_data5,rd_data6,
  output logic [11:0] addr_out1,addr_out2,addr_out3,addr_out4,addr_out5,addr_out6,
  output logic [31:0] data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,
  output logic PENABLE_1,PENABLE_2,PENABLE_3,PENABLE_4,PENABLE_5,PENABLE_6,
  input  logic PREADY_1,PREADY_2,PREADY_3,PREADY_4,PREADY_5,PREADY_6,
  input  logic PSLVERR_1,PSLVERR_2,PSLVERR_3,PSLVERR_4,PSLVERR_5,PSLVERR_6,
  input  logic en_in,
  output logic [31:0] readdata,
  output logic PSLVERR,
  output logic psel1,psel2,psel3,psel4,psel5,psel6   // this signal will be high to select peripheral
  );
  
endmodule   
            
           