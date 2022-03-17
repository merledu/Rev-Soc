// NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
// This is an automatically generated file by rehan on Sun 16 Jan 14:17:44 PKT 2022
//
// cmd:    swerv -target=typical_pd -fpga_optimize=1 
//
#ifndef RV_RESET_VEC
#define RV_RESET_VEC 0x80000000
#endif
#define RV_TARGET typical_pd
#ifndef RV_NMI_VEC
#define RV_NMI_VEC 0x11110000
#endif
#define RV_INST_ACCESS_ENABLE1 0x0
#define RV_DATA_ACCESS_ENABLE1 0x0
#define RV_INST_ACCESS_ADDR7 0x00000000
#define RV_INST_ACCESS_ADDR5 0x00000000
#define RV_DATA_ACCESS_ADDR5 0x00000000
#define RV_DATA_ACCESS_ADDR7 0x00000000
#define RV_INST_ACCESS_MASK3 0xffffffff
#define RV_DATA_ACCESS_MASK3 0xffffffff
#define RV_INST_ACCESS_MASK2 0xffffffff
#define RV_DATA_ACCESS_MASK2 0xffffffff
#define RV_DATA_ACCESS_ADDR6 0x00000000
#define RV_INST_ACCESS_ENABLE2 0x0
#define RV_DATA_ACCESS_ENABLE2 0x0
#define RV_INST_ACCESS_ADDR6 0x00000000
#define RV_INST_ACCESS_ADDR1 0x00000000
#define RV_DATA_ACCESS_ADDR1 0x00000000
#define RV_INST_ACCESS_MASK0 0xffffffff
#define RV_DATA_ACCESS_MASK0 0xffffffff
#define RV_DATA_ACCESS_MASK4 0xffffffff
#define RV_INST_ACCESS_ENABLE3 0x0
#define RV_DATA_ACCESS_ENABLE3 0x0
#define RV_INST_ACCESS_MASK4 0xffffffff
#define RV_INST_ACCESS_ADDR3 0x00000000
#define RV_INST_ACCESS_ENABLE4 0x0
#define RV_DATA_ACCESS_ENABLE4 0x0
#define RV_DATA_ACCESS_ADDR3 0x00000000
#define RV_INST_ACCESS_ENABLE6 0x0
#define RV_DATA_ACCESS_ENABLE6 0x0
#define RV_INST_ACCESS_ENABLE5 0x0
#define RV_DATA_ACCESS_ENABLE5 0x0
#define RV_DATA_ACCESS_ENABLE0 0x0
#define RV_INST_ACCESS_ENABLE0 0x0
#define RV_INST_ACCESS_MASK7 0xffffffff
#define RV_INST_ACCESS_MASK5 0xffffffff
#define RV_DATA_ACCESS_MASK5 0xffffffff
#define RV_DATA_ACCESS_MASK7 0xffffffff
#define RV_INST_ACCESS_ADDR0 0x00000000
#define RV_DATA_ACCESS_ADDR0 0x00000000
#define RV_DATA_ACCESS_ADDR4 0x00000000
#define RV_INST_ACCESS_ADDR4 0x00000000
#define RV_INST_ACCESS_ADDR2 0x00000000
#define RV_DATA_ACCESS_ADDR2 0x00000000
#define RV_DATA_ACCESS_MASK6 0xffffffff
#define RV_INST_ACCESS_MASK6 0xffffffff
#define RV_INST_ACCESS_ENABLE7 0x0
#define RV_DATA_ACCESS_ENABLE7 0x0
#define RV_INST_ACCESS_MASK1 0xffffffff
#define RV_DATA_ACCESS_MASK1 0xffffffff
#define RV_XLEN 32
#define RV_DMA_BUF_DEPTH 2
#define RV_BITMANIP_ZBB 1
#define RV_LSU_STBUF_DEPTH 4
#define RV_BITMANIP_ZBE 0
#define RV_BITMANIP_ZBA 1
#define RV_BITMANIP_ZBS 1
#define RV_DIV_BIT 1
#define RV_LSU_NUM_NBLOAD_WIDTH 2
#define RV_BITMANIP_ZBP 0
#define RV_LSU2DMA 0
#define RV_FAST_INTERRUPT_REDIRECT 1
#define RV_LSU_NUM_NBLOAD 4
#define RV_DIV_NEW 1
#define RV_ICACHE_ONLY 1
#define RV_TIMER_LEGAL_EN 1
#define RV_BITMANIP_ZBR 0
#define RV_BITMANIP_ZBF 0
#define RV_BITMANIP_ZBC 1
#define RV_PIC_TOTAL_INT_PLUS1 3
#define RV_PIC_MPICCFG_MASK 0x1
#define RV_PIC_TOTAL_INT 2
#define RV_PIC_MEIP_COUNT 1
#define RV_PIC_BASE_ADDR 0xf00c0000
#define RV_PIC_MPICCFG_OFFSET 0x3000
#define RV_PIC_MEIP_MASK 0x0
#define RV_PIC_MPICCFG_COUNT 1
#define RV_PIC_MEIPT_OFFSET 0x3004
#define RV_PIC_SIZE 32
#define RV_PIC_MEIE_COUNT 31
#define RV_PIC_MEIGWCTRL_COUNT 31
#define RV_PIC_MEIPL_OFFSET 0x0000
#define RV_PIC_MEIE_MASK 0x1
#define RV_PIC_MEIGWCLR_OFFSET 0x5000
#define RV_PIC_INT_WORDS 1
#define RV_PIC_MEIP_OFFSET 0x1000
#define RV_PIC_BITS 15
#define RV_PIC_MEIGWCLR_MASK 0x0
#define RV_PIC_OFFSET 0xc0000
#define RV_PIC_MEIGWCTRL_MASK 0x3
#define RV_PIC_REGION 0xf
#define RV_PIC_MEIPL_MASK 0xf
#define RV_PIC_MEIPT_COUNT 31
#define RV_PIC_MEIGWCTRL_OFFSET 0x4000
#define RV_PIC_MEIE_OFFSET 0x2000
#define RV_PIC_MEIGWCLR_COUNT 31
#define RV_PIC_MEIPT_MASK 0x0
#define RV_PIC_MEIPL_COUNT 31
#define RV_ICCM_ROWS 4096
#define RV_ICCM_NUM_BANKS 4
#define RV_ICCM_BANK_INDEX_LO 4
#define RV_ICCM_SIZE_64 
#define RV_ICCM_NUM_BANKS_4 
#define RV_ICCM_BANK_BITS 2
#define RV_ICCM_BITS 16
#define RV_ICCM_INDEX_BITS 12
#define RV_ICCM_SADR 0xee000000
#define RV_ICCM_DATA_CELL ram_4096x39
#define RV_ICCM_RESERVED 0x1000
#define RV_ICCM_EADR 0xee00ffff
#define RV_ICCM_BANK_HI 3
#define RV_ICCM_OFFSET 0xe000000
#define RV_ICCM_REGION 0xe
#define RV_ICCM_SIZE 64
#ifndef RV_SERIALIO
#define RV_SERIALIO 0xd0580000
#endif
#define RV_UNUSED_REGION5 0x30000000
#define RV_UNUSED_REGION8 0x00000000
#define RV_UNUSED_REGION6 0x20000000
#define RV_EXTERNAL_DATA_1 0xb0000000
#define RV_UNUSED_REGION7 0x10000000
#define RV_DEBUG_SB_MEM 0xa0580000
#ifndef RV_EXTERNAL_DATA
#define RV_EXTERNAL_DATA 0xc0580000
#endif
#define RV_UNUSED_REGION3 0x50000000
#define RV_UNUSED_REGION1 0x70000000
#define RV_UNUSED_REGION2 0x60000000
#define RV_UNUSED_REGION4 0x40000000
#define RV_UNUSED_REGION0 0x90000000
#define CLOCK_PERIOD 100
#define RV_BUILD_AXI4 1
#define RV_STERR_ROLLBACK 0
#define RV_TOP `TOP.rvtop
#define CPU_TOP `RV_TOP.swerv
#define RV_LDERR_ROLLBACK 1
#define RV_ASSERT_ON 
#define RV_EXT_ADDRWIDTH 32
#define RV_BUILD_AXI_NATIVE 1
#define RV_EXT_DATAWIDTH 64
#define SDVT_AHB 0
#define TOP tb_top
#define RV_DCCM_BANK_BITS 1
#define RV_DCCM_BYTE_WIDTH 4
#define RV_DCCM_BITS 14
#define RV_DCCM_SADR 0xf0040000
#define RV_DCCM_INDEX_BITS 11
#define RV_DCCM_DATA_CELL ram_2048x39
#define RV_DCCM_EADR 0xf0043fff
#define RV_DCCM_RESERVED 0x1400
#define RV_DCCM_OFFSET 0x40000
#define RV_DCCM_WIDTH_BITS 2
#define RV_DCCM_REGION 0xf
#define RV_DCCM_NUM_BANKS_2 
#define RV_DCCM_SIZE 16
#define RV_DCCM_ECC_WIDTH 7
#define RV_DCCM_DATA_WIDTH 32
#define RV_DCCM_SIZE_16 
#define RV_DCCM_ROWS 2048
#define RV_DCCM_NUM_BANKS 2
#define RV_DCCM_ENABLE 0
#define RV_DCCM_FDATA_WIDTH 39
#define RV_LSU_SB_BITS 14