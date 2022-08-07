module fp_register( 
	input logic  clk_i, rst_ni, fregwrite_i,regread_en,cvt_en,fp_move_sx,fp_move_xs,fp_load_o,fp_store_en,fp_load_en,
	input logic  [4:0] frd_i, freg1_i, freg2_i, freg3_i,frd_load,
	input logic  [31:0] writeback_data_i, gpr_i0_rs1_d,dccm_rd_data_lo,
  input logic  [11:0]        offset,
	output logic [31:0] foperand_a_o , foperand_b_o, foperand_c_o,output_to_store,move_data_xs,addr_out
);
	logic   [31:0]  registers [31:0];
	logic   [31:0]        we,re;

always_comb begin 
    for (int i = 0; i < 32; i++) begin
      we[i] = (frd_i == 5'(i)) ?  fregwrite_i : 1'b0;
    end
    for (int i = 0; i < 32; i++) begin
      re[i] = (frd_i == 5'(i)) ?  regread_en : 1'b0;
    end
end
  for (genvar i = 0; i < 32; i++) begin 
    always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
        registers[i] <= '0;
      end else if(we[i]) begin
        registers[i] <= fp_move_sx? foperand_a_o : writeback_data_i;
      end
    end
  end
  always_comb begin 
    for (int i = 0; i < 32; i++) begin
      if(re[i]) begin
        output_to_store = registers[freg2_i];
      end 
    end
    if (fp_store_en == 1'b1 || fp_load_o == 1'b1)begin
      addr_out = {20'b0,offset} + gpr_i0_rs1_d;
    end
  end
  always_comb begin
    if (cvt_en) begin
      registers[freg1_i] = gpr_i0_rs1_d;
    end
    if (fp_move_sx) begin 
      registers[freg1_i] = gpr_i0_rs1_d;
    end 
    if (fp_move_xs) begin
      move_data_xs = registers[freg1_i];
    end
    if (fp_load_en)begin
      registers[frd_load] = dccm_rd_data_lo;
    end
  end

  assign foperand_a_o = registers[freg1_i];
  assign foperand_b_o = registers[freg2_i];
  assign foperand_c_o = registers[freg3_i];
endmodule