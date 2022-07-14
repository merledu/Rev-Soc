module fp_register( 
	input logic  clk_i, rst_ni, fregwrite_i,mv_wx_en,
	input logic [4:0] frd_i, freg1_i, freg2_i, freg3_i,
	input logic [31:0] writeback_data_i,
	output logic [31:0] foperand_a_o , foperand_b_o, foperand_c_o
);
	logic   [31:0]  registers [31:0]; 
	logic   [31:0]        we;

always_comb begin 
    for (int i = 0; i < 32; i++) begin
      we[i] = (frd_i == 5'(i)) ?  fregwrite_i : 1'b0;
    end
  end

  for (genvar i = 0; i < 32; i++) begin 
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        registers[i] <= '0;
      end else if(we[i]) begin
        registers[i] <= writeback_data_i;
      end
    end
  end
always_comb begin
  if(mv_wx_en == 1) begin
    assign foperand_a_o = writeback_data_i;
    assign foperand_b_o = 32'd0;
  end
  else begin
    assign foperand_a_o = registers[freg1_i];
    assign foperand_b_o = registers[freg2_i];
    assign foperand_c_o = registers[freg3_i];
  end
end
// assign registers[freg1_i] = 32'd4;
// assign registers[freg2_i] = 32'd3;
// assign registers[freg3_i] = 32'd1;
endmodule
