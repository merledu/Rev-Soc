// performance monitor stuff
//`ifndef EL2_DEF_SV
//`define EL2_DEF_SV
package el2_pkg;
`include"common_defines.vh"
typedef struct packed {
	bit [7:0]      BHT_ADDR_HI;
	bit [5:0]      BHT_ADDR_LO;
	bit [14:0]     BHT_ARRAY_DEPTH;
	bit [4:0]      BHT_GHR_HASH_1;
	bit [7:0]      BHT_GHR_SIZE;
	bit [15:0]     BHT_SIZE;
	bit [4:0]      BITMANIP_ZBA;
	bit [4:0]      BITMANIP_ZBB;
	bit [4:0]      BITMANIP_ZBC;
	bit [4:0]      BITMANIP_ZBE;
	bit [4:0]      BITMANIP_ZBF;
	bit [4:0]      BITMANIP_ZBP;
	bit [4:0]      BITMANIP_ZBR;
	bit [4:0]      BITMANIP_ZBS;
	bit [8:0]      BTB_ADDR_HI;
	bit [5:0]      BTB_ADDR_LO;
	bit [12:0]     BTB_ARRAY_DEPTH;
	bit [4:0]      BTB_BTAG_FOLD;
	bit [8:0]      BTB_BTAG_SIZE;
	bit [4:0]      BTB_ENABLE;
	bit [4:0]      BTB_FOLD2_INDEX_HASH;
	bit [4:0]      BTB_FULLYA;
	bit [8:0]      BTB_INDEX1_HI;
	bit [8:0]      BTB_INDEX1_LO;
	bit [8:0]      BTB_INDEX2_HI;
	bit [8:0]      BTB_INDEX2_LO;
	bit [8:0]      BTB_INDEX3_HI;
	bit [8:0]      BTB_INDEX3_LO;
	bit [13:0]     BTB_SIZE;
	bit [8:0]      BTB_TOFFSET_SIZE;
	bit            BUILD_AHB_LITE;
	bit [4:0]      BUILD_AXI4;
	bit [4:0]      BUILD_AXI_NATIVE;
	bit [5:0]      BUS_PRTY_DEFAULT;
	bit [35:0]     DATA_ACCESS_ADDR0;
	bit [35:0]     DATA_ACCESS_ADDR1;
	bit [35:0]     DATA_ACCESS_ADDR2;
	bit [35:0]     DATA_ACCESS_ADDR3;
	bit [35:0]     DATA_ACCESS_ADDR4;
	bit [35:0]     DATA_ACCESS_ADDR5;
	bit [35:0]     DATA_ACCESS_ADDR6;
	bit [35:0]     DATA_ACCESS_ADDR7;
	bit [4:0]      DATA_ACCESS_ENABLE0;
	bit [4:0]      DATA_ACCESS_ENABLE1;
	bit [4:0]      DATA_ACCESS_ENABLE2;
	bit [4:0]      DATA_ACCESS_ENABLE3;
	bit [4:0]      DATA_ACCESS_ENABLE4;
	bit [4:0]      DATA_ACCESS_ENABLE5;
	bit [4:0]      DATA_ACCESS_ENABLE6;
	bit [4:0]      DATA_ACCESS_ENABLE7;
	bit [35:0]     DATA_ACCESS_MASK0;
	bit [35:0]     DATA_ACCESS_MASK1;
	bit [35:0]     DATA_ACCESS_MASK2;
	bit [35:0]     DATA_ACCESS_MASK3;
	bit [35:0]     DATA_ACCESS_MASK4;
	bit [35:0]     DATA_ACCESS_MASK5;
	bit [35:0]     DATA_ACCESS_MASK6;
	bit [35:0]     DATA_ACCESS_MASK7;
	bit [6:0]      DCCM_BANK_BITS;
	bit [8:0]      DCCM_BITS;
	bit [6:0]      DCCM_BYTE_WIDTH;
	bit [9:0]      DCCM_DATA_WIDTH;
	bit [6:0]      DCCM_ECC_WIDTH;
	bit [4:0]      DCCM_ENABLE;
	bit [9:0]      DCCM_FDATA_WIDTH;
	bit [7:0]      DCCM_INDEX_BITS;
	bit [8:0]      DCCM_NUM_BANKS;
	bit [7:0]      DCCM_REGION;
	bit [35:0]     DCCM_SADR;
	bit [13:0]     DCCM_SIZE;
	bit [5:0]      DCCM_WIDTH_BITS;
	bit [6:0]      DIV_BIT;
	bit [4:0]      DIV_NEW;
	bit [6:0]      DMA_BUF_DEPTH;
	bit [8:0]      DMA_BUS_ID;
	bit [5:0]      DMA_BUS_PRTY;
	bit [7:0]      DMA_BUS_TAG;
	bit [4:0]      FAST_INTERRUPT_REDIRECT;
	bit [4:0]      ICACHE_2BANKS;
	bit [6:0]      ICACHE_BANK_BITS;
	bit [6:0]      ICACHE_BANK_HI;
	bit [5:0]      ICACHE_BANK_LO;
	bit [7:0]      ICACHE_BANK_WIDTH;
	bit [6:0]      ICACHE_BANKS_WAY;
	bit [7:0]      ICACHE_BEAT_ADDR_HI;
	bit [7:0]      ICACHE_BEAT_BITS;
	bit [4:0]      ICACHE_BYPASS_ENABLE;
	bit [17:0]     ICACHE_DATA_DEPTH;
	bit [6:0]      ICACHE_DATA_INDEX_LO;
	bit [10:0]     ICACHE_DATA_WIDTH;
	bit [4:0]      ICACHE_ECC;
	bit [4:0]      ICACHE_ENABLE;
	bit [10:0]     ICACHE_FDATA_WIDTH;
	bit [8:0]      ICACHE_INDEX_HI;
	bit [10:0]     ICACHE_LN_SZ;
	bit [7:0]      ICACHE_NUM_BEATS;
	bit [7:0]      ICACHE_NUM_BYPASS;
	bit [7:0]      ICACHE_NUM_BYPASS_WIDTH;
	bit [6:0]      ICACHE_NUM_WAYS;
	bit [4:0]      ICACHE_ONLY;
	bit [7:0]      ICACHE_SCND_LAST;
	bit [12:0]     ICACHE_SIZE;
	bit [6:0]      ICACHE_STATUS_BITS;
	bit [4:0]      ICACHE_TAG_BYPASS_ENABLE;
	bit [16:0]     ICACHE_TAG_DEPTH;
	bit [6:0]      ICACHE_TAG_INDEX_LO;
	bit [8:0]      ICACHE_TAG_LO;
	bit [7:0]      ICACHE_TAG_NUM_BYPASS;
	bit [7:0]      ICACHE_TAG_NUM_BYPASS_WIDTH;
	bit [4:0]      ICACHE_WAYPACK;
	bit [6:0]      ICCM_BANK_BITS;
	bit [8:0]      ICCM_BANK_HI;
	bit [8:0]      ICCM_BANK_INDEX_LO;
	bit [8:0]      ICCM_BITS;
	bit [4:0]      ICCM_ENABLE;
	bit [4:0]      ICCM_ICACHE;
	bit [7:0]      ICCM_INDEX_BITS;
	bit [8:0]      ICCM_NUM_BANKS;
	bit [4:0]      ICCM_ONLY;
	bit [7:0]      ICCM_REGION;
	bit [35:0]     ICCM_SADR;
	bit [13:0]     ICCM_SIZE;
	bit [4:0]      IFU_BUS_ID;
	bit [5:0]      IFU_BUS_PRTY;
	bit [7:0]      IFU_BUS_TAG;
	bit [35:0]     INST_ACCESS_ADDR0;
	bit [35:0]     INST_ACCESS_ADDR1;
	bit [35:0]     INST_ACCESS_ADDR2;
	bit [35:0]     INST_ACCESS_ADDR3;
	bit [35:0]     INST_ACCESS_ADDR4;
	bit [35:0]     INST_ACCESS_ADDR5;
	bit [35:0]     INST_ACCESS_ADDR6;
	bit [35:0]     INST_ACCESS_ADDR7;
	bit [4:0]      INST_ACCESS_ENABLE0;
	bit [4:0]      INST_ACCESS_ENABLE1;
	bit [4:0]      INST_ACCESS_ENABLE2;
	bit [4:0]      INST_ACCESS_ENABLE3;
	bit [4:0]      INST_ACCESS_ENABLE4;
	bit [4:0]      INST_ACCESS_ENABLE5;
	bit [4:0]      INST_ACCESS_ENABLE6;
	bit [4:0]      INST_ACCESS_ENABLE7;
	bit [35:0]     INST_ACCESS_MASK0;
	bit [35:0]     INST_ACCESS_MASK1;
	bit [35:0]     INST_ACCESS_MASK2;
	bit [35:0]     INST_ACCESS_MASK3;
	bit [35:0]     INST_ACCESS_MASK4;
	bit [35:0]     INST_ACCESS_MASK5;
	bit [35:0]     INST_ACCESS_MASK6;
	bit [35:0]     INST_ACCESS_MASK7;
	bit [4:0]      LOAD_TO_USE_PLUS1;
	bit [4:0]      LSU2DMA;
	bit [4:0]      LSU_BUS_ID;
	bit [5:0]      LSU_BUS_PRTY;
	bit [7:0]      LSU_BUS_TAG;
	bit [8:0]      LSU_NUM_NBLOAD;
	bit [6:0]      LSU_NUM_NBLOAD_WIDTH;
	bit [8:0]      LSU_SB_BITS;
	bit [7:0]      LSU_STBUF_DEPTH;
	bit [4:0]      NO_ICCM_NO_ICACHE;
	bit [4:0]      PIC_2CYCLE;
	bit [35:0]     PIC_BASE_ADDR;
	bit [8:0]      PIC_BITS;
	bit [7:0]      PIC_INT_WORDS;
	bit [7:0]      PIC_REGION;
	bit [12:0]     PIC_SIZE;
	bit [11:0]     PIC_TOTAL_INT;
	bit [12:0]     PIC_TOTAL_INT_PLUS1;
	bit [7:0]      RET_STACK_SIZE;
	bit [4:0]      SB_BUS_ID;
	bit [5:0]      SB_BUS_PRTY;
	bit [7:0]      SB_BUS_TAG;
	bit [4:0]      TIMER_LEGAL_EN;
} el2_param_t;




typedef struct packed {
                       logic  trace_rv_i_valid_ip;
                       logic [31:0] trace_rv_i_insn_ip;
                       logic [31:0] trace_rv_i_address_ip;
                       logic  trace_rv_i_exception_ip;
                       logic [4:0] trace_rv_i_ecause_ip;
                       logic  trace_rv_i_interrupt_ip;
                       logic [31:0] trace_rv_i_tval_ip;
                       } el2_trace_pkt_t;


typedef enum logic [3:0] {
                          NULL     = 4'b0000,
                          MUL      = 4'b0001,
                          LOAD     = 4'b0010,
                          STORE    = 4'b0011,
                          ALU      = 4'b0100,
                          CSRREAD  = 4'b0101,
                          CSRWRITE = 4'b0110,
                          CSRRW    = 4'b0111,
                          EBREAK   = 4'b1000,
                          ECALL    = 4'b1001,
                          FENCE    = 4'b1010,
                          FENCEI   = 4'b1011,
                          MRET     = 4'b1100,
                          CONDBR   = 4'b1101,
                          JAL      = 4'b1110,
                          BITMANIPU = 4'b1111
                          } el2_inst_pkt_t;

typedef struct packed {
                       logic valid;
                       logic wb;
                       logic [2:0] tag;
                       logic [4:0] rd;
                       } el2_load_cam_pkt_t;

typedef struct packed {
                       logic pc0_call;
                       logic pc0_ret;
                       logic pc0_pc4;
                       } el2_rets_pkt_t;
typedef struct packed {
                       logic valid;
                       logic [11:0] toffset;
                       logic [1:0] hist;
                       logic br_error;
                       logic br_start_error;
                       logic  bank;
                       logic [31:1] prett;  // predicted ret target
                       logic way;
                       logic ret;
                       } el2_br_pkt_t;

typedef struct packed {
                       logic valid;
                       logic [1:0] hist;
                       logic br_error;
                       logic br_start_error;
                       logic way;
                       logic middle;
                       } el2_br_tlu_pkt_t;

typedef struct packed {
                       logic misp;
                       logic ataken;
                       logic boffset;
                       logic pc4;
                       logic [1:0] hist;
                       logic [11:0] toffset;
                       logic valid;
                       logic br_error;
                       logic br_start_error;
                       logic pcall;
                       logic pja;
                       logic way;
                       logic pret;
                       // for power use the pret bit to clock the prett field
                       logic [31:1] prett;
                       } el2_predict_pkt_t;

typedef struct packed {
                       // unlikely to change
                       logic icaf;
                       logic icaf_second;
                       logic [1:0] icaf_type;
                       logic fence_i;
                       logic [3:0] i0trigger;
                       logic pmu_i0_br_unpred;     // pmu
                       logic pmu_divide;
                       // likely to change
                       logic legal;
                       logic pmu_lsu_misaligned;
                       el2_inst_pkt_t pmu_i0_itype;        // pmu - instruction type
                       } el2_trap_pkt_t;

typedef struct packed {
                       // unlikely to change
                       logic i0div;
                       logic csrwen;
                       logic csrwonly;
                       logic [11:0] csrwaddr;
                       // likely to change
                       logic [4:0] i0rd;
                       logic i0load;
                       logic i0store;
                       logic i0v;
                       logic i0valid;
                       } el2_dest_pkt_t;

typedef struct packed {
                       logic mul;
                       logic load;
                       logic alu;
                       } el2_class_pkt_t;

typedef struct packed {
                       logic [4:0] rs1;
                       logic [4:0] rs2;
                       logic [4:0] rd;
                       } el2_reg_pkt_t;


typedef struct packed {
                       logic clz;
                       logic ctz;
                       logic cpop;
                       logic sext_b;
                       logic sext_h;
                       logic min;
                       logic max;
                       logic pack;
                       logic packu;
                       logic packh;
                       logic rol;
                       logic ror;
                       logic grev;
                       logic gorc;
                       logic zbb;
                       logic bset;
                       logic bclr;
                       logic binv;
                       logic bext;
                       logic sh1add;
                       logic sh2add;
                       logic sh3add;
                       logic zba;
                       logic land;
                       logic lor;
                       logic lxor;
                       logic sll;
                       logic srl;
                       logic sra;
                       logic beq;
                       logic bne;
                       logic blt;
                       logic bge;
                       logic add;
                       logic sub;
                       logic slt;
                       logic unsign;
                       logic jal;
                       logic predict_t;
                       logic predict_nt;
                       logic csr_write;
                       logic csr_imm;
                       } el2_alu_pkt_t;

typedef struct packed {
                       logic fast_int;
/* verilator lint_off SYMRSVDWORD */
                       logic stack;
/* verilator lint_on SYMRSVDWORD */
                       logic by;
                       logic half;
                       logic word;
                       logic dword;  // for dma
                       logic load;
                       logic store;
                       logic unsign;
                       logic dma;    // dma pkt
                       logic store_data_bypass_d;
                       logic load_ldst_bypass_d;
                       logic store_data_bypass_m;
                       logic valid;
                       } el2_lsu_pkt_t;

typedef struct packed {
                      logic inst_type;   //0: Load, 1: Store
                      //logic dma_valid;
                      logic exc_type;    //0: MisAligned, 1: Access Fault
                      logic [3:0] mscause;
                      logic [31:0] addr;
                      logic single_ecc_error;
                      logic exc_valid;
                      } el2_lsu_error_pkt_t;

typedef struct packed {
                       logic clz;
                       logic ctz;
                       logic cpop;
                       logic sext_b;
                       logic sext_h;
                       logic min;
                       logic max;
                       logic pack;
                       logic packu;
                       logic packh;
                       logic rol;
                       logic ror;
                       logic grev;
                       logic gorc;
                       logic zbb;
                       logic bset;
                       logic bclr;
                       logic binv;
                       logic bext;
                       logic zbs;
                       logic bcompress;
                       logic bdecompress;
                       logic zbe;
                       logic clmul;
                       logic clmulh;
                       logic clmulr;
                       logic zbc;
                       logic shfl;
                       logic unshfl;
                       logic xperm_n;
                       logic xperm_b;
                       logic xperm_h;
                       logic zbp;
                       logic crc32_b;
                       logic crc32_h;
                       logic crc32_w;
                       logic crc32c_b;
                       logic crc32c_h;
                       logic crc32c_w;
                       logic zbr;
                       logic bfp;
                       logic zbf;
                       logic sh1add;
                       logic sh2add;
                       logic sh3add;
                       logic zba;
                       logic alu;
                       logic rs1;
                       logic rs2;
                       logic imm12;
                       logic rd;
                       logic shimm5;
                       logic imm20;
                       logic pc;
                       logic load;
                       logic store;
                       logic lsu;
                       logic add;
                       logic sub;
                       logic land;
                       logic lor;
                       logic lxor;
                       logic sll;
                       logic sra;
                       logic srl;
                       logic slt;
                       logic unsign;
                       logic condbr;
                       logic beq;
                       logic bne;
                       logic bge;
                       logic blt;
                       logic jal;
                       logic by;
                       logic half;
                       logic word;
                       logic csr_read;
                       logic csr_clr;
                       logic csr_set;
                       logic csr_write;
                       logic csr_imm;
                       logic presync;
                       logic postsync;
                       logic ebreak;
                       logic ecall;
                       logic mret;
                       logic mul;
                       logic rs1_sign;
                       logic rs2_sign;
                       logic low;
                       logic div;
                       logic rem;
                       logic fence;
                       logic fence_i;
                       logic pm_alu;
                       logic legal;
                       } el2_dec_pkt_t;


typedef struct packed {
                       logic valid;
                       logic rs1_sign;
                       logic rs2_sign;
                       logic low;
                       logic bcompress;
                       logic bdecompress;
                       logic clmul;
                       logic clmulh;
                       logic clmulr;
                       logic grev;
                       logic gorc;
                       logic shfl;
                       logic unshfl;
                       logic crc32_b;
                       logic crc32_h;
                       logic crc32_w;
                       logic crc32c_b;
                       logic crc32c_h;
                       logic crc32c_w;
                       logic bfp;
                       logic xperm_n;
                       logic xperm_b;
                       logic xperm_h;
                       } el2_mul_pkt_t;

typedef struct packed {
                       logic valid;
                       logic unsign;
                       logic rem;
                       } el2_div_pkt_t;

typedef struct packed {
                       logic        TEST1;
                       logic        RME;
                       logic [3:0]  RM;

                       logic        LS;
                       logic        DS;
                       logic        SD;
                       logic        TEST_RNM;
                       logic        BC1;
                       logic        BC2;
                      } el2_ccm_ext_in_pkt_t;

typedef struct packed {
                       logic        TEST1;
                       logic        RME;
                       logic [3:0]  RM;
                       logic        LS;
                       logic        DS;
                       logic        SD;
                       logic        TEST_RNM;
                       logic        BC1;
                       logic        BC2;
                      } el2_dccm_ext_in_pkt_t;


typedef struct packed {
                       logic        TEST1;
                       logic        RME;
                       logic [3:0]  RM;
                       logic        LS;
                       logic        DS;
                       logic        SD;
                       logic        TEST_RNM;
                       logic        BC1;
                       logic        BC2;
                      } el2_ic_data_ext_in_pkt_t;


typedef struct packed {
                       logic        TEST1;
                       logic        RME;
                       logic [3:0]  RM;
                       logic        LS;
                       logic        DS;
                       logic        SD;
                       logic        TEST_RNM;
                       logic        BC1;
                       logic        BC2;
                      } el2_ic_tag_ext_in_pkt_t;



typedef struct packed {
                        logic        select;
                        logic        match;
                        logic        store;
                        logic        load;
                        logic        execute;
                        logic        m;
                        logic [31:0] tdata2;
            } el2_trigger_pkt_t;


typedef struct packed {
                        logic [70:0]  icache_wrdata; // {dicad1[1:0], dicad0h[31:0], dicad0[31:0]}
                        logic [16:0]  icache_dicawics; // Arraysel:24, Waysel:21:20, Index:16:3
                        logic         icache_rd_valid;
                        logic         icache_wr_valid;
            } el2_cache_debug_pkt_t;
//`endif
parameter el2_param_t pt = '{
	BHT_ADDR_HI            : 8'h07         ,
	BHT_ADDR_LO            : 6'h02         ,
	BHT_ARRAY_DEPTH        : 15'h0040       ,
	BHT_GHR_HASH_1         : 5'h01         ,
	BHT_GHR_SIZE           : 8'h06         ,
	BHT_SIZE               : 16'h0080       ,
	BITMANIP_ZBA           : 5'h01         ,
	BITMANIP_ZBB           : 5'h01         ,
	BITMANIP_ZBC           : 5'h01         ,
	BITMANIP_ZBE           : 5'h00         ,
	BITMANIP_ZBF           : 5'h00         ,
	BITMANIP_ZBP           : 5'h00         ,
	BITMANIP_ZBR           : 5'h00         ,
	BITMANIP_ZBS           : 5'h01         ,
	BTB_ADDR_HI            : 9'h005        ,
	BTB_ADDR_LO            : 6'h02         ,
	BTB_ARRAY_DEPTH        : 13'h0010       ,
	BTB_BTAG_FOLD          : 5'h01         ,
	BTB_BTAG_SIZE          : 9'h009        ,
	BTB_ENABLE             : 5'h01         ,
	BTB_FOLD2_INDEX_HASH   : 5'h00         ,
	BTB_FULLYA             : 5'h00         ,
	BTB_INDEX1_HI          : 9'h005        ,
	BTB_INDEX1_LO          : 9'h002        ,
	BTB_INDEX2_HI          : 9'h009        ,
	BTB_INDEX2_LO          : 9'h006        ,
	BTB_INDEX3_HI          : 9'h00D        ,
	BTB_INDEX3_LO          : 9'h00A        ,
	BTB_SIZE               : 14'h0020       ,
	BTB_TOFFSET_SIZE       : 9'h00C        ,
	BUILD_AHB_LITE         : 4'h0          ,
	BUILD_AXI4             : 5'h01         ,
	BUILD_AXI_NATIVE       : 5'h01         ,
	BUS_PRTY_DEFAULT       : 6'h03         ,
	DATA_ACCESS_ADDR0      : 36'h000000000  ,
	DATA_ACCESS_ADDR1      : 36'h000000000  ,
	DATA_ACCESS_ADDR2      : 36'h000000000  ,
	DATA_ACCESS_ADDR3      : 36'h000000000  ,
	DATA_ACCESS_ADDR4      : 36'h000000000  ,
	DATA_ACCESS_ADDR5      : 36'h000000000  ,
	DATA_ACCESS_ADDR6      : 36'h000000000  ,
	DATA_ACCESS_ADDR7      : 36'h000000000  ,
	DATA_ACCESS_ENABLE0    : 5'h00         ,
	DATA_ACCESS_ENABLE1    : 5'h00         ,
	DATA_ACCESS_ENABLE2    : 5'h00         ,
	DATA_ACCESS_ENABLE3    : 5'h00         ,
	DATA_ACCESS_ENABLE4    : 5'h00         ,
	DATA_ACCESS_ENABLE5    : 5'h00         ,
	DATA_ACCESS_ENABLE6    : 5'h00         ,
	DATA_ACCESS_ENABLE7    : 5'h00         ,
	DATA_ACCESS_MASK0      : 36'h0FFFFFFFF  ,
	DATA_ACCESS_MASK1      : 36'h0FFFFFFFF  ,
	DATA_ACCESS_MASK2      : 36'h0FFFFFFFF  ,
	DATA_ACCESS_MASK3      : 36'h0FFFFFFFF  ,
	DATA_ACCESS_MASK4      : 36'h0FFFFFFFF  ,
	DATA_ACCESS_MASK5      : 36'h0FFFFFFFF  ,
	DATA_ACCESS_MASK6      : 36'h0FFFFFFFF  ,
	DATA_ACCESS_MASK7      : 36'h0FFFFFFFF  ,
	DCCM_BANK_BITS         : 7'h01         ,
	DCCM_BITS              : 9'h00E        ,
	DCCM_BYTE_WIDTH        : 7'h04         ,
	DCCM_DATA_WIDTH        : 10'h020        ,
	DCCM_ECC_WIDTH         : 7'h07         ,
	DCCM_ENABLE            : 5'h01         ,
	DCCM_FDATA_WIDTH       : 10'h027        ,
	DCCM_INDEX_BITS        : 8'h0B         ,
	DCCM_NUM_BANKS         : 9'h002        ,
	DCCM_REGION            : 8'h0F         ,
	DCCM_SADR              : 36'h0F0040000  ,
	DCCM_SIZE              : 14'h0010       ,
	DCCM_WIDTH_BITS        : 6'h02         ,
	DIV_BIT                : 7'h04         ,
	DIV_NEW                : 5'h01         ,
	DMA_BUF_DEPTH          : 7'h05         ,
	DMA_BUS_ID             : 9'h001        ,
	DMA_BUS_PRTY           : 6'h02         ,
	DMA_BUS_TAG            : 8'h01         ,
	FAST_INTERRUPT_REDIRECT : 5'h01         ,
	ICACHE_2BANKS          : 5'h01         ,
	ICACHE_BANK_BITS       : 7'h01         ,
	ICACHE_BANK_HI         : 7'h03         ,
	ICACHE_BANK_LO         : 6'h03         ,
	ICACHE_BANK_WIDTH      : 8'h08         ,
	ICACHE_BANKS_WAY       : 7'h02         ,
	ICACHE_BEAT_ADDR_HI    : 8'h05         ,
	ICACHE_BEAT_BITS       : 8'h03         ,
	ICACHE_BYPASS_ENABLE   : 5'h01         ,
	ICACHE_DATA_DEPTH      : 18'h00200      ,
	ICACHE_DATA_INDEX_LO   : 7'h04         ,
	ICACHE_DATA_WIDTH      : 11'h040        ,
	ICACHE_ECC             : 5'h01         ,
	ICACHE_ENABLE          : 5'h01         ,
	ICACHE_FDATA_WIDTH     : 11'h047        ,
	ICACHE_INDEX_HI        : 9'h00C        ,
	ICACHE_LN_SZ           : 11'h040        ,
	ICACHE_NUM_BEATS       : 8'h08         ,
	ICACHE_NUM_BYPASS      : 8'h02         ,
	ICACHE_NUM_BYPASS_WIDTH : 8'h02         ,
	ICACHE_NUM_WAYS        : 7'h02         ,
	ICACHE_ONLY            : 5'h01         ,
	ICACHE_SCND_LAST       : 8'h06         ,
	ICACHE_SIZE            : 13'h0010       ,
	ICACHE_STATUS_BITS     : 7'h01         ,
	ICACHE_TAG_BYPASS_ENABLE : 5'h01         ,
	ICACHE_TAG_DEPTH       : 17'h00080      ,
	ICACHE_TAG_INDEX_LO    : 7'h06         ,
	ICACHE_TAG_LO          : 9'h00D        ,
	ICACHE_TAG_NUM_BYPASS  : 8'h02         ,
	ICACHE_TAG_NUM_BYPASS_WIDTH : 8'h02         ,
	ICACHE_WAYPACK         : 5'h01         ,
	ICCM_BANK_BITS         : 7'h02         ,
	ICCM_BANK_HI           : 9'h003        ,
	ICCM_BANK_INDEX_LO     : 9'h004        ,
	ICCM_BITS              : 9'h010        ,
	ICCM_ENABLE            : 5'h00         ,
	ICCM_ICACHE            : 5'h00         ,
	ICCM_INDEX_BITS        : 8'h0C         ,
	ICCM_NUM_BANKS         : 9'h004        ,
	ICCM_ONLY              : 5'h00         ,
	ICCM_REGION            : 8'h0E         ,
	ICCM_SADR              : 36'h0EE000000  ,
	ICCM_SIZE              : 14'h0040       ,
	IFU_BUS_ID             : 5'h01         ,
	IFU_BUS_PRTY           : 6'h02         ,
	IFU_BUS_TAG            : 8'h03         ,
	INST_ACCESS_ADDR0      : 36'h000000000  ,
	INST_ACCESS_ADDR1      : 36'h000000000  ,
	INST_ACCESS_ADDR2      : 36'h000000000  ,
	INST_ACCESS_ADDR3      : 36'h000000000  ,
	INST_ACCESS_ADDR4      : 36'h000000000  ,
	INST_ACCESS_ADDR5      : 36'h000000000  ,
	INST_ACCESS_ADDR6      : 36'h000000000  ,
	INST_ACCESS_ADDR7      : 36'h000000000  ,
	INST_ACCESS_ENABLE0    : 5'h00         ,
	INST_ACCESS_ENABLE1    : 5'h00         ,
	INST_ACCESS_ENABLE2    : 5'h00         ,
	INST_ACCESS_ENABLE3    : 5'h00         ,
	INST_ACCESS_ENABLE4    : 5'h00         ,
	INST_ACCESS_ENABLE5    : 5'h00         ,
	INST_ACCESS_ENABLE6    : 5'h00         ,
	INST_ACCESS_ENABLE7    : 5'h00         ,
	INST_ACCESS_MASK0      : 36'h0FFFFFFFF  ,
	INST_ACCESS_MASK1      : 36'h0FFFFFFFF  ,
	INST_ACCESS_MASK2      : 36'h0FFFFFFFF  ,
	INST_ACCESS_MASK3      : 36'h0FFFFFFFF  ,
	INST_ACCESS_MASK4      : 36'h0FFFFFFFF  ,
	INST_ACCESS_MASK5      : 36'h0FFFFFFFF  ,
	INST_ACCESS_MASK6      : 36'h0FFFFFFFF  ,
	INST_ACCESS_MASK7      : 36'h0FFFFFFFF  ,
	LOAD_TO_USE_PLUS1      : 5'h00         ,
	LSU2DMA                : 5'h00         ,
	LSU_BUS_ID             : 5'h01         ,
	LSU_BUS_PRTY           : 6'h02         ,
	LSU_BUS_TAG            : 8'h03         ,
	LSU_NUM_NBLOAD         : 9'h004        ,
	LSU_NUM_NBLOAD_WIDTH   : 7'h02         ,
	LSU_SB_BITS            : 9'h00E        ,
	LSU_STBUF_DEPTH        : 8'h04         ,
	NO_ICCM_NO_ICACHE      : 5'h00         ,
	PIC_2CYCLE             : 5'h00         ,
	PIC_BASE_ADDR          : 36'h0F00C0000  ,
	PIC_BITS               : 9'h00F        ,
	PIC_INT_WORDS          : 8'h01         ,
	PIC_REGION             : 8'h0F         ,
	PIC_SIZE               : 13'h0020       ,
	PIC_TOTAL_INT          : 12'h01F        ,
	PIC_TOTAL_INT_PLUS1    : 13'h0020       ,
	RET_STACK_SIZE         : 8'h02         ,
	SB_BUS_ID              : 5'h01         ,
	SB_BUS_PRTY            : 6'h02         ,
	SB_BUS_TAG             : 8'h01         ,
	TIMER_LEGAL_EN         : 5'h01         
};
endpackage // el2_pkg
