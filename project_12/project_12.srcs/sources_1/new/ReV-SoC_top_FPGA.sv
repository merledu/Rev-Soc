//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2021 14:37:55
// Design Name: 
// Module Name: ReV-SoC_top_FPGA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ReV_SoC_top_FPGA
import el2_pkg::*;
#(parameter A=0)(
input clk_in1,rst_l,output logic led_on=0
    );
    logic                  core_clk;
//    logic                  rst_l;
    logic                  dbg_rst_l;
    logic [31:1]           rst_vec=0;
    logic                  nmi_int=0;
    logic [31:1]           nmi_vec;
    logic                 core_rst_l;   // This is "rst_l | dbg_rst_l"
   assign core_rst_l = rst_l;
    logic                 active_l2clk=0;
    logic                 free_l2clk=0;

    logic [31:0] trace_rv_i_insn_ip;
    logic [31:0] trace_rv_i_address_ip;
    logic   trace_rv_i_valid_ip;
    logic   trace_rv_i_exception_ip;
    logic [4:0]  trace_rv_i_ecause_ip;
    logic   trace_rv_i_interrupt_ip;
    logic [31:0] trace_rv_i_tval_ip;

    clk_wiz_0 clk_gen
 (
  .clk_out1(core_clk),
  .resetn(rst_l),
  .clk_in1(clk_in1)
 );

    logic                 dccm_clk_override=0;
    logic                 icm_clk_override=0;
    logic                 dec_tlu_core_ecc_disable=0;

    // external halt/run interface
    logic  i_cpu_halt_req=0;    // Asynchronous Halt request to CPU
    logic  i_cpu_run_req=0;     // Asynchronous Restart request to CPU
    logic o_cpu_halt_ack=0;    // Core Acknowledge to Halt request
    logic o_cpu_halt_status=0; // 1'b1 indicates processor is halted
    logic o_cpu_run_ack=0;     // Core Acknowledge to run request
    logic o_debug_mode_status=0; // Core to the PMU that core is in debug mode. When core is in debug mode; the PMU should refrain from sendng a halt or run request

    logic [31:4] core_id=0; // CORE ID

    // external MPC halt/run interface
    logic mpc_debug_halt_req=0; // Async halt request
    logic mpc_debug_run_req=0; // Async run request
    logic mpc_reset_run_req=0; // Run/halt after reset
    logic mpc_debug_halt_ack=0; // Halt ack
    logic mpc_debug_run_ack=0; // Run ack
    logic debug_brkpt_status=0; // debug breakpoint

    logic dec_tlu_perfcnt0=0; // toggles when slot0 perf counter 0 has an event inc
    logic dec_tlu_perfcnt1=0;
    logic dec_tlu_perfcnt2=0;
    logic dec_tlu_perfcnt3=0;

    // DCCM ports
    logic                          dccm_wren=0;
    logic                          dccm_rden=0;
    logic [pt.DCCM_BITS-1:0]          dccm_wr_addr_lo=0;
    logic [pt.DCCM_BITS-1:0]          dccm_wr_addr_hi=0;
    logic [pt.DCCM_BITS-1:0]          dccm_rd_addr_lo=0;
    logic [pt.DCCM_BITS-1:0]          dccm_rd_addr_hi=0;
    logic [pt.DCCM_FDATA_WIDTH-1:0]   dccm_wr_data_lo=0;
    logic [pt.DCCM_FDATA_WIDTH-1:0]   dccm_wr_data_hi=0;

    logic [pt.DCCM_FDATA_WIDTH-1:0]    dccm_rd_data_lo=0;
    logic [pt.DCCM_FDATA_WIDTH-1:0]    dccm_rd_data_hi=0;

    // ICCM ports
    logic [pt.ICCM_BITS-1:1]           iccm_rw_addr=0;
    logic                  iccm_wren=0;
    logic                  iccm_rden=0;
    logic [2:0]            iccm_wr_size=0;
    logic [77:0]           iccm_wr_data=0;
    logic                  iccm_buf_correct_ecc=0;
    logic                  iccm_correction_state=0;

    logic [63:0]          iccm_rd_data=0;
    logic [77:0]           iccm_rd_data_ecc=0;

    // ICache ; ITAG  ports
    logic [31:1]           ic_rw_addr;
    logic [pt.ICACHE_NUM_WAYS-1:0]            ic_tag_valid=0;
    logic [pt.ICACHE_NUM_WAYS-1:0]            ic_wr_en=0;
    logic                  ic_rd_en=0;

    logic [pt.ICACHE_BANKS_WAY-1:0][70:0]               ic_wr_data=0;         // Data to fill to the Icache. With ECC
    logic [63:0]               ic_rd_data=0 ;        // Data read from Icache. 2x64bits + parity bits. F2 stage. With ECC
    logic [70:0]               ic_debug_rd_data=0 ;        // Data read from Icache. 2x64bits + parity bits. F2 stage. With ECC
    logic [25:0]               ictag_debug_rd_data=0;// Debug icache tag.
    logic [70:0]               ic_debug_wr_data=0;   // Debug wr cache.

    logic [pt.ICACHE_BANKS_WAY-1:0] ic_eccerr=0;
    logic [pt.ICACHE_BANKS_WAY-1:0] ic_parerr=0;
    logic [63:0]               ic_premux_data=0;     // Premux data to be muxed with each way of the Icache.
    logic                      ic_sel_premux_data=0; // Select premux data


    logic [pt.ICACHE_INDEX_HI:3]               ic_debug_addr=0;      // Read/Write addresss to the Icache.
    logic                      ic_debug_rd_en=0;     // Icache debug rd
    logic                      ic_debug_wr_en=0;     // Icache debug wr
    logic                      ic_debug_tag_array=0; // Debug tag array
    logic [pt.ICACHE_NUM_WAYS-1:0]                ic_debug_way=0;       // Debug way. Rd or Wr.



    logic [pt.ICACHE_NUM_WAYS-1:0]            ic_rd_hit=0;
    logic                  ic_tag_perr=0;        // Icache Tag parity error

    //-------------------------- LSU AXI signals--------------------------
    // AXI Write Channels
    logic                            lsu_axi_awvalid=0;
    logic                            lsu_axi_awready=0;
    logic [pt.LSU_BUS_TAG-1:0]       lsu_axi_awid=0;
    logic [31:0]                     lsu_axi_awaddr=0;
    logic [3:0]                      lsu_axi_awregion=0;
    logic [7:0]                      lsu_axi_awlen=0;
    logic [2:0]                      lsu_axi_awsize=0;
    logic [1:0]                      lsu_axi_awburst=0;
    logic                            lsu_axi_awlock=0;
    logic [3:0]                      lsu_axi_awcache=0;
    logic [2:0]                      lsu_axi_awprot=0;
    logic [3:0]                      lsu_axi_awqos=0;

    logic                            lsu_axi_wvalid=0;
    logic                            lsu_axi_wready=0;
    logic [63:0]                     lsu_axi_wdata=0;
    logic [7:0]                      lsu_axi_wstrb=0;
    logic                            lsu_axi_wlast=0;

    logic                            lsu_axi_bvalid=0;
    logic                            lsu_axi_bready=0;
    logic [1:0]                      lsu_axi_bresp=0;
    logic [pt.LSU_BUS_TAG-1:0]       lsu_axi_bid=0;

    // AXI Read Channels
    logic                            lsu_axi_arvalid=0;
    logic                            lsu_axi_arready=0;
    logic [pt.LSU_BUS_TAG-1:0]       lsu_axi_arid=0;
    logic [31:0]                     lsu_axi_araddr=0;
    logic [3:0]                      lsu_axi_arregion=0;
    logic [7:0]                      lsu_axi_arlen=0;
    logic [2:0]                      lsu_axi_arsize=0;
    logic [1:0]                      lsu_axi_arburst=0;
    logic                            lsu_axi_arlock=0;
    logic [3:0]                      lsu_axi_arcache=0;
    logic [2:0]                      lsu_axi_arprot=0;
    logic [3:0]                      lsu_axi_arqos=0;

    logic                            lsu_axi_rvalid=0;
    logic                            lsu_axi_rready=0;
    logic [pt.LSU_BUS_TAG-1:0]       lsu_axi_rid=0;
    logic [63:0]                     lsu_axi_rdata=0;
    logic [1:0]                      lsu_axi_rresp=0;
    logic                            lsu_axi_rlast;

    //-------------------------- IFU AXI signals--------------------------
    // AXI Write Channels
    logic                            ifu_axi_awvalid=0;
    logic                            ifu_axi_awready=0;
    logic [pt.IFU_BUS_TAG-1:0]       ifu_axi_awid=0;
    logic [31:0]                     ifu_axi_awaddr=0;
    logic [3:0]                      ifu_axi_awregion=0;
    logic [7:0]                      ifu_axi_awlen=0;
    logic [2:0]                      ifu_axi_awsize=0;
    logic [1:0]                      ifu_axi_awburst=0;
    logic                            ifu_axi_awlock=0;
    logic [3:0]                      ifu_axi_awcache=0;
    logic [2:0]                      ifu_axi_awprot=0;
    logic [3:0]                      ifu_axi_awqos=0;

    logic                            ifu_axi_wvalid=0;
    logic                            ifu_axi_wready=0;
    logic [63:0]                     ifu_axi_wdata=0;
    logic [7:0]                      ifu_axi_wstrb=0;
    logic                            ifu_axi_wlast=0;

    logic                            ifu_axi_bvalid=0;
    logic                            ifu_axi_bready=0;
    logic [1:0]                      ifu_axi_bresp=0;
    logic [pt.IFU_BUS_TAG-1:0]       ifu_axi_bid=0;

    // AXI Read Channels
    logic                            ifu_axi_arvalid=0;
    logic                            ifu_axi_arready=0;
    logic [pt.IFU_BUS_TAG-1:0]       ifu_axi_arid=0;
    logic [31:0]                     ifu_axi_araddr=0;
    logic [3:0]                      ifu_axi_arregion=0;
    logic [7:0]                      ifu_axi_arlen=0;
    logic [2:0]                      ifu_axi_arsize=0;
    logic [1:0]                      ifu_axi_arburst=0;
    logic                            ifu_axi_arlock=0;
    logic [3:0]                      ifu_axi_arcache=0;
    logic [2:0]                      ifu_axi_arprot=0;
    logic [3:0]                      ifu_axi_arqos=0;

    logic                            ifu_axi_rvalid=0;
    logic                            ifu_axi_rready=0;
    logic [pt.IFU_BUS_TAG-1:0]       ifu_axi_rid=0;
    logic [63:0]                     ifu_axi_rdata=0;
    logic [1:0]                      ifu_axi_rresp=0;
    logic                            ifu_axi_rlast=0;

    //-------------------------- SB AXI signals--------------------------
    // AXI Write Channels
    logic                            sb_axi_awvalid=0;
    logic                            sb_axi_awready=0;
    logic [pt.SB_BUS_TAG-1:0]        sb_axi_awid=0;
    logic [31:0]                     sb_axi_awaddr=0;
    logic [3:0]                      sb_axi_awregion=0;
    logic [7:0]                      sb_axi_awlen=0;
    logic [2:0]                      sb_axi_awsize=0;
    logic [1:0]                      sb_axi_awburst=0;
    logic                            sb_axi_awlock=0;
    logic [3:0]                      sb_axi_awcache=0;
    logic [2:0]                      sb_axi_awprot=0;
    logic [3:0]                      sb_axi_awqos=0;

    logic                            sb_axi_wvalid=0;
    logic                            sb_axi_wready=0;
    logic [63:0]                     sb_axi_wdata=0;
    logic [7:0]                      sb_axi_wstrb=0;
    logic                            sb_axi_wlast=0;

    logic                            sb_axi_bvalid=0;
    logic                            sb_axi_bready=0;
    logic [1:0]                      sb_axi_bresp=0;
    logic [pt.SB_BUS_TAG-1:0]        sb_axi_bid=0;

    // AXI Read Channels
    logic                            sb_axi_arvalid=0;
    logic                            sb_axi_arready=0;
    logic [pt.SB_BUS_TAG-1:0]        sb_axi_arid=0;
    logic [31:0]                     sb_axi_araddr=0;
    logic [3:0]                      sb_axi_arregion=0;
    logic [7:0]                      sb_axi_arlen=0;
    logic [2:0]                      sb_axi_arsize=0;
    logic [1:0]                      sb_axi_arburst=0;
    logic                            sb_axi_arlock=0;
    logic [3:0]                      sb_axi_arcache=0;
    logic [2:0]                      sb_axi_arprot=0;
    logic [3:0]                      sb_axi_arqos=0;

    logic                            sb_axi_rvalid=0;
    logic                            sb_axi_rready=0;
    logic [pt.SB_BUS_TAG-1:0]        sb_axi_rid=0;
    logic [63:0]                     sb_axi_rdata=0;
    logic [1:0]                      sb_axi_rresp=0;
    logic                            sb_axi_rlast=0;

    //-------------------------- DMA AXI signals--------------------------
    // AXI Write Channels
    logic                         dma_axi_awvalid=0;
    logic                         dma_axi_awready=0;
    logic [pt.DMA_BUS_TAG-1:0]    dma_axi_awid=0;
    logic [31:0]                  dma_axi_awaddr=0;
    logic [2:0]                   dma_axi_awsize=0;
    logic [2:0]                   dma_axi_awprot=0;
    logic [7:0]                   dma_axi_awlen=0;
    logic [1:0]                   dma_axi_awburst=0;


    logic                         dma_axi_wvalid=0;
    logic                         dma_axi_wready=0;
    logic [63:0]                  dma_axi_wdata=0;
    logic [7:0]                   dma_axi_wstrb=0;
    logic                         dma_axi_wlast=0;

    logic                         dma_axi_bvalid=0;
    logic                         dma_axi_bready=0;
    logic [1:0]                   dma_axi_bresp=0;
    logic [pt.DMA_BUS_TAG-1:0]    dma_axi_bid=0;

    // AXI Read Channels
    logic                         dma_axi_arvalid=0;
    logic                         dma_axi_arready=0;
    logic [pt.DMA_BUS_TAG-1:0]    dma_axi_arid=0;
    logic [31:0]                  dma_axi_araddr=0;
    logic [2:0]                   dma_axi_arsize=0;
    logic [2:0]                   dma_axi_arprot=0;
    logic [7:0]                   dma_axi_arlen=0;
    logic [1:0]                   dma_axi_arburst=0;

    logic                         dma_axi_rvalid=0;
    logic                         dma_axi_rready=0;
    logic [pt.DMA_BUS_TAG-1:0]    dma_axi_rid=0;
    logic [63:0]                  dma_axi_rdata=0;
    logic [1:0]                   dma_axi_rresp=0;
    logic                         dma_axi_rlast=0;


    //// AHB LITE BUS
    logic [31:0]           haddr=0;
    logic [2:0]            hburst=0;
    logic                  hmastlock=0;
    logic [3:0]            hprot=0;
    logic [2:0]            hsize=0;
    logic [1:0]            htrans=0;
    logic                  hwrite=0;

    logic [63:0]           hrdata=0;
    logic                  hready=0;
    logic                  hresp=0;

    // LSU AHB Master
    logic [31:0]          lsu_haddr=0;
    logic [2:0]           lsu_hburst=0;
    logic                 lsu_hmastlock=0;
    logic [3:0]           lsu_hprot=0;
    logic [2:0]           lsu_hsize=0;
    logic [1:0]           lsu_htrans=0;
    logic                 lsu_hwrite=0;
    logic [63:0]          lsu_hwdata=0;

    logic [63:0]          lsu_hrdata=0;
    logic                 lsu_hready=0;
    logic                 lsu_hresp=0;
    //   input  logic                 interrupt_1=0;

    //System Bus Debug Master
    logic [31:0]          sb_haddr=0;
    logic [2:0]           sb_hburst=0;
    logic                 sb_hmastlock=0;
    logic [3:0]           sb_hprot=0;
    logic [2:0]           sb_hsize=0;
    logic [1:0]           sb_htrans=0;
    logic                 sb_hwrite=0;
    logic [63:0]          sb_hwdata=0;

    logic [63:0]          sb_hrdata=0;
    logic                 sb_hready=0;
    logic                 sb_hresp=0;

    // DMA Slave
    logic                   dma_hsel=0;
    logic [31:0]            dma_haddr=0;
    logic [2:0]             dma_hburst=0;
    logic                   dma_hmastlock=0;
    logic [3:0]             dma_hprot=0;
    logic [2:0]             dma_hsize=0;
    logic [1:0]             dma_htrans=0;
    logic                   dma_hwrite=0;
    logic [63:0]            dma_hwdata=0;
    logic                   dma_hreadyin=0;

    logic [63:0]          dma_hrdata=0;
    logic                 dma_hreadyout=0;
    logic                 dma_hresp=0;

    logic                 lsu_bus_clk_en=0;
    logic                 ifu_bus_clk_en=0;
    logic                 dbg_bus_clk_en=0;
    logic                 dma_bus_clk_en=0;

    logic                  dmi_reg_en=0;                // read or write
    logic [6:0]            dmi_reg_addr=0;              // address of DM register
    logic                  dmi_reg_wr_en=0;             // write instruction
    logic [31:0]           dmi_reg_wdata=0;             // write data
    logic [31:0]          dmi_reg_rdata=0;

    logic [pt.PIC_TOTAL_INT:1]           extintsrc_req=0;
    logic                   timer_int=0;
    logic                   soft_int=0;
    logic                   scan_mode=0;
    logic [1:0] TIMER_irq_o=0;
    logic [31:1] reset_vector;
    logic [31:1] nmi_vector;
    logic [31:1] jtag_id;
    logic jtag_tdo;   
    logic porst_l;
    logic timer_interrupt;
    assign timer_interrupt = TIMER_irq_o[1];
    always @(posedge timer_interrupt) begin
    led_on <= ~led_on;
    end
    

    
        wire                        lmem_axi_arvalid;
        wire                        lmem_axi_arready;
    
        wire                        lmem_axi_rvalid;
        wire [`RV_LSU_BUS_TAG-1:0]  lmem_axi_rid;
        wire [1:0]                  lmem_axi_rresp;
        wire [63:0]                 lmem_axi_rdata;
        wire                        lmem_axi_rlast;
        wire                        lmem_axi_rready;
    
        wire                        lmem_axi_awvalid;
        wire                        lmem_axi_awready;
    
        wire                        lmem_axi_wvalid;
        wire                        lmem_axi_wready;
    
        wire [1:0]                  lmem_axi_bresp;
        wire                        lmem_axi_bvalid;
        wire [`RV_LSU_BUS_TAG-1:0]  lmem_axi_bid;
        wire                        lmem_axi_bready;
       assign nmi_vector   = 32'hee000000;
       assign nmi_vec   = 32'hee000000;
       
       assign jtag_id[31:28] = 4'b1;
       assign       jtag_id[11:1]  = 11'h45;
       assign reset_vector = `RV_RESET_VEC;
       int cycleCnt=0;
          always @(negedge core_clk) begin
            cycleCnt <= cycleCnt+1;
            end
            
       assign porst_l = cycleCnt > 2;
       assign dbg_rst_l = cycleCnt > 2;
 
el2_swerv_wrapper  
#(.A(A) )
 ReV_top(
  .rst_l                  ( rst_l         ),
   .dbg_rst_l              ( porst_l       ),
   .clk                    ( core_clk      ),
   .rst_vec                ( reset_vector[31:1]),
   .nmi_int                ( nmi_int       ),
   .nmi_vec                ( nmi_vector[31:1]),
   .jtag_id                ( jtag_id[31:1]),
   //-------------------------- LSU AXI signals--------------------------
   // AXI Write Channels
   .lsu_axi_awvalid_o        (lsu_axi_awvalid),
   .lsu_axi_awready_o        (lsu_axi_awready),
   .lsu_axi_awid_o           (lsu_axi_awid),
   .lsu_axi_awaddr_o         (lsu_axi_awaddr),
   .TIMER_irq_o              (TIMER_irq_o),
   .lsu_axi_awregion_o       (lsu_axi_awregion),
   .lsu_axi_awlen_o          (lsu_axi_awlen),
   .lsu_axi_awsize_o         (lsu_axi_awsize),
   .lsu_axi_awburst_o        (lsu_axi_awburst),
   .lsu_axi_awlock_o         (lsu_axi_awlock),
   .lsu_axi_awcache_o        (lsu_axi_awcache),
   .lsu_axi_awprot_o         (lsu_axi_awprot),
   .lsu_axi_awqos_o          (lsu_axi_awqos),

   .lsu_axi_wvalid_o         (lsu_axi_wvalid),
   .lsu_axi_wready_o         (lsu_axi_wready),
   .lsu_axi_wdata_o          (lsu_axi_wdata),
   .lsu_axi_wstrb_o          (lsu_axi_wstrb),
   .lsu_axi_wlast_o          (lsu_axi_wlast),

   .lsu_axi_bvalid_o         (lsu_axi_bvalid),
   .lsu_axi_bready_o         (lsu_axi_bready),
   .lsu_axi_bresp_o          (lsu_axi_bresp),
   .lsu_axi_bid_o            (lsu_axi_bid),


   .lsu_axi_arvalid_o        (lsu_axi_arvalid),
   .lsu_axi_arready_o        (lsu_axi_arready),
   .lsu_axi_arid_o           (lsu_axi_arid),
   .lsu_axi_araddr_o         (lsu_axi_araddr),
   .lsu_axi_arregion_o       (lsu_axi_arregion),
   .lsu_axi_arlen_o          (lsu_axi_arlen),
   .lsu_axi_arsize_o         (lsu_axi_arsize),
   .lsu_axi_arburst_o        (lsu_axi_arburst),
   .lsu_axi_arlock_o         (lsu_axi_arlock),
   .lsu_axi_arcache_o        (lsu_axi_arcache),
   .lsu_axi_arprot_o         (lsu_axi_arprot),
   .lsu_axi_arqos_o          (lsu_axi_arqos),

   .lsu_axi_rvalid_o         (lsu_axi_rvalid),
   .lsu_axi_rready_o         (lsu_axi_rready),
   .lsu_axi_rid_o            (lsu_axi_rid),
   .lsu_axi_rdata_o          (lsu_axi_rdata),
   .lsu_axi_rresp_o          (lsu_axi_rresp),
   .lsu_axi_rlast_o          (lsu_axi_rlast),

   //-------------------------- IFU AXI signals--------------------------
   // AXI Write Channels
   .ifu_axi_awvalid_o        (ifu_axi_awvalid),
   .ifu_axi_awready_o        (ifu_axi_awready),
   .ifu_axi_awid_o           (ifu_axi_awid),
   .ifu_axi_awaddr_o         (ifu_axi_awaddr),
   .ifu_axi_awregion_o       (ifu_axi_awregion),
   .ifu_axi_awlen_o          (ifu_axi_awlen),
   .ifu_axi_awsize_o         (ifu_axi_awsize),
   .ifu_axi_awburst_o        (ifu_axi_awburst),
   .ifu_axi_awlock_o         (ifu_axi_awlock),
   .ifu_axi_awcache_o        (ifu_axi_awcache),
   .ifu_axi_awprot_o         (ifu_axi_awprot),
   .ifu_axi_awqos_o          (ifu_axi_awqos),

   .ifu_axi_wvalid_o         (ifu_axi_wvalid),
   .ifu_axi_wready_o         (ifu_axi_wready),
   .ifu_axi_wdata_o          (ifu_axi_wdata),
   .ifu_axi_wstrb_o          (ifu_axi_wstrb),
   .ifu_axi_wlast_o          (ifu_axi_wlast),

   .ifu_axi_bvalid_o         (ifu_axi_bvalid),
   .ifu_axi_bready_o         (ifu_axi_bready),
   .ifu_axi_bresp_o          (ifu_axi_bresp),
   .ifu_axi_bid_o            (ifu_axi_bid),

   .ifu_axi_arvalid_o        (ifu_axi_arvalid),
   .ifu_axi_arready_o        (ifu_axi_arready),
   .ifu_axi_arid_o           (ifu_axi_arid),
   .ifu_axi_araddr_o         (ifu_axi_araddr),
   .ifu_axi_arregion_o       (ifu_axi_arregion),
   .ifu_axi_arlen_o          (ifu_axi_arlen),
   .ifu_axi_arsize_o         (ifu_axi_arsize),
   .ifu_axi_arburst_o        (ifu_axi_arburst),
   .ifu_axi_arlock_o         (ifu_axi_arlock),
   .ifu_axi_arcache_o        (ifu_axi_arcache),
   .ifu_axi_arprot_o         (ifu_axi_arprot),
   .ifu_axi_arqos_o          (ifu_axi_arqos),

   .ifu_axi_rvalid_o         (ifu_axi_rvalid),
   .ifu_axi_rready_o         (ifu_axi_rready),
   .ifu_axi_rid_o            (ifu_axi_rid),
   .ifu_axi_rdata_o          (ifu_axi_rdata),
   .ifu_axi_rresp_o          (ifu_axi_rresp),
   .ifu_axi_rlast_o          (ifu_axi_rlast),

   //-------------------------- SB AXI signals--------------------------
   // AXI Write Channels
   .sb_axi_awvalid_o         (sb_axi_awvalid),
   .sb_axi_awready_o         (sb_axi_awready),
   .sb_axi_awid_o            (sb_axi_awid),
   .sb_axi_awaddr_o          (sb_axi_awaddr),
   .sb_axi_awregion_o        (sb_axi_awregion),
   .sb_axi_awlen_o           (sb_axi_awlen),
   .sb_axi_awsize_o          (sb_axi_awsize),
   .sb_axi_awburst_o         (sb_axi_awburst),
   .sb_axi_awlock_o          (sb_axi_awlock),
   .sb_axi_awcache_o         (sb_axi_awcache),
   .sb_axi_awprot_o          (sb_axi_awprot),
   .sb_axi_awqos_o           (sb_axi_awqos),

   .sb_axi_wvalid_o          (sb_axi_wvalid),
   .sb_axi_wready_o          (sb_axi_wready),
   .sb_axi_wdata_o           (sb_axi_wdata),
   .sb_axi_wstrb_o           (sb_axi_wstrb),
   .sb_axi_wlast_o           (sb_axi_wlast),

   .sb_axi_bvalid_o          (sb_axi_bvalid),
   .sb_axi_bready_o          (sb_axi_bready),
   .sb_axi_bresp_o           (sb_axi_bresp),
   .sb_axi_bid_o             (sb_axi_bid),


   .sb_axi_arvalid_o         (sb_axi_arvalid),
   .sb_axi_arready_o         (sb_axi_arready),
   .sb_axi_arid_o            (sb_axi_arid),
   .sb_axi_araddr_o          (sb_axi_araddr),
   .sb_axi_arregion_o        (sb_axi_arregion),
   .sb_axi_arlen_o           (sb_axi_arlen),
   .sb_axi_arsize_o          (sb_axi_arsize),
   .sb_axi_arburst_o         (sb_axi_arburst),
   .sb_axi_arlock_o          (sb_axi_arlock),
   .sb_axi_arcache_o         (sb_axi_arcache),
   .sb_axi_arprot_o          (sb_axi_arprot),
   .sb_axi_arqos_o           (sb_axi_arqos),

   .sb_axi_rvalid_o          (sb_axi_rvalid),
   .sb_axi_rready_o          (sb_axi_rready),
   .sb_axi_rid_o             (sb_axi_rid),
   .sb_axi_rdata_o           (sb_axi_rdata),
   .sb_axi_rresp_o           (sb_axi_rresp),
   .sb_axi_rlast_o           (sb_axi_rlast),


   //-------------------------- DMA AXI signals--------------------------
   // AXI Write Channels
   .dma_axi_awvalid        (dma_axi_awvalid),
   .dma_axi_awready        (dma_axi_awready),
   .dma_axi_awid           ('0),
   .dma_axi_awaddr         (lsu_axi_awaddr),
   .dma_axi_awsize         (lsu_axi_awsize),
   .dma_axi_awprot         (lsu_axi_awprot),
   .dma_axi_awlen          (lsu_axi_awlen),
   .dma_axi_awburst        (lsu_axi_awburst),


   .dma_axi_wvalid         (dma_axi_wvalid),
   .dma_axi_wready         (dma_axi_wready),
   .dma_axi_wdata          (lsu_axi_wdata),
   .dma_axi_wstrb          (lsu_axi_wstrb),
   .dma_axi_wlast          (lsu_axi_wlast),

   .dma_axi_bvalid         (dma_axi_bvalid),
   .dma_axi_bready         (dma_axi_bready),
   .dma_axi_bresp          (dma_axi_bresp),
   .dma_axi_bid            (),


   .dma_axi_arvalid        (dma_axi_arvalid),
   .dma_axi_arready        (dma_axi_arready),
   .dma_axi_arid           ('0),
   .dma_axi_araddr         (lsu_axi_araddr),
   .dma_axi_arsize         (lsu_axi_arsize),
   .dma_axi_arprot         (lsu_axi_arprot),
   .dma_axi_arlen          (lsu_axi_arlen),
   .dma_axi_arburst        (lsu_axi_arburst),

   .dma_axi_rvalid         (dma_axi_rvalid),
   .dma_axi_rready         (dma_axi_rready),
   .dma_axi_rid            (),
   .dma_axi_rdata          (dma_axi_rdata),
   .dma_axi_rresp          (dma_axi_rresp),
   .dma_axi_rlast          (dma_axi_rlast),
   .timer_int              ( 1'b0     ),
   .extintsrc_req          ( {253'd0}),//interrupt_1,interrupt_1}  ),
   .lsu_bus_clk_en         ( 1'b1  ),// Clock ratio b/w cpu core clk & AHB master interface
   .ifu_bus_clk_en         ( 1'b1  ),// Clock ratio b/w cpu core clk & AHB master interface
   .dbg_bus_clk_en         ( 1'b1  ),// Clock ratio b/w cpu core clk & AHB Debug master interface
   .dma_bus_clk_en         ( 1'b1  ),// Clock ratio b/w cpu core clk & AHB slave interface

   .trace_rv_i_insn_ip     (trace_rv_i_insn_ip),
   .trace_rv_i_address_ip  (trace_rv_i_address_ip),
   .trace_rv_i_valid_ip    (trace_rv_i_valid_ip),
   .trace_rv_i_exception_ip(trace_rv_i_exception_ip),
   .trace_rv_i_ecause_ip   (trace_rv_i_ecause_ip),
   .trace_rv_i_interrupt_ip(trace_rv_i_interrupt_ip),
   .trace_rv_i_tval_ip     (trace_rv_i_tval_ip),

   .jtag_tck               ( 1'b0  ),
   .jtag_tms               ( 1'b0  ),
   .jtag_tdi               ( 1'b0  ),
   .jtag_trst_n            ( 1'b0  ),
   .jtag_tdo               ( jtag_tdo ),

   .mpc_debug_halt_ack     ( mpc_debug_halt_ack),
   .mpc_debug_halt_req     ( 1'b0),
   .mpc_debug_run_ack      ( mpc_debug_run_ack),
   .mpc_debug_run_req      ( 1'b1),
   .mpc_reset_run_req      ( 1'b1),             // Start running after reset
    .debug_brkpt_status    (debug_brkpt_status),

   .i_cpu_halt_req         ( 1'b0  ),    // Async halt req to CPU
   .o_cpu_halt_ack         ( o_cpu_halt_ack ),    // core response to halt
   .o_cpu_halt_status      ( o_cpu_halt_status ), // 1'b1 indicates core is halted
   .i_cpu_run_req          ( 1'b0  ),     // Async restart req to CPU
   .o_debug_mode_status    (o_debug_mode_status),
   .o_cpu_run_ack          ( o_cpu_run_ack ),     // Core response to run req

   .dec_tlu_perfcnt0       (),
   .dec_tlu_perfcnt1       (),
   .dec_tlu_perfcnt2       (),
   .dec_tlu_perfcnt3       (),

// remove mems DFT pins for opensource
   .dccm_ext_in_pkt        ('0),
   .iccm_ext_in_pkt        ('0),
   .ic_data_ext_in_pkt     ('0),
   .ic_tag_ext_in_pkt      ('0),

   .soft_int               ('0),
   .core_id                ('0),
   .scan_mode              ( 1'b0 ),         // To enable scan mode
   .mbist_mode             ( 1'b0 )        // to enable mbist

);
axi_slv #(.TAGW(`RV_IFU_BUS_TAG)) imem(
    .aclk(core_clk),
    .rst_l(rst_l),
    .arvalid(ifu_axi_arvalid),
    .arready(ifu_axi_arready),
    .araddr(ifu_axi_araddr),
    .arid(ifu_axi_arid),
    .arlen(ifu_axi_arlen),
    .arburst(ifu_axi_arburst),
    .arsize(ifu_axi_arsize),

    .rvalid(ifu_axi_rvalid),
    .rready(ifu_axi_rready),
    .rdata(ifu_axi_rdata),
    .rresp(ifu_axi_rresp),
    .rid(ifu_axi_rid),
    .rlast(ifu_axi_rlast),

    .awvalid(1'b0),
    .awready(),
    .awaddr('0),
    .awid('0),
    .awlen('0),
    .awburst('0),
    .awsize('0),

    .wdata('0),
    .wstrb('0),
    .wvalid(1'b0),
    .wready(),

    .bvalid(),
    .bready(1'b0),
    .bresp(),
    .bid()
);

defparam lmem.TAGW =`RV_LSU_BUS_TAG;

axi_slv #(.TAGW(`RV_LSU_BUS_TAG)) lmem(
//axi_slv  lmem(
    .aclk(core_clk),
    .rst_l(rst_l),
    .arvalid(lmem_axi_arvalid),
    .arready(lmem_axi_arready),
    .araddr(lsu_axi_araddr),
    .arid(lsu_axi_arid),
    .arlen(lsu_axi_arlen),
    .arburst(lsu_axi_arburst),
    .arsize(lsu_axi_arsize),

    .rvalid(lmem_axi_rvalid),
    .rready(lmem_axi_rready),
    .rdata(lmem_axi_rdata),
    .rresp(lmem_axi_rresp),
    .rid(lmem_axi_rid),
    .rlast(lmem_axi_rlast),

    .awvalid(lmem_axi_awvalid),
    .awready(lmem_axi_awready),
    .awaddr(lsu_axi_awaddr),
    .awid(lsu_axi_awid),
    .awlen(lsu_axi_awlen),
    .awburst(lsu_axi_awburst),
    .awsize(lsu_axi_awsize),

    .wdata(lsu_axi_wdata),
    .wstrb(lsu_axi_wstrb),
    .wvalid(lmem_axi_wvalid),
    .wready(lmem_axi_wready),

    .bvalid(lmem_axi_bvalid),
    .bready(lmem_axi_bready),
    .bresp(lmem_axi_bresp),
    .bid(lmem_axi_bid)
);

axi_lsu_dma_bridge # (`RV_LSU_BUS_TAG,`RV_LSU_BUS_TAG ) bridge(
    .clk(core_clk),
    .reset_l(rst_l),

    .m_arvalid(lsu_axi_arvalid),
    .m_arid(lsu_axi_arid),
    .m_araddr(lsu_axi_araddr),
    .m_arready(lsu_axi_arready),

    .m_rvalid(lsu_axi_rvalid),
    .m_rready(lsu_axi_rready),
    .m_rdata(lsu_axi_rdata),
    .m_rid(lsu_axi_rid),
    .m_rresp(lsu_axi_rresp),
    .m_rlast(lsu_axi_rlast),

    .m_awvalid(lsu_axi_awvalid),
    .m_awid(lsu_axi_awid),
    .m_awaddr(lsu_axi_awaddr),
    .m_awready(lsu_axi_awready),

    .m_wvalid(lsu_axi_wvalid),
    .m_wready(lsu_axi_wready),

    .m_bresp(lsu_axi_bresp),
    .m_bvalid(lsu_axi_bvalid),
    .m_bid(lsu_axi_bid),
    .m_bready(lsu_axi_bready),

    .s0_arvalid(lmem_axi_arvalid),
    .s0_arready(lmem_axi_arready),

    .s0_rvalid(lmem_axi_rvalid),
    .s0_rid(lmem_axi_rid),
    .s0_rresp(lmem_axi_rresp),
    .s0_rdata(lmem_axi_rdata),
    .s0_rlast(lmem_axi_rlast),
    .s0_rready(lmem_axi_rready),

    .s0_awvalid(lmem_axi_awvalid),
    .s0_awready(lmem_axi_awready),

    .s0_wvalid(lmem_axi_wvalid),
    .s0_wready(lmem_axi_wready),

    .s0_bresp(lmem_axi_bresp),
    .s0_bvalid(lmem_axi_bvalid),
    .s0_bid(lmem_axi_bid),
    .s0_bready(lmem_axi_bready),


    .s1_arvalid(dma_axi_arvalid),
    .s1_arready(dma_axi_arready),

    .s1_rvalid(dma_axi_rvalid),
    .s1_rresp(dma_axi_rresp),
    .s1_rdata(dma_axi_rdata),
    .s1_rlast(dma_axi_rlast),
    .s1_rready(dma_axi_rready),

    .s1_awvalid(dma_axi_awvalid),
    .s1_awready(dma_axi_awready),

    .s1_wvalid(dma_axi_wvalid),
    .s1_wready(dma_axi_wready),

    .s1_bresp(dma_axi_bresp),
    .s1_bvalid(dma_axi_bvalid),
    .s1_bready(dma_axi_bready)
);

    
    
    
endmodule
