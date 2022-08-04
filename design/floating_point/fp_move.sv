module fp_move(
  input logic fpu_valid, fp_move_en,
  input [31:0] integer_data, 
  output logic [31:0] moved_out_f1
);
always_comb begin
  if (fp_move_en & fpu_valid) begin
      moved_out_f1 [31:0] = integer_data[31:0];
    end
end
endmodule