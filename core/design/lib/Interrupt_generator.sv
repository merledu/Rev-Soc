module Interrupt_generator(
   output interrupt_1,
   input core_clk

);
logic [31:0] clk_cnt;
logic  interrupt;
always @(posedge core_clk) begin

  if (clk_cnt < 100)
  interrupt <= 1'b0;
  else if (clk_cnt >= 100 && clk_cnt < 150  ) 
  interrupt <= 1'b1;
  else if(clk_cnt >= 150 && clk_cnt < 200 )
   interrupt <= 1'b0;
  else if(clk_cnt >= 250 && clk_cnt < 300 )
   interrupt <= 1'b1;
  else if(clk_cnt >= 300 && clk_cnt < 350 )
   interrupt <= 1'b0;
  else if(clk_cnt >= 350 && clk_cnt < 450 )
   interrupt <= 1'b1;
  else if(clk_cnt >= 450 && clk_cnt < 500 )
   interrupt <= 1'b0;

  clk_cnt++;

end
 assign  interrupt_1 = interrupt;
   endmodule