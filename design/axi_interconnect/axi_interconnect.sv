//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2022 09:15:30
// Design Name: 
// Module Name: axi_interconnect
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
/////////////////////////////////////////////////////////////////////////////////


module axi_interconnect
       import el2_pkg::*;
       #(
       `include "el2_param.vh"
       )
         (
       
              //-------------------------- LSU AXI signals--------------------------
              // AXI Write Channels
              //output  logic                            lsu_axi_awread,
              output  logic                            lsu_axi_wready,
              output  logic                            lsu_axi_bvalid,
              output  logic [1:0]                      lsu_axi_bresp,
              output  logic [pt.LSU_BUS_TAG-1:0]       lsu_axi_bid,
       
       
              input logic                              lsu_axi_awvalid,
              input logic [pt.LSU_BUS_TAG-1:0]         lsu_axi_awid,
              input logic [31:0]                       lsu_axi_awaddr,
              input logic [3:0]                        lsu_axi_awregion,
              input logic [7:0]                        lsu_axi_awlen,
              input logic [2:0]                        lsu_axi_awsize,
              input logic [1:0]                        lsu_axi_awburst,
              input logic                              lsu_axi_awlock,
              input logic [3:0]                        lsu_axi_awcache,
              input logic [2:0]                        lsu_axi_awprot,
              input logic [3:0]                        lsu_axi_awqos,
              input logic                              lsu_axi_wvalid,
              input logic [63:0]                       lsu_axi_wdata,
              input logic [7:0]                        lsu_axi_wstrb,
              input logic                              lsu_axi_wlast,
              input logic                              lsu_axi_bready,
              //////////////////////////////////////////////////////////////
              // AXI Read Channels
              output  logic                            lsu_axi_arready,
              output  logic                            lsu_axi_rvalid,
              output  logic [pt.LSU_BUS_TAG-1:0]          lsu_axi_rid,
              output  logic [63:0]                     lsu_axi_rdata,
              output  logic [1:0]                      lsu_axi_rresp,
              output  logic                            lsu_axi_rlast,
              output  logic                            lsu_axi_awready,
              //////////////////////////////////////////////////////////////
              input logic                             lsu_axi_arvalid,
              input logic [pt.LSU_BUS_TAG-1:0]           lsu_axi_arid,
              input logic [31:0]                      lsu_axi_araddr,
              input logic [3:0]                       lsu_axi_arregion,
              input logic [7:0]                       lsu_axi_arlen,
              input logic [2:0]                       lsu_axi_arsize,
              input logic [1:0]                       lsu_axi_arburst,
              input logic                             lsu_axi_arlock,
              input logic [3:0]                       lsu_axi_arcache,
              input logic [2:0]                       lsu_axi_arprot,
              input logic [3:0]                       lsu_axi_arqos,
              input logic                             lsu_axi_rready,
       
              //-------------------------- LSU AXI signals--------------------------
              
              
              
              
              input  logic                            lsu_axi_arready_o,
              input  logic [pt.LSU_BUS_TAG-1:0]          lsu_axi_rid_o,
              input  logic [63:0]                     lsu_axi_rdata_o,
              input  logic [1:0]                      lsu_axi_rresp_o,
              input  logic                            lsu_axi_rlast_o,
              input  logic                            lsu_axi_rvalid_o,
              input  logic [1:0]                      lsu_axi_bresp_o,
              input  logic [pt.LSU_BUS_TAG-1:0]          lsu_axi_bid_o,
              input  logic                            lsu_axi_awready_o,
              input  logic                            lsu_axi_wready_o,
              input  logic                            lsu_axi_bvalid_o,
       
              output logic                            lsu_axi_rready_o,
              output logic [pt.LSU_BUS_TAG-1:0]          lsu_axi_arid_o,
              output logic [31:0]                     lsu_axi_araddr_o,
              output logic [3:0]                      lsu_axi_arregion_o,
              output logic [7:0]                      lsu_axi_arlen_o,
              output logic [2:0]                      lsu_axi_arsize_o,
              output logic [1:0]                      lsu_axi_arburst_o,
              output logic                            lsu_axi_arlock_o,
              output logic [3:0]                      lsu_axi_arcache_o,
              output logic [2:0]                      lsu_axi_arprot_o,
              output logic [3:0]                      lsu_axi_arqos_o,
              output logic                            lsu_axi_arvalid_o,
              output logic                            lsu_axi_awvalid_o,
              output logic [pt.LSU_BUS_TAG-1:0]          lsu_axi_awid_o,
              output logic [31:0]                     lsu_axi_awaddr_o,
              output logic [3:0]                      lsu_axi_awregion_o,
              output logic [7:0]                      lsu_axi_awlen_o,
              output logic [2:0]                      lsu_axi_awsize_o,
              output logic [1:0]                      lsu_axi_awburst_o,
              output logic                            lsu_axi_awlock_o,
              output logic [3:0]                      lsu_axi_awcache_o,
              output logic [2:0]                      lsu_axi_awprot_o,
              output logic [3:0]                      lsu_axi_awqos_o,
              output logic                            lsu_axi_wvalid_o,
              output logic [63:0]                     lsu_axi_wdata_o,
              output logic [7:0]                      lsu_axi_wstrb_o,
              output logic                            lsu_axi_wlast_o,
              output logic                            lsu_axi_bready_o,
              
       
       
              //-------------------------- LSU AXI signals--------------------------
              
              
              
              
              input  logic                            lsu_axi_arready_B_o,
              input  logic [pt.LSU_BUS_TAG-1:0]          lsu_axi_rid_B_o,
              input  logic [63:0]                     lsu_axi_rdata_B_o,
              input  logic [1:0]                      lsu_axi_rresp_B_o,
              input  logic                            lsu_axi_rlast_B_o,
              input  logic                            lsu_axi_rvalid_B_o,
              input  logic [1:0]                      lsu_axi_bresp_B_o,
              input  logic [pt.LSU_BUS_TAG-1:0]          lsu_axi_bid_B_o,
              input  logic                            lsu_axi_awready_B_o,
              input  logic                            lsu_axi_wready_B_o,
              input  logic                            lsu_axi_bvalid_B_o,
       
              output logic                            lsu_axi_rready_B_o,
              output logic [pt.LSU_BUS_TAG-1:0]          lsu_axi_arid_B_o,
              output logic [31:0]                     lsu_axi_araddr_B_o,
              output logic [3:0]                      lsu_axi_arregion_B_o,
              output logic [7:0]                      lsu_axi_arlen_B_o,
              output logic [2:0]                      lsu_axi_arsize_B_o,
              output logic [1:0]                      lsu_axi_arburst_B_o,
              output logic                            lsu_axi_arlock_B_o,
              output logic [3:0]                      lsu_axi_arcache_B_o,
              output logic [2:0]                      lsu_axi_arprot_B_o,
              output logic [3:0]                      lsu_axi_arqos_B_o,
              output logic                            lsu_axi_arvalid_B_o,
              output logic                            lsu_axi_awvalid_B_o,
              output logic [pt.LSU_BUS_TAG-1:0]          lsu_axi_awid_B_o,
              output logic [31:0]                     lsu_axi_awaddr_B_o,
              output logic [3:0]                      lsu_axi_awregion_B_o,
              output logic [7:0]                      lsu_axi_awlen_B_o,
              output logic [2:0]                      lsu_axi_awsize_B_o,
              output logic [1:0]                      lsu_axi_awburst_B_o,
              output logic                            lsu_axi_awlock_B_o,
              output logic [3:0]                      lsu_axi_awcache_B_o,
              output logic [2:0]                      lsu_axi_awprot_B_o,
              output logic [3:0]                      lsu_axi_awqos_B_o,
              output logic                            lsu_axi_wvalid_B_o,
              output logic [63:0]                     lsu_axi_wdata_B_o,
              output logic [7:0]                      lsu_axi_wstrb_B_o,
              output logic                            lsu_axi_wlast_B_o,
              output logic                            lsu_axi_bready_B_o
              
       
         );
       
              localparam BRIDGE_RANGE_low        =  32'h1fffffff;
              localparam BRIDGE_RANGE_high       =  32'h60000000;
       
       
       
       
       
              always_comb begin
       
                     if ( ((lsu_axi_araddr > BRIDGE_RANGE_low) && (lsu_axi_araddr < BRIDGE_RANGE_high)) ||  ((lsu_axi_awaddr > BRIDGE_RANGE_low) && (lsu_axi_awaddr < BRIDGE_RANGE_high)) ) begin    
                     
                            lsu_axi_arready = lsu_axi_arready_B_o;    
                            lsu_axi_rid   = lsu_axi_rid_B_o;    
                            lsu_axi_rdata   = lsu_axi_rdata_B_o;   
                            lsu_axi_rresp   = lsu_axi_rresp_B_o;   
                            lsu_axi_rlast   = lsu_axi_rlast_B_o;   
                            lsu_axi_rvalid  = lsu_axi_rvalid_B_o;   
                            lsu_axi_bresp   = lsu_axi_bresp_B_o;   
                            lsu_axi_bid   = lsu_axi_bid_B_o;    
                            lsu_axi_awready = lsu_axi_awready_B_o;   
                            lsu_axi_wready  = lsu_axi_wready_B_o;   
                            lsu_axi_bvalid  = lsu_axi_bvalid_B_o;   
                            
                            lsu_axi_rready_B_o     = lsu_axi_rready   ;
                            lsu_axi_arid_B_o       = lsu_axi_arid     ;
                            lsu_axi_araddr_B_o     = lsu_axi_araddr   ;
                            lsu_axi_arregion_B_o   = lsu_axi_arregion ;
                            lsu_axi_arlen_B_o      = lsu_axi_arlen    ;
                            lsu_axi_arsize_B_o     = lsu_axi_arsize   ;
                            lsu_axi_arburst_B_o    = lsu_axi_arburst  ;
                            lsu_axi_arlock_B_o     = lsu_axi_arlock   ;
                            lsu_axi_arcache_B_o    = lsu_axi_arcache  ;
                            lsu_axi_arprot_B_o     = lsu_axi_arprot   ;
                            lsu_axi_arqos_B_o      = lsu_axi_arqos    ;                      
                            lsu_axi_arvalid_B_o    = lsu_axi_arvalid  ;
                            lsu_axi_awvalid_B_o    = lsu_axi_awvalid  ;
                            lsu_axi_awid_B_o       = lsu_axi_awid     ;
                            lsu_axi_awaddr_B_o     = lsu_axi_awaddr   ;
                            lsu_axi_awregion_B_o   = lsu_axi_awregion ;
                            lsu_axi_awlen_B_o      = lsu_axi_awlen    ;
                            lsu_axi_awsize_B_o     = lsu_axi_awsize   ;
                            lsu_axi_awburst_B_o    = lsu_axi_awburst  ;
                            lsu_axi_awlock_B_o     = lsu_axi_awlock   ;
                            lsu_axi_awcache_B_o    = lsu_axi_awcache  ;
                            lsu_axi_awprot_B_o     = lsu_axi_awprot   ;
                            lsu_axi_awqos_B_o      = lsu_axi_awqos    ;
                            lsu_axi_wvalid_B_o     = lsu_axi_wvalid   ;
                            lsu_axi_wdata_B_o      = lsu_axi_wdata    ;
                            lsu_axi_wstrb_B_o      = lsu_axi_wstrb    ;
                            lsu_axi_wlast_B_o      = lsu_axi_wlast    ;
                            lsu_axi_bready_B_o     = lsu_axi_bready   ;     
                            
                            
                            lsu_axi_rready_o     = 0;
                            lsu_axi_arid_o       = 0;
                            lsu_axi_araddr_o     = 0;
                            lsu_axi_arregion_o   = 0;
                            lsu_axi_arlen_o      = 0;
                            lsu_axi_arsize_o     = 0;
                            lsu_axi_arburst_o    = 0;
                            lsu_axi_arlock_o     = 0;
                            lsu_axi_arcache_o    = 0;
                            lsu_axi_arprot_o     = 0;
                            lsu_axi_arqos_o      = 0;                      
                            lsu_axi_arvalid_o    = 0;
                            lsu_axi_awvalid_o    = 0;
                            lsu_axi_awid_o       = 0;
                            lsu_axi_awaddr_o     = 0;
                            lsu_axi_awregion_o   = 0;
                            lsu_axi_awlen_o      = 0;
                            lsu_axi_awsize_o     = 0;
                            lsu_axi_awburst_o    = 0;
                            lsu_axi_awlock_o     = 0;
                            lsu_axi_awcache_o    = 0;
                            lsu_axi_awprot_o     = 0;
                            lsu_axi_awqos_o      = 0;
                            lsu_axi_wvalid_o     = 0;
                            lsu_axi_wdata_o      = 0;
                            lsu_axi_wstrb_o      = 0;
                            lsu_axi_wlast_o      = 0;
                            lsu_axi_bready_o     = 0;     
                            lsu_axi_bready_o     = 0;
                            
                                 
              
                     end
              
              
       
              
       
                     else begin 
                     
                            lsu_axi_arready = lsu_axi_arready_o;    
                            lsu_axi_rid     = lsu_axi_rid_o;    
                            lsu_axi_rdata   = lsu_axi_rdata_o;   
                            lsu_axi_rresp   = lsu_axi_rresp_o;   
                            lsu_axi_rlast   = lsu_axi_rlast_o;   
                            lsu_axi_rvalid  = lsu_axi_rvalid_o;   
                            lsu_axi_bresp   = lsu_axi_bresp_o;   
                            lsu_axi_bid     = lsu_axi_bid_o;    
                            lsu_axi_awready = lsu_axi_awready_o;   
                            lsu_axi_wready  = lsu_axi_wready_o;   
                            lsu_axi_bvalid  = lsu_axi_bvalid_o;   
       
                            lsu_axi_rready_o     = lsu_axi_rready   ;
                            lsu_axi_arid_o       = lsu_axi_arid     ;
                            lsu_axi_araddr_o     = lsu_axi_araddr   ;
                            lsu_axi_arregion_o   = lsu_axi_arregion ;
                            lsu_axi_arlen_o      = lsu_axi_arlen    ;
                            lsu_axi_arsize_o     = lsu_axi_arsize   ;
                            lsu_axi_arburst_o    = lsu_axi_arburst  ;
                            lsu_axi_arlock_o     = lsu_axi_arlock   ;
                            lsu_axi_arcache_o    = lsu_axi_arcache  ;
                            lsu_axi_arprot_o     = lsu_axi_arprot   ;
                            lsu_axi_arqos_o      = lsu_axi_arqos    ;                      
                            lsu_axi_arvalid_o    = lsu_axi_arvalid  ;
                            lsu_axi_awvalid_o    = lsu_axi_awvalid  ;
                            lsu_axi_awid_o       = lsu_axi_awid     ;
                            lsu_axi_awaddr_o     = lsu_axi_awaddr   ;
                            lsu_axi_awregion_o   = lsu_axi_awregion ;
                            lsu_axi_awlen_o      = lsu_axi_awlen    ;
                            lsu_axi_awsize_o     = lsu_axi_awsize   ;
                            lsu_axi_awburst_o    = lsu_axi_awburst  ;
                            lsu_axi_awlock_o     = lsu_axi_awlock   ;
                            lsu_axi_awcache_o    = lsu_axi_awcache  ;
                            lsu_axi_awprot_o     = lsu_axi_awprot   ;
                            lsu_axi_awqos_o      = lsu_axi_awqos    ;
                            lsu_axi_wvalid_o     = lsu_axi_wvalid   ;
                            lsu_axi_wdata_o      = lsu_axi_wdata    ;
                            lsu_axi_wstrb_o      = lsu_axi_wstrb    ;
                            lsu_axi_wlast_o      = lsu_axi_wlast    ;
                            lsu_axi_bready_o     = lsu_axi_bready   ;     
                            lsu_axi_bready_o     = lsu_axi_bready   ;  
                            
                            
                            
                            lsu_axi_rready_B_o     = 0;
                            lsu_axi_arid_B_o       = 0;
                            lsu_axi_araddr_B_o     = 0;
                            lsu_axi_arregion_B_o   = 0;
                            lsu_axi_arlen_B_o      = 0;
                            lsu_axi_arsize_B_o     = 0;
                            lsu_axi_arburst_B_o    = 0;
                            lsu_axi_arlock_B_o     = 0;
                            lsu_axi_arcache_B_o    = 0;
                            lsu_axi_arprot_B_o     = 0;
                            lsu_axi_arqos_B_o      = 0;                      
                            lsu_axi_arvalid_B_o    = 0;
                            lsu_axi_awvalid_B_o    = 0;
                            lsu_axi_awid_B_o       = 0;
                            lsu_axi_awaddr_B_o     = 0;
                            lsu_axi_awregion_B_o   = 0;
                            lsu_axi_awlen_B_o      = 0;
                            lsu_axi_awsize_B_o     = 0;
                            lsu_axi_awburst_B_o    = 0;
                            lsu_axi_awlock_B_o     = 0;
                            lsu_axi_awcache_B_o    = 0;
                            lsu_axi_awprot_B_o     = 0;
                            lsu_axi_awqos_B_o      = 0;
                            lsu_axi_wvalid_B_o     = 0;
                            lsu_axi_wdata_B_o      = 0;
                            lsu_axi_wstrb_B_o      = 0;
                            lsu_axi_wlast_B_o      = 0;
                            lsu_axi_bready_B_o     = 0;     
       
                     end
       
              end
       
         
       endmodule