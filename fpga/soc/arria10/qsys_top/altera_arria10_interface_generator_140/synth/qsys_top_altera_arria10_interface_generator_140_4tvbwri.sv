// (C) 2001-2018 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


module qsys_top_altera_arria10_interface_generator_140_4tvbwri(
// h2f_reset
  output wire [1 - 1 : 0 ] h2f_rst_n
// f2h_cold_reset_req
 ,input wire [1 - 1 : 0 ] f2h_cold_rst_req_n
// f2h_debug_reset_req
 ,input wire [1 - 1 : 0 ] f2h_dbg_rst_req_n
// f2h_warm_reset_req
 ,input wire [1 - 1 : 0 ] f2h_warm_rst_req_n
// emif
 ,input wire [4096 - 1 : 0 ] emif_emif_to_hps
 ,output wire [4096 - 1 : 0 ] emif_hps_to_emif
 ,input wire [1 - 1 : 0 ] emif_emif_to_gp
 ,output wire [2 - 1 : 0 ] emif_gp_to_emif
// f2h_axi_clock
 ,input wire [1 - 1 : 0 ] f2h_axi_clk
// f2h_axi_reset
 ,input wire [1 - 1 : 0 ] f2h_axi_rst
// f2h_axi_slave
 ,input wire [4 - 1 : 0 ] f2h_AWID
 ,input wire [32 - 1 : 0 ] f2h_AWADDR
 ,input wire [4 - 1 : 0 ] f2h_AWLEN
 ,input wire [3 - 1 : 0 ] f2h_AWSIZE
 ,input wire [2 - 1 : 0 ] f2h_AWBURST
 ,input wire [2 - 1 : 0 ] f2h_AWLOCK
 ,input wire [4 - 1 : 0 ] f2h_AWCACHE
 ,input wire [3 - 1 : 0 ] f2h_AWPROT
 ,input wire [1 - 1 : 0 ] f2h_AWVALID
 ,output wire [1 - 1 : 0 ] f2h_AWREADY
 ,input wire [5 - 1 : 0 ] f2h_AWUSER
 ,input wire [4 - 1 : 0 ] f2h_WID
 ,input wire [128 - 1 : 0 ] f2h_WDATA
 ,input wire [16 - 1 : 0 ] f2h_WSTRB
 ,input wire [1 - 1 : 0 ] f2h_WLAST
 ,input wire [1 - 1 : 0 ] f2h_WVALID
 ,output wire [1 - 1 : 0 ] f2h_WREADY
 ,output wire [4 - 1 : 0 ] f2h_BID
 ,output wire [2 - 1 : 0 ] f2h_BRESP
 ,output wire [1 - 1 : 0 ] f2h_BVALID
 ,input wire [1 - 1 : 0 ] f2h_BREADY
 ,input wire [4 - 1 : 0 ] f2h_ARID
 ,input wire [32 - 1 : 0 ] f2h_ARADDR
 ,input wire [4 - 1 : 0 ] f2h_ARLEN
 ,input wire [3 - 1 : 0 ] f2h_ARSIZE
 ,input wire [2 - 1 : 0 ] f2h_ARBURST
 ,input wire [2 - 1 : 0 ] f2h_ARLOCK
 ,input wire [4 - 1 : 0 ] f2h_ARCACHE
 ,input wire [3 - 1 : 0 ] f2h_ARPROT
 ,input wire [1 - 1 : 0 ] f2h_ARVALID
 ,output wire [1 - 1 : 0 ] f2h_ARREADY
 ,input wire [5 - 1 : 0 ] f2h_ARUSER
 ,output wire [4 - 1 : 0 ] f2h_RID
 ,output wire [128 - 1 : 0 ] f2h_RDATA
 ,output wire [2 - 1 : 0 ] f2h_RRESP
 ,output wire [1 - 1 : 0 ] f2h_RLAST
 ,output wire [1 - 1 : 0 ] f2h_RVALID
 ,input wire [1 - 1 : 0 ] f2h_RREADY
// h2f_lw_axi_clock
 ,input wire [1 - 1 : 0 ] h2f_lw_axi_clk
// h2f_lw_axi_reset
 ,input wire [1 - 1 : 0 ] h2f_lw_axi_rst
// h2f_lw_axi_master
 ,output wire [4 - 1 : 0 ] h2f_lw_AWID
 ,output wire [21 - 1 : 0 ] h2f_lw_AWADDR
 ,output wire [4 - 1 : 0 ] h2f_lw_AWLEN
 ,output wire [3 - 1 : 0 ] h2f_lw_AWSIZE
 ,output wire [2 - 1 : 0 ] h2f_lw_AWBURST
 ,output wire [2 - 1 : 0 ] h2f_lw_AWLOCK
 ,output wire [4 - 1 : 0 ] h2f_lw_AWCACHE
 ,output wire [3 - 1 : 0 ] h2f_lw_AWPROT
 ,output wire [1 - 1 : 0 ] h2f_lw_AWVALID
 ,input wire [1 - 1 : 0 ] h2f_lw_AWREADY
 ,output wire [5 - 1 : 0 ] h2f_lw_AWUSER
 ,output wire [4 - 1 : 0 ] h2f_lw_WID
 ,output wire [32 - 1 : 0 ] h2f_lw_WDATA
 ,output wire [4 - 1 : 0 ] h2f_lw_WSTRB
 ,output wire [1 - 1 : 0 ] h2f_lw_WLAST
 ,output wire [1 - 1 : 0 ] h2f_lw_WVALID
 ,input wire [1 - 1 : 0 ] h2f_lw_WREADY
 ,input wire [4 - 1 : 0 ] h2f_lw_BID
 ,input wire [2 - 1 : 0 ] h2f_lw_BRESP
 ,input wire [1 - 1 : 0 ] h2f_lw_BVALID
 ,output wire [1 - 1 : 0 ] h2f_lw_BREADY
 ,output wire [4 - 1 : 0 ] h2f_lw_ARID
 ,output wire [21 - 1 : 0 ] h2f_lw_ARADDR
 ,output wire [4 - 1 : 0 ] h2f_lw_ARLEN
 ,output wire [3 - 1 : 0 ] h2f_lw_ARSIZE
 ,output wire [2 - 1 : 0 ] h2f_lw_ARBURST
 ,output wire [2 - 1 : 0 ] h2f_lw_ARLOCK
 ,output wire [4 - 1 : 0 ] h2f_lw_ARCACHE
 ,output wire [3 - 1 : 0 ] h2f_lw_ARPROT
 ,output wire [1 - 1 : 0 ] h2f_lw_ARVALID
 ,input wire [1 - 1 : 0 ] h2f_lw_ARREADY
 ,output wire [5 - 1 : 0 ] h2f_lw_ARUSER
 ,input wire [4 - 1 : 0 ] h2f_lw_RID
 ,input wire [32 - 1 : 0 ] h2f_lw_RDATA
 ,input wire [2 - 1 : 0 ] h2f_lw_RRESP
 ,input wire [1 - 1 : 0 ] h2f_lw_RLAST
 ,input wire [1 - 1 : 0 ] h2f_lw_RVALID
 ,output wire [1 - 1 : 0 ] h2f_lw_RREADY
// h2f_axi_clock
 ,input wire [1 - 1 : 0 ] h2f_axi_clk
// h2f_axi_reset
 ,input wire [1 - 1 : 0 ] h2f_axi_rst
// h2f_axi_master
 ,output wire [4 - 1 : 0 ] h2f_AWID
 ,output wire [32 - 1 : 0 ] h2f_AWADDR
 ,output wire [4 - 1 : 0 ] h2f_AWLEN
 ,output wire [3 - 1 : 0 ] h2f_AWSIZE
 ,output wire [2 - 1 : 0 ] h2f_AWBURST
 ,output wire [2 - 1 : 0 ] h2f_AWLOCK
 ,output wire [4 - 1 : 0 ] h2f_AWCACHE
 ,output wire [3 - 1 : 0 ] h2f_AWPROT
 ,output wire [1 - 1 : 0 ] h2f_AWVALID
 ,input wire [1 - 1 : 0 ] h2f_AWREADY
 ,output wire [5 - 1 : 0 ] h2f_AWUSER
 ,output wire [4 - 1 : 0 ] h2f_WID
 ,output wire [32 - 1 : 0 ] h2f_WDATA
 ,output wire [4 - 1 : 0 ] h2f_WSTRB
 ,output wire [1 - 1 : 0 ] h2f_WLAST
 ,output wire [1 - 1 : 0 ] h2f_WVALID
 ,input wire [1 - 1 : 0 ] h2f_WREADY
 ,input wire [4 - 1 : 0 ] h2f_BID
 ,input wire [2 - 1 : 0 ] h2f_BRESP
 ,input wire [1 - 1 : 0 ] h2f_BVALID
 ,output wire [1 - 1 : 0 ] h2f_BREADY
 ,output wire [4 - 1 : 0 ] h2f_ARID
 ,output wire [32 - 1 : 0 ] h2f_ARADDR
 ,output wire [4 - 1 : 0 ] h2f_ARLEN
 ,output wire [3 - 1 : 0 ] h2f_ARSIZE
 ,output wire [2 - 1 : 0 ] h2f_ARBURST
 ,output wire [2 - 1 : 0 ] h2f_ARLOCK
 ,output wire [4 - 1 : 0 ] h2f_ARCACHE
 ,output wire [3 - 1 : 0 ] h2f_ARPROT
 ,output wire [1 - 1 : 0 ] h2f_ARVALID
 ,input wire [1 - 1 : 0 ] h2f_ARREADY
 ,output wire [5 - 1 : 0 ] h2f_ARUSER
 ,input wire [4 - 1 : 0 ] h2f_RID
 ,input wire [32 - 1 : 0 ] h2f_RDATA
 ,input wire [2 - 1 : 0 ] h2f_RRESP
 ,input wire [1 - 1 : 0 ] h2f_RLAST
 ,input wire [1 - 1 : 0 ] h2f_RVALID
 ,output wire [1 - 1 : 0 ] h2f_RREADY
// f2sdram0_clock
 ,input wire [1 - 1 : 0 ] f2sdram0_clk
// f2sdram0_reset
 ,input wire [1 - 1 : 0 ] f2s_sdram0_rst
// f2sdram0_data
 ,input wire [32 - 1 : 0 ] f2sdram0_ARADDR
 ,input wire [2 - 1 : 0 ] f2sdram0_ARBURST
 ,input wire [4 - 1 : 0 ] f2sdram0_ARCACHE
 ,input wire [4 - 1 : 0 ] f2sdram0_ARID
 ,input wire [4 - 1 : 0 ] f2sdram0_ARLEN
 ,input wire [2 - 1 : 0 ] f2sdram0_ARLOCK
 ,input wire [3 - 1 : 0 ] f2sdram0_ARPROT
 ,output wire [1 - 1 : 0 ] f2sdram0_ARREADY
 ,input wire [3 - 1 : 0 ] f2sdram0_ARSIZE
 ,input wire [5 - 1 : 0 ] f2sdram0_ARUSER
 ,input wire [1 - 1 : 0 ] f2sdram0_ARVALID
 ,input wire [32 - 1 : 0 ] f2sdram0_AWADDR
 ,input wire [2 - 1 : 0 ] f2sdram0_AWBURST
 ,input wire [4 - 1 : 0 ] f2sdram0_AWCACHE
 ,input wire [4 - 1 : 0 ] f2sdram0_AWID
 ,input wire [4 - 1 : 0 ] f2sdram0_AWLEN
 ,input wire [2 - 1 : 0 ] f2sdram0_AWLOCK
 ,input wire [3 - 1 : 0 ] f2sdram0_AWPROT
 ,output wire [1 - 1 : 0 ] f2sdram0_AWREADY
 ,input wire [3 - 1 : 0 ] f2sdram0_AWSIZE
 ,input wire [5 - 1 : 0 ] f2sdram0_AWUSER
 ,input wire [1 - 1 : 0 ] f2sdram0_AWVALID
 ,input wire [128 - 1 : 0 ] f2sdram0_WDATA
 ,input wire [4 - 1 : 0 ] f2sdram0_WID
 ,input wire [1 - 1 : 0 ] f2sdram0_WLAST
 ,output wire [1 - 1 : 0 ] f2sdram0_WREADY
 ,input wire [16 - 1 : 0 ] f2sdram0_WSTRB
 ,input wire [1 - 1 : 0 ] f2sdram0_WVALID
 ,output wire [4 - 1 : 0 ] f2sdram0_BID
 ,input wire [1 - 1 : 0 ] f2sdram0_BREADY
 ,output wire [2 - 1 : 0 ] f2sdram0_BRESP
 ,output wire [1 - 1 : 0 ] f2sdram0_BVALID
 ,output wire [128 - 1 : 0 ] f2sdram0_RDATA
 ,output wire [4 - 1 : 0 ] f2sdram0_RID
 ,output wire [1 - 1 : 0 ] f2sdram0_RLAST
 ,input wire [1 - 1 : 0 ] f2sdram0_RREADY
 ,output wire [2 - 1 : 0 ] f2sdram0_RRESP
 ,output wire [1 - 1 : 0 ] f2sdram0_RVALID
// f2sdram2_clock
 ,input wire [1 - 1 : 0 ] f2sdram2_clk
// f2sdram2_reset
 ,input wire [1 - 1 : 0 ] f2s_sdram2_rst
// f2sdram2_data
 ,input wire [32 - 1 : 0 ] f2sdram2_ARADDR
 ,input wire [2 - 1 : 0 ] f2sdram2_ARBURST
 ,input wire [4 - 1 : 0 ] f2sdram2_ARCACHE
 ,input wire [4 - 1 : 0 ] f2sdram2_ARID
 ,input wire [4 - 1 : 0 ] f2sdram2_ARLEN
 ,input wire [2 - 1 : 0 ] f2sdram2_ARLOCK
 ,input wire [3 - 1 : 0 ] f2sdram2_ARPROT
 ,output wire [1 - 1 : 0 ] f2sdram2_ARREADY
 ,input wire [3 - 1 : 0 ] f2sdram2_ARSIZE
 ,input wire [5 - 1 : 0 ] f2sdram2_ARUSER
 ,input wire [1 - 1 : 0 ] f2sdram2_ARVALID
 ,input wire [32 - 1 : 0 ] f2sdram2_AWADDR
 ,input wire [2 - 1 : 0 ] f2sdram2_AWBURST
 ,input wire [4 - 1 : 0 ] f2sdram2_AWCACHE
 ,input wire [4 - 1 : 0 ] f2sdram2_AWID
 ,input wire [4 - 1 : 0 ] f2sdram2_AWLEN
 ,input wire [2 - 1 : 0 ] f2sdram2_AWLOCK
 ,input wire [3 - 1 : 0 ] f2sdram2_AWPROT
 ,output wire [1 - 1 : 0 ] f2sdram2_AWREADY
 ,input wire [3 - 1 : 0 ] f2sdram2_AWSIZE
 ,input wire [5 - 1 : 0 ] f2sdram2_AWUSER
 ,input wire [1 - 1 : 0 ] f2sdram2_AWVALID
 ,input wire [128 - 1 : 0 ] f2sdram2_WDATA
 ,input wire [4 - 1 : 0 ] f2sdram2_WID
 ,input wire [1 - 1 : 0 ] f2sdram2_WLAST
 ,output wire [1 - 1 : 0 ] f2sdram2_WREADY
 ,input wire [16 - 1 : 0 ] f2sdram2_WSTRB
 ,input wire [1 - 1 : 0 ] f2sdram2_WVALID
 ,output wire [4 - 1 : 0 ] f2sdram2_BID
 ,input wire [1 - 1 : 0 ] f2sdram2_BREADY
 ,output wire [2 - 1 : 0 ] f2sdram2_BRESP
 ,output wire [1 - 1 : 0 ] f2sdram2_BVALID
 ,output wire [128 - 1 : 0 ] f2sdram2_RDATA
 ,output wire [4 - 1 : 0 ] f2sdram2_RID
 ,output wire [1 - 1 : 0 ] f2sdram2_RLAST
 ,input wire [1 - 1 : 0 ] f2sdram2_RREADY
 ,output wire [2 - 1 : 0 ] f2sdram2_RRESP
 ,output wire [1 - 1 : 0 ] f2sdram2_RVALID
);


wire [35 - 1 : 0] intermediate;
assign intermediate[1:1] = intermediate[0:0];
assign intermediate[2:2] = intermediate[0:0];
assign intermediate[3:3] = intermediate[0:0];
assign intermediate[4:4] = intermediate[0:0];
assign intermediate[5:5] = intermediate[0:0];
assign intermediate[6:6] = intermediate[0:0];
assign intermediate[8:8] = intermediate[7:7];
assign intermediate[9:9] = intermediate[7:7];
assign intermediate[10:10] = intermediate[7:7];
assign intermediate[11:11] = intermediate[7:7];
assign intermediate[12:12] = intermediate[7:7];
assign intermediate[13:13] = intermediate[7:7];
assign intermediate[15:15] = intermediate[14:14];
assign intermediate[16:16] = intermediate[14:14];
assign intermediate[17:17] = intermediate[14:14];
assign intermediate[18:18] = intermediate[14:14];
assign intermediate[19:19] = intermediate[14:14];
assign intermediate[20:20] = intermediate[14:14];
assign intermediate[22:22] = intermediate[21:21];
assign intermediate[23:23] = intermediate[21:21];
assign intermediate[24:24] = intermediate[21:21];
assign intermediate[25:25] = intermediate[21:21];
assign intermediate[26:26] = intermediate[21:21];
assign intermediate[27:27] = intermediate[21:21];
assign intermediate[29:29] = intermediate[28:28];
assign intermediate[30:30] = intermediate[28:28];
assign intermediate[31:31] = intermediate[28:28];
assign intermediate[32:32] = intermediate[28:28];
assign intermediate[33:33] = intermediate[28:28];
assign intermediate[34:34] = intermediate[28:28];
assign intermediate[0:0] = f2h_axi_clk[0:0];
assign intermediate[7:7] = h2f_lw_axi_clk[0:0];
assign intermediate[14:14] = h2f_axi_clk[0:0];
assign intermediate[21:21] = f2sdram0_clk[0:0];
assign intermediate[28:28] = f2sdram2_clk[0:0];

twentynm_hps_interface_clocks_resets clocks_resets(
 .f2s_cold_rst_req_n({
    f2h_cold_rst_req_n[0:0] // 0:0
  })
,.f2s_pending_rst_ack({
    1'b1 // 0:0
  })
,.f2s_warm_rst_req_n({
    f2h_warm_rst_req_n[0:0] // 0:0
  })
,.s2f_user3_clk({
    h2f_rst_n[0:0] // 0:0
  })
,.f2s_free_clk({
    1'b0 // 0:0
  })
,.f2s_dbg_rst_req_n({
    f2h_dbg_rst_req_n[0:0] // 0:0
  })
);


twentynm_hps_interface_dbg_apb debug_apb(
 .F2S_PCLKENDBG({
    1'b0 // 0:0
  })
,.F2S_DBGAPB_DISABLE({
    1'b0 // 0:0
  })
);


twentynm_hps_interface_boot_from_fpga boot_from_fpga(
 .f2s_bsel({
    3'b001 // 2:0
  })
,.f2s_boot_from_fpga_on_failure({
    1'b0 // 0:0
  })
,.f2s_boot_from_fpga_ready({
    1'b0 // 0:0
  })
,.f2s_bsel_en({
    1'b0 // 0:0
  })
);


a10_hps_emif_interface emif_interface(
 .hps_to_emif({
    emif_hps_to_emif[4095:0] // 4095:0
  })
,.emif_to_hps({
    emif_emif_to_hps[4095:0] // 4095:0
  })
);


twentynm_hps_rl_interface_fpga2hps fpga2hps(
 .ar_burst({
    f2h_ARBURST[1:0] // 1:0
  })
,.aw_size({
    f2h_AWSIZE[2:0] // 2:0
  })
,.b_resp({
    f2h_BRESP[1:0] // 1:0
  })
,.w_id({
    f2h_WID[3:0] // 3:0
  })
,.r_clk({
    intermediate[5:5] // 0:0
  })
,.aw_id({
    f2h_AWID[3:0] // 3:0
  })
,.r_id({
    f2h_RID[3:0] // 3:0
  })
,.r_ready({
    f2h_RREADY[0:0] // 0:0
  })
,.aw_valid({
    f2h_AWVALID[0:0] // 0:0
  })
,.ar_id({
    f2h_ARID[3:0] // 3:0
  })
,.clk({
    intermediate[1:1] // 0:0
  })
,.w_last({
    f2h_WLAST[0:0] // 0:0
  })
,.ar_clk({
    intermediate[4:4] // 0:0
  })
,.aw_len({
    f2h_AWLEN[3:0] // 3:0
  })
,.ar_valid({
    f2h_ARVALID[0:0] // 0:0
  })
,.r_resp({
    f2h_RRESP[1:0] // 1:0
  })
,.aw_ready({
    f2h_AWREADY[0:0] // 0:0
  })
,.ar_ready({
    f2h_ARREADY[0:0] // 0:0
  })
,.w_strb({
    f2h_WSTRB[15:0] // 15:0
  })
,.ar_user({
    f2h_ARUSER[4:0] // 4:0
  })
,.ar_lock({
    f2h_ARLOCK[1:0] // 1:0
  })
,.ar_addr({
    f2h_ARADDR[31:0] // 31:0
  })
,.rst_n({
    f2h_axi_rst[0:0] // 0:0
  })
,.w_clk({
    intermediate[2:2] // 0:0
  })
,.ar_len({
    f2h_ARLEN[3:0] // 3:0
  })
,.b_valid({
    f2h_BVALID[0:0] // 0:0
  })
,.r_data({
    f2h_RDATA[127:0] // 127:0
  })
,.w_valid({
    f2h_WVALID[0:0] // 0:0
  })
,.aw_user({
    f2h_AWUSER[4:0] // 4:0
  })
,.ar_prot({
    f2h_ARPROT[2:0] // 2:0
  })
,.aw_lock({
    f2h_AWLOCK[1:0] // 1:0
  })
,.aw_clk({
    intermediate[6:6] // 0:0
  })
,.aw_addr({
    f2h_AWADDR[31:0] // 31:0
  })
,.port_size_config_0({
    1'b0 // 0:0
  })
,.b_clk({
    intermediate[3:3] // 0:0
  })
,.aw_cache({
    f2h_AWCACHE[3:0] // 3:0
  })
,.port_size_config_1({
    1'b1 // 0:0
  })
,.port_size_config_2({
    1'b1 // 0:0
  })
,.ar_size({
    f2h_ARSIZE[2:0] // 2:0
  })
,.b_ready({
    f2h_BREADY[0:0] // 0:0
  })
,.b_id({
    f2h_BID[3:0] // 3:0
  })
,.port_size_config_3({
    1'b1 // 0:0
  })
,.aw_burst({
    f2h_AWBURST[1:0] // 1:0
  })
,.w_data({
    f2h_WDATA[127:0] // 127:0
  })
,.r_valid({
    f2h_RVALID[0:0] // 0:0
  })
,.w_ready({
    f2h_WREADY[0:0] // 0:0
  })
,.aw_prot({
    f2h_AWPROT[2:0] // 2:0
  })
,.r_last({
    f2h_RLAST[0:0] // 0:0
  })
,.ar_cache({
    f2h_ARCACHE[3:0] // 3:0
  })
);

defparam fpga2hps.DWIDTH = 128;
defparam fpga2hps.DEPTH = 3;

twentynm_hps_rl_interface_hps2fpga_light_weight hps2fpga_light_weight(
 .aw_lock({
    h2f_lw_AWLOCK[1:0] // 1:0
  })
,.aw_clk({
    intermediate[13:13] // 0:0
  })
,.ar_user({
    h2f_lw_ARUSER[4:0] // 4:0
  })
,.w_strb({
    h2f_lw_WSTRB[3:0] // 3:0
  })
,.ar_valid({
    h2f_lw_ARVALID[0:0] // 0:0
  })
,.ar_burst({
    h2f_lw_ARBURST[1:0] // 1:0
  })
,.aw_size({
    h2f_lw_AWSIZE[2:0] // 2:0
  })
,.aw_addr({
    h2f_lw_AWADDR[20:0] // 20:0
  })
,.port_size_config_0({
    1'b1 // 0:0
  })
,.r_resp({
    h2f_lw_RRESP[1:0] // 1:0
  })
,.ar_lock({
    h2f_lw_ARLOCK[1:0] // 1:0
  })
,.r_clk({
    intermediate[12:12] // 0:0
  })
,.b_resp({
    h2f_lw_BRESP[1:0] // 1:0
  })
,.aw_cache({
    h2f_lw_AWCACHE[3:0] // 3:0
  })
,.b_clk({
    intermediate[10:10] // 0:0
  })
,.w_id({
    h2f_lw_WID[3:0] // 3:0
  })
,.aw_ready({
    h2f_lw_AWREADY[0:0] // 0:0
  })
,.aw_id({
    h2f_lw_AWID[3:0] // 3:0
  })
,.port_size_config_1({
    1'b1 // 0:0
  })
,.ar_addr({
    h2f_lw_ARADDR[20:0] // 20:0
  })
,.ar_size({
    h2f_lw_ARSIZE[2:0] // 2:0
  })
,.r_ready({
    h2f_lw_RREADY[0:0] // 0:0
  })
,.b_ready({
    h2f_lw_BREADY[0:0] // 0:0
  })
,.rst_n({
    h2f_lw_axi_rst[0:0] // 0:0
  })
,.b_id({
    h2f_lw_BID[3:0] // 3:0
  })
,.r_id({
    h2f_lw_RID[3:0] // 3:0
  })
,.ar_id({
    h2f_lw_ARID[3:0] // 3:0
  })
,.aw_valid({
    h2f_lw_AWVALID[0:0] // 0:0
  })
,.aw_burst({
    h2f_lw_AWBURST[1:0] // 1:0
  })
,.w_clk({
    intermediate[9:9] // 0:0
  })
,.w_data({
    h2f_lw_WDATA[31:0] // 31:0
  })
,.ar_len({
    h2f_lw_ARLEN[3:0] // 3:0
  })
,.b_valid({
    h2f_lw_BVALID[0:0] // 0:0
  })
,.r_valid({
    h2f_lw_RVALID[0:0] // 0:0
  })
,.w_last({
    h2f_lw_WLAST[0:0] // 0:0
  })
,.clk({
    intermediate[8:8] // 0:0
  })
,.r_data({
    h2f_lw_RDATA[31:0] // 31:0
  })
,.w_ready({
    h2f_lw_WREADY[0:0] // 0:0
  })
,.ar_clk({
    intermediate[11:11] // 0:0
  })
,.aw_prot({
    h2f_lw_AWPROT[2:0] // 2:0
  })
,.r_last({
    h2f_lw_RLAST[0:0] // 0:0
  })
,.ar_cache({
    h2f_lw_ARCACHE[3:0] // 3:0
  })
,.w_valid({
    h2f_lw_WVALID[0:0] // 0:0
  })
,.aw_len({
    h2f_lw_AWLEN[3:0] // 3:0
  })
,.aw_user({
    h2f_lw_AWUSER[4:0] // 4:0
  })
,.ar_prot({
    h2f_lw_ARPROT[2:0] // 2:0
  })
,.ar_ready({
    h2f_lw_ARREADY[0:0] // 0:0
  })
);

defparam hps2fpga_light_weight.DWIDTH = 32;
defparam hps2fpga_light_weight.DEPTH = 3;

twentynm_hps_rl_interface_hps2fpga hps2fpga(
 .ar_burst({
    h2f_ARBURST[1:0] // 1:0
  })
,.aw_size({
    h2f_AWSIZE[2:0] // 2:0
  })
,.r_clk({
    intermediate[19:19] // 0:0
  })
,.w_id({
    h2f_WID[3:0] // 3:0
  })
,.b_resp({
    h2f_BRESP[1:0] // 1:0
  })
,.aw_id({
    h2f_AWID[3:0] // 3:0
  })
,.r_id({
    h2f_RID[3:0] // 3:0
  })
,.r_ready({
    h2f_RREADY[0:0] // 0:0
  })
,.aw_valid({
    h2f_AWVALID[0:0] // 0:0
  })
,.ar_id({
    h2f_ARID[3:0] // 3:0
  })
,.clk({
    intermediate[15:15] // 0:0
  })
,.w_last({
    h2f_WLAST[0:0] // 0:0
  })
,.ar_clk({
    intermediate[18:18] // 0:0
  })
,.aw_len({
    h2f_AWLEN[3:0] // 3:0
  })
,.ar_valid({
    h2f_ARVALID[0:0] // 0:0
  })
,.r_resp({
    h2f_RRESP[1:0] // 1:0
  })
,.aw_ready({
    h2f_AWREADY[0:0] // 0:0
  })
,.ar_ready({
    h2f_ARREADY[0:0] // 0:0
  })
,.w_strb({
    h2f_WSTRB[3:0] // 3:0
  })
,.ar_user({
    h2f_ARUSER[4:0] // 4:0
  })
,.ar_lock({
    h2f_ARLOCK[1:0] // 1:0
  })
,.ar_addr({
    h2f_ARADDR[31:0] // 31:0
  })
,.rst_n({
    h2f_axi_rst[0:0] // 0:0
  })
,.w_clk({
    intermediate[16:16] // 0:0
  })
,.ar_len({
    h2f_ARLEN[3:0] // 3:0
  })
,.b_valid({
    h2f_BVALID[0:0] // 0:0
  })
,.r_data({
    h2f_RDATA[31:0] // 31:0
  })
,.w_valid({
    h2f_WVALID[0:0] // 0:0
  })
,.aw_user({
    h2f_AWUSER[4:0] // 4:0
  })
,.ar_prot({
    h2f_ARPROT[2:0] // 2:0
  })
,.aw_lock({
    h2f_AWLOCK[1:0] // 1:0
  })
,.aw_clk({
    intermediate[20:20] // 0:0
  })
,.aw_addr({
    h2f_AWADDR[31:0] // 31:0
  })
,.port_size_config_0({
    1'b0 // 0:0
  })
,.b_clk({
    intermediate[17:17] // 0:0
  })
,.aw_cache({
    h2f_AWCACHE[3:0] // 3:0
  })
,.port_size_config_1({
    1'b0 // 0:0
  })
,.port_size_config_2({
    1'b1 // 0:0
  })
,.ar_size({
    h2f_ARSIZE[2:0] // 2:0
  })
,.b_ready({
    h2f_BREADY[0:0] // 0:0
  })
,.b_id({
    h2f_BID[3:0] // 3:0
  })
,.port_size_config_3({
    1'b1 // 0:0
  })
,.aw_burst({
    h2f_AWBURST[1:0] // 1:0
  })
,.w_data({
    h2f_WDATA[31:0] // 31:0
  })
,.r_valid({
    h2f_RVALID[0:0] // 0:0
  })
,.w_ready({
    h2f_WREADY[0:0] // 0:0
  })
,.aw_prot({
    h2f_AWPROT[2:0] // 2:0
  })
,.r_last({
    h2f_RLAST[0:0] // 0:0
  })
,.ar_cache({
    h2f_ARCACHE[3:0] // 3:0
  })
);

defparam hps2fpga.DWIDTH = 32;
defparam hps2fpga.DEPTH = 3;

twentynm_hps_rl_mode2_fpga2sdram f2sdram(
 .fpga2sdram2_ar_len({
    f2sdram2_ARLEN[3:0] // 3:0
  })
,.fpga2sdram2_b_valid({
    f2sdram2_BVALID[0:0] // 0:0
  })
,.f2s_sdram2_aw_clk({
    intermediate[34:34] // 0:0
  })
,.fpga2sdram2_r_data({
    f2sdram2_RDATA[127:0] // 127:0
  })
,.fpga2sdram0_w_valid({
    f2sdram0_WVALID[0:0] // 0:0
  })
,.fpga2sdram0_aw_user({
    f2sdram0_AWUSER[4:0] // 4:0
  })
,.fpga2sdram0_ar_cache({
    f2sdram0_ARCACHE[3:0] // 3:0
  })
,.fpga2sdram0_ar_prot({
    f2sdram0_ARPROT[2:0] // 2:0
  })
,.f2s_sdram2_r_clk({
    intermediate[33:33] // 0:0
  })
,.fpga2sdram2_aw_user({
    f2sdram2_AWUSER[4:0] // 4:0
  })
,.fpga2sdram0_aw_lock({
    f2sdram0_AWLOCK[1:0] // 1:0
  })
,.f2s_sdram0_rst_n({
    f2s_sdram0_rst[0:0] // 0:0
  })
,.fpga2sdram2_w_valid({
    f2sdram2_WVALID[0:0] // 0:0
  })
,.fpga2sdram0_w_strb({
    f2sdram0_WSTRB[15:0] // 15:0
  })
,.fpga2sdram2_ar_prot({
    f2sdram2_ARPROT[2:0] // 2:0
  })
,.f2s_sdram0_w_clk({
    intermediate[23:23] // 0:0
  })
,.fpga2sdram0_aw_addr({
    f2sdram0_AWADDR[31:0] // 31:0
  })
,.fpga2sdram2_aw_lock({
    f2sdram2_AWLOCK[1:0] // 1:0
  })
,.fpga2sdram0_ar_burst({
    f2sdram0_ARBURST[1:0] // 1:0
  })
,.fpga2sdram0_w_id({
    f2sdram0_WID[3:0] // 3:0
  })
,.fpga2sdram_port_size_config({
    4'b1110 // 3:0
  })
,.fpga2sdram2_aw_addr({
    f2sdram2_AWADDR[31:0] // 31:0
  })
,.fpga2sdram2_aw_cache({
    f2sdram2_AWCACHE[3:0] // 3:0
  })
,.fpga2sdram0_ar_size({
    f2sdram0_ARSIZE[2:0] // 2:0
  })
,.fpga2sdram0_r_id({
    f2sdram0_RID[3:0] // 3:0
  })
,.fpga2sdram0_b_ready({
    f2sdram0_BREADY[0:0] // 0:0
  })
,.fpga2sdram2_ar_size({
    f2sdram2_ARSIZE[2:0] // 2:0
  })
,.fpga2sdram0_aw_valid({
    f2sdram0_AWVALID[0:0] // 0:0
  })
,.fpga2sdram2_b_ready({
    f2sdram2_BREADY[0:0] // 0:0
  })
,.fpga2sdram2_b_id({
    f2sdram2_BID[3:0] // 3:0
  })
,.fpga2sdram2_aw_burst({
    f2sdram2_AWBURST[1:0] // 1:0
  })
,.fpga2sdram0_r_valid({
    f2sdram0_RVALID[0:0] // 0:0
  })
,.fpga2sdram0_ar_len({
    f2sdram0_ARLEN[3:0] // 3:0
  })
,.fpga2sdram2_w_data({
    f2sdram2_WDATA[127:0] // 127:0
  })
,.f2s_sdram0_aw_clk({
    intermediate[27:27] // 0:0
  })
,.fpga2sdram2_r_valid({
    f2sdram2_RVALID[0:0] // 0:0
  })
,.fpga2sdram0_w_ready({
    f2sdram0_WREADY[0:0] // 0:0
  })
,.fpga2sdram0_r_data({
    f2sdram0_RDATA[127:0] // 127:0
  })
,.fpga2sdram0_aw_prot({
    f2sdram0_AWPROT[2:0] // 2:0
  })
,.f2s_sdram0_b_clk({
    intermediate[24:24] // 0:0
  })
,.fpga2sdram2_w_ready({
    f2sdram2_WREADY[0:0] // 0:0
  })
,.fpga2sdram2_aw_prot({
    f2sdram2_AWPROT[2:0] // 2:0
  })
,.fpga2sdram2_r_last({
    f2sdram2_RLAST[0:0] // 0:0
  })
,.fpga2sdram2_ar_cache({
    f2sdram2_ARCACHE[3:0] // 3:0
  })
,.fpga2sdram0_ar_valid({
    f2sdram0_ARVALID[0:0] // 0:0
  })
,.fpga2sdram0_aw_size({
    f2sdram0_AWSIZE[2:0] // 2:0
  })
,.fpga2sdram2_aw_size({
    f2sdram2_AWSIZE[2:0] // 2:0
  })
,.fpga2sdram0_aw_ready({
    f2sdram0_AWREADY[0:0] // 0:0
  })
,.fpga2sdram2_ar_burst({
    f2sdram2_ARBURST[1:0] // 1:0
  })
,.fpga2sdram2_w_id({
    f2sdram2_WID[3:0] // 3:0
  })
,.fpga2sdram2_b_resp({
    f2sdram2_BRESP[1:0] // 1:0
  })
,.fpga2sdram0_r_ready({
    f2sdram0_RREADY[0:0] // 0:0
  })
,.fpga2sdram2_aw_id({
    f2sdram2_AWID[3:0] // 3:0
  })
,.f2s_sdram2_ar_clk({
    intermediate[32:32] // 0:0
  })
,.fpga2sdram2_r_ready({
    f2sdram2_RREADY[0:0] // 0:0
  })
,.fpga2sdram0_w_data({
    f2sdram0_WDATA[127:0] // 127:0
  })
,.fpga2sdram2_r_id({
    f2sdram2_RID[3:0] // 3:0
  })
,.fpga2sdram2_ar_id({
    f2sdram2_ARID[3:0] // 3:0
  })
,.fpga2sdram2_aw_valid({
    f2sdram2_AWVALID[0:0] // 0:0
  })
,.fpga2sdram2_w_last({
    f2sdram2_WLAST[0:0] // 0:0
  })
,.fpga2sdram0_r_last({
    f2sdram0_RLAST[0:0] // 0:0
  })
,.f2s_sdram0_r_clk({
    intermediate[26:26] // 0:0
  })
,.fpga2sdram0_ar_ready({
    f2sdram0_ARREADY[0:0] // 0:0
  })
,.fpga2sdram2_aw_len({
    f2sdram2_AWLEN[3:0] // 3:0
  })
,.f2s_sdram2_rst_n({
    f2s_sdram2_rst[0:0] // 0:0
  })
,.fpga2sdram0_b_resp({
    f2sdram0_BRESP[1:0] // 1:0
  })
,.fpga2sdram2_ar_valid({
    f2sdram2_ARVALID[0:0] // 0:0
  })
,.f2s_sdram2_w_clk({
    intermediate[30:30] // 0:0
  })
,.f2s_sdram0_clk({
    intermediate[22:22] // 0:0
  })
,.fpga2sdram2_r_resp({
    f2sdram2_RRESP[1:0] // 1:0
  })
,.f2s_sdram2_clk({
    intermediate[29:29] // 0:0
  })
,.f2s_sdram0_ar_clk({
    intermediate[25:25] // 0:0
  })
,.fpga2sdram2_aw_ready({
    f2sdram2_AWREADY[0:0] // 0:0
  })
,.fpga2sdram0_w_last({
    f2sdram0_WLAST[0:0] // 0:0
  })
,.fpga2sdram0_aw_len({
    f2sdram0_AWLEN[3:0] // 3:0
  })
,.f2s_sdram2_b_clk({
    intermediate[31:31] // 0:0
  })
,.fpga2sdram0_ar_user({
    f2sdram0_ARUSER[4:0] // 4:0
  })
,.fpga2sdram2_ar_ready({
    f2sdram2_ARREADY[0:0] // 0:0
  })
,.fpga2sdram2_w_strb({
    f2sdram2_WSTRB[15:0] // 15:0
  })
,.fpga2sdram0_ar_lock({
    f2sdram0_ARLOCK[1:0] // 1:0
  })
,.fpga2sdram0_aw_cache({
    f2sdram0_AWCACHE[3:0] // 3:0
  })
,.fpga2sdram0_r_resp({
    f2sdram0_RRESP[1:0] // 1:0
  })
,.fpga2sdram2_ar_user({
    f2sdram2_ARUSER[4:0] // 4:0
  })
,.fpga2sdram0_aw_id({
    f2sdram0_AWID[3:0] // 3:0
  })
,.fpga2sdram2_ar_lock({
    f2sdram2_ARLOCK[1:0] // 1:0
  })
,.fpga2sdram0_ar_addr({
    f2sdram0_ARADDR[31:0] // 31:0
  })
,.fpga2sdram0_b_id({
    f2sdram0_BID[3:0] // 3:0
  })
,.fpga2sdram0_aw_burst({
    f2sdram0_AWBURST[1:0] // 1:0
  })
,.fpga2sdram2_ar_addr({
    f2sdram2_ARADDR[31:0] // 31:0
  })
,.fpga2sdram0_ar_id({
    f2sdram0_ARID[3:0] // 3:0
  })
,.fpga2sdram0_b_valid({
    f2sdram0_BVALID[0:0] // 0:0
  })
);

defparam f2sdram.DWIDTH0 = 128;
defparam f2sdram.DEPTH = 4;
defparam f2sdram.mode = 3;
defparam f2sdram.DWIDTH2 = 128;
endmodule

