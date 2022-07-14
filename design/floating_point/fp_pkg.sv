package fp_pkg;
/////////////
// Opcodes //
/////////////
typedef enum logic [6:0] {
  // Floating Point
  OPCODE_LOAD_FP  = 7'h07,
  OPCODE_STORE_FP = 7'h27,
  OPCODE_MADD_FP  = 7'h43,
  OPCODE_MSUB_FP  = 7'h47,
  OPCODE_NMSUB_FP = 7'h4b,
  OPCODE_NMADD_FP = 7'h4f,
  OPCODE_OP_FP    = 7'h53
} opcode_e;
typedef enum integer { 
  RV32FNone     = 0,
  RV32FSingle   = 1,
  RV64FDouble   = 2
  // RV32FQuad     = 3
} rvfloat_e;
endpackage