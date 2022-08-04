module fp_wrapper 
  import fpnew_pkg::*;
    (
    input                         clk_i           ,
    input                         rst_ni          ,
    input  [31 : 0]               instr_i         ,
    input  [31 : 0]               wb_data_i       ,
    output logic [31 : 0]         result_o        ,
    output                        illegal_insn    ,
    // Input Handshake
    input                         core_valid      ,
    output                        in_ready_o      ,
    input                         flush_i         ,
    // Output signals
    output                        tag_o           ,
    // Output handshake
    output                        out_valid_o     ,
    // Indication of valid data in flight
    output                        busy_o          ,
    output                        fpu_valid       ,
    output                        fp_load_o       ,
    output                        fp_store_en     ,
    output [31:0]                 output_to_store ,
    input [31:0]                  gpr_i0_rs1_d    ,
    output                        int_reg_write   ,
    output  [4:0]                 frd             ,
    output                        fp_move_en      ,
    output                        fp_move_xs      ,
    output     [31:0]             move_data_xs    
  );
    localparam int unsigned NUM_FP_FORMATS = 5; 
    localparam int unsigned FP_FORMAT_BITS = $clog2(NUM_FP_FORMATS);
  
    localparam int unsigned NUM_INT_FORMATS = 4; 
    localparam int unsigned INT_FORMAT_BITS = $clog2(NUM_INT_FORMATS);

    logic [4:0]                        freg1            ;
    logic [4:0]                        freg2            ;
    logic [4:0]                        freg3            ;
    logic [31:0]                       foperand_a       ;
    logic [31:0]                       foperand_b       ;
    logic [31:0]                       foperand_c       ;
    logic [2:0][31:0]                  foperand         ;
    logic [3:0]                        fp_alu_operator  ; 
    logic                              op_mod           ;
    fpnew_pkg::fp_format_e             fp_src_fmt       ;
    fpnew_pkg::fp_format_e             fp_dst_fmt       ;
    fpnew_pkg::roundmode_e             fp_rounding_mode ;
    fpnew_pkg::status_t                status_o         ;
    logic                              fp_regwrite_o    ;
    logic                              regread_en       ;
    logic                              cvt_en           ;
    logic                              fp_move_sx       ;


  fp_decoder fpdecoder(           //all complete
    .clk_i(clk_i)                         ,
    .rst_ni(rst_ni)                       ,
    .instr_rdata_i(instr_i)               ,
    .illegal_insn_o(illegal_insn)         ,
    .fp_rounding_mode_o(fp_rounding_mode) ,
    .fp_rf_raddr_a_o(freg1)               ,
    .fp_rf_raddr_b_o(freg2)               ,
    .fp_rf_raddr_c_o(freg3)               ,
    .fp_rf_waddr_o(frd)                   ,
    .fp_load_o(fp_load_o)                 ,
    .fp_regwrite_o(fp_regwrite_o)         ,
    .fp_alu_operator_o(fp_alu_operator)   ,
    .fp_alu_op_mod_o(op_mod)              ,
    .fp_src_fmt_o(fp_src_fmt)             ,
    .fp_dst_fmt_o(fp_dst_fmt)             ,
    .fpu_valid(fpu_valid)                 ,
    .core_valid(core_valid)               ,
    .fp_move_en(fp_move_en)               ,
    .fp_store_en(fp_store_en)             ,
    .regread_en(regread_en)               ,
    .cvt_en(cvt_en)                       ,
    .int_reg_write(int_reg_write)         ,
    .fp_move_xs(fp_move_xs)               ,
    .fp_move_sx(fp_move_sx)
  );
  
  fp_register fpregister(         //all complete
    .clk_i(clk_i)                         , 
    .rst_ni(rst_ni)                       , 
    .fregwrite_i(fp_regwrite_o)           ,
    .freg1_i(freg1)                       ,
    .freg2_i(freg2)                       ,
    .freg3_i(freg3)                       ,
    .frd_i(frd)                           ,
    .writeback_data_i(wb_data_i)          ,
    .foperand_a_o(foperand_a)             ,  
    .foperand_b_o(foperand_b)             ,  
    .foperand_c_o(foperand_c)             ,
    .regread_en(regread_en)               ,
    .output_to_store(output_to_store)     ,
    .gpr_i0_rs1_d(gpr_i0_rs1_d)           ,
    .fp_move_sx(fp_move_sx)               ,
    .cvt_en(cvt_en)                       ,
    .move_data_xs(move_data_xs)           ,
    .fp_move_xs(fp_move_xs)    
  );
  fpnew_top fpnewtop(         //all complete
    .clk_i(clk_i)                     ,
    .rst_ni(rst_ni)                   , 
    .operands_i(foperand)             ,
    .rnd_mode_i(fp_rounding_mode)     ,
    .op_i(fp_alu_operator)            ,
    .op_mod_i(op_mod)                 ,
    .src_fmt_i(fp_src_fmt)            ,
    .dst_fmt_i(fp_dst_fmt)            ,
    .status_o(status_o)               ,
    .tag_o(tag_o)                     ,
    .out_valid_o(out_valid_o)         ,
    .busy_o(busy_o)                   ,
    .in_ready_o(in_ready_o)           ,
    .result_o(result_o)               ,
    .int_fmt_i(fpnew_pkg::INT32)      ,
    .vectorial_op_i(1'b0)             ,
    .tag_i( 1'b1)                     ,
    .in_valid_i(fpu_valid)            ,
    .flush_i(flush_i)                 ,
    .out_ready_i(1'b1)         
  );
  assign foperand[0] = foperand_a;
  assign foperand[1] = foperand_b;
  assign foperand[2] = foperand_c;
  always_comb begin
    if (fp_move_xs)begin 
      result_o = move_data_xs;
    end
  end
  endmodule