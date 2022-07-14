module fp_bypassing(
  input [4:0] dest_reg,
  input [4:0] src_reg1,src_reg2,src_reg3,
  input [31:0] bypass_op_a,bypass_op_b,bypass_op_c,  //from core
  input [31:0] fp_operand_a_o,fp_operand_b_o,fp_operand_c_o,
  input [31:0] fp_op_a,fp_op_b,fp_op_c               //from fp reg
  input bypass_enable
);
always_comb
begin
  if (src_reg1 == dest_reg)begin
    fp_op_a = bypass_op_a;
  end
  else begin
    fp_op_a = fp_operand_a_o;
  end
  if (src_reg2 == dest_reg)begin
    fp_op_b = bypass_op_b;
  end
  else begin
    fp_op_b = fp_operand_b_o;
  end
  if (src_reg3 == dest_reg)begin
    fp_op_c = bypass_op_c;
  end
  else begin
    fp_op_c = fp_operand_c_o;
  end
end
endmodule