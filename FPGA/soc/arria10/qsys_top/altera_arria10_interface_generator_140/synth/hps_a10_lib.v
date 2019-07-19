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



//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
// 
`timescale 1 ps / 1 ps
module hps_emif_interface_to_ddr(
	output wire [  9:0] mmr_addr,
	output wire [  3:0] mmr_be,
	output wire         mmr_beginbursttransfer,
	output wire [  1:0] mmr_burst_count,
	input  wire [ 31:0] mmr_rdata,
	input  wire         mmr_rdata_valid,
	output wire         mmr_read,
	input  wire         mmr_waitrequest,
	output wire [ 31:0] mmr_wdata,
	output wire         mmr_write,
	input  wire         afi_cal_success,
	output wire [ 57:0] core2ctl_cmd_data0,
	output wire         core2ctl_cmd_valid0,
	output wire         core2ctl_rd_data_ready0,
	output wire         core2ctl_wr_data_valid0,
	output wire [ 14:0] core2ctl_wr_ecc_info,
	input  wire [  2:0] ctl2core_cmd_ecc_info,
	input  wire         ctl2core_cmd_ready0,
	input  wire [  2:0] ctl2core_rd_ecc_info,
	input  wire [ 12:0] ctl2core_rdata_id,
	input  wire [  2:0] clk_out_hps,
	output wire [  2:0] fb_clk_hps,
	output wire [  7:0] afi_core2seq,
	input  wire [  7:0] afi_seq2core,
	output wire [  8:0] core2dbc_rd_data_rdy_pl,
	output wire [  8:0] core2dbc_wr_data_vld0_pl,
	output wire [ 62:0] core2dbc_wr_ecc_info_pl,
	input  wire [  8:0] dbc2core_rd_data_vld0_pl,
	input  wire [  8:0] dbc2core_rd_type_pl,
	input  wire [ 53:0] dbc2core_wb_pointer_pl,
	input  wire [  8:0] dbc2core_wr_data_rdy_pl,
	input  wire         pll_locked,
	input  wire [287:0] cdata_in,
	input  wire [143:0] cdata_upper,
	output wire         ref_clkin_hps,
	output wire [  2:0] global_reset_n,
	output wire [287:0] iod_out,
	output wire [143:0] iod_upper

);

wire          io48_a_afi_cal_success;
wire          io48_a_clk_out_hps;
wire          io48_a_ctl2core_cmd_ready0;
wire          io48_a_dbc2core_rd_data_vld0_pl3;
wire          io48_a_dbc2core_rd_type_pl3;
wire          io48_a_dbc2core_wr_data_rdy_pl3;
wire          io48_a_mmr_rdata_valid;
wire          io48_a_mmr_waitrequest;
wire          io48_a_pll_locked;
wire          io48_b_clk_out_hps;
wire          io48_c_clk_out_hps;
wire [7 : 0] io48_a_afi_seq2core;
wire [3 : 0] io48_a_cdata_pb36_in;
wire [3 : 0] io48_a_cdata_pb37_in;
wire [3 : 0] io48_a_cdata_pb38_in;
wire [3 : 0] io48_a_cdata_pb39_in;
wire [3 : 0] io48_a_cdata_pb40_in;
wire [3 : 0] io48_a_cdata_pb41_in;
wire [3 : 0] io48_a_cdata_pb42_in;
wire [3 : 0] io48_a_cdata_pb43_in;
wire [3 : 0] io48_a_cdata_pb44_in;
wire [3 : 0] io48_a_cdata_pb45_in;
wire [3 : 0] io48_a_cdata_pb46_in;
wire [3 : 0] io48_a_cdata_pb47_in;
wire [2 : 0] io48_a_ctl2core_cmd_ecc_info;
wire [2 : 0] io48_a_ctl2core_rd_ecc_info;
wire [12 : 0] io48_a_ctl2core_rdata_id;
wire [5 : 0] io48_a_dbc2core_wb_pointer_pl3;
wire [31 : 0] io48_a_mmr_rdata;
wire [3 : 0] io48_b_cdata_pb0_in;
wire [3 : 0] io48_b_cdata_pb10_in;
wire [3 : 0] io48_b_cdata_pb11_in;
wire [3 : 0] io48_b_cdata_pb12_in;
wire [3 : 0] io48_b_cdata_pb13_in;
wire [3 : 0] io48_b_cdata_pb14_in;
wire [3 : 0] io48_b_cdata_pb15_in;
wire [3 : 0] io48_b_cdata_pb16_in;
wire [3 : 0] io48_b_cdata_pb17_in;
wire [3 : 0] io48_b_cdata_pb18_in;
wire [3 : 0] io48_b_cdata_pb19_in;
wire [3 : 0] io48_b_cdata_pb1_in;
wire [3 : 0] io48_b_cdata_pb20_in;
wire [3 : 0] io48_b_cdata_pb21_in;
wire [3 : 0] io48_b_cdata_pb22_in;
wire [3 : 0] io48_b_cdata_pb23_in;
wire [3 : 0] io48_b_cdata_pb24_in;
wire [3 : 0] io48_b_cdata_pb25_in;
wire [3 : 0] io48_b_cdata_pb26_in;
wire [3 : 0] io48_b_cdata_pb27_in;
wire [3 : 0] io48_b_cdata_pb28_in;
wire [3 : 0] io48_b_cdata_pb29_in;
wire [3 : 0] io48_b_cdata_pb2_in;
wire [3 : 0] io48_b_cdata_pb30_in;
wire [3 : 0] io48_b_cdata_pb31_in;
wire [3 : 0] io48_b_cdata_pb32_in;
wire [3 : 0] io48_b_cdata_pb33_in;
wire [3 : 0] io48_b_cdata_pb34_in;
wire [3 : 0] io48_b_cdata_pb35_in;
wire [3 : 0] io48_b_cdata_pb36_in;
wire [3 : 0] io48_b_cdata_pb37_in;
wire [3 : 0] io48_b_cdata_pb38_in;
wire [3 : 0] io48_b_cdata_pb39_in;
wire [3 : 0] io48_b_cdata_pb3_in;
wire [3 : 0] io48_b_cdata_pb40_in;
wire [3 : 0] io48_b_cdata_pb41_in;
wire [3 : 0] io48_b_cdata_pb42_in;
wire [3 : 0] io48_b_cdata_pb43_in;
wire [3 : 0] io48_b_cdata_pb44_in;
wire [3 : 0] io48_b_cdata_pb45_in;
wire [3 : 0] io48_b_cdata_pb46_in;
wire [3 : 0] io48_b_cdata_pb47_in;
wire [3 : 0] io48_b_cdata_pb4_in;
wire [3 : 0] io48_b_cdata_pb5_in;
wire [3 : 0] io48_b_cdata_pb6_in;
wire [3 : 0] io48_b_cdata_pb7_in;
wire [3 : 0] io48_b_cdata_pb8_in;
wire [3 : 0] io48_b_cdata_pb9_in;
wire [3 : 0] io48_b_dbc2core_rd_data_vld0_pl;
wire [3 : 0] io48_b_dbc2core_rd_type_pl;
wire [5 : 0] io48_b_dbc2core_wb_pointer_pl0;
wire [5 : 0] io48_b_dbc2core_wb_pointer_pl1;
wire [5 : 0] io48_b_dbc2core_wb_pointer_pl2;
wire [5 : 0] io48_b_dbc2core_wb_pointer_pl3;
wire [3 : 0] io48_b_dbc2core_wr_data_rdy_pl;
wire [3 : 0] io48_c_cdata_pb0_in;
wire [3 : 0] io48_c_cdata_pb10_in;
wire [3 : 0] io48_c_cdata_pb11_in;
wire [3 : 0] io48_c_cdata_pb12_in;
wire [3 : 0] io48_c_cdata_pb13_in;
wire [3 : 0] io48_c_cdata_pb14_in;
wire [3 : 0] io48_c_cdata_pb15_in;
wire [3 : 0] io48_c_cdata_pb16_in;
wire [3 : 0] io48_c_cdata_pb17_in;
wire [3 : 0] io48_c_cdata_pb18_in;
wire [3 : 0] io48_c_cdata_pb19_in;
wire [3 : 0] io48_c_cdata_pb1_in;
wire [3 : 0] io48_c_cdata_pb20_in;
wire [3 : 0] io48_c_cdata_pb21_in;
wire [3 : 0] io48_c_cdata_pb22_in;
wire [3 : 0] io48_c_cdata_pb23_in;
wire [3 : 0] io48_c_cdata_pb24_in;
wire [3 : 0] io48_c_cdata_pb25_in;
wire [3 : 0] io48_c_cdata_pb26_in;
wire [3 : 0] io48_c_cdata_pb27_in;
wire [3 : 0] io48_c_cdata_pb28_in;
wire [3 : 0] io48_c_cdata_pb29_in;
wire [3 : 0] io48_c_cdata_pb2_in;
wire [3 : 0] io48_c_cdata_pb30_in;
wire [3 : 0] io48_c_cdata_pb31_in;
wire [3 : 0] io48_c_cdata_pb32_in;
wire [3 : 0] io48_c_cdata_pb33_in;
wire [3 : 0] io48_c_cdata_pb34_in;
wire [3 : 0] io48_c_cdata_pb35_in;
wire [3 : 0] io48_c_cdata_pb36_in;
wire [3 : 0] io48_c_cdata_pb37_in;
wire [3 : 0] io48_c_cdata_pb38_in;
wire [3 : 0] io48_c_cdata_pb39_in;
wire [3 : 0] io48_c_cdata_pb3_in;
wire [3 : 0] io48_c_cdata_pb40_in;
wire [3 : 0] io48_c_cdata_pb41_in;
wire [3 : 0] io48_c_cdata_pb42_in;
wire [3 : 0] io48_c_cdata_pb43_in;
wire [3 : 0] io48_c_cdata_pb44_in;
wire [3 : 0] io48_c_cdata_pb45_in;
wire [3 : 0] io48_c_cdata_pb46_in;
wire [3 : 0] io48_c_cdata_pb47_in;
wire [3 : 0] io48_c_cdata_pb4_in;
wire [3 : 0] io48_c_cdata_pb5_in;
wire [3 : 0] io48_c_cdata_pb6_in;
wire [3 : 0] io48_c_cdata_pb7_in;
wire [3 : 0] io48_c_cdata_pb8_in;
wire [3 : 0] io48_c_cdata_pb9_in;
wire [3 : 0] io48_c_dbc2core_rd_data_vld0_pl;
wire [3 : 0] io48_c_dbc2core_rd_type_pl;
wire [5 : 0] io48_c_dbc2core_wb_pointer_pl0;
wire [5 : 0] io48_c_dbc2core_wb_pointer_pl1;
wire [5 : 0] io48_c_dbc2core_wb_pointer_pl2;
wire [5 : 0] io48_c_dbc2core_wb_pointer_pl3;
wire [3 : 0] io48_c_dbc2core_wr_data_rdy_pl;
wire          io48_a_core2ctl_cmd_valid0;
wire          io48_a_core2ctl_rd_data_ready0;
wire          io48_a_core2ctl_wr_data_valid0;
wire          io48_a_core2dbc_rd_data_rdy_pl3;
wire          io48_a_core2dbc_wr_data_vld0_pl3;
wire          io48_a_fb_clk_hps;
wire          io48_a_global_reset_n;
wire          io48_a_mmr_beginbursttransfer;
wire          io48_a_mmr_read;
wire          io48_a_mmr_write;
wire          io48_a_ref_clkin_hps;
wire          io48_b_fb_clk_hps;
wire          io48_b_global_reset_n;
wire          io48_c_fb_clk_hps;
wire          io48_c_global_reset_n;
wire [7 : 0] io48_a_afi_core2seq;
wire [57 : 0] io48_a_core2ctl_cmd_data0;
wire [14 : 0] io48_a_core2ctl_wr_ecc_info;
wire [6 : 0] io48_a_core2dbc_wr_ecc_info_pl3;
wire [3 : 0] io48_a_iod_pb36_out;
wire [3 : 0] io48_a_iod_pb37_out;
wire [3 : 0] io48_a_iod_pb38_out;
wire [3 : 0] io48_a_iod_pb39_out;
wire [3 : 0] io48_a_iod_pb40_out;
wire [3 : 0] io48_a_iod_pb41_out;
wire [3 : 0] io48_a_iod_pb42_out;
wire [3 : 0] io48_a_iod_pb43_out;
wire [3 : 0] io48_a_iod_pb44_out;
wire [3 : 0] io48_a_iod_pb45_out;
wire [3 : 0] io48_a_iod_pb46_out;
wire [3 : 0] io48_a_iod_pb47_out;
wire [9 : 0] io48_a_mmr_addr;
wire [3 : 0] io48_a_mmr_be;
wire [1 : 0] io48_a_mmr_burst_count;
wire [31 : 0] io48_a_mmr_wdata;
wire [3 : 0] io48_b_core2dbc_rd_data_rdy_pl;
wire [3 : 0] io48_b_core2dbc_wr_data_vld0_pl;
wire [6 : 0] io48_b_core2dbc_wr_ecc_info_pl0;
wire [6 : 0] io48_b_core2dbc_wr_ecc_info_pl1;
wire [6 : 0] io48_b_core2dbc_wr_ecc_info_pl2;
wire [6 : 0] io48_b_core2dbc_wr_ecc_info_pl3;
wire [3 : 0] io48_b_iod_pb0_out;
wire [3 : 0] io48_b_iod_pb10_out;
wire [3 : 0] io48_b_iod_pb11_out;
wire [3 : 0] io48_b_iod_pb12_out;
wire [3 : 0] io48_b_iod_pb13_out;
wire [3 : 0] io48_b_iod_pb14_out;
wire [3 : 0] io48_b_iod_pb15_out;
wire [3 : 0] io48_b_iod_pb16_out;
wire [3 : 0] io48_b_iod_pb17_out;
wire [3 : 0] io48_b_iod_pb18_out;
wire [3 : 0] io48_b_iod_pb19_out;
wire [3 : 0] io48_b_iod_pb1_out;
wire [3 : 0] io48_b_iod_pb20_out;
wire [3 : 0] io48_b_iod_pb21_out;
wire [3 : 0] io48_b_iod_pb22_out;
wire [3 : 0] io48_b_iod_pb23_out;
wire [3 : 0] io48_b_iod_pb24_out;
wire [3 : 0] io48_b_iod_pb25_out;
wire [3 : 0] io48_b_iod_pb26_out;
wire [3 : 0] io48_b_iod_pb27_out;
wire [3 : 0] io48_b_iod_pb28_out;
wire [3 : 0] io48_b_iod_pb29_out;
wire [3 : 0] io48_b_iod_pb2_out;
wire [3 : 0] io48_b_iod_pb30_out;
wire [3 : 0] io48_b_iod_pb31_out;
wire [3 : 0] io48_b_iod_pb32_out;
wire [3 : 0] io48_b_iod_pb33_out;
wire [3 : 0] io48_b_iod_pb34_out;
wire [3 : 0] io48_b_iod_pb35_out;
wire [3 : 0] io48_b_iod_pb36_out;
wire [3 : 0] io48_b_iod_pb37_out;
wire [3 : 0] io48_b_iod_pb38_out;
wire [3 : 0] io48_b_iod_pb39_out;
wire [3 : 0] io48_b_iod_pb3_out;
wire [3 : 0] io48_b_iod_pb40_out;
wire [3 : 0] io48_b_iod_pb41_out;
wire [3 : 0] io48_b_iod_pb42_out;
wire [3 : 0] io48_b_iod_pb43_out;
wire [3 : 0] io48_b_iod_pb44_out;
wire [3 : 0] io48_b_iod_pb45_out;
wire [3 : 0] io48_b_iod_pb46_out;
wire [3 : 0] io48_b_iod_pb47_out;
wire [3 : 0] io48_b_iod_pb4_out;
wire [3 : 0] io48_b_iod_pb5_out;
wire [3 : 0] io48_b_iod_pb6_out;
wire [3 : 0] io48_b_iod_pb7_out;
wire [3 : 0] io48_b_iod_pb8_out;
wire [3 : 0] io48_b_iod_pb9_out;
wire [3 : 0] io48_c_core2dbc_rd_data_rdy_pl;
wire [3 : 0] io48_c_core2dbc_wr_data_vld0_pl;
wire [6 : 0] io48_c_core2dbc_wr_ecc_info_pl0;
wire [6 : 0] io48_c_core2dbc_wr_ecc_info_pl1;
wire [6 : 0] io48_c_core2dbc_wr_ecc_info_pl2;
wire [6 : 0] io48_c_core2dbc_wr_ecc_info_pl3;
wire [3 : 0] io48_c_iod_pb0_out;
wire [3 : 0] io48_c_iod_pb10_out;
wire [3 : 0] io48_c_iod_pb11_out;
wire [3 : 0] io48_c_iod_pb12_out;
wire [3 : 0] io48_c_iod_pb13_out;
wire [3 : 0] io48_c_iod_pb14_out;
wire [3 : 0] io48_c_iod_pb15_out;
wire [3 : 0] io48_c_iod_pb16_out;
wire [3 : 0] io48_c_iod_pb17_out;
wire [3 : 0] io48_c_iod_pb18_out;
wire [3 : 0] io48_c_iod_pb19_out;
wire [3 : 0] io48_c_iod_pb1_out;
wire [3 : 0] io48_c_iod_pb20_out;
wire [3 : 0] io48_c_iod_pb21_out;
wire [3 : 0] io48_c_iod_pb22_out;
wire [3 : 0] io48_c_iod_pb23_out;
wire [3 : 0] io48_c_iod_pb24_out;
wire [3 : 0] io48_c_iod_pb25_out;
wire [3 : 0] io48_c_iod_pb26_out;
wire [3 : 0] io48_c_iod_pb27_out;
wire [3 : 0] io48_c_iod_pb28_out;
wire [3 : 0] io48_c_iod_pb29_out;
wire [3 : 0] io48_c_iod_pb2_out;
wire [3 : 0] io48_c_iod_pb30_out;
wire [3 : 0] io48_c_iod_pb31_out;
wire [3 : 0] io48_c_iod_pb32_out;
wire [3 : 0] io48_c_iod_pb33_out;
wire [3 : 0] io48_c_iod_pb34_out;
wire [3 : 0] io48_c_iod_pb35_out;
wire [3 : 0] io48_c_iod_pb36_out;
wire [3 : 0] io48_c_iod_pb37_out;
wire [3 : 0] io48_c_iod_pb38_out;
wire [3 : 0] io48_c_iod_pb39_out;
wire [3 : 0] io48_c_iod_pb3_out;
wire [3 : 0] io48_c_iod_pb40_out;
wire [3 : 0] io48_c_iod_pb41_out;
wire [3 : 0] io48_c_iod_pb42_out;
wire [3 : 0] io48_c_iod_pb43_out;
wire [3 : 0] io48_c_iod_pb44_out;
wire [3 : 0] io48_c_iod_pb45_out;
wire [3 : 0] io48_c_iod_pb46_out;
wire [3 : 0] io48_c_iod_pb47_out;
wire [3 : 0] io48_c_iod_pb4_out;
wire [3 : 0] io48_c_iod_pb5_out;
wire [3 : 0] io48_c_iod_pb6_out;
wire [3 : 0] io48_c_iod_pb7_out;
wire [3 : 0] io48_c_iod_pb8_out;
wire [3 : 0] io48_c_iod_pb9_out;

assign  mmr_addr = io48_a_mmr_addr;
assign  mmr_be = io48_a_mmr_be;
assign  mmr_beginbursttransfer = io48_a_mmr_beginbursttransfer;
assign  mmr_burst_count = io48_a_mmr_burst_count;
assign  io48_a_mmr_rdata = mmr_rdata;
assign  io48_a_mmr_rdata_valid = mmr_rdata_valid;
assign  mmr_read = io48_a_mmr_read;
assign  io48_a_mmr_waitrequest = mmr_waitrequest;
assign  mmr_wdata = io48_a_mmr_wdata;
assign  mmr_write = io48_a_mmr_write;
assign  io48_a_afi_cal_success = afi_cal_success;
assign  core2ctl_cmd_data0 = io48_a_core2ctl_cmd_data0;
assign  core2ctl_cmd_valid0 = io48_a_core2ctl_cmd_valid0;
assign  core2ctl_rd_data_ready0 = io48_a_core2ctl_rd_data_ready0;
assign  core2ctl_wr_data_valid0 = io48_a_core2ctl_wr_data_valid0;
assign  core2ctl_wr_ecc_info = io48_a_core2ctl_wr_ecc_info;
assign  io48_a_ctl2core_cmd_ecc_info = ctl2core_cmd_ecc_info;
assign  io48_a_ctl2core_cmd_ready0 = ctl2core_cmd_ready0;
assign  io48_a_ctl2core_rd_ecc_info = ctl2core_rd_ecc_info;
assign  io48_a_ctl2core_rdata_id = ctl2core_rdata_id;
assign  afi_core2seq = io48_a_afi_core2seq;
assign  io48_a_afi_seq2core = afi_seq2core;
assign  io48_a_pll_locked = pll_locked;
assign  ref_clkin_hps = io48_a_ref_clkin_hps;

assign iod_out ={
	io48_a_iod_pb36_out[0], io48_a_iod_pb36_out[1], io48_a_iod_pb36_out[2], io48_a_iod_pb36_out[3], 
	io48_a_iod_pb37_out[0], io48_a_iod_pb37_out[1], io48_a_iod_pb37_out[2], io48_a_iod_pb37_out[3], 
	io48_a_iod_pb38_out[0], io48_a_iod_pb38_out[1], io48_a_iod_pb38_out[2], io48_a_iod_pb38_out[3], 
	io48_a_iod_pb39_out[0], io48_a_iod_pb39_out[1], io48_a_iod_pb39_out[2], io48_a_iod_pb39_out[3], 
	io48_a_iod_pb40_out[0], io48_a_iod_pb40_out[1], io48_a_iod_pb40_out[2], io48_a_iod_pb40_out[3], 
	io48_a_iod_pb41_out[0], io48_a_iod_pb41_out[1], io48_a_iod_pb41_out[2], io48_a_iod_pb41_out[3], 
	io48_a_iod_pb42_out[0], io48_a_iod_pb42_out[1], io48_a_iod_pb42_out[2], io48_a_iod_pb42_out[3], 
	io48_a_iod_pb43_out[0], io48_a_iod_pb43_out[1], io48_a_iod_pb43_out[2], io48_a_iod_pb43_out[3], 
	io48_b_iod_pb0_out[0], io48_b_iod_pb0_out[1], io48_b_iod_pb0_out[2], io48_b_iod_pb0_out[3], 
	io48_b_iod_pb1_out[0], io48_b_iod_pb1_out[1], io48_b_iod_pb1_out[2], io48_b_iod_pb1_out[3], 
	io48_b_iod_pb2_out[0], io48_b_iod_pb2_out[1], io48_b_iod_pb2_out[2], io48_b_iod_pb2_out[3], 
	io48_b_iod_pb3_out[0], io48_b_iod_pb3_out[1], io48_b_iod_pb3_out[2], io48_b_iod_pb3_out[3], 
	io48_b_iod_pb4_out[0], io48_b_iod_pb4_out[1], io48_b_iod_pb4_out[2], io48_b_iod_pb4_out[3], 
	io48_b_iod_pb5_out[0], io48_b_iod_pb5_out[1], io48_b_iod_pb5_out[2], io48_b_iod_pb5_out[3], 
	io48_b_iod_pb6_out[0], io48_b_iod_pb6_out[1], io48_b_iod_pb6_out[2], io48_b_iod_pb6_out[3], 
	io48_b_iod_pb7_out[0], io48_b_iod_pb7_out[1], io48_b_iod_pb7_out[2], io48_b_iod_pb7_out[3], 
	io48_b_iod_pb12_out[0], io48_b_iod_pb12_out[1], io48_b_iod_pb12_out[2], io48_b_iod_pb12_out[3], 
	io48_b_iod_pb13_out[0], io48_b_iod_pb13_out[1], io48_b_iod_pb13_out[2], io48_b_iod_pb13_out[3], 
	io48_b_iod_pb14_out[0], io48_b_iod_pb14_out[1], io48_b_iod_pb14_out[2], io48_b_iod_pb14_out[3], 
	io48_b_iod_pb15_out[0], io48_b_iod_pb15_out[1], io48_b_iod_pb15_out[2], io48_b_iod_pb15_out[3], 
	io48_b_iod_pb16_out[0], io48_b_iod_pb16_out[1], io48_b_iod_pb16_out[2], io48_b_iod_pb16_out[3], 
	io48_b_iod_pb17_out[0], io48_b_iod_pb17_out[1], io48_b_iod_pb17_out[2], io48_b_iod_pb17_out[3], 
	io48_b_iod_pb18_out[0], io48_b_iod_pb18_out[1], io48_b_iod_pb18_out[2], io48_b_iod_pb18_out[3], 
	io48_b_iod_pb19_out[0], io48_b_iod_pb19_out[1], io48_b_iod_pb19_out[2], io48_b_iod_pb19_out[3], 
	io48_b_iod_pb24_out[0], io48_b_iod_pb24_out[1], io48_b_iod_pb24_out[2], io48_b_iod_pb24_out[3], 
	io48_b_iod_pb25_out[0], io48_b_iod_pb25_out[1], io48_b_iod_pb25_out[2], io48_b_iod_pb25_out[3], 
	io48_b_iod_pb26_out[0], io48_b_iod_pb26_out[1], io48_b_iod_pb26_out[2], io48_b_iod_pb26_out[3], 
	io48_b_iod_pb27_out[0], io48_b_iod_pb27_out[1], io48_b_iod_pb27_out[2], io48_b_iod_pb27_out[3], 
	io48_b_iod_pb28_out[0], io48_b_iod_pb28_out[1], io48_b_iod_pb28_out[2], io48_b_iod_pb28_out[3], 
	io48_b_iod_pb29_out[0], io48_b_iod_pb29_out[1], io48_b_iod_pb29_out[2], io48_b_iod_pb29_out[3], 
	io48_b_iod_pb30_out[0], io48_b_iod_pb30_out[1], io48_b_iod_pb30_out[2], io48_b_iod_pb30_out[3], 
	io48_b_iod_pb31_out[0], io48_b_iod_pb31_out[1], io48_b_iod_pb31_out[2], io48_b_iod_pb31_out[3], 
	io48_b_iod_pb36_out[0], io48_b_iod_pb36_out[1], io48_b_iod_pb36_out[2], io48_b_iod_pb36_out[3], 
	io48_b_iod_pb37_out[0], io48_b_iod_pb37_out[1], io48_b_iod_pb37_out[2], io48_b_iod_pb37_out[3], 
	io48_b_iod_pb38_out[0], io48_b_iod_pb38_out[1], io48_b_iod_pb38_out[2], io48_b_iod_pb38_out[3], 
	io48_b_iod_pb39_out[0], io48_b_iod_pb39_out[1], io48_b_iod_pb39_out[2], io48_b_iod_pb39_out[3], 
	io48_b_iod_pb40_out[0], io48_b_iod_pb40_out[1], io48_b_iod_pb40_out[2], io48_b_iod_pb40_out[3], 
	io48_b_iod_pb41_out[0], io48_b_iod_pb41_out[1], io48_b_iod_pb41_out[2], io48_b_iod_pb41_out[3], 
	io48_b_iod_pb42_out[0], io48_b_iod_pb42_out[1], io48_b_iod_pb42_out[2], io48_b_iod_pb42_out[3], 
	io48_b_iod_pb43_out[0], io48_b_iod_pb43_out[1], io48_b_iod_pb43_out[2], io48_b_iod_pb43_out[3], 
	io48_c_iod_pb0_out[0], io48_c_iod_pb0_out[1], io48_c_iod_pb0_out[2], io48_c_iod_pb0_out[3], 
	io48_c_iod_pb1_out[0], io48_c_iod_pb1_out[1], io48_c_iod_pb1_out[2], io48_c_iod_pb1_out[3], 
	io48_c_iod_pb2_out[0], io48_c_iod_pb2_out[1], io48_c_iod_pb2_out[2], io48_c_iod_pb2_out[3], 
	io48_c_iod_pb3_out[0], io48_c_iod_pb3_out[1], io48_c_iod_pb3_out[2], io48_c_iod_pb3_out[3], 
	io48_c_iod_pb4_out[0], io48_c_iod_pb4_out[1], io48_c_iod_pb4_out[2], io48_c_iod_pb4_out[3], 
	io48_c_iod_pb5_out[0], io48_c_iod_pb5_out[1], io48_c_iod_pb5_out[2], io48_c_iod_pb5_out[3], 
	io48_c_iod_pb6_out[0], io48_c_iod_pb6_out[1], io48_c_iod_pb6_out[2], io48_c_iod_pb6_out[3], 
	io48_c_iod_pb7_out[0], io48_c_iod_pb7_out[1], io48_c_iod_pb7_out[2], io48_c_iod_pb7_out[3], 
	io48_c_iod_pb12_out[0], io48_c_iod_pb12_out[1], io48_c_iod_pb12_out[2], io48_c_iod_pb12_out[3], 
	io48_c_iod_pb13_out[0], io48_c_iod_pb13_out[1], io48_c_iod_pb13_out[2], io48_c_iod_pb13_out[3], 
	io48_c_iod_pb14_out[0], io48_c_iod_pb14_out[1], io48_c_iod_pb14_out[2], io48_c_iod_pb14_out[3], 
	io48_c_iod_pb15_out[0], io48_c_iod_pb15_out[1], io48_c_iod_pb15_out[2], io48_c_iod_pb15_out[3], 
	io48_c_iod_pb16_out[0], io48_c_iod_pb16_out[1], io48_c_iod_pb16_out[2], io48_c_iod_pb16_out[3], 
	io48_c_iod_pb17_out[0], io48_c_iod_pb17_out[1], io48_c_iod_pb17_out[2], io48_c_iod_pb17_out[3], 
	io48_c_iod_pb18_out[0], io48_c_iod_pb18_out[1], io48_c_iod_pb18_out[2], io48_c_iod_pb18_out[3], 
	io48_c_iod_pb19_out[0], io48_c_iod_pb19_out[1], io48_c_iod_pb19_out[2], io48_c_iod_pb19_out[3], 
	io48_c_iod_pb24_out[0], io48_c_iod_pb24_out[1], io48_c_iod_pb24_out[2], io48_c_iod_pb24_out[3], 
	io48_c_iod_pb25_out[0], io48_c_iod_pb25_out[1], io48_c_iod_pb25_out[2], io48_c_iod_pb25_out[3], 
	io48_c_iod_pb26_out[0], io48_c_iod_pb26_out[1], io48_c_iod_pb26_out[2], io48_c_iod_pb26_out[3], 
	io48_c_iod_pb27_out[0], io48_c_iod_pb27_out[1], io48_c_iod_pb27_out[2], io48_c_iod_pb27_out[3], 
	io48_c_iod_pb28_out[0], io48_c_iod_pb28_out[1], io48_c_iod_pb28_out[2], io48_c_iod_pb28_out[3], 
	io48_c_iod_pb29_out[0], io48_c_iod_pb29_out[1], io48_c_iod_pb29_out[2], io48_c_iod_pb29_out[3], 
	io48_c_iod_pb30_out[0], io48_c_iod_pb30_out[1], io48_c_iod_pb30_out[2], io48_c_iod_pb30_out[3], 
	io48_c_iod_pb31_out[0], io48_c_iod_pb31_out[1], io48_c_iod_pb31_out[2], io48_c_iod_pb31_out[3], 
	io48_c_iod_pb36_out[0], io48_c_iod_pb36_out[1], io48_c_iod_pb36_out[2], io48_c_iod_pb36_out[3], 
	io48_c_iod_pb37_out[0], io48_c_iod_pb37_out[1], io48_c_iod_pb37_out[2], io48_c_iod_pb37_out[3], 
	io48_c_iod_pb38_out[0], io48_c_iod_pb38_out[1], io48_c_iod_pb38_out[2], io48_c_iod_pb38_out[3], 
	io48_c_iod_pb39_out[0], io48_c_iod_pb39_out[1], io48_c_iod_pb39_out[2], io48_c_iod_pb39_out[3], 
	io48_c_iod_pb40_out[0], io48_c_iod_pb40_out[1], io48_c_iod_pb40_out[2], io48_c_iod_pb40_out[3], 
	io48_c_iod_pb41_out[0], io48_c_iod_pb41_out[1], io48_c_iod_pb41_out[2], io48_c_iod_pb41_out[3], 
	io48_c_iod_pb42_out[0], io48_c_iod_pb42_out[1], io48_c_iod_pb42_out[2], io48_c_iod_pb42_out[3], 
	io48_c_iod_pb43_out[0], io48_c_iod_pb43_out[1], io48_c_iod_pb43_out[2], io48_c_iod_pb43_out[3]} ;
assign {
	io48_a_cdata_pb36_in[0], io48_a_cdata_pb36_in[1], io48_a_cdata_pb36_in[2], io48_a_cdata_pb36_in[3], 
	io48_a_cdata_pb37_in[0], io48_a_cdata_pb37_in[1], io48_a_cdata_pb37_in[2], io48_a_cdata_pb37_in[3], 
	io48_a_cdata_pb38_in[0], io48_a_cdata_pb38_in[1], io48_a_cdata_pb38_in[2], io48_a_cdata_pb38_in[3], 
	io48_a_cdata_pb39_in[0], io48_a_cdata_pb39_in[1], io48_a_cdata_pb39_in[2], io48_a_cdata_pb39_in[3], 
	io48_a_cdata_pb40_in[0], io48_a_cdata_pb40_in[1], io48_a_cdata_pb40_in[2], io48_a_cdata_pb40_in[3], 
	io48_a_cdata_pb41_in[0], io48_a_cdata_pb41_in[1], io48_a_cdata_pb41_in[2], io48_a_cdata_pb41_in[3], 
	io48_a_cdata_pb42_in[0], io48_a_cdata_pb42_in[1], io48_a_cdata_pb42_in[2], io48_a_cdata_pb42_in[3], 
	io48_a_cdata_pb43_in[0], io48_a_cdata_pb43_in[1], io48_a_cdata_pb43_in[2], io48_a_cdata_pb43_in[3], 
	io48_b_cdata_pb0_in[0], io48_b_cdata_pb0_in[1], io48_b_cdata_pb0_in[2], io48_b_cdata_pb0_in[3], 
	io48_b_cdata_pb1_in[0], io48_b_cdata_pb1_in[1], io48_b_cdata_pb1_in[2], io48_b_cdata_pb1_in[3], 
	io48_b_cdata_pb2_in[0], io48_b_cdata_pb2_in[1], io48_b_cdata_pb2_in[2], io48_b_cdata_pb2_in[3], 
	io48_b_cdata_pb3_in[0], io48_b_cdata_pb3_in[1], io48_b_cdata_pb3_in[2], io48_b_cdata_pb3_in[3], 
	io48_b_cdata_pb4_in[0], io48_b_cdata_pb4_in[1], io48_b_cdata_pb4_in[2], io48_b_cdata_pb4_in[3], 
	io48_b_cdata_pb5_in[0], io48_b_cdata_pb5_in[1], io48_b_cdata_pb5_in[2], io48_b_cdata_pb5_in[3], 
	io48_b_cdata_pb6_in[0], io48_b_cdata_pb6_in[1], io48_b_cdata_pb6_in[2], io48_b_cdata_pb6_in[3], 
	io48_b_cdata_pb7_in[0], io48_b_cdata_pb7_in[1], io48_b_cdata_pb7_in[2], io48_b_cdata_pb7_in[3], 
	io48_b_cdata_pb12_in[0], io48_b_cdata_pb12_in[1], io48_b_cdata_pb12_in[2], io48_b_cdata_pb12_in[3], 
	io48_b_cdata_pb13_in[0], io48_b_cdata_pb13_in[1], io48_b_cdata_pb13_in[2], io48_b_cdata_pb13_in[3], 
	io48_b_cdata_pb14_in[0], io48_b_cdata_pb14_in[1], io48_b_cdata_pb14_in[2], io48_b_cdata_pb14_in[3], 
	io48_b_cdata_pb15_in[0], io48_b_cdata_pb15_in[1], io48_b_cdata_pb15_in[2], io48_b_cdata_pb15_in[3], 
	io48_b_cdata_pb16_in[0], io48_b_cdata_pb16_in[1], io48_b_cdata_pb16_in[2], io48_b_cdata_pb16_in[3], 
	io48_b_cdata_pb17_in[0], io48_b_cdata_pb17_in[1], io48_b_cdata_pb17_in[2], io48_b_cdata_pb17_in[3], 
	io48_b_cdata_pb18_in[0], io48_b_cdata_pb18_in[1], io48_b_cdata_pb18_in[2], io48_b_cdata_pb18_in[3], 
	io48_b_cdata_pb19_in[0], io48_b_cdata_pb19_in[1], io48_b_cdata_pb19_in[2], io48_b_cdata_pb19_in[3], 
	io48_b_cdata_pb24_in[0], io48_b_cdata_pb24_in[1], io48_b_cdata_pb24_in[2], io48_b_cdata_pb24_in[3], 
	io48_b_cdata_pb25_in[0], io48_b_cdata_pb25_in[1], io48_b_cdata_pb25_in[2], io48_b_cdata_pb25_in[3], 
	io48_b_cdata_pb26_in[0], io48_b_cdata_pb26_in[1], io48_b_cdata_pb26_in[2], io48_b_cdata_pb26_in[3], 
	io48_b_cdata_pb27_in[0], io48_b_cdata_pb27_in[1], io48_b_cdata_pb27_in[2], io48_b_cdata_pb27_in[3], 
	io48_b_cdata_pb28_in[0], io48_b_cdata_pb28_in[1], io48_b_cdata_pb28_in[2], io48_b_cdata_pb28_in[3], 
	io48_b_cdata_pb29_in[0], io48_b_cdata_pb29_in[1], io48_b_cdata_pb29_in[2], io48_b_cdata_pb29_in[3], 
	io48_b_cdata_pb30_in[0], io48_b_cdata_pb30_in[1], io48_b_cdata_pb30_in[2], io48_b_cdata_pb30_in[3], 
	io48_b_cdata_pb31_in[0], io48_b_cdata_pb31_in[1], io48_b_cdata_pb31_in[2], io48_b_cdata_pb31_in[3], 
	io48_b_cdata_pb36_in[0], io48_b_cdata_pb36_in[1], io48_b_cdata_pb36_in[2], io48_b_cdata_pb36_in[3], 
	io48_b_cdata_pb37_in[0], io48_b_cdata_pb37_in[1], io48_b_cdata_pb37_in[2], io48_b_cdata_pb37_in[3], 
	io48_b_cdata_pb38_in[0], io48_b_cdata_pb38_in[1], io48_b_cdata_pb38_in[2], io48_b_cdata_pb38_in[3], 
	io48_b_cdata_pb39_in[0], io48_b_cdata_pb39_in[1], io48_b_cdata_pb39_in[2], io48_b_cdata_pb39_in[3], 
	io48_b_cdata_pb40_in[0], io48_b_cdata_pb40_in[1], io48_b_cdata_pb40_in[2], io48_b_cdata_pb40_in[3], 
	io48_b_cdata_pb41_in[0], io48_b_cdata_pb41_in[1], io48_b_cdata_pb41_in[2], io48_b_cdata_pb41_in[3], 
	io48_b_cdata_pb42_in[0], io48_b_cdata_pb42_in[1], io48_b_cdata_pb42_in[2], io48_b_cdata_pb42_in[3], 
	io48_b_cdata_pb43_in[0], io48_b_cdata_pb43_in[1], io48_b_cdata_pb43_in[2], io48_b_cdata_pb43_in[3], 
	io48_c_cdata_pb0_in[0], io48_c_cdata_pb0_in[1], io48_c_cdata_pb0_in[2], io48_c_cdata_pb0_in[3], 
	io48_c_cdata_pb1_in[0], io48_c_cdata_pb1_in[1], io48_c_cdata_pb1_in[2], io48_c_cdata_pb1_in[3], 
	io48_c_cdata_pb2_in[0], io48_c_cdata_pb2_in[1], io48_c_cdata_pb2_in[2], io48_c_cdata_pb2_in[3], 
	io48_c_cdata_pb3_in[0], io48_c_cdata_pb3_in[1], io48_c_cdata_pb3_in[2], io48_c_cdata_pb3_in[3], 
	io48_c_cdata_pb4_in[0], io48_c_cdata_pb4_in[1], io48_c_cdata_pb4_in[2], io48_c_cdata_pb4_in[3], 
	io48_c_cdata_pb5_in[0], io48_c_cdata_pb5_in[1], io48_c_cdata_pb5_in[2], io48_c_cdata_pb5_in[3], 
	io48_c_cdata_pb6_in[0], io48_c_cdata_pb6_in[1], io48_c_cdata_pb6_in[2], io48_c_cdata_pb6_in[3], 
	io48_c_cdata_pb7_in[0], io48_c_cdata_pb7_in[1], io48_c_cdata_pb7_in[2], io48_c_cdata_pb7_in[3], 
	io48_c_cdata_pb12_in[0], io48_c_cdata_pb12_in[1], io48_c_cdata_pb12_in[2], io48_c_cdata_pb12_in[3], 
	io48_c_cdata_pb13_in[0], io48_c_cdata_pb13_in[1], io48_c_cdata_pb13_in[2], io48_c_cdata_pb13_in[3], 
	io48_c_cdata_pb14_in[0], io48_c_cdata_pb14_in[1], io48_c_cdata_pb14_in[2], io48_c_cdata_pb14_in[3], 
	io48_c_cdata_pb15_in[0], io48_c_cdata_pb15_in[1], io48_c_cdata_pb15_in[2], io48_c_cdata_pb15_in[3], 
	io48_c_cdata_pb16_in[0], io48_c_cdata_pb16_in[1], io48_c_cdata_pb16_in[2], io48_c_cdata_pb16_in[3], 
	io48_c_cdata_pb17_in[0], io48_c_cdata_pb17_in[1], io48_c_cdata_pb17_in[2], io48_c_cdata_pb17_in[3], 
	io48_c_cdata_pb18_in[0], io48_c_cdata_pb18_in[1], io48_c_cdata_pb18_in[2], io48_c_cdata_pb18_in[3], 
	io48_c_cdata_pb19_in[0], io48_c_cdata_pb19_in[1], io48_c_cdata_pb19_in[2], io48_c_cdata_pb19_in[3], 
	io48_c_cdata_pb24_in[0], io48_c_cdata_pb24_in[1], io48_c_cdata_pb24_in[2], io48_c_cdata_pb24_in[3], 
	io48_c_cdata_pb25_in[0], io48_c_cdata_pb25_in[1], io48_c_cdata_pb25_in[2], io48_c_cdata_pb25_in[3], 
	io48_c_cdata_pb26_in[0], io48_c_cdata_pb26_in[1], io48_c_cdata_pb26_in[2], io48_c_cdata_pb26_in[3], 
	io48_c_cdata_pb27_in[0], io48_c_cdata_pb27_in[1], io48_c_cdata_pb27_in[2], io48_c_cdata_pb27_in[3], 
	io48_c_cdata_pb28_in[0], io48_c_cdata_pb28_in[1], io48_c_cdata_pb28_in[2], io48_c_cdata_pb28_in[3], 
	io48_c_cdata_pb29_in[0], io48_c_cdata_pb29_in[1], io48_c_cdata_pb29_in[2], io48_c_cdata_pb29_in[3], 
	io48_c_cdata_pb30_in[0], io48_c_cdata_pb30_in[1], io48_c_cdata_pb30_in[2], io48_c_cdata_pb30_in[3], 
	io48_c_cdata_pb31_in[0], io48_c_cdata_pb31_in[1], io48_c_cdata_pb31_in[2], io48_c_cdata_pb31_in[3], 
	io48_c_cdata_pb36_in[0], io48_c_cdata_pb36_in[1], io48_c_cdata_pb36_in[2], io48_c_cdata_pb36_in[3], 
	io48_c_cdata_pb37_in[0], io48_c_cdata_pb37_in[1], io48_c_cdata_pb37_in[2], io48_c_cdata_pb37_in[3], 
	io48_c_cdata_pb38_in[0], io48_c_cdata_pb38_in[1], io48_c_cdata_pb38_in[2], io48_c_cdata_pb38_in[3], 
	io48_c_cdata_pb39_in[0], io48_c_cdata_pb39_in[1], io48_c_cdata_pb39_in[2], io48_c_cdata_pb39_in[3], 
	io48_c_cdata_pb40_in[0], io48_c_cdata_pb40_in[1], io48_c_cdata_pb40_in[2], io48_c_cdata_pb40_in[3], 
	io48_c_cdata_pb41_in[0], io48_c_cdata_pb41_in[1], io48_c_cdata_pb41_in[2], io48_c_cdata_pb41_in[3], 
	io48_c_cdata_pb42_in[0], io48_c_cdata_pb42_in[1], io48_c_cdata_pb42_in[2], io48_c_cdata_pb42_in[3], 
	io48_c_cdata_pb43_in[0], io48_c_cdata_pb43_in[1], io48_c_cdata_pb43_in[2], io48_c_cdata_pb43_in[3]} = cdata_in;
assign iod_upper = {
	io48_a_iod_pb44_out[0], io48_a_iod_pb44_out[1], io48_a_iod_pb44_out[2], io48_a_iod_pb44_out[3], 
	io48_a_iod_pb45_out[0], io48_a_iod_pb45_out[1], io48_a_iod_pb45_out[2], io48_a_iod_pb45_out[3], 
	io48_a_iod_pb46_out[0], io48_a_iod_pb46_out[1], io48_a_iod_pb46_out[2], io48_a_iod_pb46_out[3], 
	io48_a_iod_pb47_out[0], io48_a_iod_pb47_out[1], io48_a_iod_pb47_out[2], io48_a_iod_pb47_out[3], 
	io48_b_iod_pb8_out[0], io48_b_iod_pb8_out[1], io48_b_iod_pb8_out[2], io48_b_iod_pb8_out[3], 
	io48_b_iod_pb9_out[0], io48_b_iod_pb9_out[1], io48_b_iod_pb9_out[2], io48_b_iod_pb9_out[3], 
	io48_b_iod_pb10_out[0], io48_b_iod_pb10_out[1], io48_b_iod_pb10_out[2], io48_b_iod_pb10_out[3], 
	io48_b_iod_pb11_out[0], io48_b_iod_pb11_out[1], io48_b_iod_pb11_out[2], io48_b_iod_pb11_out[3], 
	io48_b_iod_pb20_out[0], io48_b_iod_pb20_out[1], io48_b_iod_pb20_out[2], io48_b_iod_pb20_out[3], 
	io48_b_iod_pb21_out[0], io48_b_iod_pb21_out[1], io48_b_iod_pb21_out[2], io48_b_iod_pb21_out[3], 
	io48_b_iod_pb22_out[0], io48_b_iod_pb22_out[1], io48_b_iod_pb22_out[2], io48_b_iod_pb22_out[3], 
	io48_b_iod_pb23_out[0], io48_b_iod_pb23_out[1], io48_b_iod_pb23_out[2], io48_b_iod_pb23_out[3], 
	io48_b_iod_pb32_out[0], io48_b_iod_pb32_out[1], io48_b_iod_pb32_out[2], io48_b_iod_pb32_out[3], 
	io48_b_iod_pb33_out[0], io48_b_iod_pb33_out[1], io48_b_iod_pb33_out[2], io48_b_iod_pb33_out[3], 
	io48_b_iod_pb34_out[0], io48_b_iod_pb34_out[1], io48_b_iod_pb34_out[2], io48_b_iod_pb34_out[3], 
	io48_b_iod_pb35_out[0], io48_b_iod_pb35_out[1], io48_b_iod_pb35_out[2], io48_b_iod_pb35_out[3], 
	io48_b_iod_pb44_out[0], io48_b_iod_pb44_out[1], io48_b_iod_pb44_out[2], io48_b_iod_pb44_out[3], 
	io48_b_iod_pb45_out[0], io48_b_iod_pb45_out[1], io48_b_iod_pb45_out[2], io48_b_iod_pb45_out[3], 
	io48_b_iod_pb46_out[0], io48_b_iod_pb46_out[1], io48_b_iod_pb46_out[2], io48_b_iod_pb46_out[3], 
	io48_b_iod_pb47_out[0], io48_b_iod_pb47_out[1], io48_b_iod_pb47_out[2], io48_b_iod_pb47_out[3], 
	io48_c_iod_pb8_out[0], io48_c_iod_pb8_out[1], io48_c_iod_pb8_out[2], io48_c_iod_pb8_out[3], 
	io48_c_iod_pb9_out[0], io48_c_iod_pb9_out[1], io48_c_iod_pb9_out[2], io48_c_iod_pb9_out[3], 
	io48_c_iod_pb10_out[0], io48_c_iod_pb10_out[1], io48_c_iod_pb10_out[2], io48_c_iod_pb10_out[3], 
	io48_c_iod_pb11_out[0], io48_c_iod_pb11_out[1], io48_c_iod_pb11_out[2], io48_c_iod_pb11_out[3], 
	io48_c_iod_pb20_out[0], io48_c_iod_pb20_out[1], io48_c_iod_pb20_out[2], io48_c_iod_pb20_out[3], 
	io48_c_iod_pb21_out[0], io48_c_iod_pb21_out[1], io48_c_iod_pb21_out[2], io48_c_iod_pb21_out[3], 
	io48_c_iod_pb22_out[0], io48_c_iod_pb22_out[1], io48_c_iod_pb22_out[2], io48_c_iod_pb22_out[3], 
	io48_c_iod_pb23_out[0], io48_c_iod_pb23_out[1], io48_c_iod_pb23_out[2], io48_c_iod_pb23_out[3], 
	io48_c_iod_pb32_out[0], io48_c_iod_pb32_out[1], io48_c_iod_pb32_out[2], io48_c_iod_pb32_out[3], 
	io48_c_iod_pb33_out[0], io48_c_iod_pb33_out[1], io48_c_iod_pb33_out[2], io48_c_iod_pb33_out[3], 
	io48_c_iod_pb34_out[0], io48_c_iod_pb34_out[1], io48_c_iod_pb34_out[2], io48_c_iod_pb34_out[3], 
	io48_c_iod_pb35_out[0], io48_c_iod_pb35_out[1], io48_c_iod_pb35_out[2], io48_c_iod_pb35_out[3], 
	io48_c_iod_pb44_out[0], io48_c_iod_pb44_out[1], io48_c_iod_pb44_out[2], io48_c_iod_pb44_out[3], 
	io48_c_iod_pb45_out[0], io48_c_iod_pb45_out[1], io48_c_iod_pb45_out[2], io48_c_iod_pb45_out[3], 
	io48_c_iod_pb46_out[0], io48_c_iod_pb46_out[1], io48_c_iod_pb46_out[2], io48_c_iod_pb46_out[3], 
	io48_c_iod_pb47_out[0], io48_c_iod_pb47_out[1], io48_c_iod_pb47_out[2], io48_c_iod_pb47_out[3]};
assign {
	io48_a_cdata_pb44_in[0], io48_a_cdata_pb44_in[1], io48_a_cdata_pb44_in[2], io48_a_cdata_pb44_in[3], 
	io48_a_cdata_pb45_in[0], io48_a_cdata_pb45_in[1], io48_a_cdata_pb45_in[2], io48_a_cdata_pb45_in[3], 
	io48_a_cdata_pb46_in[0], io48_a_cdata_pb46_in[1], io48_a_cdata_pb46_in[2], io48_a_cdata_pb46_in[3], 
	io48_a_cdata_pb47_in[0], io48_a_cdata_pb47_in[1], io48_a_cdata_pb47_in[2], io48_a_cdata_pb47_in[3], 
	io48_b_cdata_pb8_in[0], io48_b_cdata_pb8_in[1], io48_b_cdata_pb8_in[2], io48_b_cdata_pb8_in[3], 
	io48_b_cdata_pb9_in[0], io48_b_cdata_pb9_in[1], io48_b_cdata_pb9_in[2], io48_b_cdata_pb9_in[3], 
	io48_b_cdata_pb10_in[0], io48_b_cdata_pb10_in[1], io48_b_cdata_pb10_in[2], io48_b_cdata_pb10_in[3], 
	io48_b_cdata_pb11_in[0], io48_b_cdata_pb11_in[1], io48_b_cdata_pb11_in[2], io48_b_cdata_pb11_in[3], 
	io48_b_cdata_pb20_in[0], io48_b_cdata_pb20_in[1], io48_b_cdata_pb20_in[2], io48_b_cdata_pb20_in[3], 
	io48_b_cdata_pb21_in[0], io48_b_cdata_pb21_in[1], io48_b_cdata_pb21_in[2], io48_b_cdata_pb21_in[3], 
	io48_b_cdata_pb22_in[0], io48_b_cdata_pb22_in[1], io48_b_cdata_pb22_in[2], io48_b_cdata_pb22_in[3], 
	io48_b_cdata_pb23_in[0], io48_b_cdata_pb23_in[1], io48_b_cdata_pb23_in[2], io48_b_cdata_pb23_in[3], 
	io48_b_cdata_pb32_in[0], io48_b_cdata_pb32_in[1], io48_b_cdata_pb32_in[2], io48_b_cdata_pb32_in[3], 
	io48_b_cdata_pb33_in[0], io48_b_cdata_pb33_in[1], io48_b_cdata_pb33_in[2], io48_b_cdata_pb33_in[3], 
	io48_b_cdata_pb34_in[0], io48_b_cdata_pb34_in[1], io48_b_cdata_pb34_in[2], io48_b_cdata_pb34_in[3], 
	io48_b_cdata_pb35_in[0], io48_b_cdata_pb35_in[1], io48_b_cdata_pb35_in[2], io48_b_cdata_pb35_in[3], 
	io48_b_cdata_pb44_in[0], io48_b_cdata_pb44_in[1], io48_b_cdata_pb44_in[2], io48_b_cdata_pb44_in[3], 
	io48_b_cdata_pb45_in[0], io48_b_cdata_pb45_in[1], io48_b_cdata_pb45_in[2], io48_b_cdata_pb45_in[3], 
	io48_b_cdata_pb46_in[0], io48_b_cdata_pb46_in[1], io48_b_cdata_pb46_in[2], io48_b_cdata_pb46_in[3], 
	io48_b_cdata_pb47_in[0], io48_b_cdata_pb47_in[1], io48_b_cdata_pb47_in[2], io48_b_cdata_pb47_in[3], 
	io48_c_cdata_pb8_in[0], io48_c_cdata_pb8_in[1], io48_c_cdata_pb8_in[2], io48_c_cdata_pb8_in[3], 
	io48_c_cdata_pb9_in[0], io48_c_cdata_pb9_in[1], io48_c_cdata_pb9_in[2], io48_c_cdata_pb9_in[3], 
	io48_c_cdata_pb10_in[0], io48_c_cdata_pb10_in[1], io48_c_cdata_pb10_in[2], io48_c_cdata_pb10_in[3], 
	io48_c_cdata_pb11_in[0], io48_c_cdata_pb11_in[1], io48_c_cdata_pb11_in[2], io48_c_cdata_pb11_in[3], 
	io48_c_cdata_pb20_in[0], io48_c_cdata_pb20_in[1], io48_c_cdata_pb20_in[2], io48_c_cdata_pb20_in[3], 
	io48_c_cdata_pb21_in[0], io48_c_cdata_pb21_in[1], io48_c_cdata_pb21_in[2], io48_c_cdata_pb21_in[3], 
	io48_c_cdata_pb22_in[0], io48_c_cdata_pb22_in[1], io48_c_cdata_pb22_in[2], io48_c_cdata_pb22_in[3], 
	io48_c_cdata_pb23_in[0], io48_c_cdata_pb23_in[1], io48_c_cdata_pb23_in[2], io48_c_cdata_pb23_in[3], 
	io48_c_cdata_pb32_in[0], io48_c_cdata_pb32_in[1], io48_c_cdata_pb32_in[2], io48_c_cdata_pb32_in[3], 
	io48_c_cdata_pb33_in[0], io48_c_cdata_pb33_in[1], io48_c_cdata_pb33_in[2], io48_c_cdata_pb33_in[3], 
	io48_c_cdata_pb34_in[0], io48_c_cdata_pb34_in[1], io48_c_cdata_pb34_in[2], io48_c_cdata_pb34_in[3], 
	io48_c_cdata_pb35_in[0], io48_c_cdata_pb35_in[1], io48_c_cdata_pb35_in[2], io48_c_cdata_pb35_in[3], 
	io48_c_cdata_pb44_in[0], io48_c_cdata_pb44_in[1], io48_c_cdata_pb44_in[2], io48_c_cdata_pb44_in[3], 
	io48_c_cdata_pb45_in[0], io48_c_cdata_pb45_in[1], io48_c_cdata_pb45_in[2], io48_c_cdata_pb45_in[3], 
	io48_c_cdata_pb46_in[0], io48_c_cdata_pb46_in[1], io48_c_cdata_pb46_in[2], io48_c_cdata_pb46_in[3], 
	io48_c_cdata_pb47_in[0], io48_c_cdata_pb47_in[1], io48_c_cdata_pb47_in[2], io48_c_cdata_pb47_in[3]} = cdata_upper;

assign {io48_b_dbc2core_wb_pointer_pl0[0], io48_b_dbc2core_wb_pointer_pl0[1], io48_b_dbc2core_wb_pointer_pl0[2], io48_b_dbc2core_wb_pointer_pl0[3], io48_b_dbc2core_wb_pointer_pl0[4], io48_b_dbc2core_wb_pointer_pl0[5], io48_c_dbc2core_wb_pointer_pl0[0], io48_c_dbc2core_wb_pointer_pl0[1], io48_c_dbc2core_wb_pointer_pl0[2], io48_c_dbc2core_wb_pointer_pl0[3], io48_c_dbc2core_wb_pointer_pl0[4], io48_c_dbc2core_wb_pointer_pl0[5], io48_b_dbc2core_wb_pointer_pl1[0], io48_b_dbc2core_wb_pointer_pl1[1], io48_b_dbc2core_wb_pointer_pl1[2], io48_b_dbc2core_wb_pointer_pl1[3], io48_b_dbc2core_wb_pointer_pl1[4], io48_b_dbc2core_wb_pointer_pl1[5], io48_c_dbc2core_wb_pointer_pl1[0], io48_c_dbc2core_wb_pointer_pl1[1], io48_c_dbc2core_wb_pointer_pl1[2], io48_c_dbc2core_wb_pointer_pl1[3], io48_c_dbc2core_wb_pointer_pl1[4], io48_c_dbc2core_wb_pointer_pl1[5], io48_b_dbc2core_wb_pointer_pl2[0], io48_b_dbc2core_wb_pointer_pl2[1], io48_b_dbc2core_wb_pointer_pl2[2], io48_b_dbc2core_wb_pointer_pl2[3], io48_b_dbc2core_wb_pointer_pl2[4], io48_b_dbc2core_wb_pointer_pl2[5], io48_c_dbc2core_wb_pointer_pl2[0], io48_c_dbc2core_wb_pointer_pl2[1], io48_c_dbc2core_wb_pointer_pl2[2], io48_c_dbc2core_wb_pointer_pl2[3], io48_c_dbc2core_wb_pointer_pl2[4], io48_c_dbc2core_wb_pointer_pl2[5], io48_a_dbc2core_wb_pointer_pl3[0], io48_a_dbc2core_wb_pointer_pl3[1], io48_a_dbc2core_wb_pointer_pl3[2], io48_a_dbc2core_wb_pointer_pl3[3], io48_a_dbc2core_wb_pointer_pl3[4], io48_a_dbc2core_wb_pointer_pl3[5], io48_b_dbc2core_wb_pointer_pl3[0], io48_b_dbc2core_wb_pointer_pl3[1], io48_b_dbc2core_wb_pointer_pl3[2], io48_b_dbc2core_wb_pointer_pl3[3], io48_b_dbc2core_wb_pointer_pl3[4], io48_b_dbc2core_wb_pointer_pl3[5], io48_c_dbc2core_wb_pointer_pl3[0], io48_c_dbc2core_wb_pointer_pl3[1], io48_c_dbc2core_wb_pointer_pl3[2], io48_c_dbc2core_wb_pointer_pl3[3], io48_c_dbc2core_wb_pointer_pl3[4], io48_c_dbc2core_wb_pointer_pl3[5]} = dbc2core_wb_pointer_pl;
assign {io48_a_clk_out_hps, io48_b_clk_out_hps, io48_c_clk_out_hps} = clk_out_hps;
assign global_reset_n = {io48_a_global_reset_n, io48_b_global_reset_n, io48_c_global_reset_n};
assign {io48_b_dbc2core_rd_type_pl[0], io48_b_dbc2core_rd_type_pl[1], io48_b_dbc2core_rd_type_pl[2], io48_b_dbc2core_rd_type_pl[3], io48_c_dbc2core_rd_type_pl[0], io48_c_dbc2core_rd_type_pl[1], io48_c_dbc2core_rd_type_pl[2], io48_c_dbc2core_rd_type_pl[3], io48_a_dbc2core_rd_type_pl3} = dbc2core_rd_type_pl;
assign {io48_b_dbc2core_rd_data_vld0_pl[0], io48_b_dbc2core_rd_data_vld0_pl[1], io48_b_dbc2core_rd_data_vld0_pl[2], io48_b_dbc2core_rd_data_vld0_pl[3], io48_c_dbc2core_rd_data_vld0_pl[0], io48_c_dbc2core_rd_data_vld0_pl[1], io48_c_dbc2core_rd_data_vld0_pl[2], io48_c_dbc2core_rd_data_vld0_pl[3], io48_a_dbc2core_rd_data_vld0_pl3} = dbc2core_rd_data_vld0_pl;
assign core2dbc_wr_ecc_info_pl = {io48_b_core2dbc_wr_ecc_info_pl0[0], io48_b_core2dbc_wr_ecc_info_pl0[1], io48_b_core2dbc_wr_ecc_info_pl0[2], io48_b_core2dbc_wr_ecc_info_pl0[3], io48_b_core2dbc_wr_ecc_info_pl0[4], io48_b_core2dbc_wr_ecc_info_pl0[5], io48_b_core2dbc_wr_ecc_info_pl0[6], io48_c_core2dbc_wr_ecc_info_pl0[0], io48_c_core2dbc_wr_ecc_info_pl0[1], io48_c_core2dbc_wr_ecc_info_pl0[2], io48_c_core2dbc_wr_ecc_info_pl0[3], io48_c_core2dbc_wr_ecc_info_pl0[4], io48_c_core2dbc_wr_ecc_info_pl0[5], io48_c_core2dbc_wr_ecc_info_pl0[6], io48_b_core2dbc_wr_ecc_info_pl1[0], io48_b_core2dbc_wr_ecc_info_pl1[1], io48_b_core2dbc_wr_ecc_info_pl1[2], io48_b_core2dbc_wr_ecc_info_pl1[3], io48_b_core2dbc_wr_ecc_info_pl1[4], io48_b_core2dbc_wr_ecc_info_pl1[5], io48_b_core2dbc_wr_ecc_info_pl1[6], io48_c_core2dbc_wr_ecc_info_pl1[0], io48_c_core2dbc_wr_ecc_info_pl1[1], io48_c_core2dbc_wr_ecc_info_pl1[2], io48_c_core2dbc_wr_ecc_info_pl1[3], io48_c_core2dbc_wr_ecc_info_pl1[4], io48_c_core2dbc_wr_ecc_info_pl1[5], io48_c_core2dbc_wr_ecc_info_pl1[6], io48_b_core2dbc_wr_ecc_info_pl2[0], io48_b_core2dbc_wr_ecc_info_pl2[1], io48_b_core2dbc_wr_ecc_info_pl2[2], io48_b_core2dbc_wr_ecc_info_pl2[3], io48_b_core2dbc_wr_ecc_info_pl2[4], io48_b_core2dbc_wr_ecc_info_pl2[5], io48_b_core2dbc_wr_ecc_info_pl2[6], io48_c_core2dbc_wr_ecc_info_pl2[0], io48_c_core2dbc_wr_ecc_info_pl2[1], io48_c_core2dbc_wr_ecc_info_pl2[2], io48_c_core2dbc_wr_ecc_info_pl2[3], io48_c_core2dbc_wr_ecc_info_pl2[4], io48_c_core2dbc_wr_ecc_info_pl2[5], io48_c_core2dbc_wr_ecc_info_pl2[6], io48_a_core2dbc_wr_ecc_info_pl3[0], io48_a_core2dbc_wr_ecc_info_pl3[1], io48_a_core2dbc_wr_ecc_info_pl3[2], io48_a_core2dbc_wr_ecc_info_pl3[3], io48_a_core2dbc_wr_ecc_info_pl3[4], io48_a_core2dbc_wr_ecc_info_pl3[5], io48_a_core2dbc_wr_ecc_info_pl3[6], io48_b_core2dbc_wr_ecc_info_pl3[0], io48_b_core2dbc_wr_ecc_info_pl3[1], io48_b_core2dbc_wr_ecc_info_pl3[2], io48_b_core2dbc_wr_ecc_info_pl3[3], io48_b_core2dbc_wr_ecc_info_pl3[4], io48_b_core2dbc_wr_ecc_info_pl3[5], io48_b_core2dbc_wr_ecc_info_pl3[6], io48_c_core2dbc_wr_ecc_info_pl3[0], io48_c_core2dbc_wr_ecc_info_pl3[1], io48_c_core2dbc_wr_ecc_info_pl3[2], io48_c_core2dbc_wr_ecc_info_pl3[3], io48_c_core2dbc_wr_ecc_info_pl3[4], io48_c_core2dbc_wr_ecc_info_pl3[5], io48_c_core2dbc_wr_ecc_info_pl3[6]};
assign core2dbc_wr_data_vld0_pl = {io48_b_core2dbc_wr_data_vld0_pl[0], io48_b_core2dbc_wr_data_vld0_pl[1], io48_b_core2dbc_wr_data_vld0_pl[2], io48_b_core2dbc_wr_data_vld0_pl[3], io48_c_core2dbc_wr_data_vld0_pl[0], io48_c_core2dbc_wr_data_vld0_pl[1], io48_c_core2dbc_wr_data_vld0_pl[2], io48_c_core2dbc_wr_data_vld0_pl[3], io48_a_core2dbc_wr_data_vld0_pl3};
assign core2dbc_rd_data_rdy_pl = {io48_b_core2dbc_rd_data_rdy_pl[0], io48_b_core2dbc_rd_data_rdy_pl[1], io48_b_core2dbc_rd_data_rdy_pl[2], io48_b_core2dbc_rd_data_rdy_pl[3], io48_c_core2dbc_rd_data_rdy_pl[0], io48_c_core2dbc_rd_data_rdy_pl[1], io48_c_core2dbc_rd_data_rdy_pl[2], io48_c_core2dbc_rd_data_rdy_pl[3], io48_a_core2dbc_rd_data_rdy_pl3};
assign {io48_b_dbc2core_wr_data_rdy_pl[0], io48_b_dbc2core_wr_data_rdy_pl[1], io48_b_dbc2core_wr_data_rdy_pl[2], io48_b_dbc2core_wr_data_rdy_pl[3], io48_c_dbc2core_wr_data_rdy_pl[0], io48_c_dbc2core_wr_data_rdy_pl[1], io48_c_dbc2core_wr_data_rdy_pl[2], io48_c_dbc2core_wr_data_rdy_pl[3], io48_a_dbc2core_wr_data_rdy_pl3} = dbc2core_wr_data_rdy_pl;
assign fb_clk_hps = {io48_a_fb_clk_hps, io48_b_fb_clk_hps, io48_c_fb_clk_hps};






twentynm_hps_interface_ddr refatom(
	.io48_a_afi_cal_success(io48_a_afi_cal_success),
	.io48_a_clk_out_hps(io48_a_clk_out_hps),
	.io48_a_ctl2core_cmd_ready0(io48_a_ctl2core_cmd_ready0),
	.io48_a_dbc2core_rd_data_vld0_pl3(io48_a_dbc2core_rd_data_vld0_pl3),
	.io48_a_dbc2core_rd_type_pl3(io48_a_dbc2core_rd_type_pl3),
	.io48_a_dbc2core_wr_data_rdy_pl3(io48_a_dbc2core_wr_data_rdy_pl3),
	.io48_a_mmr_rdata_valid(io48_a_mmr_rdata_valid),
	.io48_a_mmr_waitrequest(io48_a_mmr_waitrequest),
	.io48_a_pll_locked(io48_a_pll_locked),
	.io48_b_clk_out_hps(io48_b_clk_out_hps),
	.io48_c_clk_out_hps(io48_c_clk_out_hps),
	.io48_a_afi_seq2core(io48_a_afi_seq2core),
	.io48_a_cdata_pb36_in(io48_a_cdata_pb36_in),
	.io48_a_cdata_pb37_in(io48_a_cdata_pb37_in),
	.io48_a_cdata_pb38_in(io48_a_cdata_pb38_in),
	.io48_a_cdata_pb39_in(io48_a_cdata_pb39_in),
	.io48_a_cdata_pb40_in(io48_a_cdata_pb40_in),
	.io48_a_cdata_pb41_in(io48_a_cdata_pb41_in),
	.io48_a_cdata_pb42_in(io48_a_cdata_pb42_in),
	.io48_a_cdata_pb43_in(io48_a_cdata_pb43_in),
	.io48_a_cdata_pb44_in(io48_a_cdata_pb44_in),
	.io48_a_cdata_pb45_in(io48_a_cdata_pb45_in),
	.io48_a_cdata_pb46_in(io48_a_cdata_pb46_in),
	.io48_a_cdata_pb47_in(io48_a_cdata_pb47_in),
	.io48_a_ctl2core_cmd_ecc_info(io48_a_ctl2core_cmd_ecc_info),
	.io48_a_ctl2core_rd_ecc_info(io48_a_ctl2core_rd_ecc_info),
	.io48_a_ctl2core_rdata_id(io48_a_ctl2core_rdata_id),
	.io48_a_dbc2core_wb_pointer_pl3(io48_a_dbc2core_wb_pointer_pl3),
	.io48_a_mmr_rdata(io48_a_mmr_rdata),
	.io48_b_cdata_pb0_in(io48_b_cdata_pb0_in),
	.io48_b_cdata_pb10_in(io48_b_cdata_pb10_in),
	.io48_b_cdata_pb11_in(io48_b_cdata_pb11_in),
	.io48_b_cdata_pb12_in(io48_b_cdata_pb12_in),
	.io48_b_cdata_pb13_in(io48_b_cdata_pb13_in),
	.io48_b_cdata_pb14_in(io48_b_cdata_pb14_in),
	.io48_b_cdata_pb15_in(io48_b_cdata_pb15_in),
	.io48_b_cdata_pb16_in(io48_b_cdata_pb16_in),
	.io48_b_cdata_pb17_in(io48_b_cdata_pb17_in),
	.io48_b_cdata_pb18_in(io48_b_cdata_pb18_in),
	.io48_b_cdata_pb19_in(io48_b_cdata_pb19_in),
	.io48_b_cdata_pb1_in(io48_b_cdata_pb1_in),
	.io48_b_cdata_pb20_in(io48_b_cdata_pb20_in),
	.io48_b_cdata_pb21_in(io48_b_cdata_pb21_in),
	.io48_b_cdata_pb22_in(io48_b_cdata_pb22_in),
	.io48_b_cdata_pb23_in(io48_b_cdata_pb23_in),
	.io48_b_cdata_pb24_in(io48_b_cdata_pb24_in),
	.io48_b_cdata_pb25_in(io48_b_cdata_pb25_in),
	.io48_b_cdata_pb26_in(io48_b_cdata_pb26_in),
	.io48_b_cdata_pb27_in(io48_b_cdata_pb27_in),
	.io48_b_cdata_pb28_in(io48_b_cdata_pb28_in),
	.io48_b_cdata_pb29_in(io48_b_cdata_pb29_in),
	.io48_b_cdata_pb2_in(io48_b_cdata_pb2_in),
	.io48_b_cdata_pb30_in(io48_b_cdata_pb30_in),
	.io48_b_cdata_pb31_in(io48_b_cdata_pb31_in),
	.io48_b_cdata_pb32_in(io48_b_cdata_pb32_in),
	.io48_b_cdata_pb33_in(io48_b_cdata_pb33_in),
	.io48_b_cdata_pb34_in(io48_b_cdata_pb34_in),
	.io48_b_cdata_pb35_in(io48_b_cdata_pb35_in),
	.io48_b_cdata_pb36_in(io48_b_cdata_pb36_in),
	.io48_b_cdata_pb37_in(io48_b_cdata_pb37_in),
	.io48_b_cdata_pb38_in(io48_b_cdata_pb38_in),
	.io48_b_cdata_pb39_in(io48_b_cdata_pb39_in),
	.io48_b_cdata_pb3_in(io48_b_cdata_pb3_in),
	.io48_b_cdata_pb40_in(io48_b_cdata_pb40_in),
	.io48_b_cdata_pb41_in(io48_b_cdata_pb41_in),
	.io48_b_cdata_pb42_in(io48_b_cdata_pb42_in),
	.io48_b_cdata_pb43_in(io48_b_cdata_pb43_in),
	.io48_b_cdata_pb44_in(io48_b_cdata_pb44_in),
	.io48_b_cdata_pb45_in(io48_b_cdata_pb45_in),
	.io48_b_cdata_pb46_in(io48_b_cdata_pb46_in),
	.io48_b_cdata_pb47_in(io48_b_cdata_pb47_in),
	.io48_b_cdata_pb4_in(io48_b_cdata_pb4_in),
	.io48_b_cdata_pb5_in(io48_b_cdata_pb5_in),
	.io48_b_cdata_pb6_in(io48_b_cdata_pb6_in),
	.io48_b_cdata_pb7_in(io48_b_cdata_pb7_in),
	.io48_b_cdata_pb8_in(io48_b_cdata_pb8_in),
	.io48_b_cdata_pb9_in(io48_b_cdata_pb9_in),
	.io48_b_dbc2core_rd_data_vld0_pl(io48_b_dbc2core_rd_data_vld0_pl),
	.io48_b_dbc2core_rd_type_pl(io48_b_dbc2core_rd_type_pl),
	.io48_b_dbc2core_wb_pointer_pl0(io48_b_dbc2core_wb_pointer_pl0),
	.io48_b_dbc2core_wb_pointer_pl1(io48_b_dbc2core_wb_pointer_pl1),
	.io48_b_dbc2core_wb_pointer_pl2(io48_b_dbc2core_wb_pointer_pl2),
	.io48_b_dbc2core_wb_pointer_pl3(io48_b_dbc2core_wb_pointer_pl3),
	.io48_b_dbc2core_wr_data_rdy_pl(io48_b_dbc2core_wr_data_rdy_pl),
	.io48_c_cdata_pb0_in(io48_c_cdata_pb0_in),
	.io48_c_cdata_pb10_in(io48_c_cdata_pb10_in),
	.io48_c_cdata_pb11_in(io48_c_cdata_pb11_in),
	.io48_c_cdata_pb12_in(io48_c_cdata_pb12_in),
	.io48_c_cdata_pb13_in(io48_c_cdata_pb13_in),
	.io48_c_cdata_pb14_in(io48_c_cdata_pb14_in),
	.io48_c_cdata_pb15_in(io48_c_cdata_pb15_in),
	.io48_c_cdata_pb16_in(io48_c_cdata_pb16_in),
	.io48_c_cdata_pb17_in(io48_c_cdata_pb17_in),
	.io48_c_cdata_pb18_in(io48_c_cdata_pb18_in),
	.io48_c_cdata_pb19_in(io48_c_cdata_pb19_in),
	.io48_c_cdata_pb1_in(io48_c_cdata_pb1_in),
	.io48_c_cdata_pb20_in(io48_c_cdata_pb20_in),
	.io48_c_cdata_pb21_in(io48_c_cdata_pb21_in),
	.io48_c_cdata_pb22_in(io48_c_cdata_pb22_in),
	.io48_c_cdata_pb23_in(io48_c_cdata_pb23_in),
	.io48_c_cdata_pb24_in(io48_c_cdata_pb24_in),
	.io48_c_cdata_pb25_in(io48_c_cdata_pb25_in),
	.io48_c_cdata_pb26_in(io48_c_cdata_pb26_in),
	.io48_c_cdata_pb27_in(io48_c_cdata_pb27_in),
	.io48_c_cdata_pb28_in(io48_c_cdata_pb28_in),
	.io48_c_cdata_pb29_in(io48_c_cdata_pb29_in),
	.io48_c_cdata_pb2_in(io48_c_cdata_pb2_in),
	.io48_c_cdata_pb30_in(io48_c_cdata_pb30_in),
	.io48_c_cdata_pb31_in(io48_c_cdata_pb31_in),
	.io48_c_cdata_pb32_in(io48_c_cdata_pb32_in),
	.io48_c_cdata_pb33_in(io48_c_cdata_pb33_in),
	.io48_c_cdata_pb34_in(io48_c_cdata_pb34_in),
	.io48_c_cdata_pb35_in(io48_c_cdata_pb35_in),
	.io48_c_cdata_pb36_in(io48_c_cdata_pb36_in),
	.io48_c_cdata_pb37_in(io48_c_cdata_pb37_in),
	.io48_c_cdata_pb38_in(io48_c_cdata_pb38_in),
	.io48_c_cdata_pb39_in(io48_c_cdata_pb39_in),
	.io48_c_cdata_pb3_in(io48_c_cdata_pb3_in),
	.io48_c_cdata_pb40_in(io48_c_cdata_pb40_in),
	.io48_c_cdata_pb41_in(io48_c_cdata_pb41_in),
	.io48_c_cdata_pb42_in(io48_c_cdata_pb42_in),
	.io48_c_cdata_pb43_in(io48_c_cdata_pb43_in),
	.io48_c_cdata_pb44_in(io48_c_cdata_pb44_in),
	.io48_c_cdata_pb45_in(io48_c_cdata_pb45_in),
	.io48_c_cdata_pb46_in(io48_c_cdata_pb46_in),
	.io48_c_cdata_pb47_in(io48_c_cdata_pb47_in),
	.io48_c_cdata_pb4_in(io48_c_cdata_pb4_in),
	.io48_c_cdata_pb5_in(io48_c_cdata_pb5_in),
	.io48_c_cdata_pb6_in(io48_c_cdata_pb6_in),
	.io48_c_cdata_pb7_in(io48_c_cdata_pb7_in),
	.io48_c_cdata_pb8_in(io48_c_cdata_pb8_in),
	.io48_c_cdata_pb9_in(io48_c_cdata_pb9_in),
	.io48_c_dbc2core_rd_data_vld0_pl(io48_c_dbc2core_rd_data_vld0_pl),
	.io48_c_dbc2core_rd_type_pl(io48_c_dbc2core_rd_type_pl),
	.io48_c_dbc2core_wb_pointer_pl0(io48_c_dbc2core_wb_pointer_pl0),
	.io48_c_dbc2core_wb_pointer_pl1(io48_c_dbc2core_wb_pointer_pl1),
	.io48_c_dbc2core_wb_pointer_pl2(io48_c_dbc2core_wb_pointer_pl2),
	.io48_c_dbc2core_wb_pointer_pl3(io48_c_dbc2core_wb_pointer_pl3),
	.io48_c_dbc2core_wr_data_rdy_pl(io48_c_dbc2core_wr_data_rdy_pl),
	.io48_a_core2ctl_cmd_valid0(io48_a_core2ctl_cmd_valid0),
	.io48_a_core2ctl_rd_data_ready0(io48_a_core2ctl_rd_data_ready0),
	.io48_a_core2ctl_wr_data_valid0(io48_a_core2ctl_wr_data_valid0),
	.io48_a_core2dbc_rd_data_rdy_pl3(io48_a_core2dbc_rd_data_rdy_pl3),
	.io48_a_core2dbc_wr_data_vld0_pl3(io48_a_core2dbc_wr_data_vld0_pl3),
	.io48_a_fb_clk_hps(io48_a_fb_clk_hps),
	.io48_a_global_reset_n(io48_a_global_reset_n),
	.io48_a_mmr_beginbursttransfer(io48_a_mmr_beginbursttransfer),
	.io48_a_mmr_read(io48_a_mmr_read),
	.io48_a_mmr_write(io48_a_mmr_write),
	.io48_a_ref_clkin_hps(io48_a_ref_clkin_hps),
	.io48_b_fb_clk_hps(io48_b_fb_clk_hps),
	.io48_b_global_reset_n(io48_b_global_reset_n),
	.io48_c_fb_clk_hps(io48_c_fb_clk_hps),
	.io48_c_global_reset_n(io48_c_global_reset_n),
	.io48_a_afi_core2seq(io48_a_afi_core2seq),
	.io48_a_core2ctl_cmd_data0(io48_a_core2ctl_cmd_data0),
	.io48_a_core2ctl_wr_ecc_info(io48_a_core2ctl_wr_ecc_info),
	.io48_a_core2dbc_wr_ecc_info_pl3(io48_a_core2dbc_wr_ecc_info_pl3),
	.io48_a_iod_pb36_out(io48_a_iod_pb36_out),
	.io48_a_iod_pb37_out(io48_a_iod_pb37_out),
	.io48_a_iod_pb38_out(io48_a_iod_pb38_out),
	.io48_a_iod_pb39_out(io48_a_iod_pb39_out),
	.io48_a_iod_pb40_out(io48_a_iod_pb40_out),
	.io48_a_iod_pb41_out(io48_a_iod_pb41_out),
	.io48_a_iod_pb42_out(io48_a_iod_pb42_out),
	.io48_a_iod_pb43_out(io48_a_iod_pb43_out),
	.io48_a_iod_pb44_out(io48_a_iod_pb44_out),
	.io48_a_iod_pb45_out(io48_a_iod_pb45_out),
	.io48_a_iod_pb46_out(io48_a_iod_pb46_out),
	.io48_a_iod_pb47_out(io48_a_iod_pb47_out),
	.io48_a_mmr_addr(io48_a_mmr_addr),
	.io48_a_mmr_be(io48_a_mmr_be),
	.io48_a_mmr_burst_count(io48_a_mmr_burst_count),
	.io48_a_mmr_wdata(io48_a_mmr_wdata),
	.io48_b_core2dbc_rd_data_rdy_pl(io48_b_core2dbc_rd_data_rdy_pl),
	.io48_b_core2dbc_wr_data_vld0_pl(io48_b_core2dbc_wr_data_vld0_pl),
	.io48_b_core2dbc_wr_ecc_info_pl0(io48_b_core2dbc_wr_ecc_info_pl0),
	.io48_b_core2dbc_wr_ecc_info_pl1(io48_b_core2dbc_wr_ecc_info_pl1),
	.io48_b_core2dbc_wr_ecc_info_pl2(io48_b_core2dbc_wr_ecc_info_pl2),
	.io48_b_core2dbc_wr_ecc_info_pl3(io48_b_core2dbc_wr_ecc_info_pl3),
	.io48_b_iod_pb0_out(io48_b_iod_pb0_out),
	.io48_b_iod_pb10_out(io48_b_iod_pb10_out),
	.io48_b_iod_pb11_out(io48_b_iod_pb11_out),
	.io48_b_iod_pb12_out(io48_b_iod_pb12_out),
	.io48_b_iod_pb13_out(io48_b_iod_pb13_out),
	.io48_b_iod_pb14_out(io48_b_iod_pb14_out),
	.io48_b_iod_pb15_out(io48_b_iod_pb15_out),
	.io48_b_iod_pb16_out(io48_b_iod_pb16_out),
	.io48_b_iod_pb17_out(io48_b_iod_pb17_out),
	.io48_b_iod_pb18_out(io48_b_iod_pb18_out),
	.io48_b_iod_pb19_out(io48_b_iod_pb19_out),
	.io48_b_iod_pb1_out(io48_b_iod_pb1_out),
	.io48_b_iod_pb20_out(io48_b_iod_pb20_out),
	.io48_b_iod_pb21_out(io48_b_iod_pb21_out),
	.io48_b_iod_pb22_out(io48_b_iod_pb22_out),
	.io48_b_iod_pb23_out(io48_b_iod_pb23_out),
	.io48_b_iod_pb24_out(io48_b_iod_pb24_out),
	.io48_b_iod_pb25_out(io48_b_iod_pb25_out),
	.io48_b_iod_pb26_out(io48_b_iod_pb26_out),
	.io48_b_iod_pb27_out(io48_b_iod_pb27_out),
	.io48_b_iod_pb28_out(io48_b_iod_pb28_out),
	.io48_b_iod_pb29_out(io48_b_iod_pb29_out),
	.io48_b_iod_pb2_out(io48_b_iod_pb2_out),
	.io48_b_iod_pb30_out(io48_b_iod_pb30_out),
	.io48_b_iod_pb31_out(io48_b_iod_pb31_out),
	.io48_b_iod_pb32_out(io48_b_iod_pb32_out),
	.io48_b_iod_pb33_out(io48_b_iod_pb33_out),
	.io48_b_iod_pb34_out(io48_b_iod_pb34_out),
	.io48_b_iod_pb35_out(io48_b_iod_pb35_out),
	.io48_b_iod_pb36_out(io48_b_iod_pb36_out),
	.io48_b_iod_pb37_out(io48_b_iod_pb37_out),
	.io48_b_iod_pb38_out(io48_b_iod_pb38_out),
	.io48_b_iod_pb39_out(io48_b_iod_pb39_out),
	.io48_b_iod_pb3_out(io48_b_iod_pb3_out),
	.io48_b_iod_pb40_out(io48_b_iod_pb40_out),
	.io48_b_iod_pb41_out(io48_b_iod_pb41_out),
	.io48_b_iod_pb42_out(io48_b_iod_pb42_out),
	.io48_b_iod_pb43_out(io48_b_iod_pb43_out),
	.io48_b_iod_pb44_out(io48_b_iod_pb44_out),
	.io48_b_iod_pb45_out(io48_b_iod_pb45_out),
	.io48_b_iod_pb46_out(io48_b_iod_pb46_out),
	.io48_b_iod_pb47_out(io48_b_iod_pb47_out),
	.io48_b_iod_pb4_out(io48_b_iod_pb4_out),
	.io48_b_iod_pb5_out(io48_b_iod_pb5_out),
	.io48_b_iod_pb6_out(io48_b_iod_pb6_out),
	.io48_b_iod_pb7_out(io48_b_iod_pb7_out),
	.io48_b_iod_pb8_out(io48_b_iod_pb8_out),
	.io48_b_iod_pb9_out(io48_b_iod_pb9_out),
	.io48_c_core2dbc_rd_data_rdy_pl(io48_c_core2dbc_rd_data_rdy_pl),
	.io48_c_core2dbc_wr_data_vld0_pl(io48_c_core2dbc_wr_data_vld0_pl),
	.io48_c_core2dbc_wr_ecc_info_pl0(io48_c_core2dbc_wr_ecc_info_pl0),
	.io48_c_core2dbc_wr_ecc_info_pl1(io48_c_core2dbc_wr_ecc_info_pl1),
	.io48_c_core2dbc_wr_ecc_info_pl2(io48_c_core2dbc_wr_ecc_info_pl2),
	.io48_c_core2dbc_wr_ecc_info_pl3(io48_c_core2dbc_wr_ecc_info_pl3),
	.io48_c_iod_pb0_out(io48_c_iod_pb0_out),
	.io48_c_iod_pb10_out(io48_c_iod_pb10_out),
	.io48_c_iod_pb11_out(io48_c_iod_pb11_out),
	.io48_c_iod_pb12_out(io48_c_iod_pb12_out),
	.io48_c_iod_pb13_out(io48_c_iod_pb13_out),
	.io48_c_iod_pb14_out(io48_c_iod_pb14_out),
	.io48_c_iod_pb15_out(io48_c_iod_pb15_out),
	.io48_c_iod_pb16_out(io48_c_iod_pb16_out),
	.io48_c_iod_pb17_out(io48_c_iod_pb17_out),
	.io48_c_iod_pb18_out(io48_c_iod_pb18_out),
	.io48_c_iod_pb19_out(io48_c_iod_pb19_out),
	.io48_c_iod_pb1_out(io48_c_iod_pb1_out),
	.io48_c_iod_pb20_out(io48_c_iod_pb20_out),
	.io48_c_iod_pb21_out(io48_c_iod_pb21_out),
	.io48_c_iod_pb22_out(io48_c_iod_pb22_out),
	.io48_c_iod_pb23_out(io48_c_iod_pb23_out),
	.io48_c_iod_pb24_out(io48_c_iod_pb24_out),
	.io48_c_iod_pb25_out(io48_c_iod_pb25_out),
	.io48_c_iod_pb26_out(io48_c_iod_pb26_out),
	.io48_c_iod_pb27_out(io48_c_iod_pb27_out),
	.io48_c_iod_pb28_out(io48_c_iod_pb28_out),
	.io48_c_iod_pb29_out(io48_c_iod_pb29_out),
	.io48_c_iod_pb2_out(io48_c_iod_pb2_out),
	.io48_c_iod_pb30_out(io48_c_iod_pb30_out),
	.io48_c_iod_pb31_out(io48_c_iod_pb31_out),
	.io48_c_iod_pb32_out(io48_c_iod_pb32_out),
	.io48_c_iod_pb33_out(io48_c_iod_pb33_out),
	.io48_c_iod_pb34_out(io48_c_iod_pb34_out),
	.io48_c_iod_pb35_out(io48_c_iod_pb35_out),
	.io48_c_iod_pb36_out(io48_c_iod_pb36_out),
	.io48_c_iod_pb37_out(io48_c_iod_pb37_out),
	.io48_c_iod_pb38_out(io48_c_iod_pb38_out),
	.io48_c_iod_pb39_out(io48_c_iod_pb39_out),
	.io48_c_iod_pb3_out(io48_c_iod_pb3_out),
	.io48_c_iod_pb40_out(io48_c_iod_pb40_out),
	.io48_c_iod_pb41_out(io48_c_iod_pb41_out),
	.io48_c_iod_pb42_out(io48_c_iod_pb42_out),
	.io48_c_iod_pb43_out(io48_c_iod_pb43_out),
	.io48_c_iod_pb44_out(io48_c_iod_pb44_out),
	.io48_c_iod_pb45_out(io48_c_iod_pb45_out),
	.io48_c_iod_pb46_out(io48_c_iod_pb46_out),
	.io48_c_iod_pb47_out(io48_c_iod_pb47_out),
	.io48_c_iod_pb4_out(io48_c_iod_pb4_out),
	.io48_c_iod_pb5_out(io48_c_iod_pb5_out),
	.io48_c_iod_pb6_out(io48_c_iod_pb6_out),
	.io48_c_iod_pb7_out(io48_c_iod_pb7_out),
	.io48_c_iod_pb8_out(io48_c_iod_pb8_out),
	.io48_c_iod_pb9_out(io48_c_iod_pb9_out));

endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
// MW Interface declaration
`timescale 1 ps / 1 ps
module a10_hps_emif_interface(

	input  wire [4095:0] emif_to_hps,
	output wire [4095:0] hps_to_emif
);


wire [80:0] data_control_in;
wire [80:0] data_control_out;
	
wire [19:0] command_in;
wire [75:0] command_out;
	
wire [287:0] data_in;
wire [287:0] data_out;

wire [3708:0] nc_in;
wire [3650:0] nc_out;

assign {data_control_in, command_in, data_in, nc_in} = emif_to_hps;

assign hps_to_emif = {data_control_out,command_out,data_out, nc_out };
assign nc_out = nc_in;
hps_emif_interface_to_ddr inst(
	.mmr_addr(),
	.mmr_be(),
	.mmr_beginbursttransfer(),
	.mmr_burst_count(),
	.mmr_rdata({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
	.mmr_rdata_valid(1'b1),
	.mmr_read(),
	.mmr_waitrequest(1'b1),
	.mmr_wdata(),
	.mmr_write(),
	.afi_cal_success(1'b1),
	.core2ctl_cmd_data0(command_out[57:0]),
	.core2ctl_cmd_valid0(command_out[58]),
	.core2ctl_rd_data_ready0(command_out[59]),
	.core2ctl_wr_data_valid0(command_out[60]),
	.core2ctl_wr_ecc_info(command_out[75:61]),
	.ctl2core_cmd_ecc_info(command_in[2:0]),
	.ctl2core_cmd_ready0(command_in[3]),
	.ctl2core_rd_ecc_info(command_in[6:4]),
	.ctl2core_rdata_id(command_in[19:7]),
	.clk_out_hps({1'b1,1'b1,1'b1}),
	.fb_clk_hps(),
	.afi_core2seq(),
	.afi_seq2core({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
	.core2dbc_rd_data_rdy_pl(data_control_out[8:0]),
	.core2dbc_wr_data_vld0_pl(data_control_out[17:9]),
	.core2dbc_wr_ecc_info_pl(data_control_out[80:18]),
	.dbc2core_rd_data_vld0_pl(data_control_in[8:0]),
	.dbc2core_rd_type_pl(data_control_in[17:9]),
	.dbc2core_wb_pointer_pl(data_control_in[71:18]),
	.dbc2core_wr_data_rdy_pl(data_control_in[80:72]),
	.pll_locked(1'b1),
	.cdata_in(data_in),
	.cdata_upper({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
	.ref_clkin_hps(),
	.global_reset_n(),
	.iod_out(data_out),
	.iod_upper()
);

endmodule


//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
`timescale 1 ps / 1 ps
module twentynm_hps_rl_interface_fpga2hps #(
  parameter DWIDTH = 16 , parameter DEPTH=3
)(
	input wire          ar_clk,
	input wire          ar_valid,
	input wire          aw_clk,
	input wire          aw_valid,
	input wire          b_clk,
	input wire          b_ready,
	input wire          clk,
	input wire          port_size_config_0,
	input wire          port_size_config_1,
	input wire          port_size_config_2,
	input wire          port_size_config_3,
	input wire          r_clk,
	input wire          r_ready,
	input wire          w_clk,
	input wire          w_last,
	input wire          w_valid,
	input wire [ 31 : 0] ar_addr,
	input wire [  1 : 0] ar_burst,
	input wire [  3 : 0] ar_cache,
	input wire [  3 : 0] ar_id,
	input wire [  3 : 0] ar_len,
	input wire [  1 : 0] ar_lock,
	input wire [  2 : 0] ar_prot,
	input wire [  2 : 0] ar_size,
	input wire [  4 : 0] ar_user,
	input wire [ 31 : 0] aw_addr,
	input wire [  1 : 0] aw_burst,
	input wire [  3 : 0] aw_cache,
	input wire [  3 : 0] aw_id,
	input wire [  3 : 0] aw_len,
	input wire [  1 : 0] aw_lock,
	input wire [  2 : 0] aw_prot,
	input wire [  2 : 0] aw_size,
	input wire [  4 : 0] aw_user,
	input wire [DWIDTH-1 : 0] w_data,
	input wire [  3 : 0] w_id,
	input wire [ DWIDTH/8-1 : 0] w_strb,
	output wire          ar_ready,
	output wire          aw_ready,
	output wire          b_valid,
	output wire          r_last,
	output wire          r_valid,
	output wire          w_ready,
	output wire [  3 : 0] b_id,
	output wire [  1 : 0] b_resp,
	output wire [DWIDTH-1 : 0] r_data,
	output wire [  3 : 0] r_id,
	output wire [  1 : 0] r_resp,
	input  wire         rst_n
);


wire                     s_ar_ready;
wire                     s_aw_ready;
wire               [3:0] s_b_id;
wire               [1:0] s_b_resp;
wire                     s_b_valid;
wire        [DWIDTH-1:0] s_r_data;
wire               [3:0] s_r_id;
wire                     s_r_last;
wire               [1:0] s_r_resp;
wire                     s_r_valid;
wire                     s_w_ready;
wire             [31:0] s_ar_addr;
wire              [1:0] s_ar_burst;
wire              [3:0] s_ar_cache;
wire              [3:0] s_ar_id;
wire              [3:0] s_ar_len;
wire              [1:0] s_ar_lock;
wire              [2:0] s_ar_prot;
wire              [2:0] s_ar_size;
wire              [4:0] s_ar_user;
wire                    s_ar_valid;
wire             [31:0] s_aw_addr;
wire              [1:0] s_aw_burst;
wire              [3:0] s_aw_cache;
wire              [3:0] s_aw_id;
wire              [3:0] s_aw_len;
wire              [1:0] s_aw_lock;
wire              [2:0] s_aw_prot;
wire              [2:0] s_aw_size;
wire              [4:0] s_aw_user;
wire                    s_aw_valid;
wire                    s_b_ready;
wire                    s_r_ready;
wire       [DWIDTH-1:0] s_w_data;
wire              [3:0] s_w_id;
wire                    s_w_last;
wire     [DWIDTH/8-1:0] s_w_strb;
wire                    s_w_valid;


f2s_rl_adp #( .DWIDTH(DWIDTH) ) f2s_rl_adp_inst (
	.clk( clk ),
	.f_ar_addr( ar_addr ),
	.f_ar_burst( ar_burst ),
	.f_ar_cache( ar_cache ),
	.f_ar_id( ar_id ),
	.f_ar_len( ar_len ),
	.f_ar_lock( ar_lock ),
	.f_ar_prot( ar_prot ),
	.f_ar_size( ar_size ),
	.f_ar_user( ar_user ),
	.f_ar_valid( ar_valid ),
	.f_aw_addr( aw_addr ),
	.f_aw_burst( aw_burst ),
	.f_aw_cache( aw_cache ),
	.f_aw_id( aw_id ),
	.f_aw_len( aw_len ),
	.f_aw_lock( aw_lock ),
	.f_aw_prot( aw_prot ),
	.f_aw_size( aw_size ),
	.f_aw_user( aw_user ),
	.f_aw_valid( aw_valid ),
	.f_b_ready( b_ready ),
	.f_r_ready( r_ready ),
	.f_w_data( w_data ),
	.f_w_id( w_id ),
	.f_w_last( w_last ),
	.f_w_strb( w_strb ),
	.f_w_valid( w_valid ),
	.rst_n( rst_n ),
	.s_ar_ready( s_ar_ready ),
	.s_aw_ready( s_aw_ready ),
	.s_b_id( s_b_id ),
	.s_b_resp( s_b_resp ),
	.s_b_valid( s_b_valid ),
	.s_r_data( s_r_data ),
	.s_r_id( s_r_id ),
	.s_r_last( s_r_last ),
	.s_r_resp( s_r_resp ),
	.s_r_valid( s_r_valid ),
	.s_ready_latency( port_size_config_3 ),
	.s_w_ready( s_w_ready ),
	.f_ar_ready( ar_ready ),
	.f_aw_ready( aw_ready ),
	.f_b_id( b_id ),
	.f_b_resp( b_resp ),
	.f_b_valid( b_valid ),
	.f_r_data( r_data ),
	.f_r_id( r_id ),
	.f_r_last( r_last ),
	.f_r_resp( r_resp ),
	.f_r_valid( r_valid ),
	.f_w_ready( w_ready ),
	.s_ar_addr( s_ar_addr ),
	.s_ar_burst( s_ar_burst ),
	.s_ar_cache( s_ar_cache ),
	.s_ar_id( s_ar_id ),
	.s_ar_len( s_ar_len ),
	.s_ar_lock( s_ar_lock ),
	.s_ar_prot( s_ar_prot ),
	.s_ar_size( s_ar_size ),
	.s_ar_user( s_ar_user ),
	.s_ar_valid( s_ar_valid ),
	.s_aw_addr( s_aw_addr ),
	.s_aw_burst( s_aw_burst ),
	.s_aw_cache( s_aw_cache ),
	.s_aw_id( s_aw_id ),
	.s_aw_len( s_aw_len ),
	.s_aw_lock( s_aw_lock ),
	.s_aw_prot( s_aw_prot ),
	.s_aw_size( s_aw_size ),
	.s_aw_user( s_aw_user ),
	.s_aw_valid( s_aw_valid ),
	.s_b_ready( s_b_ready ),
	.s_r_ready( s_r_ready ),
	.s_w_data( s_w_data ),
	.s_w_id( s_w_id ),
	.s_w_last( s_w_last ),
	.s_w_strb( s_w_strb ),
	.s_w_valid( s_w_valid )
);

wire [DWIDTH-1 : 0] d_w_data;
wire [32-1 : 0] d_aw_addr;
wire [32-1 : 0] d_ar_addr;
wire [ 4-1 : 0] d_ar_cache;
wire [ 4-1 : 0] d_ar_id;
wire [ 4-1 : 0] d_ar_len;
wire [ 5-1 : 0] d_ar_user;
wire [ 4-1 : 0] d_aw_cache;
wire [ 4-1 : 0] d_aw_id;
wire [ 4-1 : 0] d_aw_len;
wire [ 5-1 : 0] d_aw_user;
wire [ 4-1 : 0] d_w_id;
generate
if (DWIDTH != 16) begin
    alentar#(.DATA_WIDTH(DWIDTH), .DEPTH(DEPTH)) wdata_alen (s_w_data,  d_w_data);
    alentar#(.DATA_WIDTH(32), .DEPTH(DEPTH))  awaddr_alen   (s_aw_addr, d_aw_addr);
    alentar#(.DATA_WIDTH(32), .DEPTH(DEPTH))  araddr_alen   (s_ar_addr, d_ar_addr);
    alentar#(.DATA_WIDTH( 4), .DEPTH(DEPTH))  ar_cache_alen (s_ar_cache,d_ar_cache);
    alentar#(.DATA_WIDTH( 4), .DEPTH(DEPTH))  ar_id_alen    (s_ar_id,   d_ar_id);
    alentar#(.DATA_WIDTH( 4), .DEPTH(DEPTH))  ar_len_alen   (s_ar_len,  d_ar_len);
    alentar#(.DATA_WIDTH( 5), .DEPTH(DEPTH))  ar_ar_user    (s_ar_user, d_ar_user);
    alentar#(.DATA_WIDTH( 4), .DEPTH(DEPTH))  aw_cache_alen (s_aw_cache,d_aw_cache);
    alentar#(.DATA_WIDTH( 4), .DEPTH(DEPTH))  aw_id_alen    (s_aw_id,   d_aw_id);
    alentar#(.DATA_WIDTH( 4), .DEPTH(DEPTH))  aw_len_alen   (s_aw_len,  d_aw_len);
    alentar#(.DATA_WIDTH( 5), .DEPTH(DEPTH))  aw_ar_user    (s_aw_user, d_aw_user);
    alentar#(.DATA_WIDTH( 4), .DEPTH(DEPTH))  w_id_alen     (s_w_id,    d_w_id);
    parameter WIDTH = DWIDTH;
end
else begin
    assign d_w_data  = s_w_data;   
    assign d_aw_addr = s_aw_addr;  
    assign d_ar_addr = s_ar_addr;  
    assign d_ar_cache= s_ar_cache; 
    assign d_ar_id   = s_ar_id;    
    assign d_ar_len  = s_ar_len;   
    assign d_ar_user = s_ar_user;  
    assign d_aw_cache= s_aw_cache; 
    assign d_aw_id   = s_aw_id;    
    assign d_aw_len  = s_aw_len;   
    assign d_aw_user = s_aw_user;   
    assign d_w_id    = s_w_id;
   parameter WIDTH = 32;
end     
endgenerate
twentynm_hps_interface_fpga2hps fpga2hps_rl(
	.ar_clk(ar_clk),
	.ar_valid(s_ar_valid),
	.aw_clk(aw_clk),
	.aw_valid(s_aw_valid),
	.b_clk(b_clk),
	.b_ready(s_b_ready),
	.clk(clk),
	.port_size_config_0(port_size_config_0),
	.port_size_config_1(port_size_config_1),
	.port_size_config_2(port_size_config_2),
	.port_size_config_3(port_size_config_3),
	.r_clk(r_clk),
	.r_ready(s_r_ready),
	.w_clk(w_clk),
	.w_last(s_w_last),
	.w_valid(s_w_valid),
	.ar_addr(d_ar_addr),
	.ar_burst(s_ar_burst),
	.ar_cache(d_ar_cache),
	.ar_id(d_ar_id),
	.ar_len(d_ar_len),
	.ar_lock(s_ar_lock),
	.ar_prot(s_ar_prot),
	.ar_size(s_ar_size),
	.ar_user(d_ar_user),
	.aw_addr(d_aw_addr),
	.aw_burst(s_aw_burst),
	.aw_cache(d_aw_cache),
	.aw_id(d_aw_id),
	.aw_len(d_aw_len),
	.aw_lock(s_aw_lock),
	.aw_prot(s_aw_prot),
	.aw_size(s_aw_size),
	.aw_user(d_aw_user),
	.w_data(d_w_data),
	.w_id(d_w_id),
	.w_strb(s_w_strb),
	.ar_ready(s_ar_ready),
	.aw_ready(s_aw_ready),
	.b_valid(s_b_valid),
	.r_last(s_r_last),
	.r_valid(s_r_valid),
	.w_ready(s_w_ready),
	.b_id(s_b_id),
	.b_resp(s_b_resp),
	.r_data(s_r_data),
	.r_id(s_r_id),
	.r_resp(s_r_resp));
defparam fpga2hps_rl.data_width = 32;
endmodule



//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
`timescale 1 ps / 1 ps
module twentynm_hps_rl_interface_hps2fpga #(
  parameter DWIDTH = 16, parameter DEPTH=3
)(
	input wire          ar_clk,
	input wire          ar_ready,
	input wire          aw_clk,
	input wire          aw_ready,
	input wire          b_clk,
	input wire          b_valid,
	input wire          clk,
	input wire          port_size_config_0,
	input wire          port_size_config_1,
	input wire          port_size_config_2,
	input wire          port_size_config_3,
	input wire          r_clk,
	input wire          r_last,
	input wire          r_valid,
	input wire          w_clk,
	input wire          w_ready,
	input wire [3 : 0] b_id,
	input wire [1 : 0] b_resp,
	input wire [DWIDTH-1 : 0] r_data,
	input wire [3 : 0] r_id,
	input wire [1 : 0] r_resp,
	output wire          ar_valid,
	output wire          aw_valid,
	output wire          b_ready,
	output wire          r_ready,
	output wire          w_last,
	output wire          w_valid,
	output wire [31 : 0] ar_addr,
	output wire [1 : 0] ar_burst,
	output wire [3 : 0] ar_cache,
	output wire [3 : 0] ar_id,
	output wire [3 : 0] ar_len,
	output wire [1 : 0] ar_lock,
	output wire [2 : 0] ar_prot,
	output wire [2 : 0] ar_size,
	output wire [4 : 0] ar_user,
	output wire [31 : 0] aw_addr,
	output wire [1 : 0] aw_burst,
	output wire [3 : 0] aw_cache,
	output wire [3 : 0] aw_id,
	output wire [3 : 0] aw_len,
	output wire [1 : 0] aw_lock,
	output wire [2 : 0] aw_prot,
	output wire [2 : 0] aw_size,
	output wire [4 : 0] aw_user,
	output wire [DWIDTH-1 : 0] w_data,
	output wire [3 : 0] w_id,
	output wire [DWIDTH/8-1 : 0] w_strb,
	input  wire         rst_n
);
	
wire          s_ar_ready;
wire          s_aw_ready;
wire          s_b_valid;
wire          s_r_last;
wire          s_r_valid;
wire          s_w_ready;
wire [3 : 0] s_b_id;
wire [1 : 0] s_b_resp;
wire [DWIDTH-1 : 0] s_r_data;
wire [3 : 0] s_r_id;
wire [1 : 0] s_r_resp;
wire          s_ar_valid;
wire          s_aw_valid;
wire          s_b_ready;
wire          s_r_ready;
wire          s_w_last;
wire          s_w_valid;
wire [31 : 0] s_ar_addr;
wire [1 : 0] s_ar_burst;
wire [3 : 0] s_ar_cache;
wire [3 : 0] s_ar_id;
wire [3 : 0] s_ar_len;
wire [1 : 0] s_ar_lock;
wire [2 : 0] s_ar_prot;
wire [2 : 0] s_ar_size;
wire [4 : 0] s_ar_user;
wire [31 : 0] s_aw_addr;
wire [1 : 0] s_aw_burst;
wire [3 : 0] s_aw_cache;
wire [3 : 0] s_aw_id;
wire [3 : 0] s_aw_len;
wire [1 : 0] s_aw_lock;
wire [2 : 0] s_aw_prot;
wire [2 : 0] s_aw_size;
wire [4 : 0] s_aw_user;
wire [DWIDTH-1 : 0] s_w_data;
wire [3 : 0] s_w_id;
wire [15 : 0] s_w_strb;
wire reset;

s2f_rl_adp #( .DWIDTH(DWIDTH) ) s2f_rl_adp_ins (
	.clk( clk ),
	.f_ar_ready( ar_ready ),
	.f_aw_ready( aw_ready ),
	.f_b_id( b_id ),
	.f_b_resp( b_resp ),
	.f_b_valid( b_valid ),
	.f_r_data( r_data ),
	.f_r_id( r_id ),
	.f_r_last( r_last ),
	.f_r_resp( r_resp ),
	.f_r_valid( r_valid ),
	.f_w_ready( w_ready ),
	.rst_n( rst_n ),
	.s_ar_addr( s_ar_addr ),
	.s_ar_burst( s_ar_burst ),
	.s_ar_cache( s_ar_cache ),
	.s_ar_id( s_ar_id ),
	.s_ar_len( s_ar_len ),
	.s_ar_lock( s_ar_lock ),
	.s_ar_prot( s_ar_prot ),
	.s_ar_size( s_ar_size ),
	.s_ar_user( s_ar_user ),
	.s_ar_valid( s_ar_valid ),
	.s_aw_addr( s_aw_addr ),
	.s_aw_burst( s_aw_burst ),
	.s_aw_cache( s_aw_cache ),
	.s_aw_id( s_aw_id ),
	.s_aw_len( s_aw_len ),
	.s_aw_lock( s_aw_lock ),
	.s_aw_prot( s_aw_prot ),
	.s_aw_size( s_aw_size ),
	.s_aw_user( s_aw_user ),
	.s_aw_valid( s_aw_valid ),
	.s_b_ready( s_b_ready ),
	.s_r_ready( s_r_ready ),
	.s_ready_latency( port_size_config_3 ),
	.s_w_data( s_w_data ),
	.s_w_id( s_w_id ),
	.s_w_last( s_w_last ),
	.s_w_strb( s_w_strb ),
	.s_w_valid( s_w_valid ),
	.f_ar_addr( ar_addr ),
	.f_ar_burst( ar_burst ),
	.f_ar_cache( ar_cache ),
	.f_ar_id( ar_id ),
	.f_ar_len( ar_len ),
	.f_ar_lock( ar_lock ),
	.f_ar_prot( ar_prot ),
	.f_ar_size( ar_size ),
	.f_ar_user( ar_user ),
	.f_ar_valid( ar_valid ),
	.f_aw_addr( aw_addr ),
	.f_aw_burst( aw_burst ),
	.f_aw_cache( aw_cache ),
	.f_aw_id( aw_id ),
	.f_aw_len( aw_len ),
	.f_aw_lock( aw_lock ),
	.f_aw_prot( aw_prot ),
	.f_aw_size( aw_size ),
	.f_aw_user( aw_user ),
	.f_aw_valid( aw_valid ),
	.f_b_ready( b_ready ),
	.f_r_ready( r_ready ),
	.f_w_data( w_data ),
	.f_w_id( w_id ),
	.f_w_last( w_last ),
	.f_w_strb( w_strb ),
	.f_w_valid( w_valid ),
	.s_ar_ready(s_ar_ready),
	.s_aw_ready( s_aw_ready ),
	.s_b_id( s_b_id ),
	.s_b_resp( s_b_resp ),
	.s_b_valid( s_b_valid ),
	.s_r_data( s_r_data ),
	.s_r_id( s_r_id ),
	.s_r_last( s_r_last ),
	.s_r_resp( s_r_resp ),
	.s_r_valid( s_r_valid ),
	.s_w_ready( s_w_ready )
);

wire [DWIDTH-1 : 0] d_r_data;
wire [4-1 : 0] d_b_id;
wire [4-1 : 0] d_r_id;
generate
if (DWIDTH != 16) begin
    alentar#(.DATA_WIDTH(DWIDTH), .DEPTH(DEPTH)) rdata_alen  (s_r_data,  d_r_data);
    alentar#(.DATA_WIDTH(4), .DEPTH(DEPTH)) b_id_alen  (s_b_id,  d_b_id);
    alentar#(.DATA_WIDTH(4), .DEPTH(DEPTH)) r_id_alen  (s_r_id,  d_r_id);
    parameter WIDTH = DWIDTH;
end
else begin
    assign d_r_data = s_r_data ;
    assign d_b_id   = s_b_id;
    assign d_r_id   = s_r_id;
    parameter WIDTH = 32;
end
endgenerate

twentynm_hps_interface_hps2fpga hps2fpga_rl(
	.ar_clk(ar_clk),
	.ar_ready(s_ar_ready),
	.aw_clk(aw_clk),
	.aw_ready(s_aw_ready),
	.b_clk(b_clk),
	.b_valid(s_b_valid),
	.clk(clk),
	.port_size_config_0(port_size_config_0),
	.port_size_config_1(port_size_config_1),
	.port_size_config_2(port_size_config_2),
	.port_size_config_3(port_size_config_3),
	.r_clk(r_clk),
	.r_last(s_r_last),
	.r_valid(s_r_valid),
	.w_clk(w_clk),
	.w_ready(s_w_ready),
	.b_id(d_b_id),
	.b_resp(s_b_resp),
	.r_data(d_r_data),
	.r_id(d_r_id),
	.r_resp(s_r_resp),
	.ar_valid(s_ar_valid),
	.aw_valid(s_aw_valid),
	.b_ready(s_b_ready),
	.r_ready(s_r_ready),
	.w_last(s_w_last),
	.w_valid(s_w_valid),
	.ar_addr(s_ar_addr),
	.ar_burst(s_ar_burst),
	.ar_cache(s_ar_cache),
	.ar_id(s_ar_id),
	.ar_len(s_ar_len),
	.ar_lock(s_ar_lock),
	.ar_prot(s_ar_prot),
	.ar_size(s_ar_size),
	.ar_user(s_ar_user),
	.aw_addr(s_aw_addr),
	.aw_burst(s_aw_burst),
	.aw_cache(s_aw_cache),
	.aw_id(s_aw_id),
	.aw_len(s_aw_len),
	.aw_lock(s_aw_lock),
	.aw_prot(s_aw_prot),
	.aw_size(s_aw_size),
	.aw_user(s_aw_user),
	.w_data(s_w_data),
	.w_id(s_w_id),
	.w_strb(s_w_strb));
defparam hps2fpga_rl.data_width = 32;


endmodule



//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
`timescale 1 ps / 1 ps

module twentynm_hps_rl_interface_hps2fpga_light_weight#(
  parameter DWIDTH = 16, parameter DEPTH=3
)(
	input wire          ar_clk,
	input wire          ar_ready,
	input wire          aw_clk,
	input wire          aw_ready,
	input wire          b_clk,
	input wire          b_valid,
	input wire          clk,
	input wire          port_size_config_0,
	input wire          port_size_config_1,
	input wire          r_clk,
	input wire          r_last,
	input wire          r_valid,
	input wire          w_clk,
	input wire          w_ready,
	input wire [ 3 : 0] b_id,
	input wire [ 1 : 0] b_resp,
	input wire [31 : 0] r_data,
	input wire [ 3 : 0] r_id,
	input wire [ 1 : 0] r_resp,
	output wire          ar_valid,
	output wire          aw_valid,
	output wire          b_ready,
	output wire          r_ready,
	output wire          w_last,
	output wire          w_valid,
	output wire [31 : 0] ar_addr,
	output wire [1 : 0] ar_burst,
	output wire [3 : 0] ar_cache,
	output wire [3 : 0] ar_id,
	output wire [3 : 0] ar_len,
	output wire [1 : 0] ar_lock,
	output wire [2 : 0] ar_prot,
	output wire [2 : 0] ar_size,
	output wire [4 : 0] ar_user,
	output wire [31 : 0] aw_addr,
	output wire [1 : 0] aw_burst,
	output wire [3 : 0] aw_cache,
	output wire [3 : 0] aw_id,
	output wire [3 : 0] aw_len,
	output wire [1 : 0] aw_lock,
	output wire [2 : 0] aw_prot,
	output wire [2 : 0] aw_size,
	output wire [4 : 0] aw_user,
	output wire [31 : 0] w_data,
	output wire [3 : 0] w_id,
	output wire [3 : 0] w_strb,
	input  wire         rst_n 
);



wire          s_ar_ready;
wire          s_aw_ready;
wire          s_b_valid;
wire          s_r_last;
wire          s_r_valid;
wire          s_w_ready;
wire [3 : 0] s_b_id;
wire [1 : 0] s_b_resp;
wire [DWIDTH-1 : 0] s_r_data;
wire [3 : 0] s_r_id;
wire [1 : 0] s_r_resp;
wire          s_ar_valid;
wire          s_aw_valid;
wire          s_b_ready;
wire          s_r_ready;
wire          s_w_last;
wire          s_w_valid;
wire [31 : 0] s_ar_addr;
wire [1 : 0] s_ar_burst;
wire [3 : 0] s_ar_cache;
wire [3 : 0] s_ar_id;
wire [3 : 0] s_ar_len;
wire [1 : 0] s_ar_lock;
wire [2 : 0] s_ar_prot;
wire [2 : 0] s_ar_size;
wire [4 : 0] s_ar_user;
wire [31 : 0] s_aw_addr;
wire [1 : 0] s_aw_burst;
wire [3 : 0] s_aw_cache;
wire [3 : 0] s_aw_id;
wire [3 : 0] s_aw_len;
wire [1 : 0] s_aw_lock;
wire [2 : 0] s_aw_prot;
wire [2 : 0] s_aw_size;
wire [4 : 0] s_aw_user;
wire [DWIDTH-1 : 0] s_w_data;
wire [3 : 0] s_w_id;
wire [3 : 0] s_w_strb;


s2f_rl_adp #( .DWIDTH(DWIDTH) ) s2f_rl_adp_inst (
	.clk( clk ),
	.f_ar_ready( ar_ready ),
	.f_aw_ready( aw_ready ),
	.f_b_id( b_id ),
	.f_b_resp( b_resp ),
	.f_b_valid( b_valid ),
	.f_r_data( r_data ),
	.f_r_id( r_id ),
	.f_r_last( r_last ),
	.f_r_resp( r_resp ),
	.f_r_valid( r_valid ),
	.f_w_ready( w_ready ),
	.rst_n( rst_n ),
	.s_ar_addr( s_ar_addr ),
	.s_ar_burst( s_ar_burst ),
	.s_ar_cache( s_ar_cache ),
	.s_ar_id( s_ar_id ),
	.s_ar_len( s_ar_len ),
	.s_ar_lock( s_ar_lock ),
	.s_ar_prot( s_ar_prot ),
	.s_ar_size( s_ar_size ),
	.s_ar_user( s_ar_user ),
	.s_ar_valid( s_ar_valid ),
	.s_aw_addr( s_aw_addr ),
	.s_aw_burst( s_aw_burst ),
	.s_aw_cache( s_aw_cache ),
	.s_aw_id( s_aw_id ),
	.s_aw_len( s_aw_len ),
	.s_aw_lock( s_aw_lock ),
	.s_aw_prot( s_aw_prot ),
	.s_aw_size( s_aw_size ),
	.s_aw_user( s_aw_user ),
	.s_aw_valid( s_aw_valid ),
	.s_b_ready( s_b_ready ),
	.s_r_ready( s_r_ready ),
	.s_ready_latency( port_size_config_1 ),
	.s_w_data( s_w_data ),
	.s_w_id( s_w_id ),
	.s_w_last( s_w_last ),
	.s_w_strb( s_w_strb ),
	.s_w_valid( s_w_valid ),
	.f_ar_addr( ar_addr ),
	.f_ar_burst( ar_burst ),
	.f_ar_cache( ar_cache ),
	.f_ar_id( ar_id ),
	.f_ar_len( ar_len ),
	.f_ar_lock( ar_lock ),
	.f_ar_prot( ar_prot ),
	.f_ar_size( ar_size ),
	.f_ar_user( ar_user ),
	.f_ar_valid( ar_valid ),
	.f_aw_addr( aw_addr ),
	.f_aw_burst( aw_burst ),
	.f_aw_cache( aw_cache ),
	.f_aw_id( aw_id ),
	.f_aw_len( aw_len ),
	.f_aw_lock( aw_lock ),
	.f_aw_prot( aw_prot ),
	.f_aw_size( aw_size ),
	.f_aw_user( aw_user ),
	.f_aw_valid( aw_valid ),
	.f_b_ready( b_ready ),
	.f_r_ready( r_ready ),
	.f_w_data( w_data ),
	.f_w_id( w_id ),
	.f_w_last( w_last ),
	.f_w_strb( w_strb ),
	.f_w_valid( w_valid ),
	.s_ar_ready(s_ar_ready),
	.s_aw_ready( s_aw_ready ),
	.s_b_id( s_b_id ),
	.s_b_resp( s_b_resp ),
	.s_b_valid( s_b_valid ),
	.s_r_data( s_r_data ),
	.s_r_id( s_r_id ),
	.s_r_last( s_r_last ),
	.s_r_resp( s_r_resp ),
	.s_r_valid( s_r_valid ),
	.s_w_ready( s_w_ready )
);

wire [DWIDTH-1 : 0] d_r_data;
wire [4-1 : 0] d_b_id;
wire [4-1 : 0] d_r_id;
generate
if (DWIDTH != 16) begin
    alentar#(.DATA_WIDTH(DWIDTH), .DEPTH(DEPTH)) rdata_alen (s_r_data,d_r_data);
    alentar#(.DATA_WIDTH(4), .DEPTH(DEPTH))      b_id_alen  (s_b_id,  d_b_id);
    alentar#(.DATA_WIDTH(4), .DEPTH(DEPTH))      r_id_alen  (s_r_id,  d_r_id);
end
else begin
    assign d_r_data = s_r_data;
    assign d_b_id   = s_b_id;
    assign d_r_id   = s_r_id;
end
endgenerate

twentynm_hps_interface_hps2fpga_light_weight hps2fpga_lw_rl(
	.ar_clk(ar_clk),
	.ar_ready(s_ar_ready),
	.aw_clk(aw_clk),
	.aw_ready(s_aw_ready),
	.b_clk(b_clk),
	.b_valid(s_b_valid),
	.clk(clk),
	.port_size_config_0(port_size_config_0),
	.port_size_config_1(port_size_config_1),
	.r_clk(r_clk),
	.r_last(s_r_last),
	.r_valid(s_r_valid),
	.w_clk(w_clk),
	.w_ready(s_w_ready),
	.b_id(d_b_id),
	.b_resp(s_b_resp),
	.r_data(d_r_data),
	.r_id(d_r_id),
	.r_resp(s_r_resp),
	.ar_valid(s_ar_valid),
	.aw_valid(s_aw_valid),
	.b_ready(s_b_ready),
	.r_ready(s_r_ready),
	.w_last(s_w_last),
	.w_valid(s_w_valid),
	.ar_addr(s_ar_addr),
	.ar_burst(s_ar_burst),
	.ar_cache(s_ar_cache),
	.ar_id(s_ar_id),
	.ar_len(s_ar_len),
	.ar_lock(s_ar_lock),
	.ar_prot(s_ar_prot),
	.ar_size(s_ar_size),
	.ar_user(s_ar_user),
	.aw_addr(s_aw_addr),
	.aw_burst(s_aw_burst),
	.aw_cache(s_aw_cache),
	.aw_id(s_aw_id),
	.aw_len(s_aw_len),
	.aw_lock(s_aw_lock),
	.aw_prot(s_aw_prot),
	.aw_size(s_aw_size),
	.aw_user(s_aw_user),
	.w_data(s_w_data),
	.w_id(s_w_id),
	.w_strb(s_w_strb));

endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
`timescale 1 ps / 1 ps
module twentynm_hps_rl_mode0_fpga2sdram #(
  parameter DEPTH   = 4,
  parameter DWIDTH0 = 16,
  parameter DWIDTH1 = 16,
  parameter DWIDTH2 = 16,
  parameter mode    = 1
)(
  input   wire           f2s_sdram0_ar_clk,
  input   wire           f2s_sdram0_aw_clk,
  input   wire           f2s_sdram0_b_clk,
  input   wire           f2s_sdram0_clk,
  input   wire           f2s_sdram0_r_clk,
  input   wire           f2s_sdram0_w_clk,
  input   wire           f2s_sdram1_ar_clk,
  input   wire           f2s_sdram1_aw_clk,
  input   wire           f2s_sdram1_b_clk,
  input   wire           f2s_sdram1_clk,
  input   wire           f2s_sdram1_r_clk,
  input   wire           f2s_sdram1_w_clk,
  input   wire           f2s_sdram2_ar_clk,
  input   wire           f2s_sdram2_aw_clk,
  input   wire           f2s_sdram2_b_clk,
  input   wire           f2s_sdram2_clk,
  input   wire           f2s_sdram2_r_clk,
  input   wire           f2s_sdram2_w_clk,
  input   wire           f2s_sdram0_rst_n,
  input   wire           f2s_sdram1_rst_n,
  input   wire           f2s_sdram2_rst_n,
  input   wire [    3:0] fpga2sdram_port_size_config,
  input   wire [ 32-1:0] fpga2sdram0_ar_addr,
  input   wire [  2-1:0] fpga2sdram0_ar_burst,
  input   wire [  4-1:0] fpga2sdram0_ar_cache,
  input   wire [  4-1:0] fpga2sdram0_ar_id,
  input   wire [  4-1:0] fpga2sdram0_ar_len,
  input   wire [  2-1:0] fpga2sdram0_ar_lock,
  input   wire [  3-1:0] fpga2sdram0_ar_prot,
  output  wire [  1-1:0] fpga2sdram0_ar_ready,
  input   wire [  3-1:0] fpga2sdram0_ar_size,
  input   wire [  5-1:0] fpga2sdram0_ar_user,
  input   wire [  1-1:0] fpga2sdram0_ar_valid,
  input   wire [ 32-1:0] fpga2sdram0_aw_addr,
  input   wire [  2-1:0] fpga2sdram0_aw_burst,
  input   wire [  4-1:0] fpga2sdram0_aw_cache,
  input   wire [  4-1:0] fpga2sdram0_aw_id,
  input   wire [  4-1:0] fpga2sdram0_aw_len,
  input   wire [  2-1:0] fpga2sdram0_aw_lock,
  input   wire [  3-1:0] fpga2sdram0_aw_prot,
  output  wire [  1-1:0] fpga2sdram0_aw_ready,
  input   wire [  3-1:0] fpga2sdram0_aw_size,
  input   wire [  5-1:0] fpga2sdram0_aw_user,
  input   wire [  1-1:0] fpga2sdram0_aw_valid,
  output  wire [  4-1:0] fpga2sdram0_b_id,
  input   wire [  1-1:0] fpga2sdram0_b_ready,
  output  wire [  2-1:0] fpga2sdram0_b_resp,
  output  wire [  1-1:0] fpga2sdram0_b_valid,
  output  wire [ 32-1:0] fpga2sdram0_r_data,
  output  wire [  4-1:0] fpga2sdram0_r_id,
  output  wire [  1-1:0] fpga2sdram0_r_last,
  input   wire [  1-1:0] fpga2sdram0_r_ready,
  output  wire [  2-1:0] fpga2sdram0_r_resp,
  output  wire [  1-1:0] fpga2sdram0_r_valid,
  input   wire [ 32-1:0] fpga2sdram0_w_data,
  input   wire [  4-1:0] fpga2sdram0_w_id,
  input   wire [  1-1:0] fpga2sdram0_w_last,
  output  wire [  1-1:0] fpga2sdram0_w_ready,
  input   wire [  4-1:0] fpga2sdram0_w_strb,
  input   wire [  1-1:0] fpga2sdram0_w_valid,
  input   wire [ 32-1:0] fpga2sdram1_ar_addr,
  input   wire [  2-1:0] fpga2sdram1_ar_burst,
  input   wire [  4-1:0] fpga2sdram1_ar_cache,
  input   wire [  4-1:0] fpga2sdram1_ar_id,
  input   wire [  4-1:0] fpga2sdram1_ar_len,
  input   wire [  2-1:0] fpga2sdram1_ar_lock,
  input   wire [  3-1:0] fpga2sdram1_ar_prot,
  output  wire [  1-1:0] fpga2sdram1_ar_ready,
  input   wire [  3-1:0] fpga2sdram1_ar_size,
  input   wire [  5-1:0] fpga2sdram1_ar_user,
  input   wire [  1-1:0] fpga2sdram1_ar_valid,
  input   wire [ 32-1:0] fpga2sdram1_aw_addr,
  input   wire [  2-1:0] fpga2sdram1_aw_burst,
  input   wire [  4-1:0] fpga2sdram1_aw_cache,
  input   wire [  4-1:0] fpga2sdram1_aw_id,
  input   wire [  4-1:0] fpga2sdram1_aw_len,
  input   wire [  2-1:0] fpga2sdram1_aw_lock,
  input   wire [  3-1:0] fpga2sdram1_aw_prot,
  output  wire [  1-1:0] fpga2sdram1_aw_ready,
  input   wire [  3-1:0] fpga2sdram1_aw_size,
  input   wire [  5-1:0] fpga2sdram1_aw_user,
  input   wire [  1-1:0] fpga2sdram1_aw_valid,
  output  wire [  4-1:0] fpga2sdram1_b_id,
  input   wire [  1-1:0] fpga2sdram1_b_ready,
  output  wire [  2-1:0] fpga2sdram1_b_resp,
  output  wire [  1-1:0] fpga2sdram1_b_valid,
  output  wire [ 32-1:0] fpga2sdram1_r_data,
  output  wire [  4-1:0] fpga2sdram1_r_id,
  output  wire [  1-1:0] fpga2sdram1_r_last,
  input   wire [  1-1:0] fpga2sdram1_r_ready,
  output  wire [  2-1:0] fpga2sdram1_r_resp,
  output  wire [  1-1:0] fpga2sdram1_r_valid,
  input   wire [ 32-1:0] fpga2sdram1_w_data,
  input   wire [  4-1:0] fpga2sdram1_w_id,
  input   wire [  1-1:0] fpga2sdram1_w_last,
  output  wire [  1-1:0] fpga2sdram1_w_ready,
  input   wire [  4-1:0] fpga2sdram1_w_strb,
  input   wire [  1-1:0] fpga2sdram1_w_valid,
  input   wire [ 32-1:0] fpga2sdram2_ar_addr,
  input   wire [  2-1:0] fpga2sdram2_ar_burst,
  input   wire [  4-1:0] fpga2sdram2_ar_cache,
  input   wire [  4-1:0] fpga2sdram2_ar_id,
  input   wire [  4-1:0] fpga2sdram2_ar_len,
  input   wire [  2-1:0] fpga2sdram2_ar_lock,
  input   wire [  3-1:0] fpga2sdram2_ar_prot,
  output  wire [  1-1:0] fpga2sdram2_ar_ready,
  input   wire [  3-1:0] fpga2sdram2_ar_size,
  input   wire [  5-1:0] fpga2sdram2_ar_user,
  input   wire [  1-1:0] fpga2sdram2_ar_valid,
  input   wire [ 32-1:0] fpga2sdram2_aw_addr,
  input   wire [  2-1:0] fpga2sdram2_aw_burst,
  input   wire [  4-1:0] fpga2sdram2_aw_cache,
  input   wire [  4-1:0] fpga2sdram2_aw_id,
  input   wire [  4-1:0] fpga2sdram2_aw_len,
  input   wire [  2-1:0] fpga2sdram2_aw_lock,
  input   wire [  3-1:0] fpga2sdram2_aw_prot,
  output  wire [  1-1:0] fpga2sdram2_aw_ready,
  input   wire [  3-1:0] fpga2sdram2_aw_size,
  input   wire [  5-1:0] fpga2sdram2_aw_user,
  input   wire [  1-1:0] fpga2sdram2_aw_valid,
  output  wire [  4-1:0] fpga2sdram2_b_id,
  input   wire [  1-1:0] fpga2sdram2_b_ready,
  output  wire [  2-1:0] fpga2sdram2_b_resp,
  output  wire [  1-1:0] fpga2sdram2_b_valid,
  output  wire [ 32-1:0] fpga2sdram2_r_data,
  output  wire [  4-1:0] fpga2sdram2_r_id,
  output  wire [  1-1:0] fpga2sdram2_r_last,
  input   wire [  1-1:0] fpga2sdram2_r_ready,
  output  wire [  2-1:0] fpga2sdram2_r_resp,
  output  wire [  1-1:0] fpga2sdram2_r_valid,
  input   wire [ 32-1:0] fpga2sdram2_w_data,
  input   wire [  4-1:0] fpga2sdram2_w_id,
  input   wire [  1-1:0] fpga2sdram2_w_last,
  output  wire [  1-1:0] fpga2sdram2_w_ready,
  input   wire [  4-1:0] fpga2sdram2_w_strb,
  input   wire [  1-1:0] fpga2sdram2_w_valid
);

localparam DWIDTH = 32;

wire [  1-1:0] w_fpga2sdram0_ar_ready;
wire [  1-1:0] w_fpga2sdram0_ar_valid;
wire [  1-1:0] w_fpga2sdram0_aw_ready;
wire [  1-1:0] w_fpga2sdram0_aw_valid;
wire [  1-1:0] w_fpga2sdram0_b_ready;
wire [  1-1:0] w_fpga2sdram0_b_valid;
wire [ 32-1:0] w_fpga2sdram0_req_addr;
wire [ 16-1:0] w_fpga2sdram0_req_be;
wire [128-1:0] w_fpga2sdram0_req_data;
wire [  4-1:0] w_fpga2sdram0_req_exclid;
wire [  2-1:0] w_fpga2sdram0_req_hurry;
wire [  1-1:0] w_fpga2sdram0_req_last;
wire [  8-1:0] w_fpga2sdram0_req_length;
wire [  3-1:0] w_fpga2sdram0_req_opc;
wire [  2-1:0] w_fpga2sdram0_req_press;
wire [  1-1:0] w_fpga2sdram0_req_rdy;
wire [  4-1:0] w_fpga2sdram0_req_seqid;
wire [  3-1:0] w_fpga2sdram0_req_trid;
wire [  2-1:0] w_fpga2sdram0_req_urgency;
wire [ 12-1:0] w_fpga2sdram0_req_user;
wire [  1-1:0] w_fpga2sdram0_req_vld;
wire [  1-1:0] w_fpga2sdram0_rsp_cont;
wire [128-1:0] w_fpga2sdram0_rsp_data;
wire [  1-1:0] w_fpga2sdram0_rsp_last;
wire [  1-1:0] w_fpga2sdram0_rsp_rdy;
wire [  2-1:0] w_fpga2sdram0_rsp_status;
wire [  3-1:0] w_fpga2sdram0_rsp_trid;
wire [  1-1:0] w_fpga2sdram0_rsp_vld;
wire [  1-1:0] w_fpga2sdram1_ar_ready;
wire [  1-1:0] w_fpga2sdram1_ar_valid;
wire [  1-1:0] w_fpga2sdram1_aw_ready;
wire [  1-1:0] w_fpga2sdram1_aw_valid;
wire [  1-1:0] w_fpga2sdram1_b_ready;
wire [  1-1:0] w_fpga2sdram1_b_valid;
wire [ 32-1:0] w_fpga2sdram1_req_addr;
wire [ 16-1:0] w_fpga2sdram1_req_be;
wire [128-1:0] w_fpga2sdram1_req_data;
wire [  4-1:0] w_fpga2sdram1_req_exclid;
wire [  2-1:0] w_fpga2sdram1_req_hurry;
wire [  1-1:0] w_fpga2sdram1_req_last;
wire [  8-1:0] w_fpga2sdram1_req_length;
wire [  3-1:0] w_fpga2sdram1_req_opc;
wire [  2-1:0] w_fpga2sdram1_req_press;
wire [  1-1:0] w_fpga2sdram1_req_rdy;
wire [  4-1:0] w_fpga2sdram1_req_seqid;
wire [  3-1:0] w_fpga2sdram1_req_trid;
wire [  2-1:0] w_fpga2sdram1_req_urgency;
wire [ 12-1:0] w_fpga2sdram1_req_user;
wire [  1-1:0] w_fpga2sdram1_req_vld;
wire [  1-1:0] w_fpga2sdram1_rsp_cont;
wire [122-1:0] w_fpga2sdram1_rsp_data;
wire [  1-1:0] w_fpga2sdram1_rsp_last;
wire [  1-1:0] w_fpga2sdram1_rsp_rdy;
wire [  2-1:0] w_fpga2sdram1_rsp_status;
wire [  3-1:0] w_fpga2sdram1_rsp_trid;
wire [  1-1:0] w_fpga2sdram1_rsp_vld;
wire [  1-1:0] w_fpga2sdram2_ar_ready;
wire [  1-1:0] w_fpga2sdram2_ar_valid;
wire [  1-1:0] w_fpga2sdram2_aw_ready;
wire [  1-1:0] w_fpga2sdram2_aw_valid;
wire [  1-1:0] w_fpga2sdram2_b_ready;
wire [  1-1:0] w_fpga2sdram2_b_valid;
wire [ 32-1:0] w_fpga2sdram2_req_addr;
wire [ 16-1:0] w_fpga2sdram2_req_be;
wire [128-1:0] w_fpga2sdram2_req_data;
wire [  4-1:0] w_fpga2sdram2_req_exclid;
wire [  2-1:0] w_fpga2sdram2_req_hurry;
wire [  1-1:0] w_fpga2sdram2_req_last;
wire [  8-1:0] w_fpga2sdram2_req_length;
wire [  3-1:0] w_fpga2sdram2_req_opc;
wire [  2-1:0] w_fpga2sdram2_req_press;
wire [  1-1:0] w_fpga2sdram2_req_rdy;
wire [  4-1:0] w_fpga2sdram2_req_seqid;
wire [  3-1:0] w_fpga2sdram2_req_trid;
wire [  2-1:0] w_fpga2sdram2_req_urgency;
wire [ 12-1:0] w_fpga2sdram2_req_user;
wire [  1-1:0] w_fpga2sdram2_req_vld;
wire [  1-1:0] w_fpga2sdram2_rsp_cont;
wire [ 70-1:0] w_fpga2sdram2_rsp_data;
wire [  1-1:0] w_fpga2sdram2_rsp_last;
wire [  1-1:0] w_fpga2sdram2_rsp_rdy;
wire [  2-1:0] w_fpga2sdram2_rsp_status;
wire [  3-1:0] w_fpga2sdram2_rsp_trid;
wire [  1-1:0] w_fpga2sdram2_rsp_vld;


wire                     s0_ar_ready;
wire                     s0_aw_ready;
wire               [3:0] s0_b_id;
wire               [1:0] s0_b_resp;
wire                     s0_b_valid;
wire        [DWIDTH-1:0] s0_r_data;
wire               [3:0] s0_r_id;
wire                     s0_r_last;
wire               [1:0] s0_r_resp;
wire                     s0_r_valid;
wire                     s0_w_ready;
wire             [31:0] s0_ar_addr;
wire              [1:0] s0_ar_burst;
wire              [3:0] s0_ar_cache;
wire              [3:0] s0_ar_id;
wire              [3:0] s0_ar_len;
wire              [1:0] s0_ar_lock;
wire              [2:0] s0_ar_prot;
wire              [2:0] s0_ar_size;
wire              [4:0] s0_ar_user;
wire                    s0_ar_valid;
wire             [31:0] s0_aw_addr;
wire              [1:0] s0_aw_burst;
wire              [3:0] s0_aw_cache;
wire              [3:0] s0_aw_id;
wire              [3:0] s0_aw_len;
wire              [1:0] s0_aw_lock;
wire              [2:0] s0_aw_prot;
wire              [2:0] s0_aw_size;
wire              [4:0] s0_aw_user;
wire                    s0_aw_valid;
wire                    s0_b_ready;
wire                    s0_r_ready;
wire       [DWIDTH-1:0] s0_w_data;
wire              [3:0] s0_w_id;
wire                    s0_w_last;
wire     [DWIDTH/8-1:0] s0_w_strb;
wire                    s0_w_valid;

wire                     s1_ar_ready;
wire                     s1_aw_ready;
wire               [3:0] s1_b_id;
wire               [1:0] s1_b_resp;
wire                     s1_b_valid;
wire        [DWIDTH-1:0] s1_r_data;
wire               [3:0] s1_r_id;
wire                     s1_r_last;
wire               [1:0] s1_r_resp;
wire                     s1_r_valid;
wire                     s1_w_ready;
wire             [31:0] s1_ar_addr;
wire              [1:0] s1_ar_burst;
wire              [3:0] s1_ar_cache;
wire              [3:0] s1_ar_id;
wire              [3:0] s1_ar_len;
wire              [1:0] s1_ar_lock;
wire              [2:0] s1_ar_prot;
wire              [2:0] s1_ar_size;
wire              [4:0] s1_ar_user;
wire                    s1_ar_valid;
wire             [31:0] s1_aw_addr;
wire              [1:0] s1_aw_burst;
wire              [3:0] s1_aw_cache;
wire              [3:0] s1_aw_id;
wire              [3:0] s1_aw_len;
wire              [1:0] s1_aw_lock;
wire              [2:0] s1_aw_prot;
wire              [2:0] s1_aw_size;
wire              [4:0] s1_aw_user;
wire                    s1_aw_valid;
wire                    s1_b_ready;
wire                    s1_r_ready;
wire       [DWIDTH-1:0] s1_w_data;
wire              [3:0] s1_w_id;
wire                    s1_w_last;
wire     [DWIDTH/8-1:0] s1_w_strb;
wire                    s1_w_valid;

wire                     s2_ar_ready;
wire                     s2_aw_ready;
wire               [3:0] s2_b_id;
wire               [1:0] s2_b_resp;
wire                     s2_b_valid;
wire        [DWIDTH-1:0] s2_r_data;
wire               [3:0] s2_r_id;
wire                     s2_r_last;
wire               [1:0] s2_r_resp;
wire                     s2_r_valid;
wire                     s2_w_ready;
wire             [31:0] s2_ar_addr;
wire              [1:0] s2_ar_burst;
wire              [3:0] s2_ar_cache;
wire              [3:0] s2_ar_id;
wire              [3:0] s2_ar_len;
wire              [1:0] s2_ar_lock;
wire              [2:0] s2_ar_prot;
wire              [2:0] s2_ar_size;
wire              [4:0] s2_ar_user;
wire                    s2_ar_valid;
wire             [31:0] s2_aw_addr;
wire              [1:0] s2_aw_burst;
wire              [3:0] s2_aw_cache;
wire              [3:0] s2_aw_id;
wire              [3:0] s2_aw_len;
wire              [1:0] s2_aw_lock;
wire              [2:0] s2_aw_prot;
wire              [2:0] s2_aw_size;
wire              [4:0] s2_aw_user;
wire                    s2_aw_valid;
wire                    s2_b_ready;
wire                    s2_r_ready;
wire       [DWIDTH-1:0] s2_w_data;
wire              [3:0] s2_w_id;
wire                    s2_w_last;
wire     [DWIDTH/8-1:0] s2_w_strb;
wire                    s2_w_valid;


assign s0_ar_ready 	= w_fpga2sdram0_ar_ready;
assign s0_aw_ready 	= w_fpga2sdram0_aw_ready;
assign s0_b_id[3:0] 	= w_fpga2sdram0_rsp_data[125:122];
assign s0_b_resp[1:0] 	= w_fpga2sdram0_rsp_data[127:126];
assign s0_b_valid 	= w_fpga2sdram0_b_valid;
assign s0_r_data[31:0] 	= w_fpga2sdram0_rsp_data[31:0];
assign s0_r_id[2:0] 	= w_fpga2sdram0_rsp_trid[2:0];
assign s0_r_id[3] 	= w_fpga2sdram0_rsp_cont;
assign s0_r_last 	= w_fpga2sdram0_rsp_last;
assign s0_r_resp[1:0] 	= w_fpga2sdram0_rsp_status[1:0];
assign s0_r_valid 	= w_fpga2sdram0_rsp_vld;
assign s0_w_ready 	= w_fpga2sdram0_req_rdy;
assign s1_ar_ready 	= w_fpga2sdram1_ar_ready;
assign s1_aw_ready 	= w_fpga2sdram1_aw_ready;
assign s1_b_id[3:0] 	= w_fpga2sdram1_rsp_data[119:116];
assign s1_b_resp[1:0] 	= w_fpga2sdram1_rsp_data[121:120];
assign s1_b_valid 	= w_fpga2sdram1_b_valid;
assign s1_r_data[31:0] 	= w_fpga2sdram1_rsp_data[31:0];
assign s1_r_id[2:0] 	= w_fpga2sdram1_rsp_trid[2:0];
assign s1_r_id[3] 	= w_fpga2sdram1_rsp_cont;
assign s1_r_last 	= w_fpga2sdram1_rsp_last;
assign s1_r_resp[1:0] 	= w_fpga2sdram1_rsp_status[1:0];
assign s1_r_valid 	= w_fpga2sdram1_rsp_vld;
assign s1_w_ready 	= w_fpga2sdram1_req_rdy;
assign s2_ar_ready 	= w_fpga2sdram2_ar_ready;
assign s2_aw_ready 	= w_fpga2sdram2_aw_ready;
assign s2_b_id[3:0] 	= w_fpga2sdram2_rsp_data[67:64];
assign s2_b_resp[1:0] 	= w_fpga2sdram2_rsp_data[69:68];
assign s2_b_valid 	= w_fpga2sdram2_b_valid;
assign s2_r_data[31:0] 	= w_fpga2sdram2_rsp_data[31:0];
assign s2_r_id[2:0] 	= w_fpga2sdram2_rsp_trid[2:0];
assign s2_r_id[3] 	= w_fpga2sdram2_rsp_cont;
assign s2_r_last 	= w_fpga2sdram2_rsp_last;
assign s2_r_resp[1:0] 	= w_fpga2sdram2_rsp_status[1:0];
assign s2_r_valid 	= w_fpga2sdram2_rsp_vld;
assign s2_w_ready 	= w_fpga2sdram2_req_rdy;
assign w_fpga2sdram0_ar_valid 	= s0_ar_valid;
assign w_fpga2sdram0_aw_valid 	= s0_aw_valid;
assign w_fpga2sdram0_b_ready 	= s0_b_ready;
assign w_fpga2sdram0_req_addr[31:0] 	= s0_aw_addr[31:0];
assign w_fpga2sdram0_req_be[11:8] 	= s0_ar_cache[3:0];
assign w_fpga2sdram0_req_be[15:12] 	= s0_ar_id[3:0];
assign w_fpga2sdram0_req_be[3:0] 	= s0_w_strb[3:0];
assign w_fpga2sdram0_req_data[127:96] 	= s0_ar_addr[31:0];
assign w_fpga2sdram0_req_data[31:0] 	= s0_w_data[31:0];
assign w_fpga2sdram0_req_data[87:86] 	= s0_ar_lock[1:0];
assign w_fpga2sdram0_req_data[90:88] 	= s0_ar_size[2:0];
assign w_fpga2sdram0_req_data[95:91] 	= s0_ar_user[4:0];
assign w_fpga2sdram0_req_exclid[3:0] 	= s0_w_id[3:0];
assign w_fpga2sdram0_req_hurry[1:0] 	= s0_aw_lock[1:0];
assign w_fpga2sdram0_req_last 	= s0_w_last;
assign w_fpga2sdram0_req_length[3:0] 	= s0_aw_len[3:0];
assign w_fpga2sdram0_req_length[7:4] 	= s0_ar_len[3:0];
assign w_fpga2sdram0_req_opc[2:0] 	= s0_aw_size[2:0];
assign w_fpga2sdram0_req_press[1:0] 	= s0_aw_burst[1:0];
assign w_fpga2sdram0_req_seqid[3:0] 	= s0_aw_id[3:0];
assign w_fpga2sdram0_req_trid[2:0] 	= s0_ar_prot[2:0];
assign w_fpga2sdram0_req_urgency[1:0] 	= s0_ar_burst[1:0];
assign w_fpga2sdram0_req_user[11:7] 	= s0_aw_user[4:0];
assign w_fpga2sdram0_req_user[3:0] 	= s0_aw_cache[3:0];
assign w_fpga2sdram0_req_user[6:4] 	= s0_aw_prot[2:0];
assign w_fpga2sdram0_req_vld 	= s0_w_valid;
assign w_fpga2sdram0_rsp_rdy 	= s0_r_ready;
assign w_fpga2sdram1_ar_valid 	= s1_ar_valid;
assign w_fpga2sdram1_aw_valid 	= s1_aw_valid;
assign w_fpga2sdram1_b_ready 	= s1_b_ready;
assign w_fpga2sdram1_req_addr[31:0] 	= s1_aw_addr[31:0];
assign w_fpga2sdram1_req_be[11:8] 	= s1_ar_cache[3:0];
assign w_fpga2sdram1_req_be[15:12] 	= s1_ar_id[3:0];
assign w_fpga2sdram1_req_be[3:0] 	= s1_w_strb[3:0];
assign w_fpga2sdram1_req_data[127:96] 	= s1_ar_addr[31:0];
assign w_fpga2sdram1_req_data[31:0] 	= s1_w_data[31:0];
assign w_fpga2sdram1_req_data[87:86] 	= s1_ar_lock[1:0];
assign w_fpga2sdram1_req_data[90:88] 	= s1_ar_size[2:0];
assign w_fpga2sdram1_req_data[95:91] 	= s1_ar_user[4:0];
assign w_fpga2sdram1_req_exclid[3:0] 	= s1_w_id[3:0];
assign w_fpga2sdram1_req_hurry[1:0] 	= s1_aw_lock[1:0];
assign w_fpga2sdram1_req_last 	= s1_w_last;
assign w_fpga2sdram1_req_length[3:0] 	= s1_aw_len[3:0];
assign w_fpga2sdram1_req_length[7:4] 	= s1_ar_len[3:0];
assign w_fpga2sdram1_req_opc[2:0] 	= s1_aw_size[2:0];
assign w_fpga2sdram1_req_press[1:0] 	= s1_aw_burst[1:0];
assign w_fpga2sdram1_req_seqid[3:0] 	= s1_aw_id[3:0];
assign w_fpga2sdram1_req_trid[2:0] 	= s1_ar_prot[2:0];
assign w_fpga2sdram1_req_urgency[1:0] 	= s1_ar_burst[1:0];
assign w_fpga2sdram1_req_user[11:7] 	= s1_aw_user[4:0];
assign w_fpga2sdram1_req_user[3:0] 	= s1_aw_cache[3:0];
assign w_fpga2sdram1_req_user[6:4] 	= s1_aw_prot[2:0];
assign w_fpga2sdram1_req_vld 	= s1_w_valid;
assign w_fpga2sdram1_rsp_rdy 	= s1_r_ready;
assign w_fpga2sdram2_ar_valid 	= s2_ar_valid;
assign w_fpga2sdram2_aw_valid 	= s2_aw_valid;
assign w_fpga2sdram2_b_ready 	= s2_b_ready;
assign w_fpga2sdram2_req_addr[31:0] 	= s2_aw_addr[31:0];
assign w_fpga2sdram2_req_be[11:8] 	= s2_ar_cache[3:0];
assign w_fpga2sdram2_req_be[15:12] 	= s2_ar_id[3:0];
assign w_fpga2sdram2_req_be[3:0] 	= s2_w_strb[3:0];
assign w_fpga2sdram2_req_data[127:96] 	= s2_ar_addr[31:0];
assign w_fpga2sdram2_req_data[31:0] 	= s2_w_data[31:0];
assign w_fpga2sdram2_req_data[87:86] 	= s2_ar_lock[1:0];
assign w_fpga2sdram2_req_data[90:88] 	= s2_ar_size[2:0];
assign w_fpga2sdram2_req_data[95:91] 	= s2_ar_user[4:0];
assign w_fpga2sdram2_req_exclid[3:0] 	= s2_w_id[3:0];
assign w_fpga2sdram2_req_hurry[1:0] 	= s2_aw_lock[1:0];
assign w_fpga2sdram2_req_last 	= s2_w_last;
assign w_fpga2sdram2_req_length[3:0] 	= s2_aw_len[3:0];
assign w_fpga2sdram2_req_length[7:4] 	= s2_ar_len[3:0];
assign w_fpga2sdram2_req_opc[2:0] 	= s2_aw_size[2:0];
assign w_fpga2sdram2_req_press[1:0] 	= s2_aw_burst[1:0];
assign w_fpga2sdram2_req_seqid[3:0] 	= s2_aw_id[3:0];
assign w_fpga2sdram2_req_trid[2:0] 	= s2_ar_prot[2:0];
assign w_fpga2sdram2_req_urgency[1:0] 	= s2_ar_burst[1:0];
assign w_fpga2sdram2_req_user[11:7] 	= s2_aw_user[4:0];
assign w_fpga2sdram2_req_user[3:0] 	= s2_aw_cache[3:0];
assign w_fpga2sdram2_req_user[6:4] 	= s2_aw_prot[2:0];
assign w_fpga2sdram2_req_vld 	= s2_w_valid;
assign w_fpga2sdram2_rsp_rdy 	= s2_r_ready;


assign w_fpga2sdram0_req_be[7:4] 	= 4'b1111;
assign w_fpga2sdram0_req_data[85:32] 	= 54'b11111111111111111111111111111111111111111111111111111;
assign w_fpga2sdram2_req_be[7:4] 	= 4'b0000;
assign w_fpga2sdram2_req_data[85:32] 	= 54'b000000000000000000000000000000000000000000000000000000;


f2s_rl_delay_adp #( .DWIDTH(DWIDTH0), .DEPTH(DEPTH)) f2s_rl_adp_inst_0 (
	.clk( f2s_sdram0_ar_clk ),
	.f_ar_addr( fpga2sdram0_ar_addr ),
	.f_ar_burst( fpga2sdram0_ar_burst ),
	.f_ar_cache( fpga2sdram0_ar_cache ),
	.f_ar_id( fpga2sdram0_ar_id ),
	.f_ar_len( fpga2sdram0_ar_len ),
	.f_ar_lock( fpga2sdram0_ar_lock ),
	.f_ar_prot( fpga2sdram0_ar_prot ),
	.f_ar_size( fpga2sdram0_ar_size ),
	.f_ar_user( fpga2sdram0_ar_user ),
	.f_ar_valid( fpga2sdram0_ar_valid ),
	.f_aw_addr( fpga2sdram0_aw_addr ),
	.f_aw_burst( fpga2sdram0_aw_burst ),
	.f_aw_cache( fpga2sdram0_aw_cache ),
	.f_aw_id( fpga2sdram0_aw_id ),
	.f_aw_len( fpga2sdram0_aw_len ),
	.f_aw_lock( fpga2sdram0_aw_lock ),
	.f_aw_prot( fpga2sdram0_aw_prot ),
	.f_aw_size( fpga2sdram0_aw_size ),
	.f_aw_user( fpga2sdram0_aw_user ),
	.f_aw_valid( fpga2sdram0_aw_valid ),
	.f_b_ready( fpga2sdram0_b_ready ),
	.f_r_ready( fpga2sdram0_r_ready ),
	.f_w_data( fpga2sdram0_w_data ),
	.f_w_id( fpga2sdram0_w_id ),
	.f_w_last( fpga2sdram0_w_last ),
	.f_w_strb( fpga2sdram0_w_strb ),
	.f_w_valid( fpga2sdram0_w_valid ),
	.rst_n( f2s_sdram0_rst_n ),
	.s_ar_ready( s0_ar_ready ),
	.s_aw_ready( s0_aw_ready ),
	.s_b_id( s0_b_id ),
	.s_b_resp( s0_b_resp ),
	.s_b_valid( s0_b_valid ),
	.s_r_data( s0_r_data ),
	.s_r_id( s0_r_id ),
	.s_r_last( s0_r_last ),
	.s_r_resp( s0_r_resp ),
	.s_r_valid( s0_r_valid ),
	.s_ready_latency( fpga2sdram_port_size_config[3] ),
	.s_w_ready( s0_w_ready ),
	.f_ar_ready( fpga2sdram0_ar_ready ),
	.f_aw_ready( fpga2sdram0_aw_ready ),
	.f_b_id( fpga2sdram0_b_id ),
	.f_b_resp( fpga2sdram0_b_resp ),
	.f_b_valid( fpga2sdram0_b_valid ),
	.f_r_data( fpga2sdram0_r_data ),
	.f_r_id(   fpga2sdram0_r_id ),
	.f_r_last( fpga2sdram0_r_last ),
	.f_r_resp( fpga2sdram0_r_resp ),
	.f_r_valid( fpga2sdram0_r_valid ),
	.f_w_ready( fpga2sdram0_w_ready ),
	.s_ar_addr( s0_ar_addr ),
	.s_ar_burst( s0_ar_burst ),
	.s_ar_cache( s0_ar_cache ),
	.s_ar_id( s0_ar_id ),
	.s_ar_len( s0_ar_len ),
	.s_ar_lock( s0_ar_lock ),
	.s_ar_prot( s0_ar_prot ),
	.s_ar_size( s0_ar_size ),
	.s_ar_user( s0_ar_user ),
	.s_ar_valid( s0_ar_valid ),
	.s_aw_addr( s0_aw_addr ),
	.s_aw_burst( s0_aw_burst ),
	.s_aw_cache( s0_aw_cache ),
	.s_aw_id( s0_aw_id ),
	.s_aw_len( s0_aw_len ),
	.s_aw_lock( s0_aw_lock ),
	.s_aw_prot( s0_aw_prot ),
	.s_aw_size( s0_aw_size ),
	.s_aw_user( s0_aw_user ),
	.s_aw_valid( s0_aw_valid ),
	.s_b_ready( s0_b_ready ),
	.s_r_ready( s0_r_ready ),
	.s_w_data( s0_w_data ),
	.s_w_id( s0_w_id ),
	.s_w_last( s0_w_last ),
	.s_w_strb( s0_w_strb ),
	.s_w_valid( s0_w_valid )
);

f2s_rl_delay_adp #( .DWIDTH(DWIDTH1),  .DEPTH(DEPTH) ) f2s_rl_adp_inst_1 (
	.clk(  f2s_sdram1_ar_clk ),
	.f_ar_addr( fpga2sdram1_ar_addr ),
	.f_ar_burst( fpga2sdram1_ar_burst ),
	.f_ar_cache( fpga2sdram1_ar_cache ),
	.f_ar_id( fpga2sdram1_ar_id ),
	.f_ar_len( fpga2sdram1_ar_len ),
	.f_ar_lock( fpga2sdram1_ar_lock ),
	.f_ar_prot( fpga2sdram1_ar_prot ),
	.f_ar_size( fpga2sdram1_ar_size ),
	.f_ar_user( fpga2sdram1_ar_user ),
	.f_ar_valid( fpga2sdram1_ar_valid ),
	.f_aw_addr( fpga2sdram1_aw_addr ),
	.f_aw_burst( fpga2sdram1_aw_burst ),
	.f_aw_cache( fpga2sdram1_aw_cache ),
	.f_aw_id( fpga2sdram1_aw_id ),
	.f_aw_len( fpga2sdram1_aw_len ),
	.f_aw_lock( fpga2sdram1_aw_lock ),
	.f_aw_prot( fpga2sdram1_aw_prot ),
	.f_aw_size( fpga2sdram1_aw_size ),
	.f_aw_user( fpga2sdram1_aw_user ),
	.f_aw_valid( fpga2sdram1_aw_valid ),
	.f_b_ready( fpga2sdram1_b_ready ),
	.f_r_ready( fpga2sdram1_r_ready ),
	.f_w_data( fpga2sdram1_w_data ),
	.f_w_id( fpga2sdram1_w_id ),
	.f_w_last( fpga2sdram1_w_last ),
	.f_w_strb( fpga2sdram1_w_strb ),
	.f_w_valid( fpga2sdram1_w_valid ),
	.rst_n( f2s_sdram1_rst_n ),
	.s_ar_ready( s1_ar_ready ),
	.s_aw_ready( s1_aw_ready ),
	.s_b_id( s1_b_id ),
	.s_b_resp( s1_b_resp ),
	.s_b_valid( s1_b_valid ),
	.s_r_data( s1_r_data ),
	.s_r_id( s1_r_id ),
	.s_r_last( s1_r_last ),
	.s_r_resp( s1_r_resp ),
	.s_r_valid( s1_r_valid ),
	.s_ready_latency( fpga2sdram_port_size_config[3] ),
	.s_w_ready( s1_w_ready ),
	.f_ar_ready( fpga2sdram1_ar_ready ),
	.f_aw_ready( fpga2sdram1_aw_ready ),
	.f_b_id( fpga2sdram1_b_id ),
	.f_b_resp( fpga2sdram1_b_resp ),
	.f_b_valid( fpga2sdram1_b_valid ),
	.f_r_data( fpga2sdram1_r_data ),
	.f_r_id(   fpga2sdram1_r_id ),
	.f_r_last( fpga2sdram1_r_last ),
	.f_r_resp( fpga2sdram1_r_resp ),
	.f_r_valid( fpga2sdram1_r_valid ),
	.f_w_ready( fpga2sdram1_w_ready ),
	.s_ar_addr( s1_ar_addr ),
	.s_ar_burst( s1_ar_burst ),
	.s_ar_cache( s1_ar_cache ),
	.s_ar_id( s1_ar_id ),
	.s_ar_len( s1_ar_len ),
	.s_ar_lock( s1_ar_lock ),
	.s_ar_prot( s1_ar_prot ),
	.s_ar_size( s1_ar_size ),
	.s_ar_user( s1_ar_user ),
	.s_ar_valid( s1_ar_valid ),
	.s_aw_addr( s1_aw_addr ),
	.s_aw_burst( s1_aw_burst ),
	.s_aw_cache( s1_aw_cache ),
	.s_aw_id( s1_aw_id ),
	.s_aw_len( s1_aw_len ),
	.s_aw_lock( s1_aw_lock ),
	.s_aw_prot( s1_aw_prot ),
	.s_aw_size( s1_aw_size ),
	.s_aw_user( s1_aw_user ),
	.s_aw_valid( s1_aw_valid ),
	.s_b_ready( s1_b_ready ),
	.s_r_ready( s1_r_ready ),
	.s_w_data( s1_w_data ),
	.s_w_id( s1_w_id ),
	.s_w_last( s1_w_last ),
	.s_w_strb( s1_w_strb ),
	.s_w_valid( s1_w_valid )
);

f2s_rl_delay_adp #( .DWIDTH(DWIDTH2),  .DEPTH(DEPTH) ) f2s_rl_adp_inst_2 (
	.clk( f2s_sdram2_ar_clk ),
	.f_ar_addr( fpga2sdram2_ar_addr ),
	.f_ar_burst( fpga2sdram2_ar_burst ),
	.f_ar_cache( fpga2sdram2_ar_cache ),
	.f_ar_id( fpga2sdram2_ar_id ),
	.f_ar_len( fpga2sdram2_ar_len ),
	.f_ar_lock( fpga2sdram2_ar_lock ),
	.f_ar_prot( fpga2sdram2_ar_prot ),
	.f_ar_size( fpga2sdram2_ar_size ),
	.f_ar_user( fpga2sdram2_ar_user ),
	.f_ar_valid( fpga2sdram2_ar_valid ),
	.f_aw_addr( fpga2sdram2_aw_addr ),
	.f_aw_burst( fpga2sdram2_aw_burst ),
	.f_aw_cache( fpga2sdram2_aw_cache ),
	.f_aw_id( fpga2sdram2_aw_id ),
	.f_aw_len( fpga2sdram2_aw_len ),
	.f_aw_lock( fpga2sdram2_aw_lock ),
	.f_aw_prot( fpga2sdram2_aw_prot ),
	.f_aw_size( fpga2sdram2_aw_size ),
	.f_aw_user( fpga2sdram2_aw_user ),
	.f_aw_valid( fpga2sdram2_aw_valid ),
	.f_b_ready( fpga2sdram2_b_ready ),
	.f_r_ready( fpga2sdram2_r_ready ),
	.f_w_data( fpga2sdram2_w_data ),
	.f_w_id( fpga2sdram2_w_id ),
	.f_w_last( fpga2sdram2_w_last ),
	.f_w_strb( fpga2sdram2_w_strb ),
	.f_w_valid( fpga2sdram2_w_valid ),
	.rst_n( f2s_sdram2_rst_n ),
	.s_ar_ready( s2_ar_ready ),
	.s_aw_ready( s2_aw_ready ),
	.s_b_id( s2_b_id ),
	.s_b_resp( s2_b_resp ),
	.s_b_valid( s2_b_valid ),
	.s_r_data( s2_r_data ),
	.s_r_id( s2_r_id ),
	.s_r_last( s2_r_last ),
	.s_r_resp( s2_r_resp ),
	.s_r_valid( s2_r_valid ),
	.s_ready_latency( fpga2sdram_port_size_config[3] ),
	.s_w_ready( s2_w_ready ),
	.f_ar_ready( fpga2sdram2_ar_ready ),
	.f_aw_ready( fpga2sdram2_aw_ready ),
	.f_b_id( fpga2sdram2_b_id ),
	.f_b_resp( fpga2sdram2_b_resp ),
	.f_b_valid( fpga2sdram2_b_valid ),
	.f_r_data( fpga2sdram2_r_data ),
	.f_r_id(   fpga2sdram2_r_id ),
	.f_r_last( fpga2sdram2_r_last ),
	.f_r_resp( fpga2sdram2_r_resp ),
	.f_r_valid( fpga2sdram2_r_valid ),
	.f_w_ready( fpga2sdram2_w_ready ),
	.s_ar_addr( s2_ar_addr ),
	.s_ar_burst( s2_ar_burst ),
	.s_ar_cache( s2_ar_cache ),
	.s_ar_id( s2_ar_id ),
	.s_ar_len( s2_ar_len ),
	.s_ar_lock( s2_ar_lock ),
	.s_ar_prot( s2_ar_prot ),
	.s_ar_size( s2_ar_size ),
	.s_ar_user( s2_ar_user ),
	.s_ar_valid( s2_ar_valid ),
	.s_aw_addr( s2_aw_addr ),
	.s_aw_burst( s2_aw_burst ),
	.s_aw_cache( s2_aw_cache ),
	.s_aw_id( s2_aw_id ),
	.s_aw_len( s2_aw_len ),
	.s_aw_lock( s2_aw_lock ),
	.s_aw_prot( s2_aw_prot ),
	.s_aw_size( s2_aw_size ),
	.s_aw_user( s2_aw_user ),
	.s_aw_valid( s2_aw_valid ),
	.s_b_ready( s2_b_ready ),
	.s_r_ready( s2_r_ready ),
	.s_w_data( s2_w_data ),
	.s_w_id( s2_w_id ),
	.s_w_last( s2_w_last ),
	.s_w_strb( s2_w_strb ),
	.s_w_valid( s2_w_valid )
);

twentynm_hps_interface_fpga2sdram fpga2sdram_0_instance(
  .f2s_sdram0_ar_clk(f2s_sdram0_ar_clk),
  .f2s_sdram0_aw_clk(f2s_sdram0_aw_clk),
  .f2s_sdram0_b_clk(f2s_sdram0_b_clk),
  .f2s_sdram0_clk(f2s_sdram0_clk),
  .f2s_sdram0_r_clk(f2s_sdram0_r_clk),
  .f2s_sdram0_w_clk(f2s_sdram0_w_clk),
  .f2s_sdram1_ar_clk(f2s_sdram1_ar_clk),
  .f2s_sdram1_aw_clk(f2s_sdram1_aw_clk),
  .f2s_sdram1_b_clk(f2s_sdram1_b_clk),
  .f2s_sdram1_clk(f2s_sdram1_clk),
  .f2s_sdram1_r_clk(f2s_sdram1_r_clk),
  .f2s_sdram1_w_clk(f2s_sdram1_w_clk),
  .f2s_sdram2_ar_clk(f2s_sdram2_ar_clk),
  .f2s_sdram2_aw_clk(f2s_sdram2_aw_clk),
  .f2s_sdram2_b_clk(f2s_sdram2_b_clk),
  .f2s_sdram2_clk(f2s_sdram2_clk),
  .f2s_sdram2_r_clk(f2s_sdram2_r_clk),
  .f2s_sdram2_w_clk(f2s_sdram2_w_clk),
  .fpga2sdram_port_size_config(fpga2sdram_port_size_config),
  .fpga2sdram0_ar_ready(w_fpga2sdram0_ar_ready),
  .fpga2sdram0_ar_valid(w_fpga2sdram0_ar_valid),
  .fpga2sdram0_aw_ready(w_fpga2sdram0_aw_ready),
  .fpga2sdram0_aw_valid(w_fpga2sdram0_aw_valid),
  .fpga2sdram0_b_ready(w_fpga2sdram0_b_ready),
  .fpga2sdram0_b_valid(w_fpga2sdram0_b_valid),
  .fpga2sdram0_req_addr(w_fpga2sdram0_req_addr),
  .fpga2sdram0_req_be(w_fpga2sdram0_req_be),
  .fpga2sdram0_req_data(w_fpga2sdram0_req_data),
  .fpga2sdram0_req_exclid(w_fpga2sdram0_req_exclid),
  .fpga2sdram0_req_hurry(w_fpga2sdram0_req_hurry),
  .fpga2sdram0_req_last(w_fpga2sdram0_req_last),
  .fpga2sdram0_req_length(w_fpga2sdram0_req_length),
  .fpga2sdram0_req_opc(w_fpga2sdram0_req_opc),
  .fpga2sdram0_req_press(w_fpga2sdram0_req_press),
  .fpga2sdram0_req_rdy(w_fpga2sdram0_req_rdy),
  .fpga2sdram0_req_seqid(w_fpga2sdram0_req_seqid),
  .fpga2sdram0_req_trid(w_fpga2sdram0_req_trid),
  .fpga2sdram0_req_urgency(w_fpga2sdram0_req_urgency),
  .fpga2sdram0_req_user(w_fpga2sdram0_req_user),
  .fpga2sdram0_req_vld(w_fpga2sdram0_req_vld),
  .fpga2sdram0_rsp_cont(w_fpga2sdram0_rsp_cont),
  .fpga2sdram0_rsp_data(w_fpga2sdram0_rsp_data),
  .fpga2sdram0_rsp_last(w_fpga2sdram0_rsp_last),
  .fpga2sdram0_rsp_rdy(w_fpga2sdram0_rsp_rdy),
  .fpga2sdram0_rsp_status(w_fpga2sdram0_rsp_status),
  .fpga2sdram0_rsp_trid(w_fpga2sdram0_rsp_trid),
  .fpga2sdram0_rsp_vld(w_fpga2sdram0_rsp_vld),
  .fpga2sdram1_ar_ready(w_fpga2sdram1_ar_ready),
  .fpga2sdram1_ar_valid(w_fpga2sdram1_ar_valid),
  .fpga2sdram1_aw_ready(w_fpga2sdram1_aw_ready),
  .fpga2sdram1_aw_valid(w_fpga2sdram1_aw_valid),
  .fpga2sdram1_b_ready(w_fpga2sdram1_b_ready),
  .fpga2sdram1_b_valid(w_fpga2sdram1_b_valid),
  .fpga2sdram1_req_addr(w_fpga2sdram1_req_addr),
  .fpga2sdram1_req_be(w_fpga2sdram1_req_be),
  .fpga2sdram1_req_data(w_fpga2sdram1_req_data),
  .fpga2sdram1_req_exclid(w_fpga2sdram1_req_exclid),
  .fpga2sdram1_req_hurry(w_fpga2sdram1_req_hurry),
  .fpga2sdram1_req_last(w_fpga2sdram1_req_last),
  .fpga2sdram1_req_length(w_fpga2sdram1_req_length),
  .fpga2sdram1_req_opc(w_fpga2sdram1_req_opc),
  .fpga2sdram1_req_press(w_fpga2sdram1_req_press),
  .fpga2sdram1_req_rdy(w_fpga2sdram1_req_rdy),
  .fpga2sdram1_req_seqid(w_fpga2sdram1_req_seqid),
  .fpga2sdram1_req_trid(w_fpga2sdram1_req_trid),
  .fpga2sdram1_req_urgency(w_fpga2sdram1_req_urgency),
  .fpga2sdram1_req_user(w_fpga2sdram1_req_user),
  .fpga2sdram1_req_vld(w_fpga2sdram1_req_vld),
  .fpga2sdram1_rsp_cont(w_fpga2sdram1_rsp_cont),
  .fpga2sdram1_rsp_data(w_fpga2sdram1_rsp_data),
  .fpga2sdram1_rsp_last(w_fpga2sdram1_rsp_last),
  .fpga2sdram1_rsp_rdy(w_fpga2sdram1_rsp_rdy),
  .fpga2sdram1_rsp_status(w_fpga2sdram1_rsp_status),
  .fpga2sdram1_rsp_trid(w_fpga2sdram1_rsp_trid),
  .fpga2sdram1_rsp_vld(w_fpga2sdram1_rsp_vld),
  .fpga2sdram2_ar_ready(w_fpga2sdram2_ar_ready),
  .fpga2sdram2_ar_valid(w_fpga2sdram2_ar_valid),
  .fpga2sdram2_aw_ready(w_fpga2sdram2_aw_ready),
  .fpga2sdram2_aw_valid(w_fpga2sdram2_aw_valid),
  .fpga2sdram2_b_ready(w_fpga2sdram2_b_ready),
  .fpga2sdram2_b_valid(w_fpga2sdram2_b_valid),
  .fpga2sdram2_req_addr(w_fpga2sdram2_req_addr),
  .fpga2sdram2_req_be(w_fpga2sdram2_req_be),
  .fpga2sdram2_req_data(w_fpga2sdram2_req_data),
  .fpga2sdram2_req_exclid(w_fpga2sdram2_req_exclid),
  .fpga2sdram2_req_hurry(w_fpga2sdram2_req_hurry),
  .fpga2sdram2_req_last(w_fpga2sdram2_req_last),
  .fpga2sdram2_req_length(w_fpga2sdram2_req_length),
  .fpga2sdram2_req_opc(w_fpga2sdram2_req_opc),
  .fpga2sdram2_req_press(w_fpga2sdram2_req_press),
  .fpga2sdram2_req_rdy(w_fpga2sdram2_req_rdy),
  .fpga2sdram2_req_seqid(w_fpga2sdram2_req_seqid),
  .fpga2sdram2_req_trid(w_fpga2sdram2_req_trid),
  .fpga2sdram2_req_urgency(w_fpga2sdram2_req_urgency),
  .fpga2sdram2_req_user(w_fpga2sdram2_req_user),
  .fpga2sdram2_req_vld(w_fpga2sdram2_req_vld),
  .fpga2sdram2_rsp_cont(w_fpga2sdram2_rsp_cont),
  .fpga2sdram2_rsp_data(w_fpga2sdram2_rsp_data),
  .fpga2sdram2_rsp_last(w_fpga2sdram2_rsp_last),
  .fpga2sdram2_rsp_rdy(w_fpga2sdram2_rsp_rdy),
  .fpga2sdram2_rsp_status(w_fpga2sdram2_rsp_status),
  .fpga2sdram2_rsp_trid(w_fpga2sdram2_rsp_trid),
  .fpga2sdram2_rsp_vld(w_fpga2sdram2_rsp_vld)
);
defparam fpga2sdram_0_instance.mode = mode;

endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
`timescale 1 ps / 1 ps
module twentynm_hps_rl_mode1_fpga2sdram #(
  parameter DEPTH   = 4,
  parameter DWIDTH0 = 16,
  parameter DWIDTH1 = 16,
  parameter DWIDTH2 = 16,
  parameter mode    = 2
)(
  input   wire           f2s_sdram0_ar_clk,
  input   wire           f2s_sdram0_aw_clk,
  input   wire           f2s_sdram0_b_clk,
  input   wire           f2s_sdram0_clk,
  input   wire           f2s_sdram0_r_clk,
  input   wire           f2s_sdram0_w_clk,
  input   wire           f2s_sdram1_ar_clk,
  input   wire           f2s_sdram1_aw_clk,
  input   wire           f2s_sdram1_b_clk,
  input   wire           f2s_sdram1_clk,
  input   wire           f2s_sdram1_r_clk,
  input   wire           f2s_sdram1_w_clk,
  input   wire           f2s_sdram2_ar_clk,
  input   wire           f2s_sdram2_aw_clk,
  input   wire           f2s_sdram2_b_clk,
  input   wire           f2s_sdram2_clk,
  input   wire           f2s_sdram2_r_clk,
  input   wire           f2s_sdram2_w_clk,
  input   wire           f2s_sdram0_rst_n,
  input   wire           f2s_sdram1_rst_n,
  input   wire           f2s_sdram2_rst_n,
  input   wire [ 32-1:0] fpga2sdram0_ar_addr,
  input   wire [    3:0] fpga2sdram_port_size_config,
  input   wire [  2-1:0] fpga2sdram0_ar_burst,
  input   wire [  4-1:0] fpga2sdram0_ar_cache,
  input   wire [  4-1:0] fpga2sdram0_ar_id,
  input   wire [  4-1:0] fpga2sdram0_ar_len,
  input   wire [  2-1:0] fpga2sdram0_ar_lock,
  input   wire [  3-1:0] fpga2sdram0_ar_prot,
  output  wire [  1-1:0] fpga2sdram0_ar_ready,
  input   wire [  3-1:0] fpga2sdram0_ar_size,
  input   wire [  5-1:0] fpga2sdram0_ar_user,
  input   wire [  1-1:0] fpga2sdram0_ar_valid,
  input   wire [ 32-1:0] fpga2sdram0_aw_addr,
  input   wire [  2-1:0] fpga2sdram0_aw_burst,
  input   wire [  4-1:0] fpga2sdram0_aw_cache,
  input   wire [  4-1:0] fpga2sdram0_aw_id,
  input   wire [  4-1:0] fpga2sdram0_aw_len,
  input   wire [  2-1:0] fpga2sdram0_aw_lock,
  input   wire [  3-1:0] fpga2sdram0_aw_prot,
  output  wire [  1-1:0] fpga2sdram0_aw_ready,
  input   wire [  3-1:0] fpga2sdram0_aw_size,
  input   wire [  5-1:0] fpga2sdram0_aw_user,
  input   wire [  1-1:0] fpga2sdram0_aw_valid,
  output  wire [  4-1:0] fpga2sdram0_b_id,
  input   wire [  1-1:0] fpga2sdram0_b_ready,
  output  wire [  2-1:0] fpga2sdram0_b_resp,
  output  wire [  1-1:0] fpga2sdram0_b_valid,
  output  wire [ 64-1:0] fpga2sdram0_r_data,
  output  wire [  4-1:0] fpga2sdram0_r_id,
  output  wire [  1-1:0] fpga2sdram0_r_last,
  input   wire [  1-1:0] fpga2sdram0_r_ready,
  output  wire [  2-1:0] fpga2sdram0_r_resp,
  output  wire [  1-1:0] fpga2sdram0_r_valid,
  input   wire [ 64-1:0] fpga2sdram0_w_data,
  input   wire [  4-1:0] fpga2sdram0_w_id,
  input   wire [  1-1:0] fpga2sdram0_w_last,
  output  wire [  1-1:0] fpga2sdram0_w_ready,
  input   wire [  8-1:0] fpga2sdram0_w_strb,
  input   wire [  1-1:0] fpga2sdram0_w_valid,
  input   wire [ 32-1:0] fpga2sdram1_ar_addr,
  input   wire [  2-1:0] fpga2sdram1_ar_burst,
  input   wire [  4-1:0] fpga2sdram1_ar_cache,
  input   wire [  4-1:0] fpga2sdram1_ar_id,
  input   wire [  4-1:0] fpga2sdram1_ar_len,
  input   wire [  2-1:0] fpga2sdram1_ar_lock,
  input   wire [  3-1:0] fpga2sdram1_ar_prot,
  output  wire [  1-1:0] fpga2sdram1_ar_ready,
  input   wire [  3-1:0] fpga2sdram1_ar_size,
  input   wire [  5-1:0] fpga2sdram1_ar_user,
  input   wire [  1-1:0] fpga2sdram1_ar_valid,
  input   wire [ 32-1:0] fpga2sdram1_aw_addr,
  input   wire [  2-1:0] fpga2sdram1_aw_burst,
  input   wire [  4-1:0] fpga2sdram1_aw_cache,
  input   wire [  4-1:0] fpga2sdram1_aw_id,
  input   wire [  4-1:0] fpga2sdram1_aw_len,
  input   wire [  2-1:0] fpga2sdram1_aw_lock,
  input   wire [  3-1:0] fpga2sdram1_aw_prot,
  output  wire [  1-1:0] fpga2sdram1_aw_ready,
  input   wire [  3-1:0] fpga2sdram1_aw_size,
  input   wire [  5-1:0] fpga2sdram1_aw_user,
  input   wire [  1-1:0] fpga2sdram1_aw_valid,
  output  wire [  4-1:0] fpga2sdram1_b_id,
  input   wire [  1-1:0] fpga2sdram1_b_ready,
  output  wire [  2-1:0] fpga2sdram1_b_resp,
  output  wire [  1-1:0] fpga2sdram1_b_valid,
  output  wire [ 64-1:0] fpga2sdram1_r_data,
  output  wire [  4-1:0] fpga2sdram1_r_id,
  output  wire [  1-1:0] fpga2sdram1_r_last,
  input   wire [  1-1:0] fpga2sdram1_r_ready,
  output  wire [  2-1:0] fpga2sdram1_r_resp,
  output  wire [  1-1:0] fpga2sdram1_r_valid,
  input   wire [ 64-1:0] fpga2sdram1_w_data,
  input   wire [  4-1:0] fpga2sdram1_w_id,
  input   wire [  1-1:0] fpga2sdram1_w_last,
  output  wire [  1-1:0] fpga2sdram1_w_ready,
  input   wire [  8-1:0] fpga2sdram1_w_strb,
  input   wire [  1-1:0] fpga2sdram1_w_valid,
  input   wire [ 32-1:0] fpga2sdram2_ar_addr,
  input   wire [  2-1:0] fpga2sdram2_ar_burst,
  input   wire [  4-1:0] fpga2sdram2_ar_cache,
  input   wire [  4-1:0] fpga2sdram2_ar_id,
  input   wire [  4-1:0] fpga2sdram2_ar_len,
  input   wire [  2-1:0] fpga2sdram2_ar_lock,
  input   wire [  3-1:0] fpga2sdram2_ar_prot,
  output  wire [  1-1:0] fpga2sdram2_ar_ready,
  input   wire [  3-1:0] fpga2sdram2_ar_size,
  input   wire [  5-1:0] fpga2sdram2_ar_user,
  input   wire [  1-1:0] fpga2sdram2_ar_valid,
  input   wire [ 32-1:0] fpga2sdram2_aw_addr,
  input   wire [  2-1:0] fpga2sdram2_aw_burst,
  input   wire [  4-1:0] fpga2sdram2_aw_cache,
  input   wire [  4-1:0] fpga2sdram2_aw_id,
  input   wire [  4-1:0] fpga2sdram2_aw_len,
  input   wire [  2-1:0] fpga2sdram2_aw_lock,
  input   wire [  3-1:0] fpga2sdram2_aw_prot,
  output  wire [  1-1:0] fpga2sdram2_aw_ready,
  input   wire [  3-1:0] fpga2sdram2_aw_size,
  input   wire [  5-1:0] fpga2sdram2_aw_user,
  input   wire [  1-1:0] fpga2sdram2_aw_valid,
  output  wire [  4-1:0] fpga2sdram2_b_id,
  input   wire [  1-1:0] fpga2sdram2_b_ready,
  output  wire [  2-1:0] fpga2sdram2_b_resp,
  output  wire [  1-1:0] fpga2sdram2_b_valid,
  output  wire [ 64-1:0] fpga2sdram2_r_data,
  output  wire [  4-1:0] fpga2sdram2_r_id,
  output  wire [  1-1:0] fpga2sdram2_r_last,
  input   wire [  1-1:0] fpga2sdram2_r_ready,
  output  wire [  2-1:0] fpga2sdram2_r_resp,
  output  wire [  1-1:0] fpga2sdram2_r_valid,
  input   wire [ 64-1:0] fpga2sdram2_w_data,
  input   wire [  4-1:0] fpga2sdram2_w_id,
  input   wire [  1-1:0] fpga2sdram2_w_last,
  output  wire [  1-1:0] fpga2sdram2_w_ready,
  input   wire [  8-1:0] fpga2sdram2_w_strb,
  input   wire [  1-1:0] fpga2sdram2_w_valid
);

localparam DWIDTH = 64;

wire [  1-1:0] w_fpga2sdram0_ar_ready;
wire [  1-1:0] w_fpga2sdram0_ar_valid;
wire [  1-1:0] w_fpga2sdram0_aw_ready;
wire [  1-1:0] w_fpga2sdram0_aw_valid;
wire [  1-1:0] w_fpga2sdram0_b_ready;
wire [  1-1:0] w_fpga2sdram0_b_valid;
wire [ 32-1:0] w_fpga2sdram0_req_addr;
wire [ 16-1:0] w_fpga2sdram0_req_be;
wire [128-1:0] w_fpga2sdram0_req_data;
wire [  4-1:0] w_fpga2sdram0_req_exclid;
wire [  2-1:0] w_fpga2sdram0_req_hurry;
wire [  1-1:0] w_fpga2sdram0_req_last;
wire [  8-1:0] w_fpga2sdram0_req_length;
wire [  3-1:0] w_fpga2sdram0_req_opc;
wire [  2-1:0] w_fpga2sdram0_req_press;
wire [  1-1:0] w_fpga2sdram0_req_rdy;
wire [  4-1:0] w_fpga2sdram0_req_seqid;
wire [  3-1:0] w_fpga2sdram0_req_trid;
wire [  2-1:0] w_fpga2sdram0_req_urgency;
wire [ 12-1:0] w_fpga2sdram0_req_user;
wire [  1-1:0] w_fpga2sdram0_req_vld;
wire [  1-1:0] w_fpga2sdram0_rsp_cont;
wire [128-1:0] w_fpga2sdram0_rsp_data;
wire [  1-1:0] w_fpga2sdram0_rsp_last;
wire [  1-1:0] w_fpga2sdram0_rsp_rdy;
wire [  2-1:0] w_fpga2sdram0_rsp_status;
wire [  3-1:0] w_fpga2sdram0_rsp_trid;
wire [  1-1:0] w_fpga2sdram0_rsp_vld;
wire [  1-1:0] w_fpga2sdram1_ar_ready;
wire [  1-1:0] w_fpga2sdram1_ar_valid;
wire [  1-1:0] w_fpga2sdram1_aw_ready;
wire [  1-1:0] w_fpga2sdram1_aw_valid;
wire [  1-1:0] w_fpga2sdram1_b_ready;
wire [  1-1:0] w_fpga2sdram1_b_valid;
wire [ 32-1:0] w_fpga2sdram1_req_addr;
wire [ 16-1:0] w_fpga2sdram1_req_be;
wire [128-1:0] w_fpga2sdram1_req_data;
wire [  4-1:0] w_fpga2sdram1_req_exclid;
wire [  2-1:0] w_fpga2sdram1_req_hurry;
wire [  1-1:0] w_fpga2sdram1_req_last;
wire [  8-1:0] w_fpga2sdram1_req_length;
wire [  3-1:0] w_fpga2sdram1_req_opc;
wire [  2-1:0] w_fpga2sdram1_req_press;
wire [  1-1:0] w_fpga2sdram1_req_rdy;
wire [  4-1:0] w_fpga2sdram1_req_seqid;
wire [  3-1:0] w_fpga2sdram1_req_trid;
wire [  2-1:0] w_fpga2sdram1_req_urgency;
wire [ 12-1:0] w_fpga2sdram1_req_user;
wire [  1-1:0] w_fpga2sdram1_req_vld;
wire [  1-1:0] w_fpga2sdram1_rsp_cont;
wire [122-1:0] w_fpga2sdram1_rsp_data;
wire [  1-1:0] w_fpga2sdram1_rsp_last;
wire [  1-1:0] w_fpga2sdram1_rsp_rdy;
wire [  2-1:0] w_fpga2sdram1_rsp_status;
wire [  3-1:0] w_fpga2sdram1_rsp_trid;
wire [  1-1:0] w_fpga2sdram1_rsp_vld;
wire [  1-1:0] w_fpga2sdram2_ar_ready;
wire [  1-1:0] w_fpga2sdram2_ar_valid;
wire [  1-1:0] w_fpga2sdram2_aw_ready;
wire [  1-1:0] w_fpga2sdram2_aw_valid;
wire [  1-1:0] w_fpga2sdram2_b_ready;
wire [  1-1:0] w_fpga2sdram2_b_valid;
wire [ 32-1:0] w_fpga2sdram2_req_addr;
wire [ 16-1:0] w_fpga2sdram2_req_be;
wire [128-1:0] w_fpga2sdram2_req_data;
wire [  4-1:0] w_fpga2sdram2_req_exclid;
wire [  2-1:0] w_fpga2sdram2_req_hurry;
wire [  1-1:0] w_fpga2sdram2_req_last;
wire [  8-1:0] w_fpga2sdram2_req_length;
wire [  3-1:0] w_fpga2sdram2_req_opc;
wire [  2-1:0] w_fpga2sdram2_req_press;
wire [  1-1:0] w_fpga2sdram2_req_rdy;
wire [  4-1:0] w_fpga2sdram2_req_seqid;
wire [  3-1:0] w_fpga2sdram2_req_trid;
wire [  2-1:0] w_fpga2sdram2_req_urgency;
wire [ 12-1:0] w_fpga2sdram2_req_user;
wire [  1-1:0] w_fpga2sdram2_req_vld;
wire [  1-1:0] w_fpga2sdram2_rsp_cont;
wire [ 70-1:0] w_fpga2sdram2_rsp_data;
wire [  1-1:0] w_fpga2sdram2_rsp_last;
wire [  1-1:0] w_fpga2sdram2_rsp_rdy;
wire [  2-1:0] w_fpga2sdram2_rsp_status;
wire [  3-1:0] w_fpga2sdram2_rsp_trid;
wire [  1-1:0] w_fpga2sdram2_rsp_vld;

wire                     s0_ar_ready;
wire                     s0_aw_ready;
wire               [3:0] s0_b_id;
wire               [1:0] s0_b_resp;
wire                     s0_b_valid;
wire        [DWIDTH-1:0] s0_r_data;
wire               [3:0] s0_r_id;
wire                     s0_r_last;
wire               [1:0] s0_r_resp;
wire                     s0_r_valid;
wire                     s0_w_ready;
wire             [31:0] s0_ar_addr;
wire              [1:0] s0_ar_burst;
wire              [3:0] s0_ar_cache;
wire              [3:0] s0_ar_id;
wire              [3:0] s0_ar_len;
wire              [1:0] s0_ar_lock;
wire              [2:0] s0_ar_prot;
wire              [2:0] s0_ar_size;
wire              [4:0] s0_ar_user;
wire                    s0_ar_valid;
wire             [31:0] s0_aw_addr;
wire              [1:0] s0_aw_burst;
wire              [3:0] s0_aw_cache;
wire              [3:0] s0_aw_id;
wire              [3:0] s0_aw_len;
wire              [1:0] s0_aw_lock;
wire              [2:0] s0_aw_prot;
wire              [2:0] s0_aw_size;
wire              [4:0] s0_aw_user;
wire                    s0_aw_valid;
wire                    s0_b_ready;
wire                    s0_r_ready;
wire       [DWIDTH-1:0] s0_w_data;
wire              [3:0] s0_w_id;
wire                    s0_w_last;
wire     [DWIDTH/8-1:0] s0_w_strb;
wire                    s0_w_valid;

wire                     s1_ar_ready;
wire                     s1_aw_ready;
wire               [3:0] s1_b_id;
wire               [1:0] s1_b_resp;
wire                     s1_b_valid;
wire        [DWIDTH-1:0] s1_r_data;
wire               [3:0] s1_r_id;
wire                     s1_r_last;
wire               [1:0] s1_r_resp;
wire                     s1_r_valid;
wire                     s1_w_ready;
wire             [31:0] s1_ar_addr;
wire              [1:0] s1_ar_burst;
wire              [3:0] s1_ar_cache;
wire              [3:0] s1_ar_id;
wire              [3:0] s1_ar_len;
wire              [1:0] s1_ar_lock;
wire              [2:0] s1_ar_prot;
wire              [2:0] s1_ar_size;
wire              [4:0] s1_ar_user;
wire                    s1_ar_valid;
wire             [31:0] s1_aw_addr;
wire              [1:0] s1_aw_burst;
wire              [3:0] s1_aw_cache;
wire              [3:0] s1_aw_id;
wire              [3:0] s1_aw_len;
wire              [1:0] s1_aw_lock;
wire              [2:0] s1_aw_prot;
wire              [2:0] s1_aw_size;
wire              [4:0] s1_aw_user;
wire                    s1_aw_valid;
wire                    s1_b_ready;
wire                    s1_r_ready;
wire       [DWIDTH-1:0] s1_w_data;
wire              [3:0] s1_w_id;
wire                    s1_w_last;
wire     [DWIDTH/8-1:0] s1_w_strb;
wire                    s1_w_valid;

wire                     s2_ar_ready;
wire                     s2_aw_ready;
wire               [3:0] s2_b_id;
wire               [1:0] s2_b_resp;
wire                     s2_b_valid;
wire        [DWIDTH-1:0] s2_r_data;
wire               [3:0] s2_r_id;
wire                     s2_r_last;
wire               [1:0] s2_r_resp;
wire                     s2_r_valid;
wire                     s2_w_ready;
wire             [31:0] s2_ar_addr;
wire              [1:0] s2_ar_burst;
wire              [3:0] s2_ar_cache;
wire              [3:0] s2_ar_id;
wire              [3:0] s2_ar_len;
wire              [1:0] s2_ar_lock;
wire              [2:0] s2_ar_prot;
wire              [2:0] s2_ar_size;
wire              [4:0] s2_ar_user;
wire                    s2_ar_valid;
wire             [31:0] s2_aw_addr;
wire              [1:0] s2_aw_burst;
wire              [3:0] s2_aw_cache;
wire              [3:0] s2_aw_id;
wire              [3:0] s2_aw_len;
wire              [1:0] s2_aw_lock;
wire              [2:0] s2_aw_prot;
wire              [2:0] s2_aw_size;
wire              [4:0] s2_aw_user;
wire                    s2_aw_valid;
wire                    s2_b_ready;
wire                    s2_r_ready;
wire       [DWIDTH-1:0] s2_w_data;
wire              [3:0] s2_w_id;
wire                    s2_w_last;
wire     [DWIDTH/8-1:0] s2_w_strb;
wire                    s2_w_valid;

assign s0_ar_ready 	= w_fpga2sdram0_ar_ready;
assign s0_aw_ready 	= w_fpga2sdram0_aw_ready;
assign s0_b_id[3:0] 	= w_fpga2sdram0_rsp_data[125:122];
assign s0_b_resp[1:0] 	= w_fpga2sdram0_rsp_data[127:126];
assign s0_b_valid 	= w_fpga2sdram0_b_valid;
assign s0_r_data[31:0] 	= w_fpga2sdram0_rsp_data[31:0];
assign s0_r_data[63:32] 	= w_fpga2sdram0_rsp_data[63:32];
assign s0_r_id[2:0] 	= w_fpga2sdram0_rsp_trid[2:0];
assign s0_r_id[3] 	= w_fpga2sdram0_rsp_cont;
assign s0_r_last 	= w_fpga2sdram0_rsp_last;
assign s0_r_resp[1:0] 	= w_fpga2sdram0_rsp_status[1:0];
assign s0_r_valid 	= w_fpga2sdram0_rsp_vld;
assign s0_w_ready 	= w_fpga2sdram0_req_rdy;
assign s1_ar_ready 	= w_fpga2sdram1_ar_ready;
assign s1_aw_ready 	= w_fpga2sdram1_aw_ready;
assign s1_b_id[3:0] 	= w_fpga2sdram1_rsp_data[119:116];
assign s1_b_resp[1:0] 	= w_fpga2sdram1_rsp_data[121:120];
assign s1_b_valid 	= w_fpga2sdram1_b_valid;
assign s1_r_data[31:0] 	= w_fpga2sdram1_rsp_data[31:0];
assign s1_r_data[63:32] 	= w_fpga2sdram1_rsp_data[63:32];
assign s1_r_id[2:0] 	= w_fpga2sdram1_rsp_trid[2:0];
assign s1_r_id[3] 	= w_fpga2sdram1_rsp_cont;
assign s1_r_last 	= w_fpga2sdram1_rsp_last;
assign s1_r_resp[1:0] 	= w_fpga2sdram1_rsp_status[1:0];
assign s1_r_valid 	= w_fpga2sdram1_rsp_vld;
assign s1_w_ready 	= w_fpga2sdram1_req_rdy;
assign s2_ar_ready 	= w_fpga2sdram2_ar_ready;
assign s2_aw_ready 	= w_fpga2sdram2_aw_ready;
assign s2_b_id[3:0] 	= w_fpga2sdram2_rsp_data[67:64];
assign s2_b_resp[1:0] 	= w_fpga2sdram2_rsp_data[69:68];
assign s2_b_valid 	= w_fpga2sdram2_b_valid;
assign s2_r_data[31:0] 	= w_fpga2sdram2_rsp_data[31:0];
assign s2_r_data[63:32] 	= w_fpga2sdram2_rsp_data[63:32];
assign s2_r_id[2:0] 	= w_fpga2sdram2_rsp_trid[2:0];
assign s2_r_id[3] 	= w_fpga2sdram2_rsp_cont;
assign s2_r_last 	= w_fpga2sdram2_rsp_last;
assign s2_r_resp[1:0] 	= w_fpga2sdram2_rsp_status[1:0];
assign s2_r_valid 	= w_fpga2sdram2_rsp_vld;
assign s2_w_ready 	= w_fpga2sdram2_req_rdy;
assign w_fpga2sdram0_ar_valid 	= s0_ar_valid;
assign w_fpga2sdram0_aw_valid 	= s0_aw_valid;
assign w_fpga2sdram0_b_ready 	= s0_b_ready;
assign w_fpga2sdram0_req_addr[31:0] 	= s0_aw_addr[31:0];
assign w_fpga2sdram0_req_be[11:8] 	= s0_ar_cache[3:0];
assign w_fpga2sdram0_req_be[15:12] 	= s0_ar_id[3:0];
assign w_fpga2sdram0_req_be[3:0] 	= s0_w_strb[3:0];
assign w_fpga2sdram0_req_be[7:4] 	= s0_w_strb[7:4];
assign w_fpga2sdram0_req_data[127:96] 	= s0_ar_addr[31:0];
assign w_fpga2sdram0_req_data[31:0] 	= s0_w_data[31:0];
assign w_fpga2sdram0_req_data[63:32] 	= s0_w_data[63:32];
assign w_fpga2sdram0_req_data[87:86] 	= s0_ar_lock[1:0];
assign w_fpga2sdram0_req_data[90:88] 	= s0_ar_size[2:0];
assign w_fpga2sdram0_req_data[95:91] 	= s0_ar_user[4:0];
assign w_fpga2sdram0_req_exclid[3:0] 	= s0_w_id[3:0];
assign w_fpga2sdram0_req_hurry[1:0] 	= s0_aw_lock[1:0];
assign w_fpga2sdram0_req_last 	= s0_w_last;
assign w_fpga2sdram0_req_length[3:0] 	= s0_aw_len[3:0];
assign w_fpga2sdram0_req_length[7:4] 	= s0_ar_len[3:0];
assign w_fpga2sdram0_req_opc[2:0] 	= s0_aw_size[2:0];
assign w_fpga2sdram0_req_press[1:0] 	= s0_aw_burst[1:0];
assign w_fpga2sdram0_req_seqid[3:0] 	= s0_aw_id[3:0];
assign w_fpga2sdram0_req_trid[2:0] 	= s0_ar_prot[2:0];
assign w_fpga2sdram0_req_urgency[1:0] 	= s0_ar_burst[1:0];
assign w_fpga2sdram0_req_user[11:7] 	= s0_aw_user[4:0];
assign w_fpga2sdram0_req_user[3:0] 	= s0_aw_cache[3:0];
assign w_fpga2sdram0_req_user[6:4] 	= s0_aw_prot[2:0];
assign w_fpga2sdram0_req_vld 	= s0_w_valid;
assign w_fpga2sdram0_rsp_rdy 	= s0_r_ready;
assign w_fpga2sdram1_ar_valid 	= s1_ar_valid;
assign w_fpga2sdram1_aw_valid 	= s1_aw_valid;
assign w_fpga2sdram1_b_ready 	= s1_b_ready;
assign w_fpga2sdram1_req_addr[31:0] 	= s1_aw_addr[31:0];
assign w_fpga2sdram1_req_be[11:8] 	= s1_ar_cache[3:0];
assign w_fpga2sdram1_req_be[15:12] 	= s1_ar_id[3:0];
assign w_fpga2sdram1_req_be[3:0] 	= s1_w_strb[3:0];
assign w_fpga2sdram1_req_be[7:4] 	= s1_w_strb[7:4];
assign w_fpga2sdram1_req_data[127:96] 	= s1_ar_addr[31:0];
assign w_fpga2sdram1_req_data[31:0] 	= s1_w_data[31:0];
assign w_fpga2sdram1_req_data[63:32] 	= s1_w_data[63:32];
assign w_fpga2sdram1_req_data[87:86] 	= s1_ar_lock[1:0];
assign w_fpga2sdram1_req_data[90:88] 	= s1_ar_size[2:0];
assign w_fpga2sdram1_req_data[95:91] 	= s1_ar_user[4:0];
assign w_fpga2sdram1_req_exclid[3:0] 	= s1_w_id[3:0];
assign w_fpga2sdram1_req_hurry[1:0] 	= s1_aw_lock[1:0];
assign w_fpga2sdram1_req_last 	= s1_w_last;
assign w_fpga2sdram1_req_length[3:0] 	= s1_aw_len[3:0];
assign w_fpga2sdram1_req_length[7:4] 	= s1_ar_len[3:0];
assign w_fpga2sdram1_req_opc[2:0] 	= s1_aw_size[2:0];
assign w_fpga2sdram1_req_press[1:0] 	= s1_aw_burst[1:0];
assign w_fpga2sdram1_req_seqid[3:0] 	= s1_aw_id[3:0];
assign w_fpga2sdram1_req_trid[2:0] 	= s1_ar_prot[2:0];
assign w_fpga2sdram1_req_urgency[1:0] 	= s1_ar_burst[1:0];
assign w_fpga2sdram1_req_user[11:7] 	= s1_aw_user[4:0];
assign w_fpga2sdram1_req_user[3:0] 	= s1_aw_cache[3:0];
assign w_fpga2sdram1_req_user[6:4] 	= s1_aw_prot[2:0];
assign w_fpga2sdram1_req_vld 	= s1_w_valid;
assign w_fpga2sdram1_rsp_rdy 	= s1_r_ready;
assign w_fpga2sdram2_ar_valid 	= s2_ar_valid;
assign w_fpga2sdram2_aw_valid 	= s2_aw_valid;
assign w_fpga2sdram2_b_ready 	= s2_b_ready;
assign w_fpga2sdram2_req_addr[31:0] 	= s2_aw_addr[31:0];
assign w_fpga2sdram2_req_be[11:8] 	= s2_ar_cache[3:0];
assign w_fpga2sdram2_req_be[15:12] 	= s2_ar_id[3:0];
assign w_fpga2sdram2_req_be[3:0] 	= s2_w_strb[3:0];
assign w_fpga2sdram2_req_be[7:4] 	= s2_w_strb[7:4];
assign w_fpga2sdram2_req_data[127:96] 	= s2_ar_addr[31:0];
assign w_fpga2sdram2_req_data[31:0] 	= s2_w_data[31:0];
assign w_fpga2sdram2_req_data[63:32] 	= s2_w_data[63:32];
assign w_fpga2sdram2_req_data[87:86] 	= s2_ar_lock[1:0];
assign w_fpga2sdram2_req_data[90:88] 	= s2_ar_size[2:0];
assign w_fpga2sdram2_req_data[95:91] 	= s2_ar_user[4:0];
assign w_fpga2sdram2_req_exclid[3:0] 	= s2_w_id[3:0];
assign w_fpga2sdram2_req_hurry[1:0] 	= s2_aw_lock[1:0];
assign w_fpga2sdram2_req_last 	= s2_w_last;
assign w_fpga2sdram2_req_length[3:0] 	= s2_aw_len[3:0];
assign w_fpga2sdram2_req_length[7:4] 	= s2_ar_len[3:0];
assign w_fpga2sdram2_req_opc[2:0] 	= s2_aw_size[2:0];
assign w_fpga2sdram2_req_press[1:0] 	= s2_aw_burst[1:0];
assign w_fpga2sdram2_req_seqid[3:0] 	= s2_aw_id[3:0];
assign w_fpga2sdram2_req_trid[2:0] 	= s2_ar_prot[2:0];
assign w_fpga2sdram2_req_urgency[1:0] 	= s2_ar_burst[1:0];
assign w_fpga2sdram2_req_user[11:7] 	= s2_aw_user[4:0];
assign w_fpga2sdram2_req_user[3:0] 	= s2_aw_cache[3:0];
assign w_fpga2sdram2_req_user[6:4] 	= s2_aw_prot[2:0];
assign w_fpga2sdram2_req_vld 	= s2_w_valid;
assign w_fpga2sdram2_rsp_rdy 	= s2_r_ready;
assign w_fpga2sdram0_req_data[85:64] 	= 22'b1111111111111111111111;
assign w_fpga2sdram2_req_data[85:64] 	= 22'b0000000000000000000000;

f2s_rl_delay_adp #( .DWIDTH(DWIDTH0),  .DEPTH(DEPTH) ) f2s_rl_adp_inst_0 (
	.clk( f2s_sdram0_ar_clk ),
	.f_ar_addr( fpga2sdram0_ar_addr ),
	.f_ar_burst( fpga2sdram0_ar_burst ),
	.f_ar_cache( fpga2sdram0_ar_cache ),
	.f_ar_id( fpga2sdram0_ar_id ),
	.f_ar_len( fpga2sdram0_ar_len ),
	.f_ar_lock( fpga2sdram0_ar_lock ),
	.f_ar_prot( fpga2sdram0_ar_prot ),
	.f_ar_size( fpga2sdram0_ar_size ),
	.f_ar_user( fpga2sdram0_ar_user ),
	.f_ar_valid( fpga2sdram0_ar_valid ),
	.f_aw_addr( fpga2sdram0_aw_addr ),
	.f_aw_burst( fpga2sdram0_aw_burst ),
	.f_aw_cache( fpga2sdram0_aw_cache ),
	.f_aw_id( fpga2sdram0_aw_id ),
	.f_aw_len( fpga2sdram0_aw_len ),
	.f_aw_lock( fpga2sdram0_aw_lock ),
	.f_aw_prot( fpga2sdram0_aw_prot ),
	.f_aw_size( fpga2sdram0_aw_size ),
	.f_aw_user( fpga2sdram0_aw_user ),
	.f_aw_valid( fpga2sdram0_aw_valid ),
	.f_b_ready( fpga2sdram0_b_ready ),
	.f_r_ready( fpga2sdram0_r_ready ),
	.f_w_data( fpga2sdram0_w_data ),
	.f_w_id( fpga2sdram0_w_id ),
	.f_w_last( fpga2sdram0_w_last ),
	.f_w_strb( fpga2sdram0_w_strb ),
	.f_w_valid( fpga2sdram0_w_valid ),
	.rst_n( f2s_sdram0_rst_n ),
	.s_ar_ready( s0_ar_ready ),
	.s_aw_ready( s0_aw_ready ),
	.s_b_id( s0_b_id ),
	.s_b_resp( s0_b_resp ),
	.s_b_valid( s0_b_valid ),
	.s_r_data( s0_r_data ),
	.s_r_id( s0_r_id ),
	.s_r_last( s0_r_last ),
	.s_r_resp( s0_r_resp ),
	.s_r_valid( s0_r_valid ),
	.s_ready_latency( fpga2sdram_port_size_config[3] ),
	.s_w_ready( s0_w_ready ),
	.f_ar_ready( fpga2sdram0_ar_ready ),
	.f_aw_ready( fpga2sdram0_aw_ready ),
	.f_b_id( fpga2sdram0_b_id ),
	.f_b_resp( fpga2sdram0_b_resp ),
	.f_b_valid( fpga2sdram0_b_valid ),
	.f_r_data( fpga2sdram0_r_data ),
	.f_r_id(   fpga2sdram0_r_id ),
	.f_r_last( fpga2sdram0_r_last ),
	.f_r_resp( fpga2sdram0_r_resp ),
	.f_r_valid( fpga2sdram0_r_valid ),
	.f_w_ready( fpga2sdram0_w_ready ),
	.s_ar_addr( s0_ar_addr ),
	.s_ar_burst( s0_ar_burst ),
	.s_ar_cache( s0_ar_cache ),
	.s_ar_id( s0_ar_id ),
	.s_ar_len( s0_ar_len ),
	.s_ar_lock( s0_ar_lock ),
	.s_ar_prot( s0_ar_prot ),
	.s_ar_size( s0_ar_size ),
	.s_ar_user( s0_ar_user ),
	.s_ar_valid( s0_ar_valid ),
	.s_aw_addr( s0_aw_addr ),
	.s_aw_burst( s0_aw_burst ),
	.s_aw_cache( s0_aw_cache ),
	.s_aw_id( s0_aw_id ),
	.s_aw_len( s0_aw_len ),
	.s_aw_lock( s0_aw_lock ),
	.s_aw_prot( s0_aw_prot ),
	.s_aw_size( s0_aw_size ),
	.s_aw_user( s0_aw_user ),
	.s_aw_valid( s0_aw_valid ),
	.s_b_ready( s0_b_ready ),
	.s_r_ready( s0_r_ready ),
	.s_w_data( s0_w_data ),
	.s_w_id( s0_w_id ),
	.s_w_last( s0_w_last ),
	.s_w_strb( s0_w_strb ),
	.s_w_valid( s0_w_valid )
);

f2s_rl_delay_adp #( .DWIDTH(DWIDTH1),  .DEPTH(DEPTH) ) f2s_rl_adp_inst_1 (
	.clk(  f2s_sdram1_ar_clk ),
	.f_ar_addr( fpga2sdram1_ar_addr ),
	.f_ar_burst( fpga2sdram1_ar_burst ),
	.f_ar_cache( fpga2sdram1_ar_cache ),
	.f_ar_id( fpga2sdram1_ar_id ),
	.f_ar_len( fpga2sdram1_ar_len ),
	.f_ar_lock( fpga2sdram1_ar_lock ),
	.f_ar_prot( fpga2sdram1_ar_prot ),
	.f_ar_size( fpga2sdram1_ar_size ),
	.f_ar_user( fpga2sdram1_ar_user ),
	.f_ar_valid( fpga2sdram1_ar_valid ),
	.f_aw_addr( fpga2sdram1_aw_addr ),
	.f_aw_burst( fpga2sdram1_aw_burst ),
	.f_aw_cache( fpga2sdram1_aw_cache ),
	.f_aw_id( fpga2sdram1_aw_id ),
	.f_aw_len( fpga2sdram1_aw_len ),
	.f_aw_lock( fpga2sdram1_aw_lock ),
	.f_aw_prot( fpga2sdram1_aw_prot ),
	.f_aw_size( fpga2sdram1_aw_size ),
	.f_aw_user( fpga2sdram1_aw_user ),
	.f_aw_valid( fpga2sdram1_aw_valid ),
	.f_b_ready( fpga2sdram1_b_ready ),
	.f_r_ready( fpga2sdram1_r_ready ),
	.f_w_data( fpga2sdram1_w_data ),
	.f_w_id( fpga2sdram1_w_id ),
	.f_w_last( fpga2sdram1_w_last ),
	.f_w_strb( fpga2sdram1_w_strb ),
	.f_w_valid( fpga2sdram1_w_valid ),
	.rst_n( f2s_sdram1_rst_n ),
	.s_ar_ready( s1_ar_ready ),
	.s_aw_ready( s1_aw_ready ),
	.s_b_id( s1_b_id ),
	.s_b_resp( s1_b_resp ),
	.s_b_valid( s1_b_valid ),
	.s_r_data( s1_r_data ),
	.s_r_id( s1_r_id ),
	.s_r_last( s1_r_last ),
	.s_r_resp( s1_r_resp ),
	.s_r_valid( s1_r_valid ),
	.s_ready_latency( fpga2sdram_port_size_config[3] ),
	.s_w_ready( s1_w_ready ),
	.f_ar_ready( fpga2sdram1_ar_ready ),
	.f_aw_ready( fpga2sdram1_aw_ready ),
	.f_b_id( fpga2sdram1_b_id ),
	.f_b_resp( fpga2sdram1_b_resp ),
	.f_b_valid( fpga2sdram1_b_valid ),
	.f_r_data( fpga2sdram1_r_data ),
	.f_r_id(   fpga2sdram1_r_id ),
	.f_r_last( fpga2sdram1_r_last ),
	.f_r_resp( fpga2sdram1_r_resp ),
	.f_r_valid( fpga2sdram1_r_valid ),
	.f_w_ready( fpga2sdram1_w_ready ),
	.s_ar_addr( s1_ar_addr ),
	.s_ar_burst( s1_ar_burst ),
	.s_ar_cache( s1_ar_cache ),
	.s_ar_id( s1_ar_id ),
	.s_ar_len( s1_ar_len ),
	.s_ar_lock( s1_ar_lock ),
	.s_ar_prot( s1_ar_prot ),
	.s_ar_size( s1_ar_size ),
	.s_ar_user( s1_ar_user ),
	.s_ar_valid( s1_ar_valid ),
	.s_aw_addr( s1_aw_addr ),
	.s_aw_burst( s1_aw_burst ),
	.s_aw_cache( s1_aw_cache ),
	.s_aw_id( s1_aw_id ),
	.s_aw_len( s1_aw_len ),
	.s_aw_lock( s1_aw_lock ),
	.s_aw_prot( s1_aw_prot ),
	.s_aw_size( s1_aw_size ),
	.s_aw_user( s1_aw_user ),
	.s_aw_valid( s1_aw_valid ),
	.s_b_ready( s1_b_ready ),
	.s_r_ready( s1_r_ready ),
	.s_w_data( s1_w_data ),
	.s_w_id( s1_w_id ),
	.s_w_last( s1_w_last ),
	.s_w_strb( s1_w_strb ),
	.s_w_valid( s1_w_valid )
);

f2s_rl_delay_adp #( .DWIDTH(DWIDTH2),  .DEPTH(DEPTH) ) f2s_rl_adp_inst_2 (
	.clk( f2s_sdram2_ar_clk ),
	.f_ar_addr( fpga2sdram2_ar_addr ),
	.f_ar_burst( fpga2sdram2_ar_burst ),
	.f_ar_cache( fpga2sdram2_ar_cache ),
	.f_ar_id( fpga2sdram2_ar_id ),
	.f_ar_len( fpga2sdram2_ar_len ),
	.f_ar_lock( fpga2sdram2_ar_lock ),
	.f_ar_prot( fpga2sdram2_ar_prot ),
	.f_ar_size( fpga2sdram2_ar_size ),
	.f_ar_user( fpga2sdram2_ar_user ),
	.f_ar_valid( fpga2sdram2_ar_valid ),
	.f_aw_addr( fpga2sdram2_aw_addr ),
	.f_aw_burst( fpga2sdram2_aw_burst ),
	.f_aw_cache( fpga2sdram2_aw_cache ),
	.f_aw_id( fpga2sdram2_aw_id ),
	.f_aw_len( fpga2sdram2_aw_len ),
	.f_aw_lock( fpga2sdram2_aw_lock ),
	.f_aw_prot( fpga2sdram2_aw_prot ),
	.f_aw_size( fpga2sdram2_aw_size ),
	.f_aw_user( fpga2sdram2_aw_user ),
	.f_aw_valid( fpga2sdram2_aw_valid ),
	.f_b_ready( fpga2sdram2_b_ready ),
	.f_r_ready( fpga2sdram2_r_ready ),
	.f_w_data( fpga2sdram2_w_data ),
	.f_w_id( fpga2sdram2_w_id ),
	.f_w_last( fpga2sdram2_w_last ),
	.f_w_strb( fpga2sdram2_w_strb ),
	.f_w_valid( fpga2sdram2_w_valid ),
	.rst_n( f2s_sdram2_rst_n ),
	.s_ar_ready( s2_ar_ready ),
	.s_aw_ready( s2_aw_ready ),
	.s_b_id( s2_b_id ),
	.s_b_resp( s2_b_resp ),
	.s_b_valid( s2_b_valid ),
	.s_r_data( s2_r_data ),
	.s_r_id( s2_r_id ),
	.s_r_last( s2_r_last ),
	.s_r_resp( s2_r_resp ),
	.s_r_valid( s2_r_valid ),
	.s_ready_latency( fpga2sdram_port_size_config[3] ),
	.s_w_ready( s2_w_ready ),
	.f_ar_ready( fpga2sdram2_ar_ready ),
	.f_aw_ready( fpga2sdram2_aw_ready ),
	.f_b_id( fpga2sdram2_b_id ),
	.f_b_resp( fpga2sdram2_b_resp ),
	.f_b_valid( fpga2sdram2_b_valid ),
	.f_r_data( fpga2sdram2_r_data ),
	.f_r_id(   fpga2sdram2_r_id ),
	.f_r_last( fpga2sdram2_r_last ),
	.f_r_resp( fpga2sdram2_r_resp ),
	.f_r_valid( fpga2sdram2_r_valid ),
	.f_w_ready( fpga2sdram2_w_ready ),
	.s_ar_addr( s2_ar_addr ),
	.s_ar_burst( s2_ar_burst ),
	.s_ar_cache( s2_ar_cache ),
	.s_ar_id( s2_ar_id ),
	.s_ar_len( s2_ar_len ),
	.s_ar_lock( s2_ar_lock ),
	.s_ar_prot( s2_ar_prot ),
	.s_ar_size( s2_ar_size ),
	.s_ar_user( s2_ar_user ),
	.s_ar_valid( s2_ar_valid ),
	.s_aw_addr( s2_aw_addr ),
	.s_aw_burst( s2_aw_burst ),
	.s_aw_cache( s2_aw_cache ),
	.s_aw_id( s2_aw_id ),
	.s_aw_len( s2_aw_len ),
	.s_aw_lock( s2_aw_lock ),
	.s_aw_prot( s2_aw_prot ),
	.s_aw_size( s2_aw_size ),
	.s_aw_user( s2_aw_user ),
	.s_aw_valid( s2_aw_valid ),
	.s_b_ready( s2_b_ready ),
	.s_r_ready( s2_r_ready ),
	.s_w_data( s2_w_data ),
	.s_w_id( s2_w_id ),
	.s_w_last( s2_w_last ),
	.s_w_strb( s2_w_strb ),
	.s_w_valid( s2_w_valid )
);


twentynm_hps_interface_fpga2sdram fpga2sdram_1_instance(
  .f2s_sdram0_ar_clk(f2s_sdram0_ar_clk),
  .f2s_sdram0_aw_clk(f2s_sdram0_aw_clk),
  .f2s_sdram0_b_clk(f2s_sdram0_b_clk),
  .f2s_sdram0_clk(f2s_sdram0_clk),
  .f2s_sdram0_r_clk(f2s_sdram0_r_clk),
  .f2s_sdram0_w_clk(f2s_sdram0_w_clk),
  .f2s_sdram1_ar_clk(f2s_sdram1_ar_clk),
  .f2s_sdram1_aw_clk(f2s_sdram1_aw_clk),
  .f2s_sdram1_b_clk(f2s_sdram1_b_clk),
  .f2s_sdram1_clk(f2s_sdram1_clk),
  .f2s_sdram1_r_clk(f2s_sdram1_r_clk),
  .f2s_sdram1_w_clk(f2s_sdram1_w_clk),
  .f2s_sdram2_ar_clk(f2s_sdram2_ar_clk),
  .f2s_sdram2_aw_clk(f2s_sdram2_aw_clk),
  .f2s_sdram2_b_clk(f2s_sdram2_b_clk),
  .f2s_sdram2_clk(f2s_sdram2_clk),
  .f2s_sdram2_r_clk(f2s_sdram2_r_clk),
  .f2s_sdram2_w_clk(f2s_sdram2_w_clk),
  .fpga2sdram_port_size_config(fpga2sdram_port_size_config),
  .fpga2sdram0_ar_ready(w_fpga2sdram0_ar_ready),
  .fpga2sdram0_ar_valid(w_fpga2sdram0_ar_valid),
  .fpga2sdram0_aw_ready(w_fpga2sdram0_aw_ready),
  .fpga2sdram0_aw_valid(w_fpga2sdram0_aw_valid),
  .fpga2sdram0_b_ready(w_fpga2sdram0_b_ready),
  .fpga2sdram0_b_valid(w_fpga2sdram0_b_valid),
  .fpga2sdram0_req_addr(w_fpga2sdram0_req_addr),
  .fpga2sdram0_req_be(w_fpga2sdram0_req_be),
  .fpga2sdram0_req_data(w_fpga2sdram0_req_data),
  .fpga2sdram0_req_exclid(w_fpga2sdram0_req_exclid),
  .fpga2sdram0_req_hurry(w_fpga2sdram0_req_hurry),
  .fpga2sdram0_req_last(w_fpga2sdram0_req_last),
  .fpga2sdram0_req_length(w_fpga2sdram0_req_length),
  .fpga2sdram0_req_opc(w_fpga2sdram0_req_opc),
  .fpga2sdram0_req_press(w_fpga2sdram0_req_press),
  .fpga2sdram0_req_rdy(w_fpga2sdram0_req_rdy),
  .fpga2sdram0_req_seqid(w_fpga2sdram0_req_seqid),
  .fpga2sdram0_req_trid(w_fpga2sdram0_req_trid),
  .fpga2sdram0_req_urgency(w_fpga2sdram0_req_urgency),
  .fpga2sdram0_req_user(w_fpga2sdram0_req_user),
  .fpga2sdram0_req_vld(w_fpga2sdram0_req_vld),
  .fpga2sdram0_rsp_cont(w_fpga2sdram0_rsp_cont),
  .fpga2sdram0_rsp_data(w_fpga2sdram0_rsp_data),
  .fpga2sdram0_rsp_last(w_fpga2sdram0_rsp_last),
  .fpga2sdram0_rsp_rdy(w_fpga2sdram0_rsp_rdy),
  .fpga2sdram0_rsp_status(w_fpga2sdram0_rsp_status),
  .fpga2sdram0_rsp_trid(w_fpga2sdram0_rsp_trid),
  .fpga2sdram0_rsp_vld(w_fpga2sdram0_rsp_vld),
  .fpga2sdram1_ar_ready(w_fpga2sdram1_ar_ready),
  .fpga2sdram1_ar_valid(w_fpga2sdram1_ar_valid),
  .fpga2sdram1_aw_ready(w_fpga2sdram1_aw_ready),
  .fpga2sdram1_aw_valid(w_fpga2sdram1_aw_valid),
  .fpga2sdram1_b_ready(w_fpga2sdram1_b_ready),
  .fpga2sdram1_b_valid(w_fpga2sdram1_b_valid),
  .fpga2sdram1_req_addr(w_fpga2sdram1_req_addr),
  .fpga2sdram1_req_be(w_fpga2sdram1_req_be),
  .fpga2sdram1_req_data(w_fpga2sdram1_req_data),
  .fpga2sdram1_req_exclid(w_fpga2sdram1_req_exclid),
  .fpga2sdram1_req_hurry(w_fpga2sdram1_req_hurry),
  .fpga2sdram1_req_last(w_fpga2sdram1_req_last),
  .fpga2sdram1_req_length(w_fpga2sdram1_req_length),
  .fpga2sdram1_req_opc(w_fpga2sdram1_req_opc),
  .fpga2sdram1_req_press(w_fpga2sdram1_req_press),
  .fpga2sdram1_req_rdy(w_fpga2sdram1_req_rdy),
  .fpga2sdram1_req_seqid(w_fpga2sdram1_req_seqid),
  .fpga2sdram1_req_trid(w_fpga2sdram1_req_trid),
  .fpga2sdram1_req_urgency(w_fpga2sdram1_req_urgency),
  .fpga2sdram1_req_user(w_fpga2sdram1_req_user),
  .fpga2sdram1_req_vld(w_fpga2sdram1_req_vld),
  .fpga2sdram1_rsp_cont(w_fpga2sdram1_rsp_cont),
  .fpga2sdram1_rsp_data(w_fpga2sdram1_rsp_data),
  .fpga2sdram1_rsp_last(w_fpga2sdram1_rsp_last),
  .fpga2sdram1_rsp_rdy(w_fpga2sdram1_rsp_rdy),
  .fpga2sdram1_rsp_status(w_fpga2sdram1_rsp_status),
  .fpga2sdram1_rsp_trid(w_fpga2sdram1_rsp_trid),
  .fpga2sdram1_rsp_vld(w_fpga2sdram1_rsp_vld),
  .fpga2sdram2_ar_ready(w_fpga2sdram2_ar_ready),
  .fpga2sdram2_ar_valid(w_fpga2sdram2_ar_valid),
  .fpga2sdram2_aw_ready(w_fpga2sdram2_aw_ready),
  .fpga2sdram2_aw_valid(w_fpga2sdram2_aw_valid),
  .fpga2sdram2_b_ready(w_fpga2sdram2_b_ready),
  .fpga2sdram2_b_valid(w_fpga2sdram2_b_valid),
  .fpga2sdram2_req_addr(w_fpga2sdram2_req_addr),
  .fpga2sdram2_req_be(w_fpga2sdram2_req_be),
  .fpga2sdram2_req_data(w_fpga2sdram2_req_data),
  .fpga2sdram2_req_exclid(w_fpga2sdram2_req_exclid),
  .fpga2sdram2_req_hurry(w_fpga2sdram2_req_hurry),
  .fpga2sdram2_req_last(w_fpga2sdram2_req_last),
  .fpga2sdram2_req_length(w_fpga2sdram2_req_length),
  .fpga2sdram2_req_opc(w_fpga2sdram2_req_opc),
  .fpga2sdram2_req_press(w_fpga2sdram2_req_press),
  .fpga2sdram2_req_rdy(w_fpga2sdram2_req_rdy),
  .fpga2sdram2_req_seqid(w_fpga2sdram2_req_seqid),
  .fpga2sdram2_req_trid(w_fpga2sdram2_req_trid),
  .fpga2sdram2_req_urgency(w_fpga2sdram2_req_urgency),
  .fpga2sdram2_req_user(w_fpga2sdram2_req_user),
  .fpga2sdram2_req_vld(w_fpga2sdram2_req_vld),
  .fpga2sdram2_rsp_cont(w_fpga2sdram2_rsp_cont),
  .fpga2sdram2_rsp_data(w_fpga2sdram2_rsp_data),
  .fpga2sdram2_rsp_last(w_fpga2sdram2_rsp_last),
  .fpga2sdram2_rsp_rdy(w_fpga2sdram2_rsp_rdy),
  .fpga2sdram2_rsp_status(w_fpga2sdram2_rsp_status),
  .fpga2sdram2_rsp_trid(w_fpga2sdram2_rsp_trid),
  .fpga2sdram2_rsp_vld(w_fpga2sdram2_rsp_vld)
);
defparam fpga2sdram_1_instance.mode = mode;

endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
`timescale 1 ps / 1 ps
module twentynm_hps_rl_mode2_fpga2sdram #(
  parameter DEPTH   = 4,
  parameter DWIDTH0 = 16,
  parameter DWIDTH1 = 16,
  parameter DWIDTH2 = 16,
  parameter mode    = 3
)(
  input   wire           f2s_sdram0_ar_clk,
  input   wire           f2s_sdram0_aw_clk,
  input   wire           f2s_sdram0_b_clk,
  input   wire           f2s_sdram0_clk,
  input   wire           f2s_sdram0_r_clk,
  input   wire           f2s_sdram0_w_clk,
  input   wire           f2s_sdram2_ar_clk,
  input   wire           f2s_sdram2_aw_clk,
  input   wire           f2s_sdram2_b_clk,
  input   wire           f2s_sdram2_clk,
  input   wire           f2s_sdram2_r_clk,
  input   wire           f2s_sdram2_w_clk,
  input   wire [    3:0] fpga2sdram_port_size_config,
  input   wire           f2s_sdram0_rst_n,
  input   wire           f2s_sdram2_rst_n,
  input   wire [ 32-1:0] fpga2sdram0_ar_addr,
  input   wire [  2-1:0] fpga2sdram0_ar_burst,
  input   wire [  4-1:0] fpga2sdram0_ar_cache,
  input   wire [  4-1:0] fpga2sdram0_ar_id,
  input   wire [  4-1:0] fpga2sdram0_ar_len,
  input   wire [  2-1:0] fpga2sdram0_ar_lock,
  input   wire [  3-1:0] fpga2sdram0_ar_prot,
  output  wire [  1-1:0] fpga2sdram0_ar_ready,
  input   wire [  3-1:0] fpga2sdram0_ar_size,
  input   wire [  5-1:0] fpga2sdram0_ar_user,
  input   wire [  1-1:0] fpga2sdram0_ar_valid,
  input   wire [ 32-1:0] fpga2sdram0_aw_addr,
  input   wire [  2-1:0] fpga2sdram0_aw_burst,
  input   wire [  4-1:0] fpga2sdram0_aw_cache,
  input   wire [  4-1:0] fpga2sdram0_aw_id,
  input   wire [  4-1:0] fpga2sdram0_aw_len,
  input   wire [  2-1:0] fpga2sdram0_aw_lock,
  input   wire [  3-1:0] fpga2sdram0_aw_prot,
  output  wire [  1-1:0] fpga2sdram0_aw_ready,
  input   wire [  3-1:0] fpga2sdram0_aw_size,
  input   wire [  5-1:0] fpga2sdram0_aw_user,
  input   wire [  1-1:0] fpga2sdram0_aw_valid,
  output  wire [  4-1:0] fpga2sdram0_b_id,
  input   wire [  1-1:0] fpga2sdram0_b_ready,
  output  wire [  2-1:0] fpga2sdram0_b_resp,
  output  wire [  1-1:0] fpga2sdram0_b_valid,
  output  wire [128-1:0] fpga2sdram0_r_data,
  output  wire [  4-1:0] fpga2sdram0_r_id,
  output  wire [  1-1:0] fpga2sdram0_r_last,
  input   wire [  1-1:0] fpga2sdram0_r_ready,
  output  wire [  2-1:0] fpga2sdram0_r_resp,
  output  wire [  1-1:0] fpga2sdram0_r_valid,
  input   wire [128-1:0] fpga2sdram0_w_data,
  input   wire [  4-1:0] fpga2sdram0_w_id,
  input   wire [  1-1:0] fpga2sdram0_w_last,
  output  wire [  1-1:0] fpga2sdram0_w_ready,
  input   wire [ 16-1:0] fpga2sdram0_w_strb,
  input   wire [  1-1:0] fpga2sdram0_w_valid,
  input   wire [ 32-1:0] fpga2sdram2_ar_addr,
  input   wire [  2-1:0] fpga2sdram2_ar_burst,
  input   wire [  4-1:0] fpga2sdram2_ar_cache,
  input   wire [  4-1:0] fpga2sdram2_ar_id,
  input   wire [  4-1:0] fpga2sdram2_ar_len,
  input   wire [  2-1:0] fpga2sdram2_ar_lock,
  input   wire [  3-1:0] fpga2sdram2_ar_prot,
  output  wire [  1-1:0] fpga2sdram2_ar_ready,
  input   wire [  3-1:0] fpga2sdram2_ar_size,
  input   wire [  5-1:0] fpga2sdram2_ar_user,
  input   wire [  1-1:0] fpga2sdram2_ar_valid,
  input   wire [ 32-1:0] fpga2sdram2_aw_addr,
  input   wire [  2-1:0] fpga2sdram2_aw_burst,
  input   wire [  4-1:0] fpga2sdram2_aw_cache,
  input   wire [  4-1:0] fpga2sdram2_aw_id,
  input   wire [  4-1:0] fpga2sdram2_aw_len,
  input   wire [  2-1:0] fpga2sdram2_aw_lock,
  input   wire [  3-1:0] fpga2sdram2_aw_prot,
  output  wire [  1-1:0] fpga2sdram2_aw_ready,
  input   wire [  3-1:0] fpga2sdram2_aw_size,
  input   wire [  5-1:0] fpga2sdram2_aw_user,
  input   wire [  1-1:0] fpga2sdram2_aw_valid,
  output  wire [  4-1:0] fpga2sdram2_b_id,
  input   wire [  1-1:0] fpga2sdram2_b_ready,
  output  wire [  2-1:0] fpga2sdram2_b_resp,
  output  wire [  1-1:0] fpga2sdram2_b_valid,
  output  wire [128-1:0] fpga2sdram2_r_data,
  output  wire [  4-1:0] fpga2sdram2_r_id,
  output  wire [  1-1:0] fpga2sdram2_r_last,
  input   wire [  1-1:0] fpga2sdram2_r_ready,
  output  wire [  2-1:0] fpga2sdram2_r_resp,
  output  wire [  1-1:0] fpga2sdram2_r_valid,
  input   wire [128-1:0] fpga2sdram2_w_data,
  input   wire [  4-1:0] fpga2sdram2_w_id,
  input   wire [  1-1:0] fpga2sdram2_w_last,
  output  wire [  1-1:0] fpga2sdram2_w_ready,
  input   wire [ 16-1:0] fpga2sdram2_w_strb,
  input   wire [  1-1:0] fpga2sdram2_w_valid
);

localparam DWIDTH = 128;
wire [  1-1:0] w_fpga2sdram0_ar_ready;
wire [  1-1:0] w_fpga2sdram0_ar_valid;
wire [  1-1:0] w_fpga2sdram0_aw_ready;
wire [  1-1:0] w_fpga2sdram0_aw_valid;
wire [  1-1:0] w_fpga2sdram0_b_ready;
wire [  1-1:0] w_fpga2sdram0_b_valid;
wire [ 32-1:0] w_fpga2sdram0_req_addr;
wire [ 16-1:0] w_fpga2sdram0_req_be;
wire [128-1:0] w_fpga2sdram0_req_data;
wire [  4-1:0] w_fpga2sdram0_req_exclid;
wire [  2-1:0] w_fpga2sdram0_req_hurry;
wire [  1-1:0] w_fpga2sdram0_req_last;
wire [  8-1:0] w_fpga2sdram0_req_length;
wire [  3-1:0] w_fpga2sdram0_req_opc;
wire [  2-1:0] w_fpga2sdram0_req_press;
wire [  1-1:0] w_fpga2sdram0_req_rdy;
wire [  4-1:0] w_fpga2sdram0_req_seqid;
wire [  3-1:0] w_fpga2sdram0_req_trid;
wire [  2-1:0] w_fpga2sdram0_req_urgency;
wire [ 12-1:0] w_fpga2sdram0_req_user;
wire [  1-1:0] w_fpga2sdram0_req_vld;
wire [  1-1:0] w_fpga2sdram0_rsp_cont;
wire [128-1:0] w_fpga2sdram0_rsp_data;
wire [  1-1:0] w_fpga2sdram0_rsp_last;
wire [  1-1:0] w_fpga2sdram0_rsp_rdy;
wire [  2-1:0] w_fpga2sdram0_rsp_status;
wire [  3-1:0] w_fpga2sdram0_rsp_trid;
wire [  1-1:0] w_fpga2sdram0_rsp_vld;
wire [ 32-1:0] w_fpga2sdram1_req_addr;
wire [ 82-1:0] w_fpga2sdram1_req_data;
wire [  2-1:0] w_fpga2sdram1_req_hurry;
wire [  4-1:0] w_fpga2sdram1_req_seqid;
wire [ 12-1:0] w_fpga2sdram1_req_user;
wire [128-1:0] w_fpga2sdram1_rsp_data;
wire [  1-1:0] w_fpga2sdram2_ar_ready;
wire [  1-1:0] w_fpga2sdram2_ar_valid;
wire [  1-1:0] w_fpga2sdram2_aw_ready;
wire [  1-1:0] w_fpga2sdram2_aw_valid;
wire [  1-1:0] w_fpga2sdram2_b_ready;
wire [  1-1:0] w_fpga2sdram2_b_valid;
wire [ 32-1:0] w_fpga2sdram2_req_addr;
wire [ 16-1:0] w_fpga2sdram2_req_be;
wire [128-1:0] w_fpga2sdram2_req_data;
wire [  4-1:0] w_fpga2sdram2_req_exclid;
wire [  2-1:0] w_fpga2sdram2_req_hurry;
wire [  1-1:0] w_fpga2sdram2_req_last;
wire [  8-1:0] w_fpga2sdram2_req_length;
wire [  3-1:0] w_fpga2sdram2_req_opc;
wire [  2-1:0] w_fpga2sdram2_req_press;
wire [  1-1:0] w_fpga2sdram2_req_rdy;
wire [  4-1:0] w_fpga2sdram2_req_seqid;
wire [  3-1:0] w_fpga2sdram2_req_trid;
wire [  2-1:0] w_fpga2sdram2_req_urgency;
wire [ 12-1:0] w_fpga2sdram2_req_user;
wire [  1-1:0] w_fpga2sdram2_req_vld;
wire [  1-1:0] w_fpga2sdram2_rsp_cont;
wire [128-1:0] w_fpga2sdram2_rsp_data;
wire [  1-1:0] w_fpga2sdram2_rsp_last;
wire [  1-1:0] w_fpga2sdram2_rsp_rdy;
wire [  2-1:0] w_fpga2sdram2_rsp_status;
wire [  3-1:0] w_fpga2sdram2_rsp_trid;
wire [  1-1:0] w_fpga2sdram2_rsp_vld;


wire                     s0_ar_ready;
wire                     s0_aw_ready;
wire               [3:0] s0_b_id;
wire               [1:0] s0_b_resp;
wire                     s0_b_valid;
wire        [DWIDTH-1:0] s0_r_data;
wire               [3:0] s0_r_id;
wire                     s0_r_last;
wire               [1:0] s0_r_resp;
wire                     s0_r_valid;
wire                     s0_w_ready;
wire             [31:0] s0_ar_addr;
wire              [1:0] s0_ar_burst;
wire              [3:0] s0_ar_cache;
wire              [3:0] s0_ar_id;
wire              [3:0] s0_ar_len;
wire              [1:0] s0_ar_lock;
wire              [2:0] s0_ar_prot;
wire              [2:0] s0_ar_size;
wire              [4:0] s0_ar_user;
wire                    s0_ar_valid;
wire             [31:0] s0_aw_addr;
wire              [1:0] s0_aw_burst;
wire              [3:0] s0_aw_cache;
wire              [3:0] s0_aw_id;
wire              [3:0] s0_aw_len;
wire              [1:0] s0_aw_lock;
wire              [2:0] s0_aw_prot;
wire              [2:0] s0_aw_size;
wire              [4:0] s0_aw_user;
wire                    s0_aw_valid;
wire                    s0_b_ready;
wire                    s0_r_ready;
wire       [DWIDTH-1:0] s0_w_data;
wire              [3:0] s0_w_id;
wire                    s0_w_last;
wire     [DWIDTH/8-1:0] s0_w_strb;
wire                    s0_w_valid;

wire                     s2_ar_ready;
wire                     s2_aw_ready;
wire               [3:0] s2_b_id;
wire               [1:0] s2_b_resp;
wire                     s2_b_valid;
wire        [DWIDTH-1:0] s2_r_data;
wire               [3:0] s2_r_id;
wire                     s2_r_last;
wire               [1:0] s2_r_resp;
wire                     s2_r_valid;
wire                     s2_w_ready;
wire             [31:0] s2_ar_addr;
wire              [1:0] s2_ar_burst;
wire              [3:0] s2_ar_cache;
wire              [3:0] s2_ar_id;
wire              [3:0] s2_ar_len;
wire              [1:0] s2_ar_lock;
wire              [2:0] s2_ar_prot;
wire              [2:0] s2_ar_size;
wire              [4:0] s2_ar_user;
wire                    s2_ar_valid;
wire             [31:0] s2_aw_addr;
wire              [1:0] s2_aw_burst;
wire              [3:0] s2_aw_cache;
wire              [3:0] s2_aw_id;
wire              [3:0] s2_aw_len;
wire              [1:0] s2_aw_lock;
wire              [2:0] s2_aw_prot;
wire              [2:0] s2_aw_size;
wire              [4:0] s2_aw_user;
wire                    s2_aw_valid;
wire                    s2_b_ready;
wire                    s2_r_ready;
wire       [DWIDTH-1:0] s2_w_data;
wire              [3:0] s2_w_id;
wire                    s2_w_last;
wire     [DWIDTH/8-1:0] s2_w_strb;
wire                    s2_w_valid;



assign s0_ar_ready 	= w_fpga2sdram0_ar_ready;
assign s0_aw_ready 	= w_fpga2sdram0_aw_ready;
assign s0_b_id[3:0] 	= w_fpga2sdram1_rsp_data[35:32];
assign s0_b_resp[1:0] 	= w_fpga2sdram1_rsp_data[37:36];
assign s0_b_valid 	= w_fpga2sdram0_b_valid;
assign s0_r_data[127:64] 	= w_fpga2sdram0_rsp_data[127:64];
assign s0_r_data[31:0] 	= w_fpga2sdram0_rsp_data[31:0];
assign s0_r_data[63:32] 	= w_fpga2sdram0_rsp_data[63:32];
assign s0_r_id[2:0] 	= w_fpga2sdram0_rsp_trid[2:0];
assign s0_r_id[3] 	= w_fpga2sdram0_rsp_cont;
assign s0_r_last 	= w_fpga2sdram0_rsp_last;
assign s0_r_resp[1:0] 	= w_fpga2sdram0_rsp_status[1:0];
assign s0_r_valid 	= w_fpga2sdram0_rsp_vld;
assign s0_w_ready 	= w_fpga2sdram0_req_rdy;
assign s2_ar_ready 	= w_fpga2sdram2_ar_ready;
assign s2_aw_ready 	= w_fpga2sdram2_aw_ready;
assign s2_b_id[3:0] 	= w_fpga2sdram1_rsp_data[125:122];
assign s2_b_resp[1:0] 	= w_fpga2sdram1_rsp_data[127:126];
assign s2_b_valid 	= w_fpga2sdram2_b_valid;
assign s2_r_data[127:64] 	= w_fpga2sdram2_rsp_data[127:64];
assign s2_r_data[31:0] 	= w_fpga2sdram2_rsp_data[31:0];
assign s2_r_data[63:32] 	= w_fpga2sdram2_rsp_data[63:32];
assign s2_r_id[2:0] 	= w_fpga2sdram2_rsp_trid[2:0];
assign s2_r_id[3] 	= w_fpga2sdram2_rsp_cont;
assign s2_r_last 	= w_fpga2sdram2_rsp_last;
assign s2_r_resp[1:0] 	= w_fpga2sdram2_rsp_status[1:0];
assign s2_r_valid 	= w_fpga2sdram2_rsp_vld;
assign s2_w_ready 	= w_fpga2sdram2_req_rdy;
assign w_fpga2sdram0_ar_valid 	= s0_ar_valid;
assign w_fpga2sdram0_aw_valid 	= s0_aw_valid;
assign w_fpga2sdram0_b_ready 	= s0_b_ready;
assign w_fpga2sdram0_req_addr[31:0] 	= s0_aw_addr[31:0];
assign w_fpga2sdram0_req_be[15:8] 	= s0_w_strb[15:8];
assign w_fpga2sdram0_req_be[3:0] 	= s0_w_strb[3:0];
assign w_fpga2sdram0_req_be[7:4] 	= s0_w_strb[7:4];
assign w_fpga2sdram0_req_data[127:64] 	= s0_w_data[127:64];
assign w_fpga2sdram0_req_data[31:0] 	= s0_w_data[31:0];
assign w_fpga2sdram0_req_data[63:32] 	= s0_w_data[63:32];
assign w_fpga2sdram0_req_exclid[3:0] 	= s0_w_id[3:0];
assign w_fpga2sdram0_req_hurry[1:0] 	= s0_aw_lock[1:0];
assign w_fpga2sdram0_req_last 	= s0_w_last;
assign w_fpga2sdram0_req_length[3:0] 	= s0_aw_len[3:0];
assign w_fpga2sdram0_req_length[7:4] 	= s0_ar_len[3:0];
assign w_fpga2sdram0_req_opc[2:0] 	= s0_aw_size[2:0];
assign w_fpga2sdram0_req_press[1:0] 	= s0_aw_burst[1:0];
assign w_fpga2sdram0_req_seqid[3:0] 	= s0_aw_id[3:0];
assign w_fpga2sdram0_req_trid[2:0] 	= s0_ar_prot[2:0];
assign w_fpga2sdram0_req_urgency[1:0] 	= s0_ar_burst[1:0];
assign w_fpga2sdram0_req_user[11:7] 	= s0_aw_user[4:0];
assign w_fpga2sdram0_req_user[3:0] 	= s0_aw_cache[3:0];
assign w_fpga2sdram0_req_user[6:4] 	= s0_aw_prot[2:0];
assign w_fpga2sdram0_req_vld 	= s0_w_valid;
assign w_fpga2sdram0_rsp_rdy 	= s0_r_ready;
assign w_fpga2sdram1_req_addr[31:0] 	= s2_ar_addr[31:0];
assign w_fpga2sdram1_req_data[35:32] 	= s0_ar_cache[3:0];
assign w_fpga2sdram1_req_data[39:36] 	= s0_ar_id[3:0];
assign w_fpga2sdram1_req_data[41:40] 	= s0_ar_lock[1:0];
assign w_fpga2sdram1_req_data[44:42] 	= s0_ar_size[2:0];
assign w_fpga2sdram1_req_data[49:45] 	= s0_ar_user[4:0];
assign w_fpga2sdram1_req_data[81:50] 	= s0_ar_addr[31:0];
assign w_fpga2sdram1_req_hurry[1:0] 	= s2_ar_lock[1:0];
assign w_fpga2sdram1_req_seqid[3:0] 	= s2_ar_id[3:0];
assign w_fpga2sdram1_req_user[11:7] 	= s2_ar_user[4:0];
assign w_fpga2sdram1_req_user[3:0] 	= s2_ar_cache[3:0];
assign w_fpga2sdram1_req_user[6:4] 	= s2_ar_size[2:0];
assign w_fpga2sdram2_ar_valid 	= s2_ar_valid;
assign w_fpga2sdram2_aw_valid 	= s2_aw_valid;
assign w_fpga2sdram2_b_ready 	= s2_b_ready;
assign w_fpga2sdram2_req_addr[31:0] 	= s2_aw_addr[31:0];
assign w_fpga2sdram2_req_be[15:8] 	= s2_w_strb[15:8];
assign w_fpga2sdram2_req_be[3:0] 	= s2_w_strb[3:0];
assign w_fpga2sdram2_req_be[7:4] 	= s2_w_strb[7:4];
assign w_fpga2sdram2_req_data[127:64] 	= s2_w_data[127:64];
assign w_fpga2sdram2_req_data[31:0] 	= s2_w_data[31:0];
assign w_fpga2sdram2_req_data[63:32] 	= s2_w_data[63:32];
assign w_fpga2sdram2_req_exclid[3:0] 	= s2_w_id[3:0];
assign w_fpga2sdram2_req_hurry[1:0] 	= s2_aw_lock[1:0];
assign w_fpga2sdram2_req_last 	= s2_w_last;
assign w_fpga2sdram2_req_length[3:0] 	= s2_aw_len[3:0];
assign w_fpga2sdram2_req_length[7:4] 	= s2_ar_len[3:0];
assign w_fpga2sdram2_req_opc[2:0] 	= s2_aw_size[2:0];
assign w_fpga2sdram2_req_press[1:0] 	= s2_aw_burst[1:0];
assign w_fpga2sdram2_req_seqid[3:0] 	= s2_aw_id[3:0];
assign w_fpga2sdram2_req_trid[2:0] 	= s2_ar_prot[2:0];
assign w_fpga2sdram2_req_urgency[1:0] 	= s2_ar_burst[1:0];
assign w_fpga2sdram2_req_user[11:7] 	= s2_aw_user[4:0];
assign w_fpga2sdram2_req_user[3:0] 	= s2_aw_cache[3:0];
assign w_fpga2sdram2_req_user[6:4] 	= s2_aw_prot[2:0];
assign w_fpga2sdram2_req_vld 	= s2_w_valid;
assign w_fpga2sdram2_rsp_rdy 	= s2_r_ready;


f2s_rl_delay_adp #( .DWIDTH(DWIDTH0),  .DEPTH(DEPTH) ) f2s_rl_adp_inst_0 (
	.clk( f2s_sdram0_ar_clk ),
	.f_ar_addr( fpga2sdram0_ar_addr ),
	.f_ar_burst( fpga2sdram0_ar_burst ),
	.f_ar_cache( fpga2sdram0_ar_cache ),
	.f_ar_id( fpga2sdram0_ar_id ),
	.f_ar_len( fpga2sdram0_ar_len ),
	.f_ar_lock( fpga2sdram0_ar_lock ),
	.f_ar_prot( fpga2sdram0_ar_prot ),
	.f_ar_size( fpga2sdram0_ar_size ),
	.f_ar_user( fpga2sdram0_ar_user ),
	.f_ar_valid( fpga2sdram0_ar_valid ),
	.f_aw_addr( fpga2sdram0_aw_addr ),
	.f_aw_burst( fpga2sdram0_aw_burst ),
	.f_aw_cache( fpga2sdram0_aw_cache ),
	.f_aw_id( fpga2sdram0_aw_id ),
	.f_aw_len( fpga2sdram0_aw_len ),
	.f_aw_lock( fpga2sdram0_aw_lock ),
	.f_aw_prot( fpga2sdram0_aw_prot ),
	.f_aw_size( fpga2sdram0_aw_size ),
	.f_aw_user( fpga2sdram0_aw_user ),
	.f_aw_valid( fpga2sdram0_aw_valid ),
	.f_b_ready( fpga2sdram0_b_ready ),
	.f_r_ready( fpga2sdram0_r_ready ),
	.f_w_data( fpga2sdram0_w_data ),
	.f_w_id( fpga2sdram0_w_id ),
	.f_w_last( fpga2sdram0_w_last ),
	.f_w_strb( fpga2sdram0_w_strb ),
	.f_w_valid( fpga2sdram0_w_valid ),
	.rst_n( f2s_sdram0_rst_n ),
	.s_ar_ready( s0_ar_ready ),
	.s_aw_ready( s0_aw_ready ),
	.s_b_id( s0_b_id ),
	.s_b_resp( s0_b_resp ),
	.s_b_valid( s0_b_valid ),
	.s_r_data( s0_r_data ),
	.s_r_id( s0_r_id ),
	.s_r_last( s0_r_last ),
	.s_r_resp( s0_r_resp ),
	.s_r_valid( s0_r_valid ),
	.s_ready_latency( fpga2sdram_port_size_config[3] ),
	.s_w_ready( s0_w_ready ),
	.f_ar_ready( fpga2sdram0_ar_ready ),
	.f_aw_ready( fpga2sdram0_aw_ready ),
	.f_b_id( fpga2sdram0_b_id ),
	.f_b_resp( fpga2sdram0_b_resp ),
	.f_b_valid( fpga2sdram0_b_valid ),
	.f_r_data( fpga2sdram0_r_data ),
	.f_r_id(   fpga2sdram0_r_id ),
	.f_r_last( fpga2sdram0_r_last ),
	.f_r_resp( fpga2sdram0_r_resp ),
	.f_r_valid( fpga2sdram0_r_valid ),
	.f_w_ready( fpga2sdram0_w_ready ),
	.s_ar_addr( s0_ar_addr ),
	.s_ar_burst( s0_ar_burst ),
	.s_ar_cache( s0_ar_cache ),
	.s_ar_id( s0_ar_id ),
	.s_ar_len( s0_ar_len ),
	.s_ar_lock( s0_ar_lock ),
	.s_ar_prot( s0_ar_prot ),
	.s_ar_size( s0_ar_size ),
	.s_ar_user( s0_ar_user ),
	.s_ar_valid( s0_ar_valid ),
	.s_aw_addr( s0_aw_addr ),
	.s_aw_burst( s0_aw_burst ),
	.s_aw_cache( s0_aw_cache ),
	.s_aw_id( s0_aw_id ),
	.s_aw_len( s0_aw_len ),
	.s_aw_lock( s0_aw_lock ),
	.s_aw_prot( s0_aw_prot ),
	.s_aw_size( s0_aw_size ),
	.s_aw_user( s0_aw_user ),
	.s_aw_valid( s0_aw_valid ),
	.s_b_ready( s0_b_ready ),
	.s_r_ready( s0_r_ready ),
	.s_w_data( s0_w_data ),
	.s_w_id( s0_w_id ),
	.s_w_last( s0_w_last ),
	.s_w_strb( s0_w_strb ),
	.s_w_valid( s0_w_valid )
);



f2s_rl_delay_adp #( .DWIDTH(DWIDTH2),  .DEPTH(DEPTH)) f2s_rl_adp_inst_2 (
	.clk( f2s_sdram2_ar_clk ),
	.f_ar_addr( fpga2sdram2_ar_addr ),
	.f_ar_burst( fpga2sdram2_ar_burst ),
	.f_ar_cache( fpga2sdram2_ar_cache ),
	.f_ar_id( fpga2sdram2_ar_id ),
	.f_ar_len( fpga2sdram2_ar_len ),
	.f_ar_lock( fpga2sdram2_ar_lock ),
	.f_ar_prot( fpga2sdram2_ar_prot ),
	.f_ar_size( fpga2sdram2_ar_size ),
	.f_ar_user( fpga2sdram2_ar_user ),
	.f_ar_valid( fpga2sdram2_ar_valid ),
	.f_aw_addr( fpga2sdram2_aw_addr ),
	.f_aw_burst( fpga2sdram2_aw_burst ),
	.f_aw_cache( fpga2sdram2_aw_cache ),
	.f_aw_id( fpga2sdram2_aw_id ),
	.f_aw_len( fpga2sdram2_aw_len ),
	.f_aw_lock( fpga2sdram2_aw_lock ),
	.f_aw_prot( fpga2sdram2_aw_prot ),
	.f_aw_size( fpga2sdram2_aw_size ),
	.f_aw_user( fpga2sdram2_aw_user ),
	.f_aw_valid( fpga2sdram2_aw_valid ),
	.f_b_ready( fpga2sdram2_b_ready ),
	.f_r_ready( fpga2sdram2_r_ready ),
	.f_w_data( fpga2sdram2_w_data ),
	.f_w_id( fpga2sdram2_w_id ),
	.f_w_last( fpga2sdram2_w_last ),
	.f_w_strb( fpga2sdram2_w_strb ),
	.f_w_valid( fpga2sdram2_w_valid ),
	.rst_n( f2s_sdram2_rst_n ),
	.s_ar_ready( s2_ar_ready ),
	.s_aw_ready( s2_aw_ready ),
	.s_b_id( s2_b_id ),
	.s_b_resp( s2_b_resp ),
	.s_b_valid( s2_b_valid ),
	.s_r_data( s2_r_data ),
	.s_r_id( s2_r_id ),
	.s_r_last( s2_r_last ),
	.s_r_resp( s2_r_resp ),
	.s_r_valid( s2_r_valid ),
	.s_ready_latency( fpga2sdram_port_size_config[3] ),
	.s_w_ready( s2_w_ready ),
	.f_ar_ready( fpga2sdram2_ar_ready ),
	.f_aw_ready( fpga2sdram2_aw_ready ),
	.f_b_id( fpga2sdram2_b_id ),
	.f_b_resp( fpga2sdram2_b_resp ),
	.f_b_valid( fpga2sdram2_b_valid ),
	.f_r_data( fpga2sdram2_r_data ),
	.f_r_id(   fpga2sdram2_r_id ),
	.f_r_last( fpga2sdram2_r_last ),
	.f_r_resp( fpga2sdram2_r_resp ),
	.f_r_valid( fpga2sdram2_r_valid ),
	.f_w_ready( fpga2sdram2_w_ready ),
	.s_ar_addr( s2_ar_addr ),
	.s_ar_burst( s2_ar_burst ),
	.s_ar_cache( s2_ar_cache ),
	.s_ar_id( s2_ar_id ),
	.s_ar_len( s2_ar_len ),
	.s_ar_lock( s2_ar_lock ),
	.s_ar_prot( s2_ar_prot ),
	.s_ar_size( s2_ar_size ),
	.s_ar_user( s2_ar_user ),
	.s_ar_valid( s2_ar_valid ),
	.s_aw_addr( s2_aw_addr ),
	.s_aw_burst( s2_aw_burst ),
	.s_aw_cache( s2_aw_cache ),
	.s_aw_id( s2_aw_id ),
	.s_aw_len( s2_aw_len ),
	.s_aw_lock( s2_aw_lock ),
	.s_aw_prot( s2_aw_prot ),
	.s_aw_size( s2_aw_size ),
	.s_aw_user( s2_aw_user ),
	.s_aw_valid( s2_aw_valid ),
	.s_b_ready( s2_b_ready ),
	.s_r_ready( s2_r_ready ),
	.s_w_data( s2_w_data ),
	.s_w_id( s2_w_id ),
	.s_w_last( s2_w_last ),
	.s_w_strb( s2_w_strb ),
	.s_w_valid( s2_w_valid )
);


twentynm_hps_interface_fpga2sdram fpga2sdram_2_instance(
  .f2s_sdram0_ar_clk(f2s_sdram0_ar_clk),
  .f2s_sdram0_aw_clk(f2s_sdram0_aw_clk),
  .f2s_sdram0_b_clk(f2s_sdram0_b_clk),
  .f2s_sdram0_clk(f2s_sdram0_clk),
  .f2s_sdram0_r_clk(f2s_sdram0_r_clk),
  .f2s_sdram0_w_clk(f2s_sdram0_w_clk),
  .f2s_sdram1_ar_clk(1'b0),
  .f2s_sdram1_aw_clk(1'b0),
  .f2s_sdram1_b_clk(1'b0),
  .f2s_sdram1_clk(1'b0),
  .f2s_sdram1_r_clk(1'b0),
  .f2s_sdram1_w_clk(1'b0),
  .f2s_sdram2_ar_clk(f2s_sdram2_ar_clk),
  .f2s_sdram2_aw_clk(f2s_sdram2_aw_clk),
  .f2s_sdram2_b_clk(f2s_sdram2_b_clk),
  .f2s_sdram2_clk(f2s_sdram2_clk),
  .f2s_sdram2_r_clk(f2s_sdram2_r_clk),
  .f2s_sdram2_w_clk(f2s_sdram2_w_clk),
  .fpga2sdram_port_size_config(fpga2sdram_port_size_config),
  .fpga2sdram0_ar_ready(w_fpga2sdram0_ar_ready),
  .fpga2sdram0_ar_valid(w_fpga2sdram0_ar_valid),
  .fpga2sdram0_aw_ready(w_fpga2sdram0_aw_ready),
  .fpga2sdram0_aw_valid(w_fpga2sdram0_aw_valid),
  .fpga2sdram0_b_ready(w_fpga2sdram0_b_ready),
  .fpga2sdram0_b_valid(w_fpga2sdram0_b_valid),
  .fpga2sdram0_req_addr(w_fpga2sdram0_req_addr),
  .fpga2sdram0_req_be(w_fpga2sdram0_req_be),
  .fpga2sdram0_req_data(w_fpga2sdram0_req_data),
  .fpga2sdram0_req_exclid(w_fpga2sdram0_req_exclid),
  .fpga2sdram0_req_hurry(w_fpga2sdram0_req_hurry),
  .fpga2sdram0_req_last(w_fpga2sdram0_req_last),
  .fpga2sdram0_req_length(w_fpga2sdram0_req_length),
  .fpga2sdram0_req_opc(w_fpga2sdram0_req_opc),
  .fpga2sdram0_req_press(w_fpga2sdram0_req_press),
  .fpga2sdram0_req_rdy(w_fpga2sdram0_req_rdy),
  .fpga2sdram0_req_seqid(w_fpga2sdram0_req_seqid),
  .fpga2sdram0_req_trid(w_fpga2sdram0_req_trid),
  .fpga2sdram0_req_urgency(w_fpga2sdram0_req_urgency),
  .fpga2sdram0_req_user(w_fpga2sdram0_req_user),
  .fpga2sdram0_req_vld(w_fpga2sdram0_req_vld),
  .fpga2sdram0_rsp_cont(w_fpga2sdram0_rsp_cont),
  .fpga2sdram0_rsp_data(w_fpga2sdram0_rsp_data),
  .fpga2sdram0_rsp_last(w_fpga2sdram0_rsp_last),
  .fpga2sdram0_rsp_rdy(w_fpga2sdram0_rsp_rdy),
  .fpga2sdram0_rsp_status(w_fpga2sdram0_rsp_status),
  .fpga2sdram0_rsp_trid(w_fpga2sdram0_rsp_trid),
  .fpga2sdram0_rsp_vld(w_fpga2sdram0_rsp_vld),
  .fpga2sdram1_req_addr(w_fpga2sdram1_req_addr),
  .fpga2sdram1_req_data(w_fpga2sdram1_req_data),
  .fpga2sdram1_req_hurry(w_fpga2sdram1_req_hurry),
  .fpga2sdram1_req_seqid(w_fpga2sdram1_req_seqid),
  .fpga2sdram1_req_user(w_fpga2sdram1_req_user),
  .fpga2sdram1_rsp_data(w_fpga2sdram1_rsp_data),
  .fpga2sdram2_ar_ready(w_fpga2sdram2_ar_ready),
  .fpga2sdram2_ar_valid(w_fpga2sdram2_ar_valid),
  .fpga2sdram2_aw_ready(w_fpga2sdram2_aw_ready),
  .fpga2sdram2_aw_valid(w_fpga2sdram2_aw_valid),
  .fpga2sdram2_b_ready(w_fpga2sdram2_b_ready),
  .fpga2sdram2_b_valid(w_fpga2sdram2_b_valid),
  .fpga2sdram2_req_addr(w_fpga2sdram2_req_addr),
  .fpga2sdram2_req_be(w_fpga2sdram2_req_be),
  .fpga2sdram2_req_data(w_fpga2sdram2_req_data),
  .fpga2sdram2_req_exclid(w_fpga2sdram2_req_exclid),
  .fpga2sdram2_req_hurry(w_fpga2sdram2_req_hurry),
  .fpga2sdram2_req_last(w_fpga2sdram2_req_last),
  .fpga2sdram2_req_length(w_fpga2sdram2_req_length),
  .fpga2sdram2_req_opc(w_fpga2sdram2_req_opc),
  .fpga2sdram2_req_press(w_fpga2sdram2_req_press),
  .fpga2sdram2_req_rdy(w_fpga2sdram2_req_rdy),
  .fpga2sdram2_req_seqid(w_fpga2sdram2_req_seqid),
  .fpga2sdram2_req_trid(w_fpga2sdram2_req_trid),
  .fpga2sdram2_req_urgency(w_fpga2sdram2_req_urgency),
  .fpga2sdram2_req_user(w_fpga2sdram2_req_user),
  .fpga2sdram2_req_vld(w_fpga2sdram2_req_vld),
  .fpga2sdram2_rsp_cont(w_fpga2sdram2_rsp_cont),
  .fpga2sdram2_rsp_data(w_fpga2sdram2_rsp_data),
  .fpga2sdram2_rsp_last(w_fpga2sdram2_rsp_last),
  .fpga2sdram2_rsp_rdy(w_fpga2sdram2_rsp_rdy),
  .fpga2sdram2_rsp_status(w_fpga2sdram2_rsp_status),
  .fpga2sdram2_rsp_trid(w_fpga2sdram2_rsp_trid),
  .fpga2sdram2_rsp_vld(w_fpga2sdram2_rsp_vld)
);
defparam fpga2sdram_2_instance.mode = mode;

endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
`timescale 1 ps / 1 ps
module twentynm_hps_rl_mode3_fpga2sdram #(
  parameter DEPTH   = 4,
  parameter DWIDTH0 = 16,
  parameter DWIDTH1 = 16,
  parameter DWIDTH2 = 16,
  parameter mode    = 4
)(
  input   wire           f2s_sdram0_ar_clk,
  input   wire           f2s_sdram0_aw_clk,
  input   wire           f2s_sdram0_b_clk,
  input   wire           f2s_sdram0_clk,
  input   wire           f2s_sdram0_r_clk,
  input   wire           f2s_sdram0_w_clk,
  input   wire           f2s_sdram1_ar_clk,
  input   wire           f2s_sdram1_aw_clk,
  input   wire           f2s_sdram1_b_clk,
  input   wire           f2s_sdram1_clk,
  input   wire           f2s_sdram1_r_clk,
  input   wire           f2s_sdram1_w_clk,
  input   wire           f2s_sdram2_ar_clk,
  input   wire           f2s_sdram2_aw_clk,
  input   wire           f2s_sdram2_b_clk,
  input   wire           f2s_sdram2_clk,
  input   wire           f2s_sdram2_r_clk,
  input   wire           f2s_sdram2_w_clk,
  input   wire           f2s_sdram0_rst_n,
  input   wire           f2s_sdram1_rst_n,
  input   wire           f2s_sdram2_rst_n,
  input   wire [    3:0] fpga2sdram_port_size_config,
  input   wire [ 32-1:0] fpga2sdram0_ar_addr,
  input   wire [  2-1:0] fpga2sdram0_ar_burst,
  input   wire [  4-1:0] fpga2sdram0_ar_cache,
  input   wire [  4-1:0] fpga2sdram0_ar_id,
  input   wire [  4-1:0] fpga2sdram0_ar_len,
  input   wire [  2-1:0] fpga2sdram0_ar_lock,
  input   wire [  3-1:0] fpga2sdram0_ar_prot,
  output  wire [  1-1:0] fpga2sdram0_ar_ready,
  input   wire [  3-1:0] fpga2sdram0_ar_size,
  input   wire [  5-1:0] fpga2sdram0_ar_user,
  input   wire [  1-1:0] fpga2sdram0_ar_valid,
  input   wire [ 32-1:0] fpga2sdram0_aw_addr,
  input   wire [  2-1:0] fpga2sdram0_aw_burst,
  input   wire [  4-1:0] fpga2sdram0_aw_cache,
  input   wire [  4-1:0] fpga2sdram0_aw_id,
  input   wire [  4-1:0] fpga2sdram0_aw_len,
  input   wire [  2-1:0] fpga2sdram0_aw_lock,
  input   wire [  3-1:0] fpga2sdram0_aw_prot,
  output  wire [  1-1:0] fpga2sdram0_aw_ready,
  input   wire [  3-1:0] fpga2sdram0_aw_size,
  input   wire [  5-1:0] fpga2sdram0_aw_user,
  input   wire [  1-1:0] fpga2sdram0_aw_valid,
  output  wire [  4-1:0] fpga2sdram0_b_id,
  input   wire [  1-1:0] fpga2sdram0_b_ready,
  output  wire [  2-1:0] fpga2sdram0_b_resp,
  output  wire [  1-1:0] fpga2sdram0_b_valid,
  output  wire [128-1:0] fpga2sdram0_r_data,
  output  wire [  4-1:0] fpga2sdram0_r_id,
  output  wire [  1-1:0] fpga2sdram0_r_last,
  input   wire [  1-1:0] fpga2sdram0_r_ready,
  output  wire [  2-1:0] fpga2sdram0_r_resp,
  output  wire [  1-1:0] fpga2sdram0_r_valid,
  input   wire [128-1:0] fpga2sdram0_w_data,
  input   wire [  4-1:0] fpga2sdram0_w_id,
  input   wire [  1-1:0] fpga2sdram0_w_last,
  output  wire [  1-1:0] fpga2sdram0_w_ready,
  input   wire [ 16-1:0] fpga2sdram0_w_strb,
  input   wire [  1-1:0] fpga2sdram0_w_valid,
  input   wire [ 32-1:0] fpga2sdram1_ar_addr,
  input   wire [  2-1:0] fpga2sdram1_ar_burst,
  input   wire [  4-1:0] fpga2sdram1_ar_cache,
  input   wire [  4-1:0] fpga2sdram1_ar_id,
  input   wire [  4-1:0] fpga2sdram1_ar_len,
  input   wire [  2-1:0] fpga2sdram1_ar_lock,
  input   wire [  3-1:0] fpga2sdram1_ar_prot,
  output  wire [  1-1:0] fpga2sdram1_ar_ready,
  input   wire [  3-1:0] fpga2sdram1_ar_size,
  input   wire [  5-1:0] fpga2sdram1_ar_user,
  input   wire [  1-1:0] fpga2sdram1_ar_valid,
  input   wire [ 32-1:0] fpga2sdram1_aw_addr,
  input   wire [  2-1:0] fpga2sdram1_aw_burst,
  input   wire [  4-1:0] fpga2sdram1_aw_cache,
  input   wire [  4-1:0] fpga2sdram1_aw_id,
  input   wire [  4-1:0] fpga2sdram1_aw_len,
  input   wire [  2-1:0] fpga2sdram1_aw_lock,
  input   wire [  3-1:0] fpga2sdram1_aw_prot,
  output  wire [  1-1:0] fpga2sdram1_aw_ready,
  input   wire [  3-1:0] fpga2sdram1_aw_size,
  input   wire [  5-1:0] fpga2sdram1_aw_user,
  input   wire [  1-1:0] fpga2sdram1_aw_valid,
  output  wire [  4-1:0] fpga2sdram1_b_id,
  input   wire [  1-1:0] fpga2sdram1_b_ready,
  output  wire [  2-1:0] fpga2sdram1_b_resp,
  output  wire [  1-1:0] fpga2sdram1_b_valid,
  output  wire [ 32-1:0] fpga2sdram1_r_data,
  output  wire [  4-1:0] fpga2sdram1_r_id,
  output  wire [  1-1:0] fpga2sdram1_r_last,
  input   wire [  1-1:0] fpga2sdram1_r_ready,
  output  wire [  2-1:0] fpga2sdram1_r_resp,
  output  wire [  1-1:0] fpga2sdram1_r_valid,
  input   wire [ 32-1:0] fpga2sdram1_w_data,
  input   wire [  4-1:0] fpga2sdram1_w_id,
  input   wire [  1-1:0] fpga2sdram1_w_last,
  output  wire [  1-1:0] fpga2sdram1_w_ready,
  input   wire [  4-1:0] fpga2sdram1_w_strb,
  input   wire [  1-1:0] fpga2sdram1_w_valid,
  input   wire [ 32-1:0] fpga2sdram2_ar_addr,
  input   wire [  2-1:0] fpga2sdram2_ar_burst,
  input   wire [  4-1:0] fpga2sdram2_ar_cache,
  input   wire [  4-1:0] fpga2sdram2_ar_id,
  input   wire [  4-1:0] fpga2sdram2_ar_len,
  input   wire [  2-1:0] fpga2sdram2_ar_lock,
  input   wire [  3-1:0] fpga2sdram2_ar_prot,
  output  wire [  1-1:0] fpga2sdram2_ar_ready,
  input   wire [  3-1:0] fpga2sdram2_ar_size,
  input   wire [  5-1:0] fpga2sdram2_ar_user,
  input   wire [  1-1:0] fpga2sdram2_ar_valid,
  input   wire [ 32-1:0] fpga2sdram2_aw_addr,
  input   wire [  2-1:0] fpga2sdram2_aw_burst,
  input   wire [  4-1:0] fpga2sdram2_aw_cache,
  input   wire [  4-1:0] fpga2sdram2_aw_id,
  input   wire [  4-1:0] fpga2sdram2_aw_len,
  input   wire [  2-1:0] fpga2sdram2_aw_lock,
  input   wire [  3-1:0] fpga2sdram2_aw_prot,
  output  wire [  1-1:0] fpga2sdram2_aw_ready,
  input   wire [  3-1:0] fpga2sdram2_aw_size,
  input   wire [  5-1:0] fpga2sdram2_aw_user,
  input   wire [  1-1:0] fpga2sdram2_aw_valid,
  output  wire [  4-1:0] fpga2sdram2_b_id,
  input   wire [  1-1:0] fpga2sdram2_b_ready,
  output  wire [  2-1:0] fpga2sdram2_b_resp,
  output  wire [  1-1:0] fpga2sdram2_b_valid,
  output  wire [ 64-1:0] fpga2sdram2_r_data,
  output  wire [  4-1:0] fpga2sdram2_r_id,
  output  wire [  1-1:0] fpga2sdram2_r_last,
  input   wire [  1-1:0] fpga2sdram2_r_ready,
  output  wire [  2-1:0] fpga2sdram2_r_resp,
  output  wire [  1-1:0] fpga2sdram2_r_valid,
  input   wire [ 64-1:0] fpga2sdram2_w_data,
  input   wire [  4-1:0] fpga2sdram2_w_id,
  input   wire [  1-1:0] fpga2sdram2_w_last,
  output  wire [  1-1:0] fpga2sdram2_w_ready,
  input   wire [  8-1:0] fpga2sdram2_w_strb,
  input   wire [  1-1:0] fpga2sdram2_w_valid
);


wire [  1-1:0] w_fpga2sdram0_ar_ready;
wire [  1-1:0] w_fpga2sdram0_ar_valid;
wire [  1-1:0] w_fpga2sdram0_aw_ready;
wire [  1-1:0] w_fpga2sdram0_aw_valid;
wire [  1-1:0] w_fpga2sdram0_b_ready;
wire [  1-1:0] w_fpga2sdram0_b_valid;
wire [ 32-1:0] w_fpga2sdram0_req_addr;
wire [ 16-1:0] w_fpga2sdram0_req_be;
wire [128-1:0] w_fpga2sdram0_req_data;
wire [  4-1:0] w_fpga2sdram0_req_exclid;
wire [  2-1:0] w_fpga2sdram0_req_hurry;
wire [  1-1:0] w_fpga2sdram0_req_last;
wire [  8-1:0] w_fpga2sdram0_req_length;
wire [  3-1:0] w_fpga2sdram0_req_opc;
wire [  2-1:0] w_fpga2sdram0_req_press;
wire [  1-1:0] w_fpga2sdram0_req_rdy;
wire [  4-1:0] w_fpga2sdram0_req_seqid;
wire [  3-1:0] w_fpga2sdram0_req_trid;
wire [  2-1:0] w_fpga2sdram0_req_urgency;
wire [ 12-1:0] w_fpga2sdram0_req_user;
wire [  1-1:0] w_fpga2sdram0_req_vld;
wire [  1-1:0] w_fpga2sdram0_rsp_cont;
wire [128-1:0] w_fpga2sdram0_rsp_data;
wire [  1-1:0] w_fpga2sdram0_rsp_last;
wire [  1-1:0] w_fpga2sdram0_rsp_rdy;
wire [  2-1:0] w_fpga2sdram0_rsp_status;
wire [  3-1:0] w_fpga2sdram0_rsp_trid;
wire [  1-1:0] w_fpga2sdram0_rsp_vld;
wire [  1-1:0] w_fpga2sdram1_ar_ready;
wire [  1-1:0] w_fpga2sdram1_ar_valid;
wire [  1-1:0] w_fpga2sdram1_aw_ready;
wire [  1-1:0] w_fpga2sdram1_aw_valid;
wire [  1-1:0] w_fpga2sdram1_b_ready;
wire [  1-1:0] w_fpga2sdram1_b_valid;
wire [ 32-1:0] w_fpga2sdram1_req_addr;
wire [ 16-1:0] w_fpga2sdram1_req_be;
wire [128-1:0] w_fpga2sdram1_req_data;
wire [  4-1:0] w_fpga2sdram1_req_exclid;
wire [  2-1:0] w_fpga2sdram1_req_hurry;
wire [  1-1:0] w_fpga2sdram1_req_last;
wire [  8-1:0] w_fpga2sdram1_req_length;
wire [  3-1:0] w_fpga2sdram1_req_opc;
wire [  2-1:0] w_fpga2sdram1_req_press;
wire [  1-1:0] w_fpga2sdram1_req_rdy;
wire [  4-1:0] w_fpga2sdram1_req_seqid;
wire [  3-1:0] w_fpga2sdram1_req_trid;
wire [  2-1:0] w_fpga2sdram1_req_urgency;
wire [ 12-1:0] w_fpga2sdram1_req_user;
wire [  1-1:0] w_fpga2sdram1_req_vld;
wire [  1-1:0] w_fpga2sdram1_rsp_cont;
wire [122-1:0] w_fpga2sdram1_rsp_data;
wire [  1-1:0] w_fpga2sdram1_rsp_last;
wire [  1-1:0] w_fpga2sdram1_rsp_rdy;
wire [  2-1:0] w_fpga2sdram1_rsp_status;
wire [  3-1:0] w_fpga2sdram1_rsp_trid;
wire [  1-1:0] w_fpga2sdram1_rsp_vld;
wire [  1-1:0] w_fpga2sdram2_ar_ready;
wire [  1-1:0] w_fpga2sdram2_ar_valid;
wire [  1-1:0] w_fpga2sdram2_aw_ready;
wire [  1-1:0] w_fpga2sdram2_aw_valid;
wire [  1-1:0] w_fpga2sdram2_b_ready;
wire [  1-1:0] w_fpga2sdram2_b_valid;
wire [ 32-1:0] w_fpga2sdram2_req_addr;
wire [ 16-1:0] w_fpga2sdram2_req_be;
wire [128-1:0] w_fpga2sdram2_req_data;
wire [  4-1:0] w_fpga2sdram2_req_exclid;
wire [  2-1:0] w_fpga2sdram2_req_hurry;
wire [  1-1:0] w_fpga2sdram2_req_last;
wire [  8-1:0] w_fpga2sdram2_req_length;
wire [  3-1:0] w_fpga2sdram2_req_opc;
wire [  2-1:0] w_fpga2sdram2_req_press;
wire [  1-1:0] w_fpga2sdram2_req_rdy;
wire [  4-1:0] w_fpga2sdram2_req_seqid;
wire [  3-1:0] w_fpga2sdram2_req_trid;
wire [  2-1:0] w_fpga2sdram2_req_urgency;
wire [ 12-1:0] w_fpga2sdram2_req_user;
wire [  1-1:0] w_fpga2sdram2_req_vld;
wire [  1-1:0] w_fpga2sdram2_rsp_cont;
wire [ 70-1:0] w_fpga2sdram2_rsp_data;
wire [  1-1:0] w_fpga2sdram2_rsp_last;
wire [  1-1:0] w_fpga2sdram2_rsp_rdy;
wire [  2-1:0] w_fpga2sdram2_rsp_status;
wire [  3-1:0] w_fpga2sdram2_rsp_trid;
wire [  1-1:0] w_fpga2sdram2_rsp_vld;


wire                     s0_ar_ready;
wire                     s0_aw_ready;
wire               [3:0] s0_b_id;
wire               [1:0] s0_b_resp;
wire                     s0_b_valid;
wire           [128-1:0] s0_r_data;
wire               [3:0] s0_r_id;
wire                     s0_r_last;
wire               [1:0] s0_r_resp;
wire                     s0_r_valid;
wire                     s0_w_ready;
wire             [31:0] s0_ar_addr;
wire              [1:0] s0_ar_burst;
wire              [3:0] s0_ar_cache;
wire              [3:0] s0_ar_id;
wire              [3:0] s0_ar_len;
wire              [1:0] s0_ar_lock;
wire              [2:0] s0_ar_prot;
wire              [2:0] s0_ar_size;
wire              [4:0] s0_ar_user;
wire                    s0_ar_valid;
wire             [31:0] s0_aw_addr;
wire              [1:0] s0_aw_burst;
wire              [3:0] s0_aw_cache;
wire              [3:0] s0_aw_id;
wire              [3:0] s0_aw_len;
wire              [1:0] s0_aw_lock;
wire              [2:0] s0_aw_prot;
wire              [2:0] s0_aw_size;
wire              [4:0] s0_aw_user;
wire                    s0_aw_valid;
wire                    s0_b_ready;
wire                    s0_r_ready;
wire       [128-1:0] s0_w_data;
wire              [3:0] s0_w_id;
wire                    s0_w_last;
wire     [128/8-1:0] s0_w_strb;
wire                    s0_w_valid;

wire                     s1_ar_ready;
wire                     s1_aw_ready;
wire               [3:0] s1_b_id;
wire               [1:0] s1_b_resp;
wire                     s1_b_valid;
wire        [32-1:0] s1_r_data;
wire               [3:0] s1_r_id;
wire                     s1_r_last;
wire               [1:0] s1_r_resp;
wire                     s1_r_valid;
wire                     s1_w_ready;
wire             [31:0] s1_ar_addr;
wire              [1:0] s1_ar_burst;
wire              [3:0] s1_ar_cache;
wire              [3:0] s1_ar_id;
wire              [3:0] s1_ar_len;
wire              [1:0] s1_ar_lock;
wire              [2:0] s1_ar_prot;
wire              [2:0] s1_ar_size;
wire              [4:0] s1_ar_user;
wire                    s1_ar_valid;
wire             [31:0] s1_aw_addr;
wire              [1:0] s1_aw_burst;
wire              [3:0] s1_aw_cache;
wire              [3:0] s1_aw_id;
wire              [3:0] s1_aw_len;
wire              [1:0] s1_aw_lock;
wire              [2:0] s1_aw_prot;
wire              [2:0] s1_aw_size;
wire              [4:0] s1_aw_user;
wire                    s1_aw_valid;
wire                    s1_b_ready;
wire                    s1_r_ready;
wire       [32-1:0] s1_w_data;
wire              [3:0] s1_w_id;
wire                    s1_w_last;
wire     [32/8-1:0] s1_w_strb;
wire                    s1_w_valid;

wire                     s2_ar_ready;
wire                     s2_aw_ready;
wire               [3:0] s2_b_id;
wire               [1:0] s2_b_resp;
wire                     s2_b_valid;
wire        [64-1:0] s2_r_data;
wire               [3:0] s2_r_id;
wire                     s2_r_last;
wire               [1:0] s2_r_resp;
wire                     s2_r_valid;
wire                     s2_w_ready;
wire             [31:0] s2_ar_addr;
wire              [1:0] s2_ar_burst;
wire              [3:0] s2_ar_cache;
wire              [3:0] s2_ar_id;
wire              [3:0] s2_ar_len;
wire              [1:0] s2_ar_lock;
wire              [2:0] s2_ar_prot;
wire              [2:0] s2_ar_size;
wire              [4:0] s2_ar_user;
wire                    s2_ar_valid;
wire             [31:0] s2_aw_addr;
wire              [1:0] s2_aw_burst;
wire              [3:0] s2_aw_cache;
wire              [3:0] s2_aw_id;
wire              [3:0] s2_aw_len;
wire              [1:0] s2_aw_lock;
wire              [2:0] s2_aw_prot;
wire              [2:0] s2_aw_size;
wire              [4:0] s2_aw_user;
wire                    s2_aw_valid;
wire                    s2_b_ready;
wire                    s2_r_ready;
wire       [64-1:0] s2_w_data;
wire              [3:0] s2_w_id;
wire                    s2_w_last;
wire     [64/8-1:0] s2_w_strb;
wire                    s2_w_valid;

assign s0_ar_ready 	= w_fpga2sdram0_ar_ready;
assign s0_aw_ready 	= w_fpga2sdram0_aw_ready;
assign s0_b_id[3:0] 	= w_fpga2sdram1_rsp_data[35:32];
assign s0_b_resp[1:0] 	= w_fpga2sdram1_rsp_data[37:36];
assign s0_b_valid 	= w_fpga2sdram0_b_valid;
assign s0_r_data[127:64] 	= w_fpga2sdram0_rsp_data[127:64];
assign s0_r_data[31:0] 	= w_fpga2sdram0_rsp_data[31:0];
assign s0_r_data[63:32] 	= w_fpga2sdram0_rsp_data[63:32];
assign s0_r_id[2:0] 	= w_fpga2sdram0_rsp_trid[2:0];
assign s0_r_id[3] 	= w_fpga2sdram0_rsp_cont;
assign s0_r_last 	= w_fpga2sdram0_rsp_last;
assign s0_r_resp[1:0] 	= w_fpga2sdram0_rsp_status[1:0];
assign s0_r_valid 	= w_fpga2sdram0_rsp_vld;
assign s0_w_ready 	= w_fpga2sdram0_req_rdy;
assign s1_ar_ready 	= w_fpga2sdram1_ar_ready;
assign s1_aw_ready 	= w_fpga2sdram1_aw_ready;
assign s1_b_id[3:0] 	= w_fpga2sdram1_rsp_data[119:116];
assign s1_b_resp[1:0] 	= w_fpga2sdram1_rsp_data[121:120];
assign s1_b_valid 	= w_fpga2sdram1_b_valid;
assign s1_r_data[31:0] 	= w_fpga2sdram1_rsp_data[31:0];
assign s1_r_id[2:0] 	= w_fpga2sdram1_rsp_trid[2:0];
assign s1_r_id[3] 	= w_fpga2sdram1_rsp_cont;
assign s1_r_last 	= w_fpga2sdram1_rsp_last;
assign s1_r_resp[1:0] 	= w_fpga2sdram1_rsp_status[1:0];
assign s1_r_valid 	= w_fpga2sdram1_rsp_vld;
assign s1_w_ready 	= w_fpga2sdram1_req_rdy;
assign s2_ar_ready 	= w_fpga2sdram2_ar_ready;
assign s2_aw_ready 	= w_fpga2sdram2_aw_ready;
assign s2_b_id[3:0] 	= w_fpga2sdram2_rsp_data[67:64];
assign s2_b_resp[1:0] 	= w_fpga2sdram2_rsp_data[69:68];
assign s2_b_valid 	= w_fpga2sdram2_b_valid;
assign s2_r_data[31:0] 	= w_fpga2sdram2_rsp_data[31:0];
assign s2_r_data[63:32] 	= w_fpga2sdram2_rsp_data[63:32];
assign s2_r_id[2:0] 	= w_fpga2sdram2_rsp_trid[2:0];
assign s2_r_id[3] 	= w_fpga2sdram2_rsp_cont;
assign s2_r_last 	= w_fpga2sdram2_rsp_last;
assign s2_r_resp[1:0] 	= w_fpga2sdram2_rsp_status[1:0];
assign s2_r_valid 	= w_fpga2sdram2_rsp_vld;
assign s2_w_ready 	= w_fpga2sdram2_req_rdy;
assign w_fpga2sdram0_ar_valid 	= s0_ar_valid;
assign w_fpga2sdram0_aw_valid 	= s0_aw_valid;
assign w_fpga2sdram0_b_ready 	= s0_b_ready;
assign w_fpga2sdram0_req_addr[31:0] 	= s0_aw_addr[31:0];
assign w_fpga2sdram0_req_be[15:8] 	= s0_w_strb[15:8];
assign w_fpga2sdram0_req_be[3:0] 	= s0_w_strb[3:0];
assign w_fpga2sdram0_req_be[7:4] 	= s0_w_strb[7:4];
assign w_fpga2sdram0_req_data[127:64] 	= s0_w_data[127:64];
assign w_fpga2sdram0_req_data[31:0] 	= s0_w_data[31:0];
assign w_fpga2sdram0_req_data[63:32] 	= s0_w_data[63:32];
assign w_fpga2sdram0_req_exclid[3:0] 	= s0_w_id[3:0];
assign w_fpga2sdram0_req_hurry[1:0] 	= s0_aw_lock[1:0];
assign w_fpga2sdram0_req_last 	= s0_w_last;
assign w_fpga2sdram0_req_length[3:0] 	= s0_aw_len[3:0];
assign w_fpga2sdram0_req_length[7:4] 	= s0_ar_len[3:0];
assign w_fpga2sdram0_req_opc[2:0] 	= s0_aw_size[2:0];
assign w_fpga2sdram0_req_press[1:0] 	= s0_aw_burst[1:0];
assign w_fpga2sdram0_req_seqid[3:0] 	= s0_aw_id[3:0];
assign w_fpga2sdram0_req_trid[2:0] 	= s0_ar_prot[2:0];
assign w_fpga2sdram0_req_urgency[1:0] 	= s0_ar_burst[1:0];
assign w_fpga2sdram0_req_user[11:7] 	= s0_aw_user[4:0];
assign w_fpga2sdram0_req_user[3:0] 	= s0_aw_cache[3:0];
assign w_fpga2sdram0_req_user[6:4] 	= s0_aw_prot[2:0];
assign w_fpga2sdram0_req_vld 	= s0_w_valid;
assign w_fpga2sdram0_rsp_rdy 	= s0_r_ready;
assign w_fpga2sdram1_ar_valid 	= s1_ar_valid;
assign w_fpga2sdram1_aw_valid 	= s1_aw_valid;
assign w_fpga2sdram1_b_ready 	= s1_b_ready;
assign w_fpga2sdram1_req_addr[31:0] 	= s1_aw_addr[31:0];
assign w_fpga2sdram1_req_be[11:8] 	= s1_ar_cache[3:0];
assign w_fpga2sdram1_req_be[15:12] 	= s1_ar_id[3:0];
assign w_fpga2sdram1_req_be[3:0] 	= s1_w_strb[3:0];
assign w_fpga2sdram1_req_data[127:96] 	= s1_ar_addr[31:0];
assign w_fpga2sdram1_req_data[31:0] 	= s1_w_data[31:0];
assign w_fpga2sdram1_req_data[35:32] 	= s0_ar_cache[3:0];
assign w_fpga2sdram1_req_data[39:36] 	= s0_ar_id[3:0];
assign w_fpga2sdram1_req_data[41:40] 	= s0_ar_lock[1:0];
assign w_fpga2sdram1_req_data[44:42] 	= s0_ar_size[2:0];
assign w_fpga2sdram1_req_data[49:45] 	= s0_ar_user[4:0];
assign w_fpga2sdram1_req_data[81:50] 	= s0_ar_addr[31:0];
assign w_fpga2sdram1_req_data[87:86] 	= s1_ar_lock[1:0];
assign w_fpga2sdram1_req_data[90:88] 	= s1_ar_size[2:0];
assign w_fpga2sdram1_req_data[95:91] 	= s1_ar_user[4:0];
assign w_fpga2sdram1_req_exclid[3:0] 	= s1_w_id[3:0];
assign w_fpga2sdram1_req_hurry[1:0] 	= s1_aw_lock[1:0];
assign w_fpga2sdram1_req_last 	= s1_w_last;
assign w_fpga2sdram1_req_length[3:0] 	= s1_aw_len[3:0];
assign w_fpga2sdram1_req_length[7:4] 	= s1_ar_len[3:0];
assign w_fpga2sdram1_req_opc[2:0] 	= s1_aw_size[2:0];
assign w_fpga2sdram1_req_press[1:0] 	= s1_aw_burst[1:0];
assign w_fpga2sdram1_req_seqid[3:0] 	= s1_aw_id[3:0];
assign w_fpga2sdram1_req_trid[2:0] 	= s1_ar_prot[2:0];
assign w_fpga2sdram1_req_urgency[1:0] 	= s1_ar_burst[1:0];
assign w_fpga2sdram1_req_user[11:7] 	= s1_aw_user[4:0];
assign w_fpga2sdram1_req_user[3:0] 	= s1_aw_cache[3:0];
assign w_fpga2sdram1_req_user[6:4] 	= s1_aw_prot[2:0];
assign w_fpga2sdram1_req_vld 	= s1_w_valid;
assign w_fpga2sdram1_rsp_rdy 	= s1_r_ready;
assign w_fpga2sdram2_ar_valid 	= s2_ar_valid;
assign w_fpga2sdram2_aw_valid 	= s2_aw_valid;
assign w_fpga2sdram2_b_ready 	= s2_b_ready;
assign w_fpga2sdram2_req_addr[31:0] 	= s2_aw_addr[31:0];
assign w_fpga2sdram2_req_be[11:8] 	= s2_ar_cache[3:0];
assign w_fpga2sdram2_req_be[15:12] 	= s2_ar_id[3:0];
assign w_fpga2sdram2_req_be[3:0] 	= s2_w_strb[3:0];
assign w_fpga2sdram2_req_be[7:4] 	= s2_w_strb[7:4];
assign w_fpga2sdram2_req_data[127:96] 	= s2_ar_addr[31:0];
assign w_fpga2sdram2_req_data[31:0] 	= s2_w_data[31:0];
assign w_fpga2sdram2_req_data[63:32] 	= s2_w_data[63:32];
assign w_fpga2sdram2_req_data[87:86] 	= s2_ar_lock[1:0];
assign w_fpga2sdram2_req_data[90:88] 	= s2_ar_size[2:0];
assign w_fpga2sdram2_req_data[95:91] 	= s2_ar_user[4:0];
assign w_fpga2sdram2_req_exclid[3:0] 	= s2_w_id[3:0];
assign w_fpga2sdram2_req_hurry[1:0] 	= s2_aw_lock[1:0];
assign w_fpga2sdram2_req_last 	= s2_w_last;
assign w_fpga2sdram2_req_length[3:0] 	= s2_aw_len[3:0];
assign w_fpga2sdram2_req_length[7:4] 	= s2_ar_len[3:0];
assign w_fpga2sdram2_req_opc[2:0] 	= s2_aw_size[2:0];
assign w_fpga2sdram2_req_press[1:0] 	= s2_aw_burst[1:0];
assign w_fpga2sdram2_req_seqid[3:0] 	= s2_aw_id[3:0];
assign w_fpga2sdram2_req_trid[2:0] 	= s2_ar_prot[2:0];
assign w_fpga2sdram2_req_urgency[1:0] 	= s2_ar_burst[1:0];
assign w_fpga2sdram2_req_user[11:7] 	= s2_aw_user[4:0];
assign w_fpga2sdram2_req_user[3:0] 	= s2_aw_cache[3:0];
assign w_fpga2sdram2_req_user[6:4] 	= s2_aw_prot[2:0];
assign w_fpga2sdram2_req_vld 	= s2_w_valid;
assign w_fpga2sdram2_rsp_rdy 	= s2_r_ready;

f2s_rl_delay_adp #( .DWIDTH(DWIDTH0),  .DEPTH(DEPTH) ) f2s_rl_adp_inst_0 (
	.clk( f2s_sdram0_ar_clk ),
	.f_ar_addr( fpga2sdram0_ar_addr ),
	.f_ar_burst( fpga2sdram0_ar_burst ),
	.f_ar_cache( fpga2sdram0_ar_cache ),
	.f_ar_id( fpga2sdram0_ar_id ),
	.f_ar_len( fpga2sdram0_ar_len ),
	.f_ar_lock( fpga2sdram0_ar_lock ),
	.f_ar_prot( fpga2sdram0_ar_prot ),
	.f_ar_size( fpga2sdram0_ar_size ),
	.f_ar_user( fpga2sdram0_ar_user ),
	.f_ar_valid( fpga2sdram0_ar_valid ),
	.f_aw_addr( fpga2sdram0_aw_addr ),
	.f_aw_burst( fpga2sdram0_aw_burst ),
	.f_aw_cache( fpga2sdram0_aw_cache ),
	.f_aw_id( fpga2sdram0_aw_id ),
	.f_aw_len( fpga2sdram0_aw_len ),
	.f_aw_lock( fpga2sdram0_aw_lock ),
	.f_aw_prot( fpga2sdram0_aw_prot ),
	.f_aw_size( fpga2sdram0_aw_size ),
	.f_aw_user( fpga2sdram0_aw_user ),
	.f_aw_valid( fpga2sdram0_aw_valid ),
	.f_b_ready( fpga2sdram0_b_ready ),
	.f_r_ready( fpga2sdram0_r_ready ),
	.f_w_data( fpga2sdram0_w_data ),
	.f_w_id( fpga2sdram0_w_id ),
	.f_w_last( fpga2sdram0_w_last ),
	.f_w_strb( fpga2sdram0_w_strb ),
	.f_w_valid( fpga2sdram0_w_valid ),
	.rst_n( f2s_sdram0_rst_n ),
	.s_ar_ready( s0_ar_ready ),
	.s_aw_ready( s0_aw_ready ),
	.s_b_id( s0_b_id ),
	.s_b_resp( s0_b_resp ),
	.s_b_valid( s0_b_valid ),
	.s_r_data( s0_r_data ),
	.s_r_id( s0_r_id ),
	.s_r_last( s0_r_last ),
	.s_r_resp( s0_r_resp ),
	.s_r_valid( s0_r_valid ),
	.s_ready_latency( fpga2sdram_port_size_config[3] ),
	.s_w_ready( s0_w_ready ),
	.f_ar_ready( fpga2sdram0_ar_ready ),
	.f_aw_ready( fpga2sdram0_aw_ready ),
	.f_b_id( fpga2sdram0_b_id ),
	.f_b_resp( fpga2sdram0_b_resp ),
	.f_b_valid( fpga2sdram0_b_valid ),
	.f_r_data( fpga2sdram0_r_data ),
	.f_r_id(   fpga2sdram0_r_id ),
	.f_r_last( fpga2sdram0_r_last ),
	.f_r_resp( fpga2sdram0_r_resp ),
	.f_r_valid( fpga2sdram0_r_valid ),
	.f_w_ready( fpga2sdram0_w_ready ),
	.s_ar_addr( s0_ar_addr ),
	.s_ar_burst( s0_ar_burst ),
	.s_ar_cache( s0_ar_cache ),
	.s_ar_id( s0_ar_id ),
	.s_ar_len( s0_ar_len ),
	.s_ar_lock( s0_ar_lock ),
	.s_ar_prot( s0_ar_prot ),
	.s_ar_size( s0_ar_size ),
	.s_ar_user( s0_ar_user ),
	.s_ar_valid( s0_ar_valid ),
	.s_aw_addr( s0_aw_addr ),
	.s_aw_burst( s0_aw_burst ),
	.s_aw_cache( s0_aw_cache ),
	.s_aw_id( s0_aw_id ),
	.s_aw_len( s0_aw_len ),
	.s_aw_lock( s0_aw_lock ),
	.s_aw_prot( s0_aw_prot ),
	.s_aw_size( s0_aw_size ),
	.s_aw_user( s0_aw_user ),
	.s_aw_valid( s0_aw_valid ),
	.s_b_ready( s0_b_ready ),
	.s_r_ready( s0_r_ready ),
	.s_w_data( s0_w_data ),
	.s_w_id( s0_w_id ),
	.s_w_last( s0_w_last ),
	.s_w_strb( s0_w_strb ),
	.s_w_valid( s0_w_valid )
);

f2s_rl_delay_adp #( .DWIDTH(DWIDTH1),  .DEPTH(DEPTH) ) f2s_rl_adp_inst_1 (
	.clk(  f2s_sdram1_ar_clk ),
	.f_ar_addr( fpga2sdram1_ar_addr ),
	.f_ar_burst( fpga2sdram1_ar_burst ),
	.f_ar_cache( fpga2sdram1_ar_cache ),
	.f_ar_id( fpga2sdram1_ar_id ),
	.f_ar_len( fpga2sdram1_ar_len ),
	.f_ar_lock( fpga2sdram1_ar_lock ),
	.f_ar_prot( fpga2sdram1_ar_prot ),
	.f_ar_size( fpga2sdram1_ar_size ),
	.f_ar_user( fpga2sdram1_ar_user ),
	.f_ar_valid( fpga2sdram1_ar_valid ),
	.f_aw_addr( fpga2sdram1_aw_addr ),
	.f_aw_burst( fpga2sdram1_aw_burst ),
	.f_aw_cache( fpga2sdram1_aw_cache ),
	.f_aw_id( fpga2sdram1_aw_id ),
	.f_aw_len( fpga2sdram1_aw_len ),
	.f_aw_lock( fpga2sdram1_aw_lock ),
	.f_aw_prot( fpga2sdram1_aw_prot ),
	.f_aw_size( fpga2sdram1_aw_size ),
	.f_aw_user( fpga2sdram1_aw_user ),
	.f_aw_valid( fpga2sdram1_aw_valid ),
	.f_b_ready( fpga2sdram1_b_ready ),
	.f_r_ready( fpga2sdram1_r_ready ),
	.f_w_data( fpga2sdram1_w_data ),
	.f_w_id( fpga2sdram1_w_id ),
	.f_w_last( fpga2sdram1_w_last ),
	.f_w_strb( fpga2sdram1_w_strb ),
	.f_w_valid( fpga2sdram1_w_valid ),
	.rst_n( f2s_sdram1_rst_n ),
	.s_ar_ready( s1_ar_ready ),
	.s_aw_ready( s1_aw_ready ),
	.s_b_id( s1_b_id ),
	.s_b_resp( s1_b_resp ),
	.s_b_valid( s1_b_valid ),
	.s_r_data( s1_r_data ),
	.s_r_id( s1_r_id ),
	.s_r_last( s1_r_last ),
	.s_r_resp( s1_r_resp ),
	.s_r_valid( s1_r_valid ),
	.s_ready_latency( fpga2sdram_port_size_config[3] ),
	.s_w_ready( s1_w_ready ),
	.f_ar_ready( fpga2sdram1_ar_ready ),
	.f_aw_ready( fpga2sdram1_aw_ready ),
	.f_b_id( fpga2sdram1_b_id ),
	.f_b_resp( fpga2sdram1_b_resp ),
	.f_b_valid( fpga2sdram1_b_valid ),
	.f_r_data( fpga2sdram1_r_data ),
	.f_r_id(   fpga2sdram1_r_id ),
	.f_r_last( fpga2sdram1_r_last ),
	.f_r_resp( fpga2sdram1_r_resp ),
	.f_r_valid( fpga2sdram1_r_valid ),
	.f_w_ready( fpga2sdram1_w_ready ),
	.s_ar_addr( s1_ar_addr ),
	.s_ar_burst( s1_ar_burst ),
	.s_ar_cache( s1_ar_cache ),
	.s_ar_id( s1_ar_id ),
	.s_ar_len( s1_ar_len ),
	.s_ar_lock( s1_ar_lock ),
	.s_ar_prot( s1_ar_prot ),
	.s_ar_size( s1_ar_size ),
	.s_ar_user( s1_ar_user ),
	.s_ar_valid( s1_ar_valid ),
	.s_aw_addr( s1_aw_addr ),
	.s_aw_burst( s1_aw_burst ),
	.s_aw_cache( s1_aw_cache ),
	.s_aw_id( s1_aw_id ),
	.s_aw_len( s1_aw_len ),
	.s_aw_lock( s1_aw_lock ),
	.s_aw_prot( s1_aw_prot ),
	.s_aw_size( s1_aw_size ),
	.s_aw_user( s1_aw_user ),
	.s_aw_valid( s1_aw_valid ),
	.s_b_ready( s1_b_ready ),
	.s_r_ready( s1_r_ready ),
	.s_w_data( s1_w_data ),
	.s_w_id( s1_w_id ),
	.s_w_last( s1_w_last ),
	.s_w_strb( s1_w_strb ),
	.s_w_valid( s1_w_valid )
);

f2s_rl_delay_adp #( .DWIDTH(DWIDTH2),  .DEPTH(DEPTH) ) f2s_rl_adp_inst_2 (
	.clk( f2s_sdram2_ar_clk ),
	.f_ar_addr( fpga2sdram2_ar_addr ),
	.f_ar_burst( fpga2sdram2_ar_burst ),
	.f_ar_cache( fpga2sdram2_ar_cache ),
	.f_ar_id( fpga2sdram2_ar_id ),
	.f_ar_len( fpga2sdram2_ar_len ),
	.f_ar_lock( fpga2sdram2_ar_lock ),
	.f_ar_prot( fpga2sdram2_ar_prot ),
	.f_ar_size( fpga2sdram2_ar_size ),
	.f_ar_user( fpga2sdram2_ar_user ),
	.f_ar_valid( fpga2sdram2_ar_valid ),
	.f_aw_addr( fpga2sdram2_aw_addr ),
	.f_aw_burst( fpga2sdram2_aw_burst ),
	.f_aw_cache( fpga2sdram2_aw_cache ),
	.f_aw_id( fpga2sdram2_aw_id ),
	.f_aw_len( fpga2sdram2_aw_len ),
	.f_aw_lock( fpga2sdram2_aw_lock ),
	.f_aw_prot( fpga2sdram2_aw_prot ),
	.f_aw_size( fpga2sdram2_aw_size ),
	.f_aw_user( fpga2sdram2_aw_user ),
	.f_aw_valid( fpga2sdram2_aw_valid ),
	.f_b_ready( fpga2sdram2_b_ready ),
	.f_r_ready( fpga2sdram2_r_ready ),
	.f_w_data( fpga2sdram2_w_data ),
	.f_w_id( fpga2sdram2_w_id ),
	.f_w_last( fpga2sdram2_w_last ),
	.f_w_strb( fpga2sdram2_w_strb ),
	.f_w_valid( fpga2sdram2_w_valid ),
	.rst_n( f2s_sdram2_rst_n ),
	.s_ar_ready( s2_ar_ready ),
	.s_aw_ready( s2_aw_ready ),
	.s_b_id( s2_b_id ),
	.s_b_resp( s2_b_resp ),
	.s_b_valid( s2_b_valid ),
	.s_r_data( s2_r_data ),
	.s_r_id( s2_r_id ),
	.s_r_last( s2_r_last ),
	.s_r_resp( s2_r_resp ),
	.s_r_valid( s2_r_valid ),
	.s_ready_latency( fpga2sdram_port_size_config[3] ),
	.s_w_ready( s2_w_ready ),
	.f_ar_ready( fpga2sdram2_ar_ready ),
	.f_aw_ready( fpga2sdram2_aw_ready ),
	.f_b_id( fpga2sdram2_b_id ),
	.f_b_resp( fpga2sdram2_b_resp ),
	.f_b_valid( fpga2sdram2_b_valid ),
	.f_r_data( fpga2sdram2_r_data ),
	.f_r_id(   fpga2sdram2_r_id ),
	.f_r_last( fpga2sdram2_r_last ),
	.f_r_resp( fpga2sdram2_r_resp ),
	.f_r_valid( fpga2sdram2_r_valid ),
	.f_w_ready( fpga2sdram2_w_ready ),
	.s_ar_addr( s2_ar_addr ),
	.s_ar_burst( s2_ar_burst ),
	.s_ar_cache( s2_ar_cache ),
	.s_ar_id( s2_ar_id ),
	.s_ar_len( s2_ar_len ),
	.s_ar_lock( s2_ar_lock ),
	.s_ar_prot( s2_ar_prot ),
	.s_ar_size( s2_ar_size ),
	.s_ar_user( s2_ar_user ),
	.s_ar_valid( s2_ar_valid ),
	.s_aw_addr( s2_aw_addr ),
	.s_aw_burst( s2_aw_burst ),
	.s_aw_cache( s2_aw_cache ),
	.s_aw_id( s2_aw_id ),
	.s_aw_len( s2_aw_len ),
	.s_aw_lock( s2_aw_lock ),
	.s_aw_prot( s2_aw_prot ),
	.s_aw_size( s2_aw_size ),
	.s_aw_user( s2_aw_user ),
	.s_aw_valid( s2_aw_valid ),
	.s_b_ready( s2_b_ready ),
	.s_r_ready( s2_r_ready ),
	.s_w_data( s2_w_data ),
	.s_w_id( s2_w_id ),
	.s_w_last( s2_w_last ),
	.s_w_strb( s2_w_strb ),
	.s_w_valid( s2_w_valid )
);


twentynm_hps_interface_fpga2sdram fpga2sdram_3_instance(
  .f2s_sdram0_ar_clk(f2s_sdram0_ar_clk),
  .f2s_sdram0_aw_clk(f2s_sdram0_aw_clk),
  .f2s_sdram0_b_clk(f2s_sdram0_b_clk),
  .f2s_sdram0_clk(f2s_sdram0_clk),
  .f2s_sdram0_r_clk(f2s_sdram0_r_clk),
  .f2s_sdram0_w_clk(f2s_sdram0_w_clk),
  .f2s_sdram1_ar_clk(f2s_sdram1_ar_clk),
  .f2s_sdram1_aw_clk(f2s_sdram1_aw_clk),
  .f2s_sdram1_b_clk(f2s_sdram1_b_clk),
  .f2s_sdram1_clk(f2s_sdram1_clk),
  .f2s_sdram1_r_clk(f2s_sdram1_r_clk),
  .f2s_sdram1_w_clk(f2s_sdram1_w_clk),
  .f2s_sdram2_ar_clk(f2s_sdram2_ar_clk),
  .f2s_sdram2_aw_clk(f2s_sdram2_aw_clk),
  .f2s_sdram2_b_clk(f2s_sdram2_b_clk),
  .f2s_sdram2_clk(f2s_sdram2_clk),
  .f2s_sdram2_r_clk(f2s_sdram2_r_clk),
  .f2s_sdram2_w_clk(f2s_sdram2_w_clk),
  .fpga2sdram_port_size_config(fpga2sdram_port_size_config),
  .fpga2sdram0_ar_ready(w_fpga2sdram0_ar_ready),
  .fpga2sdram0_ar_valid(w_fpga2sdram0_ar_valid),
  .fpga2sdram0_aw_ready(w_fpga2sdram0_aw_ready),
  .fpga2sdram0_aw_valid(w_fpga2sdram0_aw_valid),
  .fpga2sdram0_b_ready(w_fpga2sdram0_b_ready),
  .fpga2sdram0_b_valid(w_fpga2sdram0_b_valid),
  .fpga2sdram0_req_addr(w_fpga2sdram0_req_addr),
  .fpga2sdram0_req_be(w_fpga2sdram0_req_be),
  .fpga2sdram0_req_data(w_fpga2sdram0_req_data),
  .fpga2sdram0_req_exclid(w_fpga2sdram0_req_exclid),
  .fpga2sdram0_req_hurry(w_fpga2sdram0_req_hurry),
  .fpga2sdram0_req_last(w_fpga2sdram0_req_last),
  .fpga2sdram0_req_length(w_fpga2sdram0_req_length),
  .fpga2sdram0_req_opc(w_fpga2sdram0_req_opc),
  .fpga2sdram0_req_press(w_fpga2sdram0_req_press),
  .fpga2sdram0_req_rdy(w_fpga2sdram0_req_rdy),
  .fpga2sdram0_req_seqid(w_fpga2sdram0_req_seqid),
  .fpga2sdram0_req_trid(w_fpga2sdram0_req_trid),
  .fpga2sdram0_req_urgency(w_fpga2sdram0_req_urgency),
  .fpga2sdram0_req_user(w_fpga2sdram0_req_user),
  .fpga2sdram0_req_vld(w_fpga2sdram0_req_vld),
  .fpga2sdram0_rsp_cont(w_fpga2sdram0_rsp_cont),
  .fpga2sdram0_rsp_data(w_fpga2sdram0_rsp_data),
  .fpga2sdram0_rsp_last(w_fpga2sdram0_rsp_last),
  .fpga2sdram0_rsp_rdy(w_fpga2sdram0_rsp_rdy),
  .fpga2sdram0_rsp_status(w_fpga2sdram0_rsp_status),
  .fpga2sdram0_rsp_trid(w_fpga2sdram0_rsp_trid),
  .fpga2sdram0_rsp_vld(w_fpga2sdram0_rsp_vld),
  .fpga2sdram1_ar_ready(w_fpga2sdram1_ar_ready),
  .fpga2sdram1_ar_valid(w_fpga2sdram1_ar_valid),
  .fpga2sdram1_aw_ready(w_fpga2sdram1_aw_ready),
  .fpga2sdram1_aw_valid(w_fpga2sdram1_aw_valid),
  .fpga2sdram1_b_ready(w_fpga2sdram1_b_ready),
  .fpga2sdram1_b_valid(w_fpga2sdram1_b_valid),
  .fpga2sdram1_req_addr(w_fpga2sdram1_req_addr),
  .fpga2sdram1_req_be(w_fpga2sdram1_req_be),
  .fpga2sdram1_req_data(w_fpga2sdram1_req_data),
  .fpga2sdram1_req_exclid(w_fpga2sdram1_req_exclid),
  .fpga2sdram1_req_hurry(w_fpga2sdram1_req_hurry),
  .fpga2sdram1_req_last(w_fpga2sdram1_req_last),
  .fpga2sdram1_req_length(w_fpga2sdram1_req_length),
  .fpga2sdram1_req_opc(w_fpga2sdram1_req_opc),
  .fpga2sdram1_req_press(w_fpga2sdram1_req_press),
  .fpga2sdram1_req_rdy(w_fpga2sdram1_req_rdy),
  .fpga2sdram1_req_seqid(w_fpga2sdram1_req_seqid),
  .fpga2sdram1_req_trid(w_fpga2sdram1_req_trid),
  .fpga2sdram1_req_urgency(w_fpga2sdram1_req_urgency),
  .fpga2sdram1_req_user(w_fpga2sdram1_req_user),
  .fpga2sdram1_req_vld(w_fpga2sdram1_req_vld),
  .fpga2sdram1_rsp_cont(w_fpga2sdram1_rsp_cont),
  .fpga2sdram1_rsp_data(w_fpga2sdram1_rsp_data),
  .fpga2sdram1_rsp_last(w_fpga2sdram1_rsp_last),
  .fpga2sdram1_rsp_rdy(w_fpga2sdram1_rsp_rdy),
  .fpga2sdram1_rsp_status(w_fpga2sdram1_rsp_status),
  .fpga2sdram1_rsp_trid(w_fpga2sdram1_rsp_trid),
  .fpga2sdram1_rsp_vld(w_fpga2sdram1_rsp_vld),
  .fpga2sdram2_ar_ready(w_fpga2sdram2_ar_ready),
  .fpga2sdram2_ar_valid(w_fpga2sdram2_ar_valid),
  .fpga2sdram2_aw_ready(w_fpga2sdram2_aw_ready),
  .fpga2sdram2_aw_valid(w_fpga2sdram2_aw_valid),
  .fpga2sdram2_b_ready(w_fpga2sdram2_b_ready),
  .fpga2sdram2_b_valid(w_fpga2sdram2_b_valid),
  .fpga2sdram2_req_addr(w_fpga2sdram2_req_addr),
  .fpga2sdram2_req_be(w_fpga2sdram2_req_be),
  .fpga2sdram2_req_data(w_fpga2sdram2_req_data),
  .fpga2sdram2_req_exclid(w_fpga2sdram2_req_exclid),
  .fpga2sdram2_req_hurry(w_fpga2sdram2_req_hurry),
  .fpga2sdram2_req_last(w_fpga2sdram2_req_last),
  .fpga2sdram2_req_length(w_fpga2sdram2_req_length),
  .fpga2sdram2_req_opc(w_fpga2sdram2_req_opc),
  .fpga2sdram2_req_press(w_fpga2sdram2_req_press),
  .fpga2sdram2_req_rdy(w_fpga2sdram2_req_rdy),
  .fpga2sdram2_req_seqid(w_fpga2sdram2_req_seqid),
  .fpga2sdram2_req_trid(w_fpga2sdram2_req_trid),
  .fpga2sdram2_req_urgency(w_fpga2sdram2_req_urgency),
  .fpga2sdram2_req_user(w_fpga2sdram2_req_user),
  .fpga2sdram2_req_vld(w_fpga2sdram2_req_vld),
  .fpga2sdram2_rsp_cont(w_fpga2sdram2_rsp_cont),
  .fpga2sdram2_rsp_data(w_fpga2sdram2_rsp_data),
  .fpga2sdram2_rsp_last(w_fpga2sdram2_rsp_last),
  .fpga2sdram2_rsp_rdy(w_fpga2sdram2_rsp_rdy),
  .fpga2sdram2_rsp_status(w_fpga2sdram2_rsp_status),
  .fpga2sdram2_rsp_trid(w_fpga2sdram2_rsp_trid),
  .fpga2sdram2_rsp_vld(w_fpga2sdram2_rsp_vld)
);
defparam fpga2sdram_3_instance.mode = mode;

endmodule



//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
`timescale 1 ps / 1 ps

module s2f_rl_adp #(
  parameter DWIDTH = 128
) (
  input                     clk,
  input                     f_ar_ready,
  input                     f_aw_ready,
  input               [3:0] f_b_id,
  input               [1:0] f_b_resp,
  input                     f_b_valid,
  input        [DWIDTH-1:0] f_r_data,
  input               [3:0] f_r_id,
  input                     f_r_last,
  input               [1:0] f_r_resp,
  input                     f_r_valid,
  input                     f_w_ready,
  input                     rst_n,
  input              [31:0] s_ar_addr,
  input               [1:0] s_ar_burst,
  input               [3:0] s_ar_cache,
  input               [3:0] s_ar_id,
  input               [3:0] s_ar_len,
  input               [1:0] s_ar_lock,
  input               [2:0] s_ar_prot,
  input               [2:0] s_ar_size,
  input               [4:0] s_ar_user,
  input                     s_ar_valid,
  input              [31:0] s_aw_addr,
  input               [1:0] s_aw_burst,
  input               [3:0] s_aw_cache,
  input               [3:0] s_aw_id,
  input               [3:0] s_aw_len,
  input               [1:0] s_aw_lock,
  input               [2:0] s_aw_prot,
  input               [2:0] s_aw_size,
  input               [4:0] s_aw_user,
  input                     s_aw_valid,
  input                     s_b_ready,
  input                     s_r_ready,
  input                     s_ready_latency,
  input        [DWIDTH-1:0] s_w_data,
  input               [3:0] s_w_id,
  input                     s_w_last,
  input      [DWIDTH/8-1:0] s_w_strb,
  input                     s_w_valid,
  output             [31:0] f_ar_addr,
  output              [1:0] f_ar_burst,
  output              [3:0] f_ar_cache,
  output              [3:0] f_ar_id,
  output              [3:0] f_ar_len,
  output              [1:0] f_ar_lock,
  output              [2:0] f_ar_prot,
  output              [2:0] f_ar_size,
  output              [4:0] f_ar_user,
  output                    f_ar_valid,
  output             [31:0] f_aw_addr,
  output              [1:0] f_aw_burst,
  output              [3:0] f_aw_cache,
  output              [3:0] f_aw_id,
  output              [3:0] f_aw_len,
  output              [1:0] f_aw_lock,
  output              [2:0] f_aw_prot,
  output              [2:0] f_aw_size,
  output              [4:0] f_aw_user,
  output                    f_aw_valid,
  output                    f_b_ready,
  output                    f_r_ready,
  output       [DWIDTH-1:0] f_w_data,
  output              [3:0] f_w_id,
  output                    f_w_last,
  output     [DWIDTH/8-1:0] f_w_strb,
  output                    f_w_valid,
  output                    s_ar_ready,
  output                    s_aw_ready,
  output              [3:0] s_b_id,
  output              [1:0] s_b_resp,
  output                    s_b_valid,
  output       [DWIDTH-1:0] s_r_data,
  output              [3:0] s_r_id,
  output                    s_r_last,
  output              [1:0] s_r_resp,
  output                    s_r_valid,
  output                    s_w_ready
);

// Declare Parameters
localparam AR_WIDTH = 59;
localparam AW_WIDTH = 59;
localparam W_WIDTH  = 5 + DWIDTH/8 + DWIDTH;
localparam R_WIDTH  = 7 + DWIDTH;
localparam B_WIDTH  = 6;

// Declare internal variables
wire [AR_WIDTH-1:0] s_ar_data_init;
wire [AR_WIDTH-1:0] ar_data_init;
reg  [AR_WIDTH-1:0] ar_data_init_r;
wire [AR_WIDTH-1:0] ar_data_targ;
wire                ar_valid;
reg                 ar_valid_r;
wire                ar_ready;
reg                 ar_ready_r;


wire [AW_WIDTH-1:0] s_aw_data_init;
wire [AW_WIDTH-1:0] aw_data_init;
reg  [AW_WIDTH-1:0] aw_data_init_r;
wire [AW_WIDTH-1:0] aw_data_targ;
wire                aw_valid;
reg                 aw_valid_r;
wire                aw_ready;
reg                 aw_ready_r;

wire  [W_WIDTH-1:0] s_w_data_init;
wire  [W_WIDTH-1:0] w_data_init;
reg   [W_WIDTH-1:0] w_data_init_r;
wire  [W_WIDTH-1:0] w_data_targ;
wire                w_valid;
reg                 w_valid_r;
wire                w_ready;
reg                 w_ready_r;

wire  [B_WIDTH-1:0] s_b_data_targ;
reg   [B_WIDTH-1:0] s_b_data_targ_r;
wire  [B_WIDTH-1:0] b_data_init;
wire  [B_WIDTH-1:0] b_data_targ;
wire                b_valid;
reg                 b_valid_r;
wire                b_ready;
reg                 b_ready_r;

wire  [R_WIDTH-1:0] s_r_data_targ;
reg   [R_WIDTH-1:0] s_r_data_targ_r;
wire  [R_WIDTH-1:0] r_data_init;
wire  [R_WIDTH-1:0] r_data_targ;
wire                r_valid;
reg                 r_valid_r;
wire                r_ready;
reg                 r_ready_r;

// Register Slice instantiation for s2f ar channel
full_reg_slice #(
  .WIDTH(AR_WIDTH),
  .PTR_WIDTH(2)
) i_s2f_ar (
  .clk(clk),
  .rst_n(rst_n),
  .valid_init(ar_valid),
  .ready_init(ar_ready),
  .data_init(ar_data_init),
  .readylatency_init(s_ready_latency),
  .valid_targ(f_ar_valid),
  .ready_targ(f_ar_ready),
  .data_targ(ar_data_targ),
  .readylatency_targ(1'b0)
);

// Register Slice instantiation for s2f aw channel
full_reg_slice #(
  .WIDTH(AW_WIDTH),
  .PTR_WIDTH(2)
) i_s2f_aw (
  .clk(clk),
  .rst_n(rst_n),
  .valid_init(aw_valid),
  .ready_init(aw_ready),
  .data_init(aw_data_init),
  .readylatency_init(s_ready_latency),
  .valid_targ(f_aw_valid),
  .ready_targ(f_aw_ready),
  .data_targ(aw_data_targ),
  .readylatency_targ(1'b0)
);

// Register Slice instantiation for s2f w channel
full_reg_slice #(
  .WIDTH(W_WIDTH),
  .PTR_WIDTH(2)
) i_s2f_w (
  .clk(clk),
  .rst_n(rst_n),
  .valid_init(w_valid),
  .ready_init(w_ready),
  .data_init(w_data_init),
  .readylatency_init(s_ready_latency),
  .valid_targ(f_w_valid),
  .ready_targ(f_w_ready),
  .data_targ(w_data_targ),
  .readylatency_targ(1'b0)
);

// Register Slice instantiation for s2f r channel
full_reg_slice #(
  .WIDTH(R_WIDTH),
  .PTR_WIDTH(1)
) i_s2f_r (
  .clk(clk),
  .rst_n(rst_n),
  .valid_init(f_r_valid),
  .ready_init(f_r_ready),
  .data_init(r_data_init),
  .readylatency_init(1'b0),
  .valid_targ(r_valid),
  .ready_targ(r_ready),
  .data_targ(r_data_targ),
  .readylatency_targ(s_ready_latency)
);

// Register Slice instantiation for s2f b channel
full_reg_slice #(
  .WIDTH(B_WIDTH),
  .PTR_WIDTH(1)
) i_s2f_b (
  .clk(clk),
  .rst_n(rst_n),
  .valid_init(f_b_valid),
  .ready_init(f_b_ready),
  .data_init(b_data_init),
  .readylatency_init(1'b0),
  .valid_targ(b_valid),
  .ready_targ(b_ready),
  .data_targ(b_data_targ),
  .readylatency_targ(s_ready_latency)
);

// s_ar_data_init assignment
assign s_ar_data_init                 = {s_ar_user, s_ar_size, s_ar_prot, s_ar_lock, s_ar_len, s_ar_id, s_ar_cache, s_ar_burst, s_ar_addr};

// ar_data_targ assignment
assign f_ar_addr[31:0]                = ar_data_targ[31:0];
assign f_ar_burst[1:0]                = ar_data_targ[33:32];
assign f_ar_cache[3:0]                = ar_data_targ[37:34];
assign f_ar_id[3:0]                   = ar_data_targ[41:38];
assign f_ar_len[3:0]                  = ar_data_targ[45:42];
assign f_ar_lock[1:0]                 = ar_data_targ[47:46];
assign f_ar_prot[2:0]                 = ar_data_targ[50:48];
assign f_ar_size[2:0]                 = ar_data_targ[53:51];
assign f_ar_user[4:0]                 = ar_data_targ[58:54];

// s_aw_data_init assignment
assign s_aw_data_init                 = {s_aw_user, s_aw_size, s_aw_prot, s_aw_lock, s_aw_len, s_aw_id, s_aw_cache, s_aw_burst, s_aw_addr};

// aw_data_targ assignment
assign f_aw_addr[31:0]                = aw_data_targ[31:0];
assign f_aw_burst[1:0]                = aw_data_targ[33:32];
assign f_aw_cache[3:0]                = aw_data_targ[37:34];
assign f_aw_id[3:0]                   = aw_data_targ[41:38];
assign f_aw_len[3:0]                  = aw_data_targ[45:42];
assign f_aw_lock[1:0]                 = aw_data_targ[47:46];
assign f_aw_prot[2:0]                 = aw_data_targ[50:48];
assign f_aw_size[2:0]                 = aw_data_targ[53:51];
assign f_aw_user[4:0]                 = aw_data_targ[58:54];

// s_w_data_init assignment
assign s_w_data_init                  = {s_w_strb, s_w_last, s_w_id, s_w_data};

// w_data_targ assignment
assign f_w_data[DWIDTH-1:0]           = w_data_targ[DWIDTH-1:0];
assign f_w_id[3:0]                    = w_data_targ[DWIDTH+3:DWIDTH];
assign f_w_last                       = w_data_targ[DWIDTH+4];
assign f_w_strb[DWIDTH/8-1:0]         = w_data_targ[DWIDTH+DWIDTH/8+4:DWIDTH+5];

// r_data_init assignment
assign r_data_init                    = {f_r_resp, f_r_last, f_r_id, f_r_data};

// s_r_data_targ assignment
assign s_r_data[DWIDTH-1:0]           = s_r_data_targ[DWIDTH-1:0];
assign s_r_id[3:0]                    = s_r_data_targ[DWIDTH+3:DWIDTH];
assign s_r_last                       = s_r_data_targ[DWIDTH+4];
assign s_r_resp[1:0]                  = s_r_data_targ[DWIDTH+6:DWIDTH+5];

// b_data_init assignment
assign b_data_init                    = {f_b_resp, f_b_id};

// s_b_data_targ assignment
assign s_b_id[3:0]                    = s_b_data_targ[3:0];
assign s_b_resp[1:0]                  = s_b_data_targ[5:4];

// ar/aw/w valid_init flops
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) ar_valid_r    <= 1'b0;
  else        ar_valid_r    <= s_ar_valid;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) aw_valid_r    <= 1'b0;
  else        aw_valid_r    <= s_aw_valid;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) w_valid_r     <= 1'b0;
  else        w_valid_r     <= s_w_valid;
end

assign ar_valid = s_ready_latency ? ar_valid_r : s_ar_valid;
assign aw_valid = s_ready_latency ? aw_valid_r : s_aw_valid;
assign w_valid  = s_ready_latency ? w_valid_r  : s_w_valid;

// ar/aw/w ready_init flops
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) ar_ready_r    <= 1'b0;
  else        ar_ready_r    <= ar_ready;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) aw_ready_r    <= 1'b0;
  else        aw_ready_r    <= aw_ready;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) w_ready_r     <= 1'b0;
  else        w_ready_r     <= w_ready;
end

assign s_ar_ready = s_ready_latency ? ar_ready_r : ar_ready;
assign s_aw_ready = s_ready_latency ? aw_ready_r : aw_ready;
assign s_w_ready  = s_ready_latency ? w_ready_r  : w_ready;

// ar/aw/w data_init flops
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) ar_data_init_r  <= {AR_WIDTH{1'b0}};
  else        ar_data_init_r  <= s_ar_data_init;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) aw_data_init_r  <= {AW_WIDTH{1'b0}};
  else        aw_data_init_r  <= s_aw_data_init;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n)  w_data_init_r  <= {W_WIDTH{1'b0}};
  else         w_data_init_r  <= s_w_data_init;
end

assign ar_data_init = s_ready_latency ? ar_data_init_r : s_ar_data_init;
assign aw_data_init = s_ready_latency ? aw_data_init_r : s_aw_data_init;
assign  w_data_init = s_ready_latency ?  w_data_init_r : s_w_data_init;

// r/b valid_targ flops
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) r_valid_r     <= 1'b0;
  else        r_valid_r     <= r_valid;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) b_valid_r     <= 1'b0;
  else        b_valid_r     <= b_valid;
end

assign s_r_valid = s_ready_latency ? r_valid_r : r_valid;
assign s_b_valid = s_ready_latency ? b_valid_r : b_valid;

// r/b ready_targ flops
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) r_ready_r     <= 1'b0;
  else        r_ready_r     <= s_r_ready;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) b_ready_r     <= 1'b0;
  else        b_ready_r     <= s_b_ready;
end

assign r_ready = s_ready_latency ? r_ready_r : s_r_ready;
assign b_ready = s_ready_latency ? b_ready_r : s_b_ready;

// r/b data_targ flops
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) s_r_data_targ_r  <= {R_WIDTH{1'b0}};
  else        s_r_data_targ_r  <= r_data_targ;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) s_b_data_targ_r  <= {B_WIDTH{1'b0}};
  else        s_b_data_targ_r  <= b_data_targ;
end

assign s_r_data_targ = s_ready_latency ? s_r_data_targ_r : r_data_targ;
assign s_b_data_targ = s_ready_latency ? s_b_data_targ_r : b_data_targ;

endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
// MW Interface declaration
`timescale 1 ps / 1 ps

(* altera_attribute = "-name AUTO_RAM_RECOGNITION OFF" *)
module f2s_rl_adp #(
  parameter DWIDTH = 128
) (
  input                     clk,
  input              [31:0] f_ar_addr,
  input               [1:0] f_ar_burst,
  input               [3:0] f_ar_cache,
  input               [3:0] f_ar_id,
  input               [3:0] f_ar_len,
  input               [1:0] f_ar_lock,
  input               [2:0] f_ar_prot,
  input               [2:0] f_ar_size,
  input               [4:0] f_ar_user,
  input                     f_ar_valid,
  input              [31:0] f_aw_addr,
  input               [1:0] f_aw_burst,
  input               [3:0] f_aw_cache,
  input               [3:0] f_aw_id,
  input               [3:0] f_aw_len,
  input               [1:0] f_aw_lock,
  input               [2:0] f_aw_prot,
  input               [2:0] f_aw_size,
  input               [4:0] f_aw_user,
  input                     f_aw_valid,
  input                     f_b_ready,
  input                     f_r_ready,
  input        [DWIDTH-1:0] f_w_data,
  input               [3:0] f_w_id,
  input                     f_w_last,
  input      [DWIDTH/8-1:0] f_w_strb,
  input                     f_w_valid,
  input                     rst_n,
  input                     s_ar_ready,
  input                     s_aw_ready,
  input               [3:0] s_b_id,
  input               [1:0] s_b_resp,
  input                     s_b_valid,
  input        [DWIDTH-1:0] s_r_data,
  input               [3:0] s_r_id,
  input                     s_r_last,
  input               [1:0] s_r_resp,
  input                     s_r_valid,
  input                     s_ready_latency,
  input                     s_w_ready,
  output                    f_ar_ready,
  output                    f_aw_ready,
  output              [3:0] f_b_id,
  output              [1:0] f_b_resp,
  output                    f_b_valid,
  output       [DWIDTH-1:0] f_r_data,
  output              [3:0] f_r_id,
  output                    f_r_last,
  output              [1:0] f_r_resp,
  output                    f_r_valid,
  output                    f_w_ready,
  output             [31:0] s_ar_addr,
  output              [1:0] s_ar_burst,
  output              [3:0] s_ar_cache,
  output              [3:0] s_ar_id,
  output              [3:0] s_ar_len,
  output              [1:0] s_ar_lock,
  output              [2:0] s_ar_prot,
  output              [2:0] s_ar_size,
  output              [4:0] s_ar_user,
  output                    s_ar_valid,
  output             [31:0] s_aw_addr,
  output              [1:0] s_aw_burst,
  output              [3:0] s_aw_cache,
  output              [3:0] s_aw_id,
  output              [3:0] s_aw_len,
  output              [1:0] s_aw_lock,
  output              [2:0] s_aw_prot,
  output              [2:0] s_aw_size,
  output              [4:0] s_aw_user,
  output                    s_aw_valid,
  output                    s_b_ready,
  output                    s_r_ready,
  output       [DWIDTH-1:0] s_w_data,
  output              [3:0] s_w_id,
  output                    s_w_last,
  output     [DWIDTH/8-1:0] s_w_strb,
  output                    s_w_valid
);

// Declare Parameters
localparam AR_WIDTH = 59;
localparam AW_WIDTH = 59;
localparam W_WIDTH  = 5 + DWIDTH/8 + DWIDTH;
localparam R_WIDTH  = 7 + DWIDTH;
localparam B_WIDTH  = 6;

// Declare internal variables
wire [AR_WIDTH-1:0] s_ar_data_targ;
reg  [AR_WIDTH-1:0] s_ar_data_targ_r;
wire [AR_WIDTH-1:0] ar_data_init;
wire [AR_WIDTH-1:0] ar_data_targ;
wire                ar_valid;
reg                 ar_valid_r;
wire                ar_ready;
reg                 ar_ready_r;

wire [AW_WIDTH-1:0] s_aw_data_targ;
reg  [AW_WIDTH-1:0] s_aw_data_targ_r;
wire [AW_WIDTH-1:0] aw_data_init;
wire [AW_WIDTH-1:0] aw_data_targ;
wire                aw_valid;
reg                 aw_valid_r;
wire                aw_ready;
reg                 aw_ready_r;

wire  [W_WIDTH-1:0] s_w_data_targ;
reg   [W_WIDTH-1:0] s_w_data_targ_r;
wire  [W_WIDTH-1:0] w_data_init;
wire  [W_WIDTH-1:0] w_data_targ;
wire                w_valid;
reg                 w_valid_r;
wire                w_ready;
reg                 w_ready_r;

wire  [B_WIDTH-1:0] s_b_data_init;
wire  [B_WIDTH-1:0] b_data_init;
reg   [B_WIDTH-1:0] b_data_init_r;
wire  [B_WIDTH-1:0] b_data_targ;
wire                b_valid;
reg                 b_valid_r;
wire                b_ready;
reg                 b_ready_r;

wire  [R_WIDTH-1:0] s_r_data_init;
wire  [R_WIDTH-1:0] r_data_init;
reg   [R_WIDTH-1:0] r_data_init_r;
wire  [R_WIDTH-1:0] r_data_targ;
wire                r_valid;
reg                 r_valid_r;
wire                r_ready;
reg                 r_ready_r;

// Register Slice instantiation for f2s ar channel
full_reg_slice #(
  .WIDTH(AR_WIDTH),
  .PTR_WIDTH(1)
) i_f2s_ar (
  .clk(clk),
  .rst_n(rst_n),
  .valid_init(f_ar_valid),
  .ready_init(f_ar_ready),
  .data_init(ar_data_init),
  .readylatency_init(1'b0),
  .valid_targ(ar_valid),
  .ready_targ(ar_ready),
  .data_targ(ar_data_targ),
  .readylatency_targ(s_ready_latency)
);

// Register Slice instantiation for f2s aw channel
full_reg_slice #(
  .WIDTH(AW_WIDTH),
  .PTR_WIDTH(1)
) i_f2s_aw (
  .clk(clk),
  .rst_n(rst_n),
  .valid_init(f_aw_valid),
  .ready_init(f_aw_ready),
  .data_init(aw_data_init),
  .readylatency_init(1'b0),
  .valid_targ(aw_valid),
  .ready_targ(aw_ready),
  .data_targ(aw_data_targ),
  .readylatency_targ(s_ready_latency)
);

// Register Slice instantiation for f2s w channel
full_reg_slice #(
  .WIDTH(W_WIDTH),
  .PTR_WIDTH(1)
) i_f2s_w (
  .clk(clk),
  .rst_n(rst_n),
  .valid_init(f_w_valid),
  .ready_init(f_w_ready),
  .data_init(w_data_init),
  .readylatency_init(1'b0),
  .valid_targ(w_valid),
  .ready_targ(w_ready),
  .data_targ(w_data_targ),
  .readylatency_targ(s_ready_latency)
);

// Register Slice instantiation for f2s r channel
full_reg_slice #(
  .WIDTH(R_WIDTH),
  .PTR_WIDTH(2)
) i_f2s_r (
  .clk(clk),
  .rst_n(rst_n),
  .valid_init(r_valid),
  .ready_init(r_ready),
  .data_init(r_data_init),
  .readylatency_init(s_ready_latency),
  .valid_targ(f_r_valid),
  .ready_targ(f_r_ready),
  .data_targ(r_data_targ),
  .readylatency_targ(1'b0)
);

// Register Slice instantiation for f2s b channel
full_reg_slice #(
  .WIDTH(B_WIDTH),
  .PTR_WIDTH(2)
) i_f2s_b (
  .clk(clk),
  .rst_n(rst_n),
  .valid_init(b_valid),
  .ready_init(b_ready),
  .data_init(b_data_init),
  .readylatency_init(s_ready_latency),
  .valid_targ(f_b_valid),
  .ready_targ(f_b_ready),
  .data_targ(b_data_targ),
  .readylatency_targ(1'b0)
);

// ar_data_init assignment
assign ar_data_init                   = {f_ar_user, f_ar_size, f_ar_prot, f_ar_lock, f_ar_len, f_ar_id, f_ar_cache, f_ar_burst, f_ar_addr};

// s_ar_data_targ assignment
assign s_ar_addr[31:0]                = s_ar_data_targ[31:0];
assign s_ar_burst[1:0]                = s_ar_data_targ[33:32];
assign s_ar_cache[3:0]                = s_ar_data_targ[37:34];
assign s_ar_id[3:0]                   = s_ar_data_targ[41:38];
assign s_ar_len[3:0]                  = s_ar_data_targ[45:42];
assign s_ar_lock[1:0]                 = s_ar_data_targ[47:46];
assign s_ar_prot[2:0]                 = s_ar_data_targ[50:48];
assign s_ar_size[2:0]                 = s_ar_data_targ[53:51];
assign s_ar_user[4:0]                 = s_ar_data_targ[58:54];

// aw_data_init assignment
assign aw_data_init                   = {f_aw_user, f_aw_size, f_aw_prot, f_aw_lock, f_aw_len, f_aw_id, f_aw_cache, f_aw_burst, f_aw_addr};

// s_aw_data_targ assignment
assign s_aw_addr[31:0]                = s_aw_data_targ[31:0];
assign s_aw_burst[1:0]                = s_aw_data_targ[33:32];
assign s_aw_cache[3:0]                = s_aw_data_targ[37:34];
assign s_aw_id[3:0]                   = s_aw_data_targ[41:38];
assign s_aw_len[3:0]                  = s_aw_data_targ[45:42];
assign s_aw_lock[1:0]                 = s_aw_data_targ[47:46];
assign s_aw_prot[2:0]                 = s_aw_data_targ[50:48];
assign s_aw_size[2:0]                 = s_aw_data_targ[53:51];
assign s_aw_user[4:0]                 = s_aw_data_targ[58:54];

// w_data_init assignment
assign w_data_init                    = {f_w_strb, f_w_last, f_w_id, f_w_data};

// s_w_data_targ assignment
assign s_w_data[DWIDTH-1:0]           = s_w_data_targ[DWIDTH-1:0];
assign s_w_id[3:0]                    = s_w_data_targ[DWIDTH+3:DWIDTH];
assign s_w_last                       = s_w_data_targ[DWIDTH+4];
assign s_w_strb[DWIDTH/8-1:0]         = s_w_data_targ[DWIDTH+DWIDTH/8+4:DWIDTH+5];

// s_r_data_init assignment
assign s_r_data_init                  = {s_r_resp, s_r_last, s_r_id, s_r_data};

// r_data_targ assignment
assign f_r_data[DWIDTH-1:0]           = r_data_targ[DWIDTH-1:0];
assign f_r_id[3:0]                    = r_data_targ[DWIDTH+3:DWIDTH];
assign f_r_last                       = r_data_targ[DWIDTH+4];
assign f_r_resp[1:0]                  = r_data_targ[DWIDTH+6:DWIDTH+5];

// s_b_data_init assignment
assign s_b_data_init                  = {s_b_resp, s_b_id};

// b_data_targ assignment
assign f_b_id[3:0]                    = b_data_targ[3:0];
assign f_b_resp[1:0]                  = b_data_targ[5:4];

// ar/aw/w valid_targ flops
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) ar_valid_r    <= 1'b0;
  else        ar_valid_r    <= ar_valid;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) aw_valid_r    <= 1'b0;
  else        aw_valid_r    <= aw_valid;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) w_valid_r     <= 1'b0;
  else        w_valid_r     <= w_valid;
end

assign s_ar_valid = s_ready_latency ? ar_valid_r : ar_valid;
assign s_aw_valid = s_ready_latency ? aw_valid_r : aw_valid;
assign s_w_valid  = s_ready_latency ? w_valid_r  : w_valid;

// ar/aw/w ready_targ flops
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) ar_ready_r     <= 1'b0;
  else        ar_ready_r     <= s_ar_ready;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) aw_ready_r     <= 1'b0;
  else        aw_ready_r     <= s_aw_ready;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) w_ready_r     <= 1'b0;
  else        w_ready_r     <= s_w_ready;
end

assign ar_ready = s_ready_latency ? ar_ready_r : s_ar_ready;
assign aw_ready = s_ready_latency ? aw_ready_r : s_aw_ready;
assign w_ready  = s_ready_latency ? w_ready_r  : s_w_ready;

// ar/aw/w data_targ flops
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) s_ar_data_targ_r  <= {AR_WIDTH{1'b0}};
  else        s_ar_data_targ_r  <= ar_data_targ;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) s_aw_data_targ_r  <= {AW_WIDTH{1'b0}};
  else        s_aw_data_targ_r  <= aw_data_targ;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) s_w_data_targ_r  <= {W_WIDTH{1'b0}};
  else        s_w_data_targ_r  <= w_data_targ;
end

assign s_ar_data_targ = s_ready_latency ? s_ar_data_targ_r : ar_data_targ;
assign s_aw_data_targ = s_ready_latency ? s_aw_data_targ_r : aw_data_targ;
assign s_w_data_targ  = s_ready_latency ? s_w_data_targ_r  :  w_data_targ;

// r/b valid_init flops
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) r_valid_r   <= 1'b0;
  else        r_valid_r   <= s_r_valid;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) b_valid_r   <= 1'b0;
  else        b_valid_r   <= s_b_valid;
end

assign r_valid = s_ready_latency ? r_valid_r : s_r_valid;
assign b_valid = s_ready_latency ? b_valid_r : s_b_valid;

// r/b ready_init flops
always @(posedge clk or negedge rst_n) begin
  if (!rst_n)  r_ready_r  <= 1'b0;
  else         r_ready_r  <= r_ready;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n)  b_ready_r  <= 1'b0;
  else         b_ready_r  <= b_ready;
end

assign s_r_ready = s_ready_latency ? r_ready_r : r_ready;
assign s_b_ready = s_ready_latency ? b_ready_r : b_ready;

// r/b data_init flops
always @(posedge clk or negedge rst_n) begin
  if (!rst_n)  r_data_init_r  <= {R_WIDTH{1'b0}};
  else         r_data_init_r  <= s_r_data_init;
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n)  b_data_init_r  <= {B_WIDTH{1'b0}};
  else         b_data_init_r  <= s_b_data_init;
end

assign r_data_init = s_ready_latency ? r_data_init_r : s_r_data_init;
assign b_data_init = s_ready_latency ? b_data_init_r : s_b_data_init;

endmodule


//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//

// Full Register Slice logic
// This is nothing but a 2-deep FIFO
// Combined synchronous FIFO with 1 read port and 1 write port

// Option 2: Moves some logic over to before flop stage - will harm valid_init input path, but to the benefit of ready_init output path
(* altera_attribute = "-name AUTO_RAM_RECOGNITION OFF" *)
module full_reg_slice #(
  parameter WIDTH = 'd8,       // Width of Register Slice
  parameter PTR_WIDTH  = 'd1    // Width of pointers - include rollover bit
) (
   input  clk, rst_n,           // Clock and Reset

   input  valid_init,           // Initiator Side: Valid Input
   output ready_init,           // Initiator Side: Ready Output
   input  [WIDTH-1:0] data_init,// Initiator Side: Data Input
   input  readylatency_init,    // Initiator Side: ReadyLatency Input

   output valid_targ,           // Target Side: Valid Output
   input  ready_targ,           // Target Side: Ready Input
   output [WIDTH-1:0] data_targ,// Target Side: Data Output
   input  readylatency_targ     // Target Side: ReadyLatency Input
);

localparam DEPTH      = 1 << PTR_WIDTH;

wire put, get, avail;
reg  free;
wire [PTR_WIDTH:0]    putptr_nxt, getptr_nxt;
reg  [PTR_WIDTH:0]    putptr, getptr;
reg  [WIDTH-1:0] mem [0:DEPTH-1];

// put & putptr logic
assign put = valid_init & (readylatency_init | free );  // ReadyLatency is handled here. When ReadyLatency != 0, put when Valid is high
assign putptr_nxt = put ? putptr + 'd1 : putptr;

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) putptr <= {PTR_WIDTH+1{1'b0}};
  else        putptr <= putptr_nxt;
end

// get & getptr logic
assign get = avail & ready_targ;
assign getptr_nxt = get ? getptr + 'd1 : getptr;

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) getptr <= {PTR_WIDTH+1{1'b0}};
  else        getptr <= getptr_nxt;
end

// free/full logic (free = ~full)
// FB: 182359 - generate all free signals directly from flop - so that it can be reset to Zero
//assign free = ~((putptr[PTR_WIDTH] != getptr[PTR_WIDTH]) && (putptr[PTR_WIDTH-1:0] == getptr[PTR_WIDTH-1:0]));
always @(posedge clk or negedge rst_n) begin
  if (!rst_n) free <= 0;
  else        free <= ~((putptr_nxt[PTR_WIDTH] != getptr_nxt[PTR_WIDTH]) && (putptr_nxt[PTR_WIDTH-1:0] == getptr_nxt[PTR_WIDTH-1:0]));
end

// avail/empty logic (avail = ~empty)
assign avail = ~(putptr[PTR_WIDTH:0] == getptr[PTR_WIDTH:0]);

// ready_init logic
// if ReadyLatency is enabled Ready deasserts at 2 entries from full
// else Ready deasserts at full
generate
if (DEPTH > 2) begin

  wire                free_gt_2;
  reg  [PTR_WIDTH:0]  nfree;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) nfree <= {PTR_WIDTH+1{1'b0}};
    else        nfree <= DEPTH - (putptr_nxt - getptr_nxt);
  end

  assign free_gt_2 = nfree > 'd2;

  assign ready_init = readylatency_init ? free_gt_2 : free;
end
else begin
  assign ready_init = free;
end
endgenerate

// valid_targ logic
assign valid_targ = get | ( avail & ~readylatency_targ );   // ReadyLatency is handled here. When ReadyLatency is !=0, qualify Valid with Ready

// Data Storage Portion - data_init enters here while data_targ exits from here
assign data_targ = mem[getptr[PTR_WIDTH-1:0]];

always @(posedge clk) begin
   if (put) mem[putptr[PTR_WIDTH-1:0]] <= data_init;
end

endmodule


//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
`timescale 1 ps / 1 ps
module twentynm_hps_rl_mode0es_fpga2sdram #(
  parameter DEPTH   = 4,
  parameter DWIDTH0 = 16,
  parameter DWIDTH1 = 16,
  parameter DWIDTH2 = 16,
  parameter mode    = 1
)(
  input   wire           f2s_sdram0_ar_clk,
  input   wire           f2s_sdram0_aw_clk,
  input   wire           f2s_sdram0_b_clk,
  input   wire           f2s_sdram0_clk,
  input   wire           f2s_sdram0_r_clk,
  input   wire           f2s_sdram0_w_clk,
  input   wire           f2s_sdram1_ar_clk,
  input   wire           f2s_sdram1_aw_clk,
  input   wire           f2s_sdram1_b_clk,
  input   wire           f2s_sdram1_clk,
  input   wire           f2s_sdram1_r_clk,
  input   wire           f2s_sdram1_w_clk,
  input   wire           f2s_sdram2_ar_clk,
  input   wire           f2s_sdram2_aw_clk,
  input   wire           f2s_sdram2_b_clk,
  input   wire           f2s_sdram2_clk,
  input   wire           f2s_sdram2_r_clk,
  input   wire           f2s_sdram2_w_clk,
  input   wire           f2s_sdram0_rst_n,
  input   wire           f2s_sdram1_rst_n,
  input   wire           f2s_sdram2_rst_n,
  input   wire [    3:0] fpga2sdram_port_size_config,
  input   wire [ 32-1:0] fpga2sdram0_ar_addr,
  input   wire [  2-1:0] fpga2sdram0_ar_burst,
  input   wire [  4-1:0] fpga2sdram0_ar_cache,
  input   wire [  4-1:0] fpga2sdram0_ar_id,
  input   wire [  4-1:0] fpga2sdram0_ar_len,
  input   wire [  2-1:0] fpga2sdram0_ar_lock,
  input   wire [  3-1:0] fpga2sdram0_ar_prot,
  output  wire [  1-1:0] fpga2sdram0_ar_ready,
  input   wire [  3-1:0] fpga2sdram0_ar_size,
  input   wire [  5-1:0] fpga2sdram0_ar_user,
  input   wire [  1-1:0] fpga2sdram0_ar_valid,
  input   wire [ 32-1:0] fpga2sdram0_aw_addr,
  input   wire [  2-1:0] fpga2sdram0_aw_burst,
  input   wire [  4-1:0] fpga2sdram0_aw_cache,
  input   wire [  4-1:0] fpga2sdram0_aw_id,
  input   wire [  4-1:0] fpga2sdram0_aw_len,
  input   wire [  2-1:0] fpga2sdram0_aw_lock,
  input   wire [  3-1:0] fpga2sdram0_aw_prot,
  output  wire [  1-1:0] fpga2sdram0_aw_ready,
  input   wire [  3-1:0] fpga2sdram0_aw_size,
  input   wire [  5-1:0] fpga2sdram0_aw_user,
  input   wire [  1-1:0] fpga2sdram0_aw_valid,
  output  wire [  4-1:0] fpga2sdram0_b_id,
  input   wire [  1-1:0] fpga2sdram0_b_ready,
  output  wire [  2-1:0] fpga2sdram0_b_resp,
  output  wire [  1-1:0] fpga2sdram0_b_valid,
  output  wire [ 32-1:0] fpga2sdram0_r_data,
  output  wire [  4-1:0] fpga2sdram0_r_id,
  output  wire [  1-1:0] fpga2sdram0_r_last,
  input   wire [  1-1:0] fpga2sdram0_r_ready,
  output  wire [  2-1:0] fpga2sdram0_r_resp,
  output  wire [  1-1:0] fpga2sdram0_r_valid,
  input   wire [ 32-1:0] fpga2sdram0_w_data,
  input   wire [  4-1:0] fpga2sdram0_w_id,
  input   wire [  1-1:0] fpga2sdram0_w_last,
  output  wire [  1-1:0] fpga2sdram0_w_ready,
  input   wire [  4-1:0] fpga2sdram0_w_strb,
  input   wire [  1-1:0] fpga2sdram0_w_valid,
  input   wire [ 32-1:0] fpga2sdram1_ar_addr,
  input   wire [  2-1:0] fpga2sdram1_ar_burst,
  input   wire [  4-1:0] fpga2sdram1_ar_cache,
  input   wire [  4-1:0] fpga2sdram1_ar_id,
  input   wire [  4-1:0] fpga2sdram1_ar_len,
  input   wire [  2-1:0] fpga2sdram1_ar_lock,
  input   wire [  3-1:0] fpga2sdram1_ar_prot,
  output  wire [  1-1:0] fpga2sdram1_ar_ready,
  input   wire [  3-1:0] fpga2sdram1_ar_size,
  input   wire [  5-1:0] fpga2sdram1_ar_user,
  input   wire [  1-1:0] fpga2sdram1_ar_valid,
  input   wire [ 32-1:0] fpga2sdram1_aw_addr,
  input   wire [  2-1:0] fpga2sdram1_aw_burst,
  input   wire [  4-1:0] fpga2sdram1_aw_cache,
  input   wire [  4-1:0] fpga2sdram1_aw_id,
  input   wire [  4-1:0] fpga2sdram1_aw_len,
  input   wire [  2-1:0] fpga2sdram1_aw_lock,
  input   wire [  3-1:0] fpga2sdram1_aw_prot,
  output  wire [  1-1:0] fpga2sdram1_aw_ready,
  input   wire [  3-1:0] fpga2sdram1_aw_size,
  input   wire [  5-1:0] fpga2sdram1_aw_user,
  input   wire [  1-1:0] fpga2sdram1_aw_valid,
  output  wire [  4-1:0] fpga2sdram1_b_id,
  input   wire [  1-1:0] fpga2sdram1_b_ready,
  output  wire [  2-1:0] fpga2sdram1_b_resp,
  output  wire [  1-1:0] fpga2sdram1_b_valid,
  output  wire [ 32-1:0] fpga2sdram1_r_data,
  output  wire [  4-1:0] fpga2sdram1_r_id,
  output  wire [  1-1:0] fpga2sdram1_r_last,
  input   wire [  1-1:0] fpga2sdram1_r_ready,
  output  wire [  2-1:0] fpga2sdram1_r_resp,
  output  wire [  1-1:0] fpga2sdram1_r_valid,
  input   wire [ 32-1:0] fpga2sdram1_w_data,
  input   wire [  4-1:0] fpga2sdram1_w_id,
  input   wire [  1-1:0] fpga2sdram1_w_last,
  output  wire [  1-1:0] fpga2sdram1_w_ready,
  input   wire [  4-1:0] fpga2sdram1_w_strb,
  input   wire [  1-1:0] fpga2sdram1_w_valid,
  input   wire [ 32-1:0] fpga2sdram2_ar_addr,
  input   wire [  2-1:0] fpga2sdram2_ar_burst,
  input   wire [  4-1:0] fpga2sdram2_ar_cache,
  input   wire [  4-1:0] fpga2sdram2_ar_id,
  input   wire [  4-1:0] fpga2sdram2_ar_len,
  input   wire [  2-1:0] fpga2sdram2_ar_lock,
  input   wire [  3-1:0] fpga2sdram2_ar_prot,
  output  wire [  1-1:0] fpga2sdram2_ar_ready,
  input   wire [  3-1:0] fpga2sdram2_ar_size,
  input   wire [  5-1:0] fpga2sdram2_ar_user,
  input   wire [  1-1:0] fpga2sdram2_ar_valid,
  input   wire [ 32-1:0] fpga2sdram2_aw_addr,
  input   wire [  2-1:0] fpga2sdram2_aw_burst,
  input   wire [  4-1:0] fpga2sdram2_aw_cache,
  input   wire [  4-1:0] fpga2sdram2_aw_id,
  input   wire [  4-1:0] fpga2sdram2_aw_len,
  input   wire [  2-1:0] fpga2sdram2_aw_lock,
  input   wire [  3-1:0] fpga2sdram2_aw_prot,
  output  wire [  1-1:0] fpga2sdram2_aw_ready,
  input   wire [  3-1:0] fpga2sdram2_aw_size,
  input   wire [  5-1:0] fpga2sdram2_aw_user,
  input   wire [  1-1:0] fpga2sdram2_aw_valid,
  output  wire [  4-1:0] fpga2sdram2_b_id,
  input   wire [  1-1:0] fpga2sdram2_b_ready,
  output  wire [  2-1:0] fpga2sdram2_b_resp,
  output  wire [  1-1:0] fpga2sdram2_b_valid,
  output  wire [ 32-1:0] fpga2sdram2_r_data,
  output  wire [  4-1:0] fpga2sdram2_r_id,
  output  wire [  1-1:0] fpga2sdram2_r_last,
  input   wire [  1-1:0] fpga2sdram2_r_ready,
  output  wire [  2-1:0] fpga2sdram2_r_resp,
  output  wire [  1-1:0] fpga2sdram2_r_valid,
  input   wire [ 32-1:0] fpga2sdram2_w_data,
  input   wire [  4-1:0] fpga2sdram2_w_id,
  input   wire [  1-1:0] fpga2sdram2_w_last,
  output  wire [  1-1:0] fpga2sdram2_w_ready,
  input   wire [  4-1:0] fpga2sdram2_w_strb,
  input   wire [  1-1:0] fpga2sdram2_w_valid
);

localparam DWIDTH = 32;

wire [  1-1:0] w_fpga2sdram0_ar_ready;
wire [  1-1:0] w_fpga2sdram0_ar_valid;
wire [  1-1:0] w_fpga2sdram0_aw_ready;
wire [  1-1:0] w_fpga2sdram0_aw_valid;
wire [  1-1:0] w_fpga2sdram0_b_ready;
wire [  1-1:0] w_fpga2sdram0_b_valid;
wire [ 32-1:0] w_fpga2sdram0_req_addr;
wire [ 16-1:0] w_fpga2sdram0_req_be;
wire [128-1:0] w_fpga2sdram0_req_data;
wire [  4-1:0] w_fpga2sdram0_req_exclid;
wire [  2-1:0] w_fpga2sdram0_req_hurry;
wire [  1-1:0] w_fpga2sdram0_req_last;
wire [  8-1:0] w_fpga2sdram0_req_length;
wire [  3-1:0] w_fpga2sdram0_req_opc;
wire [  2-1:0] w_fpga2sdram0_req_press;
wire [  1-1:0] w_fpga2sdram0_req_rdy;
wire [  4-1:0] w_fpga2sdram0_req_seqid;
wire [  3-1:0] w_fpga2sdram0_req_trid;
wire [  2-1:0] w_fpga2sdram0_req_urgency;
wire [ 12-1:0] w_fpga2sdram0_req_user;
wire [  1-1:0] w_fpga2sdram0_req_vld;
wire [  1-1:0] w_fpga2sdram0_rsp_cont;
wire [128-1:0] w_fpga2sdram0_rsp_data;
wire [  1-1:0] w_fpga2sdram0_rsp_last;
wire [  1-1:0] w_fpga2sdram0_rsp_rdy;
wire [  2-1:0] w_fpga2sdram0_rsp_status;
wire [  3-1:0] w_fpga2sdram0_rsp_trid;
wire [  1-1:0] w_fpga2sdram0_rsp_vld;
wire [  1-1:0] w_fpga2sdram1_ar_ready;
wire [  1-1:0] w_fpga2sdram1_ar_valid;
wire [  1-1:0] w_fpga2sdram1_aw_ready;
wire [  1-1:0] w_fpga2sdram1_aw_valid;
wire [  1-1:0] w_fpga2sdram1_b_ready;
wire [  1-1:0] w_fpga2sdram1_b_valid;
wire [ 32-1:0] w_fpga2sdram1_req_addr;
wire [ 16-1:0] w_fpga2sdram1_req_be;
wire [128-1:0] w_fpga2sdram1_req_data;
wire [  4-1:0] w_fpga2sdram1_req_exclid;
wire [  2-1:0] w_fpga2sdram1_req_hurry;
wire [  1-1:0] w_fpga2sdram1_req_last;
wire [  8-1:0] w_fpga2sdram1_req_length;
wire [  3-1:0] w_fpga2sdram1_req_opc;
wire [  2-1:0] w_fpga2sdram1_req_press;
wire [  1-1:0] w_fpga2sdram1_req_rdy;
wire [  4-1:0] w_fpga2sdram1_req_seqid;
wire [  3-1:0] w_fpga2sdram1_req_trid;
wire [  2-1:0] w_fpga2sdram1_req_urgency;
wire [ 12-1:0] w_fpga2sdram1_req_user;
wire [  1-1:0] w_fpga2sdram1_req_vld;
wire [  1-1:0] w_fpga2sdram1_rsp_cont;
wire [122-1:0] w_fpga2sdram1_rsp_data;
wire [  1-1:0] w_fpga2sdram1_rsp_last;
wire [  1-1:0] w_fpga2sdram1_rsp_rdy;
wire [  2-1:0] w_fpga2sdram1_rsp_status;
wire [  3-1:0] w_fpga2sdram1_rsp_trid;
wire [  1-1:0] w_fpga2sdram1_rsp_vld;
wire [  1-1:0] w_fpga2sdram2_ar_ready;
wire [  1-1:0] w_fpga2sdram2_ar_valid;
wire [  1-1:0] w_fpga2sdram2_aw_ready;
wire [  1-1:0] w_fpga2sdram2_aw_valid;
wire [  1-1:0] w_fpga2sdram2_b_ready;
wire [  1-1:0] w_fpga2sdram2_b_valid;
wire [ 32-1:0] w_fpga2sdram2_req_addr;
wire [ 16-1:0] w_fpga2sdram2_req_be;
wire [128-1:0] w_fpga2sdram2_req_data;
wire [  4-1:0] w_fpga2sdram2_req_exclid;
wire [  2-1:0] w_fpga2sdram2_req_hurry;
wire [  1-1:0] w_fpga2sdram2_req_last;
wire [  8-1:0] w_fpga2sdram2_req_length;
wire [  3-1:0] w_fpga2sdram2_req_opc;
wire [  2-1:0] w_fpga2sdram2_req_press;
wire [  1-1:0] w_fpga2sdram2_req_rdy;
wire [  4-1:0] w_fpga2sdram2_req_seqid;
wire [  3-1:0] w_fpga2sdram2_req_trid;
wire [  2-1:0] w_fpga2sdram2_req_urgency;
wire [ 12-1:0] w_fpga2sdram2_req_user;
wire [  1-1:0] w_fpga2sdram2_req_vld;
wire [  1-1:0] w_fpga2sdram2_rsp_cont;
wire [ 70-1:0] w_fpga2sdram2_rsp_data;
wire [  1-1:0] w_fpga2sdram2_rsp_last;
wire [  1-1:0] w_fpga2sdram2_rsp_rdy;
wire [  2-1:0] w_fpga2sdram2_rsp_status;
wire [  3-1:0] w_fpga2sdram2_rsp_trid;
wire [  1-1:0] w_fpga2sdram2_rsp_vld;



wire                     s1_ar_ready;
wire                     s1_aw_ready;
wire               [3:0] s1_b_id;
wire               [1:0] s1_b_resp;
wire                     s1_b_valid;
wire        [DWIDTH-1:0] s1_r_data;
wire               [3:0] s1_r_id;
wire                     s1_r_last;
wire               [1:0] s1_r_resp;
wire                     s1_r_valid;
wire                     s1_w_ready;
wire             [31:0] s1_ar_addr;
wire              [1:0] s1_ar_burst;
wire              [3:0] s1_ar_cache;
wire              [3:0] s1_ar_id;
wire              [3:0] s1_ar_len;
wire              [1:0] s1_ar_lock;
wire              [2:0] s1_ar_prot;
wire              [2:0] s1_ar_size;
wire              [4:0] s1_ar_user;
wire                    s1_ar_valid;
wire             [31:0] s1_aw_addr;
wire              [1:0] s1_aw_burst;
wire              [3:0] s1_aw_cache;
wire              [3:0] s1_aw_id;
wire              [3:0] s1_aw_len;
wire              [1:0] s1_aw_lock;
wire              [2:0] s1_aw_prot;
wire              [2:0] s1_aw_size;
wire              [4:0] s1_aw_user;
wire                    s1_aw_valid;
wire                    s1_b_ready;
wire                    s1_r_ready;
wire       [DWIDTH-1:0] s1_w_data;
wire              [3:0] s1_w_id;
wire                    s1_w_last;
wire     [DWIDTH/8-1:0] s1_w_strb;
wire                    s1_w_valid;


assign fpga2sdram0_ar_ready 	= w_fpga2sdram0_ar_ready;
assign fpga2sdram0_aw_ready 	= w_fpga2sdram0_aw_ready;
assign fpga2sdram0_b_id[3:0] 	= w_fpga2sdram0_rsp_data[125:122];
assign fpga2sdram0_b_resp[1:0] 	= w_fpga2sdram0_rsp_data[127:126];
assign fpga2sdram0_b_valid 	= w_fpga2sdram0_b_valid;
assign fpga2sdram0_r_data[31:0] 	= w_fpga2sdram0_rsp_data[31:0];
assign fpga2sdram0_r_id[2:0] 	= w_fpga2sdram0_rsp_trid[2:0];
assign fpga2sdram0_r_id[3] 	= w_fpga2sdram0_rsp_cont;
assign fpga2sdram0_r_last 	= w_fpga2sdram0_rsp_last;
assign fpga2sdram0_r_resp[1:0] 	= w_fpga2sdram0_rsp_status[1:0];
assign fpga2sdram0_r_valid 	= w_fpga2sdram0_rsp_vld;
assign fpga2sdram0_w_ready 	= w_fpga2sdram0_req_rdy;
assign fpga2sdram2_ar_ready 	= w_fpga2sdram2_ar_ready;
assign fpga2sdram2_aw_ready 	= w_fpga2sdram2_aw_ready;
assign fpga2sdram2_b_id[3:0] 	= w_fpga2sdram2_rsp_data[67:64];
assign fpga2sdram2_b_resp[1:0] 	= w_fpga2sdram2_rsp_data[69:68];
assign fpga2sdram2_b_valid 	= w_fpga2sdram2_b_valid;
assign fpga2sdram2_r_data[31:0] 	= w_fpga2sdram2_rsp_data[31:0];
assign fpga2sdram2_r_id[2:0] 	= w_fpga2sdram2_rsp_trid[2:0];
assign fpga2sdram2_r_id[3] 	= w_fpga2sdram2_rsp_cont;
assign fpga2sdram2_r_last 	= w_fpga2sdram2_rsp_last;
assign fpga2sdram2_r_resp[1:0] 	= w_fpga2sdram2_rsp_status[1:0];
assign fpga2sdram2_r_valid 	= w_fpga2sdram2_rsp_vld;
assign fpga2sdram2_w_ready 	= w_fpga2sdram2_req_rdy;

assign w_fpga2sdram0_ar_valid 	= fpga2sdram0_ar_valid;
assign w_fpga2sdram0_aw_valid 	= fpga2sdram0_aw_valid;
assign w_fpga2sdram0_b_ready 	= fpga2sdram0_b_ready;
assign w_fpga2sdram0_req_addr[31:0] 	= fpga2sdram0_aw_addr[31:0];
assign w_fpga2sdram0_req_be[11:8] 	= fpga2sdram0_ar_cache[3:0];
assign w_fpga2sdram0_req_be[15:12] 	= fpga2sdram0_ar_id[3:0];
assign w_fpga2sdram0_req_be[3:0] 	= fpga2sdram0_w_strb[3:0];
assign w_fpga2sdram0_req_be[7:4] 	= 4'b1111;
assign w_fpga2sdram0_req_data[127:96] 	= fpga2sdram0_ar_addr[31:0];
assign w_fpga2sdram0_req_data[31:0] 	= fpga2sdram0_w_data[31:0];
assign w_fpga2sdram0_req_data[87:86] 	= fpga2sdram0_ar_lock[1:0];
assign w_fpga2sdram0_req_data[90:88] 	= fpga2sdram0_ar_size[2:0];
assign w_fpga2sdram0_req_data[95:91] 	= fpga2sdram0_ar_user[4:0];
assign w_fpga2sdram0_req_data[85:32] 	= 54'b11111111111111111111111111111111111111111111111111111;
assign w_fpga2sdram0_req_exclid[3:0] 	= fpga2sdram0_w_id[3:0];
assign w_fpga2sdram0_req_hurry[1:0] 	= fpga2sdram0_aw_lock[1:0];
assign w_fpga2sdram0_req_last 	= fpga2sdram0_w_last;
assign w_fpga2sdram0_req_length[3:0] 	= fpga2sdram0_aw_len[3:0];
assign w_fpga2sdram0_req_length[7:4] 	= fpga2sdram0_ar_len[3:0];
assign w_fpga2sdram0_req_opc[2:0] 	= fpga2sdram0_aw_size[2:0];
assign w_fpga2sdram0_req_press[1:0] 	= fpga2sdram0_aw_burst[1:0];
assign w_fpga2sdram0_req_seqid[3:0] 	= fpga2sdram0_aw_id[3:0];
assign w_fpga2sdram0_req_trid[2:0] 	= fpga2sdram0_ar_prot[2:0];
assign w_fpga2sdram0_req_urgency[1:0] 	= fpga2sdram0_ar_burst[1:0];
assign w_fpga2sdram0_req_user[11:7] 	= fpga2sdram0_aw_user[4:0];
assign w_fpga2sdram0_req_user[3:0] 	= fpga2sdram0_aw_cache[3:0];
assign w_fpga2sdram0_req_user[6:4] 	= fpga2sdram0_aw_prot[2:0];
assign w_fpga2sdram0_req_vld 	= fpga2sdram0_w_valid;
assign w_fpga2sdram0_rsp_rdy 	= fpga2sdram0_r_ready;
assign w_fpga2sdram2_ar_valid 	= fpga2sdram2_ar_valid;
assign w_fpga2sdram2_aw_valid 	= fpga2sdram2_aw_valid;
assign w_fpga2sdram2_b_ready 	= fpga2sdram2_b_ready;
assign w_fpga2sdram2_req_addr[31:0] 	= fpga2sdram2_aw_addr[31:0];

assign w_fpga2sdram2_req_be[3:0] 	= fpga2sdram2_w_strb[3:0];
assign w_fpga2sdram2_req_be[7:4] 	= 4'b0000;
assign w_fpga2sdram2_req_be[11:8] 	= fpga2sdram2_ar_cache[3:0];
assign w_fpga2sdram2_req_be[15:12] 	= fpga2sdram2_ar_id[3:0];

assign w_fpga2sdram2_req_data[31:0] 	= fpga2sdram2_w_data[31:0];
assign w_fpga2sdram2_req_data[85:32] 	= 54'b000000000000000000000000000000000000000000000000000000;
assign w_fpga2sdram2_req_data[87:86] 	= fpga2sdram2_ar_lock[1:0];
assign w_fpga2sdram2_req_data[90:88] 	= fpga2sdram2_ar_size[2:0];
assign w_fpga2sdram2_req_data[95:91] 	= fpga2sdram2_ar_user[4:0];
assign w_fpga2sdram2_req_data[127:96] 	= fpga2sdram2_ar_addr[31:0];

assign w_fpga2sdram2_req_exclid[3:0] 	= fpga2sdram2_w_id[3:0];
assign w_fpga2sdram2_req_hurry[1:0] 	= fpga2sdram2_aw_lock[1:0];
assign w_fpga2sdram2_req_last 	= fpga2sdram2_w_last;
assign w_fpga2sdram2_req_length[3:0] 	= fpga2sdram2_aw_len[3:0];
assign w_fpga2sdram2_req_length[7:4] 	= fpga2sdram2_ar_len[3:0];
assign w_fpga2sdram2_req_opc[2:0] 	= fpga2sdram2_aw_size[2:0];
assign w_fpga2sdram2_req_press[1:0] 	= fpga2sdram2_aw_burst[1:0];
assign w_fpga2sdram2_req_seqid[3:0] 	= fpga2sdram2_aw_id[3:0];
assign w_fpga2sdram2_req_trid[2:0] 	= fpga2sdram2_ar_prot[2:0];
assign w_fpga2sdram2_req_urgency[1:0] 	= fpga2sdram2_ar_burst[1:0];
assign w_fpga2sdram2_req_user[11:7] 	= fpga2sdram2_aw_user[4:0];
assign w_fpga2sdram2_req_user[3:0] 	= fpga2sdram2_aw_cache[3:0];
assign w_fpga2sdram2_req_user[6:4] 	= fpga2sdram2_aw_prot[2:0];
assign w_fpga2sdram2_req_vld 	= fpga2sdram2_w_valid;
assign w_fpga2sdram2_rsp_rdy 	= fpga2sdram2_r_ready;

assign s1_ar_ready 	= w_fpga2sdram1_ar_ready;
assign s1_aw_ready 	= w_fpga2sdram1_aw_ready;
assign s1_b_id[3:0] 	= w_fpga2sdram1_rsp_data[119:116];
assign s1_b_resp[1:0] 	= w_fpga2sdram1_rsp_data[121:120];
assign s1_b_valid 	= w_fpga2sdram1_b_valid;
assign s1_r_data[31:0] 	= w_fpga2sdram1_rsp_data[31:0];
assign s1_r_id[2:0] 	= w_fpga2sdram1_rsp_trid[2:0];
assign s1_r_id[3] 	= w_fpga2sdram1_rsp_cont;
assign s1_r_last 	= w_fpga2sdram1_rsp_last;
assign s1_r_resp[1:0] 	= w_fpga2sdram1_rsp_status[1:0];
assign s1_r_valid 	= w_fpga2sdram1_rsp_vld;
assign s1_w_ready 	= w_fpga2sdram1_req_rdy;

assign w_fpga2sdram1_ar_valid 	= s1_ar_valid;
assign w_fpga2sdram1_aw_valid 	= s1_aw_valid;
assign w_fpga2sdram1_b_ready 	= s1_b_ready;
assign w_fpga2sdram1_req_addr[31:0] 	= s1_aw_addr[31:0];
assign w_fpga2sdram1_req_be[11:8] 	= s1_ar_cache[3:0];
assign w_fpga2sdram1_req_be[15:12] 	= s1_ar_id[3:0];
assign w_fpga2sdram1_req_be[3:0] 	= s1_w_strb[3:0];
assign w_fpga2sdram1_req_data[127:96] 	= s1_ar_addr[31:0];
assign w_fpga2sdram1_req_data[31:0] 	= s1_w_data[31:0];
assign w_fpga2sdram1_req_data[87:86] 	= s1_ar_lock[1:0];
assign w_fpga2sdram1_req_data[90:88] 	= s1_ar_size[2:0];
assign w_fpga2sdram1_req_data[95:91] 	= s1_ar_user[4:0];
assign w_fpga2sdram1_req_exclid[3:0] 	= s1_w_id[3:0];
assign w_fpga2sdram1_req_hurry[1:0] 	= s1_aw_lock[1:0];
assign w_fpga2sdram1_req_last 	= s1_w_last;
assign w_fpga2sdram1_req_length[3:0] 	= s1_aw_len[3:0];
assign w_fpga2sdram1_req_length[7:4] 	= s1_ar_len[3:0];
assign w_fpga2sdram1_req_opc[2:0] 	= s1_aw_size[2:0];
assign w_fpga2sdram1_req_press[1:0] 	= s1_aw_burst[1:0];
assign w_fpga2sdram1_req_seqid[3:0] 	= s1_aw_id[3:0];
assign w_fpga2sdram1_req_trid[2:0] 	= s1_ar_prot[2:0];
assign w_fpga2sdram1_req_urgency[1:0] 	= s1_ar_burst[1:0];
assign w_fpga2sdram1_req_user[11:7] 	= s1_aw_user[4:0];
assign w_fpga2sdram1_req_user[3:0] 	= s1_aw_cache[3:0];
assign w_fpga2sdram1_req_user[6:4] 	= s1_aw_prot[2:0];
assign w_fpga2sdram1_req_vld 	= s1_w_valid;
assign w_fpga2sdram1_rsp_rdy 	= s1_r_ready;




f2s_rl_delay_adp #( .DWIDTH(DWIDTH0),   .DEPTH(DEPTH)) f2s_rl_adp_inst_1 (
	.clk(  f2s_sdram1_ar_clk ),
	.f_ar_addr( fpga2sdram1_ar_addr ),
	.f_ar_burst( fpga2sdram1_ar_burst ),
	.f_ar_cache( fpga2sdram1_ar_cache ),
	.f_ar_id( fpga2sdram1_ar_id ),
	.f_ar_len( fpga2sdram1_ar_len ),
	.f_ar_lock( fpga2sdram1_ar_lock ),
	.f_ar_prot( fpga2sdram1_ar_prot ),
	.f_ar_size( fpga2sdram1_ar_size ),
	.f_ar_user( fpga2sdram1_ar_user ),
	.f_ar_valid( fpga2sdram1_ar_valid ),
	.f_aw_addr( fpga2sdram1_aw_addr ),
	.f_aw_burst( fpga2sdram1_aw_burst ),
	.f_aw_cache( fpga2sdram1_aw_cache ),
	.f_aw_id( fpga2sdram1_aw_id ),
	.f_aw_len( fpga2sdram1_aw_len ),
	.f_aw_lock( fpga2sdram1_aw_lock ),
	.f_aw_prot( fpga2sdram1_aw_prot ),
	.f_aw_size( fpga2sdram1_aw_size ),
	.f_aw_user( fpga2sdram1_aw_user ),
	.f_aw_valid( fpga2sdram1_aw_valid ),
	.f_b_ready( fpga2sdram1_b_ready ),
	.f_r_ready( fpga2sdram1_r_ready ),
	.f_w_data( fpga2sdram1_w_data ),
	.f_w_id( fpga2sdram1_w_id ),
	.f_w_last( fpga2sdram1_w_last ),
	.f_w_strb( fpga2sdram1_w_strb ),
	.f_w_valid( fpga2sdram1_w_valid ),
	.rst_n( f2s_sdram1_rst_n ),
	.s_ar_ready( s1_ar_ready ),
	.s_aw_ready( s1_aw_ready ),
	.s_b_id( s1_b_id ),
	.s_b_resp( s1_b_resp ),
	.s_b_valid( s1_b_valid ),
	.s_r_data( s1_r_data ),
	.s_r_id( s1_r_id ),
	.s_r_last( s1_r_last ),
	.s_r_resp( s1_r_resp ),
	.s_r_valid( s1_r_valid ),
	.s_ready_latency( fpga2sdram_port_size_config[3] ),
	.s_w_ready( s1_w_ready ),
	.f_ar_ready( fpga2sdram1_ar_ready ),
	.f_aw_ready( fpga2sdram1_aw_ready ),
	.f_b_id( fpga2sdram1_b_id ),
	.f_b_resp( fpga2sdram1_b_resp ),
	.f_b_valid( fpga2sdram1_b_valid ),
	.f_r_data( fpga2sdram1_r_data ),
	.f_r_id(   fpga2sdram1_r_id ),
	.f_r_last( fpga2sdram1_r_last ),
	.f_r_resp( fpga2sdram1_r_resp ),
	.f_r_valid( fpga2sdram1_r_valid ),
	.f_w_ready( fpga2sdram1_w_ready ),
	.s_ar_addr( s1_ar_addr ),
	.s_ar_burst( s1_ar_burst ),
	.s_ar_cache( s1_ar_cache ),
	.s_ar_id( s1_ar_id ),
	.s_ar_len( s1_ar_len ),
	.s_ar_lock( s1_ar_lock ),
	.s_ar_prot( s1_ar_prot ),
	.s_ar_size( s1_ar_size ),
	.s_ar_user( s1_ar_user ),
	.s_ar_valid( s1_ar_valid ),
	.s_aw_addr( s1_aw_addr ),
	.s_aw_burst( s1_aw_burst ),
	.s_aw_cache( s1_aw_cache ),
	.s_aw_id( s1_aw_id ),
	.s_aw_len( s1_aw_len ),
	.s_aw_lock( s1_aw_lock ),
	.s_aw_prot( s1_aw_prot ),
	.s_aw_size( s1_aw_size ),
	.s_aw_user( s1_aw_user ),
	.s_aw_valid( s1_aw_valid ),
	.s_b_ready( s1_b_ready ),
	.s_r_ready( s1_r_ready ),
	.s_w_data( s1_w_data ),
	.s_w_id( s1_w_id ),
	.s_w_last( s1_w_last ),
	.s_w_strb( s1_w_strb ),
	.s_w_valid( s1_w_valid )
);

twentynm_hps_interface_fpga2sdram fpga2sdram_0es_instance(
  .f2s_sdram0_ar_clk(f2s_sdram0_ar_clk),
  .f2s_sdram0_aw_clk(f2s_sdram0_aw_clk),
  .f2s_sdram0_b_clk(f2s_sdram0_b_clk),
  .f2s_sdram0_clk(f2s_sdram0_clk),
  .f2s_sdram0_r_clk(f2s_sdram0_r_clk),
  .f2s_sdram0_w_clk(f2s_sdram0_w_clk),
  .f2s_sdram1_ar_clk(f2s_sdram1_ar_clk),
  .f2s_sdram1_aw_clk(f2s_sdram1_aw_clk),
  .f2s_sdram1_b_clk(f2s_sdram1_b_clk),
  .f2s_sdram1_clk(f2s_sdram1_clk),
  .f2s_sdram1_r_clk(f2s_sdram1_r_clk),
  .f2s_sdram1_w_clk(f2s_sdram1_w_clk),
  .f2s_sdram2_ar_clk(f2s_sdram2_ar_clk),
  .f2s_sdram2_aw_clk(f2s_sdram2_aw_clk),
  .f2s_sdram2_b_clk(f2s_sdram2_b_clk),
  .f2s_sdram2_clk(f2s_sdram2_clk),
  .f2s_sdram2_r_clk(f2s_sdram2_r_clk),
  .f2s_sdram2_w_clk(f2s_sdram2_w_clk),
  .fpga2sdram_port_size_config(fpga2sdram_port_size_config),
  .fpga2sdram0_ar_ready(w_fpga2sdram0_ar_ready),
  .fpga2sdram0_ar_valid(w_fpga2sdram0_ar_valid),
  .fpga2sdram0_aw_ready(w_fpga2sdram0_aw_ready),
  .fpga2sdram0_aw_valid(w_fpga2sdram0_aw_valid),
  .fpga2sdram0_b_ready(w_fpga2sdram0_b_ready),
  .fpga2sdram0_b_valid(w_fpga2sdram0_b_valid),
  .fpga2sdram0_req_addr(w_fpga2sdram0_req_addr),
  .fpga2sdram0_req_be(w_fpga2sdram0_req_be),
  .fpga2sdram0_req_data(w_fpga2sdram0_req_data),
  .fpga2sdram0_req_exclid(w_fpga2sdram0_req_exclid),
  .fpga2sdram0_req_hurry(w_fpga2sdram0_req_hurry),
  .fpga2sdram0_req_last(w_fpga2sdram0_req_last),
  .fpga2sdram0_req_length(w_fpga2sdram0_req_length),
  .fpga2sdram0_req_opc(w_fpga2sdram0_req_opc),
  .fpga2sdram0_req_press(w_fpga2sdram0_req_press),
  .fpga2sdram0_req_rdy(w_fpga2sdram0_req_rdy),
  .fpga2sdram0_req_seqid(w_fpga2sdram0_req_seqid),
  .fpga2sdram0_req_trid(w_fpga2sdram0_req_trid),
  .fpga2sdram0_req_urgency(w_fpga2sdram0_req_urgency),
  .fpga2sdram0_req_user(w_fpga2sdram0_req_user),
  .fpga2sdram0_req_vld(w_fpga2sdram0_req_vld),
  .fpga2sdram0_rsp_cont(w_fpga2sdram0_rsp_cont),
  .fpga2sdram0_rsp_data(w_fpga2sdram0_rsp_data),
  .fpga2sdram0_rsp_last(w_fpga2sdram0_rsp_last),
  .fpga2sdram0_rsp_rdy(w_fpga2sdram0_rsp_rdy),
  .fpga2sdram0_rsp_status(w_fpga2sdram0_rsp_status),
  .fpga2sdram0_rsp_trid(w_fpga2sdram0_rsp_trid),
  .fpga2sdram0_rsp_vld(w_fpga2sdram0_rsp_vld),
  .fpga2sdram1_ar_ready(w_fpga2sdram1_ar_ready),
  .fpga2sdram1_ar_valid(w_fpga2sdram1_ar_valid),
  .fpga2sdram1_aw_ready(w_fpga2sdram1_aw_ready),
  .fpga2sdram1_aw_valid(w_fpga2sdram1_aw_valid),
  .fpga2sdram1_b_ready(w_fpga2sdram1_b_ready),
  .fpga2sdram1_b_valid(w_fpga2sdram1_b_valid),
  .fpga2sdram1_req_addr(w_fpga2sdram1_req_addr),
  .fpga2sdram1_req_be(w_fpga2sdram1_req_be),
  .fpga2sdram1_req_data(w_fpga2sdram1_req_data),
  .fpga2sdram1_req_exclid(w_fpga2sdram1_req_exclid),
  .fpga2sdram1_req_hurry(w_fpga2sdram1_req_hurry),
  .fpga2sdram1_req_last(w_fpga2sdram1_req_last),
  .fpga2sdram1_req_length(w_fpga2sdram1_req_length),
  .fpga2sdram1_req_opc(w_fpga2sdram1_req_opc),
  .fpga2sdram1_req_press(w_fpga2sdram1_req_press),
  .fpga2sdram1_req_rdy(w_fpga2sdram1_req_rdy),
  .fpga2sdram1_req_seqid(w_fpga2sdram1_req_seqid),
  .fpga2sdram1_req_trid(w_fpga2sdram1_req_trid),
  .fpga2sdram1_req_urgency(w_fpga2sdram1_req_urgency),
  .fpga2sdram1_req_user(w_fpga2sdram1_req_user),
  .fpga2sdram1_req_vld(w_fpga2sdram1_req_vld),
  .fpga2sdram1_rsp_cont(w_fpga2sdram1_rsp_cont),
  .fpga2sdram1_rsp_data(w_fpga2sdram1_rsp_data),
  .fpga2sdram1_rsp_last(w_fpga2sdram1_rsp_last),
  .fpga2sdram1_rsp_rdy(w_fpga2sdram1_rsp_rdy),
  .fpga2sdram1_rsp_status(w_fpga2sdram1_rsp_status),
  .fpga2sdram1_rsp_trid(w_fpga2sdram1_rsp_trid),
  .fpga2sdram1_rsp_vld(w_fpga2sdram1_rsp_vld),
  .fpga2sdram2_ar_ready(w_fpga2sdram2_ar_ready),
  .fpga2sdram2_ar_valid(w_fpga2sdram2_ar_valid),
  .fpga2sdram2_aw_ready(w_fpga2sdram2_aw_ready),
  .fpga2sdram2_aw_valid(w_fpga2sdram2_aw_valid),
  .fpga2sdram2_b_ready(w_fpga2sdram2_b_ready),
  .fpga2sdram2_b_valid(w_fpga2sdram2_b_valid),
  .fpga2sdram2_req_addr(w_fpga2sdram2_req_addr),
  .fpga2sdram2_req_be(w_fpga2sdram2_req_be),
  .fpga2sdram2_req_data(w_fpga2sdram2_req_data),
  .fpga2sdram2_req_exclid(w_fpga2sdram2_req_exclid),
  .fpga2sdram2_req_hurry(w_fpga2sdram2_req_hurry),
  .fpga2sdram2_req_last(w_fpga2sdram2_req_last),
  .fpga2sdram2_req_length(w_fpga2sdram2_req_length),
  .fpga2sdram2_req_opc(w_fpga2sdram2_req_opc),
  .fpga2sdram2_req_press(w_fpga2sdram2_req_press),
  .fpga2sdram2_req_rdy(w_fpga2sdram2_req_rdy),
  .fpga2sdram2_req_seqid(w_fpga2sdram2_req_seqid),
  .fpga2sdram2_req_trid(w_fpga2sdram2_req_trid),
  .fpga2sdram2_req_urgency(w_fpga2sdram2_req_urgency),
  .fpga2sdram2_req_user(w_fpga2sdram2_req_user),
  .fpga2sdram2_req_vld(w_fpga2sdram2_req_vld),
  .fpga2sdram2_rsp_cont(w_fpga2sdram2_rsp_cont),
  .fpga2sdram2_rsp_data(w_fpga2sdram2_rsp_data),
  .fpga2sdram2_rsp_last(w_fpga2sdram2_rsp_last),
  .fpga2sdram2_rsp_rdy(w_fpga2sdram2_rsp_rdy),
  .fpga2sdram2_rsp_status(w_fpga2sdram2_rsp_status),
  .fpga2sdram2_rsp_trid(w_fpga2sdram2_rsp_trid),
  .fpga2sdram2_rsp_vld(w_fpga2sdram2_rsp_vld)
);
defparam fpga2sdram_0es_instance.mode = mode;

endmodule


//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
`timescale 1 ps / 1 ps
module twentynm_hps_rl_mode1es_fpga2sdram #(
  parameter DEPTH   = 4,
  parameter DWIDTH0 = 16,
  parameter DWIDTH1 = 16,
  parameter DWIDTH2 = 16,
  parameter mode    = 2
)(
  input   wire           f2s_sdram0_ar_clk,
  input   wire           f2s_sdram0_aw_clk,
  input   wire           f2s_sdram0_b_clk,
  input   wire           f2s_sdram0_clk,
  input   wire           f2s_sdram0_r_clk,
  input   wire           f2s_sdram0_w_clk,
  input   wire           f2s_sdram1_ar_clk,
  input   wire           f2s_sdram1_aw_clk,
  input   wire           f2s_sdram1_b_clk,
  input   wire           f2s_sdram1_clk,
  input   wire           f2s_sdram1_r_clk,
  input   wire           f2s_sdram1_w_clk,
  input   wire           f2s_sdram2_ar_clk,
  input   wire           f2s_sdram2_aw_clk,
  input   wire           f2s_sdram2_b_clk,
  input   wire           f2s_sdram2_clk,
  input   wire           f2s_sdram2_r_clk,
  input   wire           f2s_sdram2_w_clk,
  input   wire           f2s_sdram0_rst_n,
  input   wire           f2s_sdram1_rst_n,
  input   wire           f2s_sdram2_rst_n,
  input   wire [ 32-1:0] fpga2sdram0_ar_addr,
  input   wire [    3:0] fpga2sdram_port_size_config,
  input   wire [  2-1:0] fpga2sdram0_ar_burst,
  input   wire [  4-1:0] fpga2sdram0_ar_cache,
  input   wire [  4-1:0] fpga2sdram0_ar_id,
  input   wire [  4-1:0] fpga2sdram0_ar_len,
  input   wire [  2-1:0] fpga2sdram0_ar_lock,
  input   wire [  3-1:0] fpga2sdram0_ar_prot,
  output  wire [  1-1:0] fpga2sdram0_ar_ready,
  input   wire [  3-1:0] fpga2sdram0_ar_size,
  input   wire [  5-1:0] fpga2sdram0_ar_user,
  input   wire [  1-1:0] fpga2sdram0_ar_valid,
  input   wire [ 32-1:0] fpga2sdram0_aw_addr,
  input   wire [  2-1:0] fpga2sdram0_aw_burst,
  input   wire [  4-1:0] fpga2sdram0_aw_cache,
  input   wire [  4-1:0] fpga2sdram0_aw_id,
  input   wire [  4-1:0] fpga2sdram0_aw_len,
  input   wire [  2-1:0] fpga2sdram0_aw_lock,
  input   wire [  3-1:0] fpga2sdram0_aw_prot,
  output  wire [  1-1:0] fpga2sdram0_aw_ready,
  input   wire [  3-1:0] fpga2sdram0_aw_size,
  input   wire [  5-1:0] fpga2sdram0_aw_user,
  input   wire [  1-1:0] fpga2sdram0_aw_valid,
  output  wire [  4-1:0] fpga2sdram0_b_id,
  input   wire [  1-1:0] fpga2sdram0_b_ready,
  output  wire [  2-1:0] fpga2sdram0_b_resp,
  output  wire [  1-1:0] fpga2sdram0_b_valid,
  output  wire [ 64-1:0] fpga2sdram0_r_data,
  output  wire [  4-1:0] fpga2sdram0_r_id,
  output  wire [  1-1:0] fpga2sdram0_r_last,
  input   wire [  1-1:0] fpga2sdram0_r_ready,
  output  wire [  2-1:0] fpga2sdram0_r_resp,
  output  wire [  1-1:0] fpga2sdram0_r_valid,
  input   wire [ 64-1:0] fpga2sdram0_w_data,
  input   wire [  4-1:0] fpga2sdram0_w_id,
  input   wire [  1-1:0] fpga2sdram0_w_last,
  output  wire [  1-1:0] fpga2sdram0_w_ready,
  input   wire [  8-1:0] fpga2sdram0_w_strb,
  input   wire [  1-1:0] fpga2sdram0_w_valid,
  input   wire [ 32-1:0] fpga2sdram1_ar_addr,
  input   wire [  2-1:0] fpga2sdram1_ar_burst,
  input   wire [  4-1:0] fpga2sdram1_ar_cache,
  input   wire [  4-1:0] fpga2sdram1_ar_id,
  input   wire [  4-1:0] fpga2sdram1_ar_len,
  input   wire [  2-1:0] fpga2sdram1_ar_lock,
  input   wire [  3-1:0] fpga2sdram1_ar_prot,
  output  wire [  1-1:0] fpga2sdram1_ar_ready,
  input   wire [  3-1:0] fpga2sdram1_ar_size,
  input   wire [  5-1:0] fpga2sdram1_ar_user,
  input   wire [  1-1:0] fpga2sdram1_ar_valid,
  input   wire [ 32-1:0] fpga2sdram1_aw_addr,
  input   wire [  2-1:0] fpga2sdram1_aw_burst,
  input   wire [  4-1:0] fpga2sdram1_aw_cache,
  input   wire [  4-1:0] fpga2sdram1_aw_id,
  input   wire [  4-1:0] fpga2sdram1_aw_len,
  input   wire [  2-1:0] fpga2sdram1_aw_lock,
  input   wire [  3-1:0] fpga2sdram1_aw_prot,
  output  wire [  1-1:0] fpga2sdram1_aw_ready,
  input   wire [  3-1:0] fpga2sdram1_aw_size,
  input   wire [  5-1:0] fpga2sdram1_aw_user,
  input   wire [  1-1:0] fpga2sdram1_aw_valid,
  output  wire [  4-1:0] fpga2sdram1_b_id,
  input   wire [  1-1:0] fpga2sdram1_b_ready,
  output  wire [  2-1:0] fpga2sdram1_b_resp,
  output  wire [  1-1:0] fpga2sdram1_b_valid,
  output  wire [ 64-1:0] fpga2sdram1_r_data,
  output  wire [  4-1:0] fpga2sdram1_r_id,
  output  wire [  1-1:0] fpga2sdram1_r_last,
  input   wire [  1-1:0] fpga2sdram1_r_ready,
  output  wire [  2-1:0] fpga2sdram1_r_resp,
  output  wire [  1-1:0] fpga2sdram1_r_valid,
  input   wire [ 64-1:0] fpga2sdram1_w_data,
  input   wire [  4-1:0] fpga2sdram1_w_id,
  input   wire [  1-1:0] fpga2sdram1_w_last,
  output  wire [  1-1:0] fpga2sdram1_w_ready,
  input   wire [  8-1:0] fpga2sdram1_w_strb,
  input   wire [  1-1:0] fpga2sdram1_w_valid,
  input   wire [ 32-1:0] fpga2sdram2_ar_addr,
  input   wire [  2-1:0] fpga2sdram2_ar_burst,
  input   wire [  4-1:0] fpga2sdram2_ar_cache,
  input   wire [  4-1:0] fpga2sdram2_ar_id,
  input   wire [  4-1:0] fpga2sdram2_ar_len,
  input   wire [  2-1:0] fpga2sdram2_ar_lock,
  input   wire [  3-1:0] fpga2sdram2_ar_prot,
  output  wire [  1-1:0] fpga2sdram2_ar_ready,
  input   wire [  3-1:0] fpga2sdram2_ar_size,
  input   wire [  5-1:0] fpga2sdram2_ar_user,
  input   wire [  1-1:0] fpga2sdram2_ar_valid,
  input   wire [ 32-1:0] fpga2sdram2_aw_addr,
  input   wire [  2-1:0] fpga2sdram2_aw_burst,
  input   wire [  4-1:0] fpga2sdram2_aw_cache,
  input   wire [  4-1:0] fpga2sdram2_aw_id,
  input   wire [  4-1:0] fpga2sdram2_aw_len,
  input   wire [  2-1:0] fpga2sdram2_aw_lock,
  input   wire [  3-1:0] fpga2sdram2_aw_prot,
  output  wire [  1-1:0] fpga2sdram2_aw_ready,
  input   wire [  3-1:0] fpga2sdram2_aw_size,
  input   wire [  5-1:0] fpga2sdram2_aw_user,
  input   wire [  1-1:0] fpga2sdram2_aw_valid,
  output  wire [  4-1:0] fpga2sdram2_b_id,
  input   wire [  1-1:0] fpga2sdram2_b_ready,
  output  wire [  2-1:0] fpga2sdram2_b_resp,
  output  wire [  1-1:0] fpga2sdram2_b_valid,
  output  wire [ 64-1:0] fpga2sdram2_r_data,
  output  wire [  4-1:0] fpga2sdram2_r_id,
  output  wire [  1-1:0] fpga2sdram2_r_last,
  input   wire [  1-1:0] fpga2sdram2_r_ready,
  output  wire [  2-1:0] fpga2sdram2_r_resp,
  output  wire [  1-1:0] fpga2sdram2_r_valid,
  input   wire [ 64-1:0] fpga2sdram2_w_data,
  input   wire [  4-1:0] fpga2sdram2_w_id,
  input   wire [  1-1:0] fpga2sdram2_w_last,
  output  wire [  1-1:0] fpga2sdram2_w_ready,
  input   wire [  8-1:0] fpga2sdram2_w_strb,
  input   wire [  1-1:0] fpga2sdram2_w_valid
);

localparam DWIDTH = 64;

wire [  1-1:0] w_fpga2sdram0_ar_ready;
wire [  1-1:0] w_fpga2sdram0_ar_valid;
wire [  1-1:0] w_fpga2sdram0_aw_ready;
wire [  1-1:0] w_fpga2sdram0_aw_valid;
wire [  1-1:0] w_fpga2sdram0_b_ready;
wire [  1-1:0] w_fpga2sdram0_b_valid;
wire [ 32-1:0] w_fpga2sdram0_req_addr;
wire [ 16-1:0] w_fpga2sdram0_req_be;
wire [128-1:0] w_fpga2sdram0_req_data;
wire [  4-1:0] w_fpga2sdram0_req_exclid;
wire [  2-1:0] w_fpga2sdram0_req_hurry;
wire [  1-1:0] w_fpga2sdram0_req_last;
wire [  8-1:0] w_fpga2sdram0_req_length;
wire [  3-1:0] w_fpga2sdram0_req_opc;
wire [  2-1:0] w_fpga2sdram0_req_press;
wire [  1-1:0] w_fpga2sdram0_req_rdy;
wire [  4-1:0] w_fpga2sdram0_req_seqid;
wire [  3-1:0] w_fpga2sdram0_req_trid;
wire [  2-1:0] w_fpga2sdram0_req_urgency;
wire [ 12-1:0] w_fpga2sdram0_req_user;
wire [  1-1:0] w_fpga2sdram0_req_vld;
wire [  1-1:0] w_fpga2sdram0_rsp_cont;
wire [128-1:0] w_fpga2sdram0_rsp_data;
wire [  1-1:0] w_fpga2sdram0_rsp_last;
wire [  1-1:0] w_fpga2sdram0_rsp_rdy;
wire [  2-1:0] w_fpga2sdram0_rsp_status;
wire [  3-1:0] w_fpga2sdram0_rsp_trid;
wire [  1-1:0] w_fpga2sdram0_rsp_vld;
wire [  1-1:0] w_fpga2sdram1_ar_ready;
wire [  1-1:0] w_fpga2sdram1_ar_valid;
wire [  1-1:0] w_fpga2sdram1_aw_ready;
wire [  1-1:0] w_fpga2sdram1_aw_valid;
wire [  1-1:0] w_fpga2sdram1_b_ready;
wire [  1-1:0] w_fpga2sdram1_b_valid;
wire [ 32-1:0] w_fpga2sdram1_req_addr;
wire [ 16-1:0] w_fpga2sdram1_req_be;
wire [128-1:0] w_fpga2sdram1_req_data;
wire [  4-1:0] w_fpga2sdram1_req_exclid;
wire [  2-1:0] w_fpga2sdram1_req_hurry;
wire [  1-1:0] w_fpga2sdram1_req_last;
wire [  8-1:0] w_fpga2sdram1_req_length;
wire [  3-1:0] w_fpga2sdram1_req_opc;
wire [  2-1:0] w_fpga2sdram1_req_press;
wire [  1-1:0] w_fpga2sdram1_req_rdy;
wire [  4-1:0] w_fpga2sdram1_req_seqid;
wire [  3-1:0] w_fpga2sdram1_req_trid;
wire [  2-1:0] w_fpga2sdram1_req_urgency;
wire [ 12-1:0] w_fpga2sdram1_req_user;
wire [  1-1:0] w_fpga2sdram1_req_vld;
wire [  1-1:0] w_fpga2sdram1_rsp_cont;
wire [122-1:0] w_fpga2sdram1_rsp_data;
wire [  1-1:0] w_fpga2sdram1_rsp_last;
wire [  1-1:0] w_fpga2sdram1_rsp_rdy;
wire [  2-1:0] w_fpga2sdram1_rsp_status;
wire [  3-1:0] w_fpga2sdram1_rsp_trid;
wire [  1-1:0] w_fpga2sdram1_rsp_vld;
wire [  1-1:0] w_fpga2sdram2_ar_ready;
wire [  1-1:0] w_fpga2sdram2_ar_valid;
wire [  1-1:0] w_fpga2sdram2_aw_ready;
wire [  1-1:0] w_fpga2sdram2_aw_valid;
wire [  1-1:0] w_fpga2sdram2_b_ready;
wire [  1-1:0] w_fpga2sdram2_b_valid;
wire [ 32-1:0] w_fpga2sdram2_req_addr;
wire [ 16-1:0] w_fpga2sdram2_req_be;
wire [128-1:0] w_fpga2sdram2_req_data;
wire [  4-1:0] w_fpga2sdram2_req_exclid;
wire [  2-1:0] w_fpga2sdram2_req_hurry;
wire [  1-1:0] w_fpga2sdram2_req_last;
wire [  8-1:0] w_fpga2sdram2_req_length;
wire [  3-1:0] w_fpga2sdram2_req_opc;
wire [  2-1:0] w_fpga2sdram2_req_press;
wire [  1-1:0] w_fpga2sdram2_req_rdy;
wire [  4-1:0] w_fpga2sdram2_req_seqid;
wire [  3-1:0] w_fpga2sdram2_req_trid;
wire [  2-1:0] w_fpga2sdram2_req_urgency;
wire [ 12-1:0] w_fpga2sdram2_req_user;
wire [  1-1:0] w_fpga2sdram2_req_vld;
wire [  1-1:0] w_fpga2sdram2_rsp_cont;
wire [ 70-1:0] w_fpga2sdram2_rsp_data;
wire [  1-1:0] w_fpga2sdram2_rsp_last;
wire [  1-1:0] w_fpga2sdram2_rsp_rdy;
wire [  2-1:0] w_fpga2sdram2_rsp_status;
wire [  3-1:0] w_fpga2sdram2_rsp_trid;
wire [  1-1:0] w_fpga2sdram2_rsp_vld;



wire                     s1_ar_ready;
wire                     s1_aw_ready;
wire               [3:0] s1_b_id;
wire               [1:0] s1_b_resp;
wire                     s1_b_valid;
wire        [DWIDTH-1:0] s1_r_data;
wire               [3:0] s1_r_id;
wire                     s1_r_last;
wire               [1:0] s1_r_resp;
wire                     s1_r_valid;
wire                     s1_w_ready;
wire             [31:0] s1_ar_addr;
wire              [1:0] s1_ar_burst;
wire              [3:0] s1_ar_cache;
wire              [3:0] s1_ar_id;
wire              [3:0] s1_ar_len;
wire              [1:0] s1_ar_lock;
wire              [2:0] s1_ar_prot;
wire              [2:0] s1_ar_size;
wire              [4:0] s1_ar_user;
wire                    s1_ar_valid;
wire             [31:0] s1_aw_addr;
wire              [1:0] s1_aw_burst;
wire              [3:0] s1_aw_cache;
wire              [3:0] s1_aw_id;
wire              [3:0] s1_aw_len;
wire              [1:0] s1_aw_lock;
wire              [2:0] s1_aw_prot;
wire              [2:0] s1_aw_size;
wire              [4:0] s1_aw_user;
wire                    s1_aw_valid;
wire                    s1_b_ready;
wire                    s1_r_ready;
wire       [DWIDTH-1:0] s1_w_data;
wire              [3:0] s1_w_id;
wire                    s1_w_last;
wire     [DWIDTH/8-1:0] s1_w_strb;
wire                    s1_w_valid;


assign s1_ar_ready 	= w_fpga2sdram1_ar_ready;
assign s1_aw_ready 	= w_fpga2sdram1_aw_ready;
assign s1_b_id[3:0] 	= w_fpga2sdram1_rsp_data[119:116];
assign s1_b_resp[1:0] 	= w_fpga2sdram1_rsp_data[121:120];
assign s1_b_valid 	= w_fpga2sdram1_b_valid;
assign s1_r_data[31:0] 	= w_fpga2sdram1_rsp_data[31:0];
assign s1_r_data[63:32] 	= w_fpga2sdram1_rsp_data[63:32];
assign s1_r_id[2:0] 	= w_fpga2sdram1_rsp_trid[2:0];
assign s1_r_id[3] 	= w_fpga2sdram1_rsp_cont;
assign s1_r_last 	= w_fpga2sdram1_rsp_last;
assign s1_r_resp[1:0] 	= w_fpga2sdram1_rsp_status[1:0];
assign s1_r_valid 	= w_fpga2sdram1_rsp_vld;
assign s1_w_ready 	= w_fpga2sdram1_req_rdy;

assign w_fpga2sdram1_ar_valid 	= s1_ar_valid;
assign w_fpga2sdram1_aw_valid 	= s1_aw_valid;
assign w_fpga2sdram1_b_ready 	= s1_b_ready;
assign w_fpga2sdram1_req_addr[31:0] 	= s1_aw_addr[31:0];
assign w_fpga2sdram1_req_be[11:8] 	= s1_ar_cache[3:0];
assign w_fpga2sdram1_req_be[15:12] 	= s1_ar_id[3:0];
assign w_fpga2sdram1_req_be[3:0] 	= s1_w_strb[3:0];
assign w_fpga2sdram1_req_be[7:4] 	= s1_w_strb[7:4];
assign w_fpga2sdram1_req_data[127:96] 	= s1_ar_addr[31:0];
assign w_fpga2sdram1_req_data[31:0] 	= s1_w_data[31:0];
assign w_fpga2sdram1_req_data[63:32] 	= s1_w_data[63:32];
assign w_fpga2sdram1_req_data[87:86] 	= s1_ar_lock[1:0];
assign w_fpga2sdram1_req_data[90:88] 	= s1_ar_size[2:0];
assign w_fpga2sdram1_req_data[95:91] 	= s1_ar_user[4:0];
assign w_fpga2sdram1_req_exclid[3:0] 	= s1_w_id[3:0];
assign w_fpga2sdram1_req_hurry[1:0] 	= s1_aw_lock[1:0];
assign w_fpga2sdram1_req_last 	= s1_w_last;
assign w_fpga2sdram1_req_length[3:0] 	= s1_aw_len[3:0];
assign w_fpga2sdram1_req_length[7:4] 	= s1_ar_len[3:0];
assign w_fpga2sdram1_req_opc[2:0] 	= s1_aw_size[2:0];
assign w_fpga2sdram1_req_press[1:0] 	= s1_aw_burst[1:0];
assign w_fpga2sdram1_req_seqid[3:0] 	= s1_aw_id[3:0];
assign w_fpga2sdram1_req_trid[2:0] 	= s1_ar_prot[2:0];
assign w_fpga2sdram1_req_urgency[1:0] 	= s1_ar_burst[1:0];
assign w_fpga2sdram1_req_user[11:7] 	= s1_aw_user[4:0];
assign w_fpga2sdram1_req_user[3:0] 	= s1_aw_cache[3:0];
assign w_fpga2sdram1_req_user[6:4] 	= s1_aw_prot[2:0];
assign w_fpga2sdram1_req_vld 	= s1_w_valid;
assign w_fpga2sdram1_rsp_rdy 	= s1_r_ready;


assign fpga2sdram0_ar_ready 	= w_fpga2sdram0_ar_ready;
assign fpga2sdram0_aw_ready 	= w_fpga2sdram0_aw_ready;
assign fpga2sdram0_b_id[3:0] 	= w_fpga2sdram0_rsp_data[125:122];
assign fpga2sdram0_b_resp[1:0] 	= w_fpga2sdram0_rsp_data[127:126];
assign fpga2sdram0_b_valid 	= w_fpga2sdram0_b_valid;
assign fpga2sdram0_r_data[31:0] 	= w_fpga2sdram0_rsp_data[31:0];
assign fpga2sdram0_r_data[63:32] 	= w_fpga2sdram0_rsp_data[63:32];
assign fpga2sdram0_r_id[2:0] 	= w_fpga2sdram0_rsp_trid[2:0];
assign fpga2sdram0_r_id[3] 	= w_fpga2sdram0_rsp_cont;
assign fpga2sdram0_r_last 	= w_fpga2sdram0_rsp_last;
assign fpga2sdram0_r_resp[1:0] 	= w_fpga2sdram0_rsp_status[1:0];
assign fpga2sdram0_r_valid 	= w_fpga2sdram0_rsp_vld;
assign fpga2sdram0_w_ready 	= w_fpga2sdram0_req_rdy;
assign fpga2sdram2_ar_ready 	= w_fpga2sdram2_ar_ready;
assign fpga2sdram2_aw_ready 	= w_fpga2sdram2_aw_ready;
assign fpga2sdram2_b_id[3:0] 	= w_fpga2sdram2_rsp_data[67:64];
assign fpga2sdram2_b_resp[1:0] 	= w_fpga2sdram2_rsp_data[69:68];
assign fpga2sdram2_b_valid 	= w_fpga2sdram2_b_valid;
assign fpga2sdram2_r_data[31:0] 	= w_fpga2sdram2_rsp_data[31:0];
assign fpga2sdram2_r_data[63:32] 	= w_fpga2sdram2_rsp_data[63:32];
assign fpga2sdram2_r_id[2:0] 	= w_fpga2sdram2_rsp_trid[2:0];
assign fpga2sdram2_r_id[3] 	= w_fpga2sdram2_rsp_cont;
assign fpga2sdram2_r_last 	= w_fpga2sdram2_rsp_last;
assign fpga2sdram2_r_resp[1:0] 	= w_fpga2sdram2_rsp_status[1:0];
assign fpga2sdram2_r_valid 	= w_fpga2sdram2_rsp_vld;
assign fpga2sdram2_w_ready 	= w_fpga2sdram2_req_rdy;
assign w_fpga2sdram0_ar_valid 	= fpga2sdram0_ar_valid;
assign w_fpga2sdram0_aw_valid 	= fpga2sdram0_aw_valid;
assign w_fpga2sdram0_b_ready 	= fpga2sdram0_b_ready;
assign w_fpga2sdram0_req_addr[31:0] 	= fpga2sdram0_aw_addr[31:0];
assign w_fpga2sdram0_req_be[11:8] 	= fpga2sdram0_ar_cache[3:0];
assign w_fpga2sdram0_req_be[15:12] 	= fpga2sdram0_ar_id[3:0];
assign w_fpga2sdram0_req_be[3:0] 	= fpga2sdram0_w_strb[3:0];
assign w_fpga2sdram0_req_be[7:4] 	= fpga2sdram0_w_strb[7:4];
assign w_fpga2sdram0_req_data[127:96] 	= fpga2sdram0_ar_addr[31:0];
assign w_fpga2sdram0_req_data[31:0] 	= fpga2sdram0_w_data[31:0];
assign w_fpga2sdram0_req_data[63:32] 	= fpga2sdram0_w_data[63:32];
assign w_fpga2sdram0_req_data[87:86] 	= fpga2sdram0_ar_lock[1:0];
assign w_fpga2sdram0_req_data[90:88] 	= fpga2sdram0_ar_size[2:0];
assign w_fpga2sdram0_req_data[95:91] 	= fpga2sdram0_ar_user[4:0];
assign w_fpga2sdram0_req_data[85:64] 	= 22'b1111111111111111111111;
assign w_fpga2sdram0_req_exclid[3:0] 	= fpga2sdram0_w_id[3:0];
assign w_fpga2sdram0_req_hurry[1:0] 	= fpga2sdram0_aw_lock[1:0];
assign w_fpga2sdram0_req_last 	= fpga2sdram0_w_last;
assign w_fpga2sdram0_req_length[3:0] 	= fpga2sdram0_aw_len[3:0];
assign w_fpga2sdram0_req_length[7:4] 	= fpga2sdram0_ar_len[3:0];
assign w_fpga2sdram0_req_opc[2:0] 	= fpga2sdram0_aw_size[2:0];
assign w_fpga2sdram0_req_press[1:0] 	= fpga2sdram0_aw_burst[1:0];
assign w_fpga2sdram0_req_seqid[3:0] 	= fpga2sdram0_aw_id[3:0];
assign w_fpga2sdram0_req_trid[2:0] 	= fpga2sdram0_ar_prot[2:0];
assign w_fpga2sdram0_req_urgency[1:0] 	= fpga2sdram0_ar_burst[1:0];
assign w_fpga2sdram0_req_user[11:7] 	= fpga2sdram0_aw_user[4:0];
assign w_fpga2sdram0_req_user[3:0] 	= fpga2sdram0_aw_cache[3:0];
assign w_fpga2sdram0_req_user[6:4] 	= fpga2sdram0_aw_prot[2:0];
assign w_fpga2sdram0_req_vld 	= fpga2sdram0_w_valid;
assign w_fpga2sdram0_rsp_rdy 	= fpga2sdram0_r_ready;
assign w_fpga2sdram2_ar_valid 	= fpga2sdram2_ar_valid;
assign w_fpga2sdram2_aw_valid 	= fpga2sdram2_aw_valid;
assign w_fpga2sdram2_b_ready 	= fpga2sdram2_b_ready;
assign w_fpga2sdram2_req_addr[31:0] 	= fpga2sdram2_aw_addr[31:0];

assign w_fpga2sdram2_req_be[3:0] 	= fpga2sdram2_w_strb[3:0];
assign w_fpga2sdram2_req_be[7:4] 	= fpga2sdram2_w_strb[7:4];
assign w_fpga2sdram2_req_be[11:8] 	= fpga2sdram2_ar_cache[3:0];
assign w_fpga2sdram2_req_be[15:12] 	= fpga2sdram2_ar_id[3:0];

assign w_fpga2sdram2_req_data[31:0] 	= fpga2sdram2_w_data[31:0];
assign w_fpga2sdram2_req_data[63:32] 	= fpga2sdram2_w_data[63:32];

assign w_fpga2sdram2_req_data[85:64] 	= 22'b0000000000000000000000;

assign w_fpga2sdram2_req_data[87:86] 	= fpga2sdram2_ar_lock[1:0];
assign w_fpga2sdram2_req_data[90:88] 	= fpga2sdram2_ar_size[2:0];
assign w_fpga2sdram2_req_data[95:91] 	= fpga2sdram2_ar_user[4:0];
assign w_fpga2sdram2_req_data[127:96] 	= fpga2sdram2_ar_addr[31:0];

assign w_fpga2sdram2_req_exclid[3:0] 	= fpga2sdram2_w_id[3:0];
assign w_fpga2sdram2_req_hurry[1:0] 	= fpga2sdram2_aw_lock[1:0];
assign w_fpga2sdram2_req_last 	= fpga2sdram2_w_last;
assign w_fpga2sdram2_req_length[3:0] 	= fpga2sdram2_aw_len[3:0];
assign w_fpga2sdram2_req_length[7:4] 	= fpga2sdram2_ar_len[3:0];
assign w_fpga2sdram2_req_opc[2:0] 	= fpga2sdram2_aw_size[2:0];
assign w_fpga2sdram2_req_press[1:0] 	= fpga2sdram2_aw_burst[1:0];
assign w_fpga2sdram2_req_seqid[3:0] 	= fpga2sdram2_aw_id[3:0];
assign w_fpga2sdram2_req_trid[2:0] 	= fpga2sdram2_ar_prot[2:0];
assign w_fpga2sdram2_req_urgency[1:0] 	= fpga2sdram2_ar_burst[1:0];
assign w_fpga2sdram2_req_user[11:7] 	= fpga2sdram2_aw_user[4:0];
assign w_fpga2sdram2_req_user[3:0] 	= fpga2sdram2_aw_cache[3:0];
assign w_fpga2sdram2_req_user[6:4] 	= fpga2sdram2_aw_prot[2:0];
assign w_fpga2sdram2_req_vld 	= fpga2sdram2_w_valid;
assign w_fpga2sdram2_rsp_rdy 	= fpga2sdram2_r_ready;



f2s_rl_delay_adp #( .DWIDTH(DWIDTH1), .DEPTH(DEPTH) ) f2s_rl_adp_inst_1 (
	.clk(  f2s_sdram1_ar_clk ),
	.f_ar_addr( fpga2sdram1_ar_addr ),
	.f_ar_burst( fpga2sdram1_ar_burst ),
	.f_ar_cache( fpga2sdram1_ar_cache ),
	.f_ar_id( fpga2sdram1_ar_id ),
	.f_ar_len( fpga2sdram1_ar_len ),
	.f_ar_lock( fpga2sdram1_ar_lock ),
	.f_ar_prot( fpga2sdram1_ar_prot ),
	.f_ar_size( fpga2sdram1_ar_size ),
	.f_ar_user( fpga2sdram1_ar_user ),
	.f_ar_valid( fpga2sdram1_ar_valid ),
	.f_aw_addr( fpga2sdram1_aw_addr ),
	.f_aw_burst( fpga2sdram1_aw_burst ),
	.f_aw_cache( fpga2sdram1_aw_cache ),
	.f_aw_id( fpga2sdram1_aw_id ),
	.f_aw_len( fpga2sdram1_aw_len ),
	.f_aw_lock( fpga2sdram1_aw_lock ),
	.f_aw_prot( fpga2sdram1_aw_prot ),
	.f_aw_size( fpga2sdram1_aw_size ),
	.f_aw_user( fpga2sdram1_aw_user ),
	.f_aw_valid( fpga2sdram1_aw_valid ),
	.f_b_ready( fpga2sdram1_b_ready ),
	.f_r_ready( fpga2sdram1_r_ready ),
	.f_w_data( fpga2sdram1_w_data ),
	.f_w_id( fpga2sdram1_w_id ),
	.f_w_last( fpga2sdram1_w_last ),
	.f_w_strb( fpga2sdram1_w_strb ),
	.f_w_valid( fpga2sdram1_w_valid ),
	.rst_n( f2s_sdram1_rst_n ),
	.s_ar_ready( s1_ar_ready ),
	.s_aw_ready( s1_aw_ready ),
	.s_b_id( s1_b_id ),
	.s_b_resp( s1_b_resp ),
	.s_b_valid( s1_b_valid ),
	.s_r_data( s1_r_data ),
	.s_r_id( s1_r_id ),
	.s_r_last( s1_r_last ),
	.s_r_resp( s1_r_resp ),
	.s_r_valid( s1_r_valid ),
	.s_ready_latency( fpga2sdram_port_size_config[3] ),
	.s_w_ready( s1_w_ready ),
	.f_ar_ready( fpga2sdram1_ar_ready ),
	.f_aw_ready( fpga2sdram1_aw_ready ),
	.f_b_id( fpga2sdram1_b_id ),
	.f_b_resp( fpga2sdram1_b_resp ),
	.f_b_valid( fpga2sdram1_b_valid ),
	.f_r_data( fpga2sdram1_r_data ),
	.f_r_id(   fpga2sdram1_r_id ),
	.f_r_last( fpga2sdram1_r_last ),
	.f_r_resp( fpga2sdram1_r_resp ),
	.f_r_valid( fpga2sdram1_r_valid ),
	.f_w_ready( fpga2sdram1_w_ready ),
	.s_ar_addr( s1_ar_addr ),
	.s_ar_burst( s1_ar_burst ),
	.s_ar_cache( s1_ar_cache ),
	.s_ar_id( s1_ar_id ),
	.s_ar_len( s1_ar_len ),
	.s_ar_lock( s1_ar_lock ),
	.s_ar_prot( s1_ar_prot ),
	.s_ar_size( s1_ar_size ),
	.s_ar_user( s1_ar_user ),
	.s_ar_valid( s1_ar_valid ),
	.s_aw_addr( s1_aw_addr ),
	.s_aw_burst( s1_aw_burst ),
	.s_aw_cache( s1_aw_cache ),
	.s_aw_id( s1_aw_id ),
	.s_aw_len( s1_aw_len ),
	.s_aw_lock( s1_aw_lock ),
	.s_aw_prot( s1_aw_prot ),
	.s_aw_size( s1_aw_size ),
	.s_aw_user( s1_aw_user ),
	.s_aw_valid( s1_aw_valid ),
	.s_b_ready( s1_b_ready ),
	.s_r_ready( s1_r_ready ),
	.s_w_data( s1_w_data ),
	.s_w_id( s1_w_id ),
	.s_w_last( s1_w_last ),
	.s_w_strb( s1_w_strb ),
	.s_w_valid( s1_w_valid )
);

twentynm_hps_interface_fpga2sdram fpga2sdram_1es_instance(
  .f2s_sdram0_ar_clk(f2s_sdram0_ar_clk),
  .f2s_sdram0_aw_clk(f2s_sdram0_aw_clk),
  .f2s_sdram0_b_clk(f2s_sdram0_b_clk),
  .f2s_sdram0_clk(f2s_sdram0_clk),
  .f2s_sdram0_r_clk(f2s_sdram0_r_clk),
  .f2s_sdram0_w_clk(f2s_sdram0_w_clk),
  .f2s_sdram1_ar_clk(f2s_sdram1_ar_clk),
  .f2s_sdram1_aw_clk(f2s_sdram1_aw_clk),
  .f2s_sdram1_b_clk(f2s_sdram1_b_clk),
  .f2s_sdram1_clk(f2s_sdram1_clk),
  .f2s_sdram1_r_clk(f2s_sdram1_r_clk),
  .f2s_sdram1_w_clk(f2s_sdram1_w_clk),
  .f2s_sdram2_ar_clk(f2s_sdram2_ar_clk),
  .f2s_sdram2_aw_clk(f2s_sdram2_aw_clk),
  .f2s_sdram2_b_clk(f2s_sdram2_b_clk),
  .f2s_sdram2_clk(f2s_sdram2_clk),
  .f2s_sdram2_r_clk(f2s_sdram2_r_clk),
  .f2s_sdram2_w_clk(f2s_sdram2_w_clk),
  .fpga2sdram_port_size_config(fpga2sdram_port_size_config),
  .fpga2sdram0_ar_ready(w_fpga2sdram0_ar_ready),
  .fpga2sdram0_ar_valid(w_fpga2sdram0_ar_valid),
  .fpga2sdram0_aw_ready(w_fpga2sdram0_aw_ready),
  .fpga2sdram0_aw_valid(w_fpga2sdram0_aw_valid),
  .fpga2sdram0_b_ready(w_fpga2sdram0_b_ready),
  .fpga2sdram0_b_valid(w_fpga2sdram0_b_valid),
  .fpga2sdram0_req_addr(w_fpga2sdram0_req_addr),
  .fpga2sdram0_req_be(w_fpga2sdram0_req_be),
  .fpga2sdram0_req_data(w_fpga2sdram0_req_data),
  .fpga2sdram0_req_exclid(w_fpga2sdram0_req_exclid),
  .fpga2sdram0_req_hurry(w_fpga2sdram0_req_hurry),
  .fpga2sdram0_req_last(w_fpga2sdram0_req_last),
  .fpga2sdram0_req_length(w_fpga2sdram0_req_length),
  .fpga2sdram0_req_opc(w_fpga2sdram0_req_opc),
  .fpga2sdram0_req_press(w_fpga2sdram0_req_press),
  .fpga2sdram0_req_rdy(w_fpga2sdram0_req_rdy),
  .fpga2sdram0_req_seqid(w_fpga2sdram0_req_seqid),
  .fpga2sdram0_req_trid(w_fpga2sdram0_req_trid),
  .fpga2sdram0_req_urgency(w_fpga2sdram0_req_urgency),
  .fpga2sdram0_req_user(w_fpga2sdram0_req_user),
  .fpga2sdram0_req_vld(w_fpga2sdram0_req_vld),
  .fpga2sdram0_rsp_cont(w_fpga2sdram0_rsp_cont),
  .fpga2sdram0_rsp_data(w_fpga2sdram0_rsp_data),
  .fpga2sdram0_rsp_last(w_fpga2sdram0_rsp_last),
  .fpga2sdram0_rsp_rdy(w_fpga2sdram0_rsp_rdy),
  .fpga2sdram0_rsp_status(w_fpga2sdram0_rsp_status),
  .fpga2sdram0_rsp_trid(w_fpga2sdram0_rsp_trid),
  .fpga2sdram0_rsp_vld(w_fpga2sdram0_rsp_vld),
  .fpga2sdram1_ar_ready(w_fpga2sdram1_ar_ready),
  .fpga2sdram1_ar_valid(w_fpga2sdram1_ar_valid),
  .fpga2sdram1_aw_ready(w_fpga2sdram1_aw_ready),
  .fpga2sdram1_aw_valid(w_fpga2sdram1_aw_valid),
  .fpga2sdram1_b_ready(w_fpga2sdram1_b_ready),
  .fpga2sdram1_b_valid(w_fpga2sdram1_b_valid),
  .fpga2sdram1_req_addr(w_fpga2sdram1_req_addr),
  .fpga2sdram1_req_be(w_fpga2sdram1_req_be),
  .fpga2sdram1_req_data(w_fpga2sdram1_req_data),
  .fpga2sdram1_req_exclid(w_fpga2sdram1_req_exclid),
  .fpga2sdram1_req_hurry(w_fpga2sdram1_req_hurry),
  .fpga2sdram1_req_last(w_fpga2sdram1_req_last),
  .fpga2sdram1_req_length(w_fpga2sdram1_req_length),
  .fpga2sdram1_req_opc(w_fpga2sdram1_req_opc),
  .fpga2sdram1_req_press(w_fpga2sdram1_req_press),
  .fpga2sdram1_req_rdy(w_fpga2sdram1_req_rdy),
  .fpga2sdram1_req_seqid(w_fpga2sdram1_req_seqid),
  .fpga2sdram1_req_trid(w_fpga2sdram1_req_trid),
  .fpga2sdram1_req_urgency(w_fpga2sdram1_req_urgency),
  .fpga2sdram1_req_user(w_fpga2sdram1_req_user),
  .fpga2sdram1_req_vld(w_fpga2sdram1_req_vld),
  .fpga2sdram1_rsp_cont(w_fpga2sdram1_rsp_cont),
  .fpga2sdram1_rsp_data(w_fpga2sdram1_rsp_data),
  .fpga2sdram1_rsp_last(w_fpga2sdram1_rsp_last),
  .fpga2sdram1_rsp_rdy(w_fpga2sdram1_rsp_rdy),
  .fpga2sdram1_rsp_status(w_fpga2sdram1_rsp_status),
  .fpga2sdram1_rsp_trid(w_fpga2sdram1_rsp_trid),
  .fpga2sdram1_rsp_vld(w_fpga2sdram1_rsp_vld),
  .fpga2sdram2_ar_ready(w_fpga2sdram2_ar_ready),
  .fpga2sdram2_ar_valid(w_fpga2sdram2_ar_valid),
  .fpga2sdram2_aw_ready(w_fpga2sdram2_aw_ready),
  .fpga2sdram2_aw_valid(w_fpga2sdram2_aw_valid),
  .fpga2sdram2_b_ready(w_fpga2sdram2_b_ready),
  .fpga2sdram2_b_valid(w_fpga2sdram2_b_valid),
  .fpga2sdram2_req_addr(w_fpga2sdram2_req_addr),
  .fpga2sdram2_req_be(w_fpga2sdram2_req_be),
  .fpga2sdram2_req_data(w_fpga2sdram2_req_data),
  .fpga2sdram2_req_exclid(w_fpga2sdram2_req_exclid),
  .fpga2sdram2_req_hurry(w_fpga2sdram2_req_hurry),
  .fpga2sdram2_req_last(w_fpga2sdram2_req_last),
  .fpga2sdram2_req_length(w_fpga2sdram2_req_length),
  .fpga2sdram2_req_opc(w_fpga2sdram2_req_opc),
  .fpga2sdram2_req_press(w_fpga2sdram2_req_press),
  .fpga2sdram2_req_rdy(w_fpga2sdram2_req_rdy),
  .fpga2sdram2_req_seqid(w_fpga2sdram2_req_seqid),
  .fpga2sdram2_req_trid(w_fpga2sdram2_req_trid),
  .fpga2sdram2_req_urgency(w_fpga2sdram2_req_urgency),
  .fpga2sdram2_req_user(w_fpga2sdram2_req_user),
  .fpga2sdram2_req_vld(w_fpga2sdram2_req_vld),
  .fpga2sdram2_rsp_cont(w_fpga2sdram2_rsp_cont),
  .fpga2sdram2_rsp_data(w_fpga2sdram2_rsp_data),
  .fpga2sdram2_rsp_last(w_fpga2sdram2_rsp_last),
  .fpga2sdram2_rsp_rdy(w_fpga2sdram2_rsp_rdy),
  .fpga2sdram2_rsp_status(w_fpga2sdram2_rsp_status),
  .fpga2sdram2_rsp_trid(w_fpga2sdram2_rsp_trid),
  .fpga2sdram2_rsp_vld(w_fpga2sdram2_rsp_vld)
);
defparam fpga2sdram_1es_instance.mode = mode;

endmodule


//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
`timescale 1 ps / 1 ps
module f2s_rl_delay_adp #(
  parameter DWIDTH = 16,
  parameter DEPTH=4
) (
  input                     clk,
  input              [31:0] f_ar_addr,
  input               [1:0] f_ar_burst,
  input               [3:0] f_ar_cache,
  input               [3:0] f_ar_id,
  input               [3:0] f_ar_len,
  input               [1:0] f_ar_lock,
  input               [2:0] f_ar_prot,
  input               [2:0] f_ar_size,
  input               [4:0] f_ar_user,
  input                     f_ar_valid,
  input              [31:0] f_aw_addr,
  input               [1:0] f_aw_burst,
  input               [3:0] f_aw_cache,
  input               [3:0] f_aw_id,
  input               [3:0] f_aw_len,
  input               [1:0] f_aw_lock,
  input               [2:0] f_aw_prot,
  input               [2:0] f_aw_size,
  input               [4:0] f_aw_user,
  input                     f_aw_valid,
  input                     f_b_ready,
  input                     f_r_ready,
  input        [DWIDTH-1:0] f_w_data,
  input               [3:0] f_w_id,
  input                     f_w_last,
  input      [DWIDTH/8-1:0] f_w_strb,
  input                     f_w_valid,
  input                     rst_n,
  input                     s_ar_ready,
  input                     s_aw_ready,
  input               [3:0] s_b_id,
  input               [1:0] s_b_resp,
  input                     s_b_valid,
  input        [DWIDTH-1:0] s_r_data,
  input               [3:0] s_r_id,
  input                     s_r_last,
  input               [1:0] s_r_resp,
  input                     s_r_valid,
  input                     s_ready_latency,
  input                     s_w_ready,
  output                    f_ar_ready,
  output                    f_aw_ready,
  output              [3:0] f_b_id,
  output              [1:0] f_b_resp,
  output                    f_b_valid,
  output       [DWIDTH-1:0] f_r_data,
  output              [3:0] f_r_id,
  output                    f_r_last,
  output              [1:0] f_r_resp,
  output                    f_r_valid,
  output                    f_w_ready,
  output             [31:0] s_ar_addr,
  output              [1:0] s_ar_burst,
  output              [3:0] s_ar_cache,
  output              [3:0] s_ar_id,
  output              [3:0] s_ar_len,
  output              [1:0] s_ar_lock,
  output              [2:0] s_ar_prot,
  output              [2:0] s_ar_size,
  output              [4:0] s_ar_user,
  output                    s_ar_valid,
  output             [31:0] s_aw_addr,
  output              [1:0] s_aw_burst,
  output              [3:0] s_aw_cache,
  output              [3:0] s_aw_id,
  output              [3:0] s_aw_len,
  output              [1:0] s_aw_lock,
  output              [2:0] s_aw_prot,
  output              [2:0] s_aw_size,
  output              [4:0] s_aw_user,
  output                    s_aw_valid,
  output                    s_b_ready,
  output                    s_r_ready,
  output       [DWIDTH-1:0] s_w_data,
  output              [3:0] s_w_id,
  output                    s_w_last,
  output     [DWIDTH/8-1:0] s_w_strb,
  output                    s_w_valid
);
wire [DWIDTH-1 : 0] d_w_data;
wire [32-1 : 0] d_aw_addr;
wire [32-1 : 0] d_ar_addr;
wire [ 4-1 : 0] d_ar_cache;
wire [ 4-1 : 0] d_ar_id;
wire [ 4-1 : 0] d_ar_len;
wire [ 5-1 : 0] d_ar_user;
wire [ 4-1 : 0] d_aw_cache;
wire [ 4-1 : 0] d_aw_id;
wire [ 4-1 : 0] d_aw_len;
wire [ 5-1 : 0] d_aw_user;
wire [ 4-1 : 0] d_w_id;

wire         ds_r_ready;
wire         ds_ar_valid;
wire         ds_b_ready;
wire         ds_aw_valid;
wire         ds_w_last;
wire [DWIDTH/8-1:0]  ds_w_strb;
wire         ds_w_valid;
wire   [1:0] ds_ar_burst;
wire   [1:0] ds_ar_lock;
wire   [1:0] ds_aw_burst;
wire   [1:0] ds_aw_lock;
wire   [2:0] ds_ar_prot;
wire   [2:0] ds_ar_size;
wire   [2:0] ds_aw_prot;
wire   [2:0] ds_aw_size;

generate
if (DWIDTH != 16) begin
    alentar#(.DATA_WIDTH(DWIDTH), .DEPTH(DEPTH)) wdata_alen (d_w_data,  s_w_data);
    alentar#(.DATA_WIDTH(32), .DEPTH(DEPTH))  awaddr_alen   (d_aw_addr, s_aw_addr);
    alentar#(.DATA_WIDTH(32), .DEPTH(DEPTH))  araddr_alen   (d_ar_addr, s_ar_addr);
    alentar#(.DATA_WIDTH( 4), .DEPTH(DEPTH))  ar_cache_alen (d_ar_cache,s_ar_cache);
    alentar#(.DATA_WIDTH( 4), .DEPTH(DEPTH))  ar_id_alen    (d_ar_id,   s_ar_id);
    alentar#(.DATA_WIDTH( 4), .DEPTH(DEPTH))  ar_len_alen   (d_ar_len,  s_ar_len);
    alentar#(.DATA_WIDTH( 5), .DEPTH(DEPTH))  ar_ar_user    (d_ar_user, s_ar_user);
    alentar#(.DATA_WIDTH( 4), .DEPTH(DEPTH))  aw_cache_alen (d_aw_cache,s_aw_cache);
    alentar#(.DATA_WIDTH( 4), .DEPTH(DEPTH))  aw_id_alen    (d_aw_id,   s_aw_id);
    alentar#(.DATA_WIDTH( 4), .DEPTH(DEPTH))  aw_len_alen   (d_aw_len,  s_aw_len);
    alentar#(.DATA_WIDTH( 5), .DEPTH(DEPTH))  aw_ar_user    (d_aw_user, s_aw_user);
    alentar#(.DATA_WIDTH( 4), .DEPTH(DEPTH))  w_id_alen     (d_w_id,    s_w_id);
    
    alentar#(.DATA_WIDTH( 2), .DEPTH(DEPTH))  ar_burst_alen  (ds_ar_burst, s_ar_burst  );
    alentar#(.DATA_WIDTH( 2), .DEPTH(DEPTH))  ar_lock_alen   (ds_ar_lock,s_ar_lock   );
    alentar#(.DATA_WIDTH( 2), .DEPTH(DEPTH))  aw_burst_alen  (ds_aw_burst, s_aw_burst  );
    alentar#(.DATA_WIDTH( 2), .DEPTH(DEPTH))  aw_lock_alen   (ds_aw_lock,s_aw_lock   );
    alentar#(.DATA_WIDTH( 3), .DEPTH(DEPTH))  ar_prot_alen   (ds_ar_prot, s_ar_prot  );
    alentar#(.DATA_WIDTH( 3), .DEPTH(DEPTH))  ar_size_alen   (ds_ar_size,s_ar_size   );
    alentar#(.DATA_WIDTH( 3), .DEPTH(DEPTH))  aw_prot_alen   (ds_aw_prot, s_aw_prot  );
    alentar#(.DATA_WIDTH( 3), .DEPTH(DEPTH))  aw_size_alen   (ds_aw_size,s_aw_size   );
    
    alentar#(.DATA_WIDTH( 1), .DEPTH(DEPTH))  aw_valid_alen  (ds_aw_valid,  s_aw_valid);
    alentar#(.DATA_WIDTH( 1), .DEPTH(DEPTH))  w_last_alen    (ds_w_last,    s_w_last);
    alentar#(.DATA_WIDTH( 1), .DEPTH(DEPTH))  r_ready_alen   (ds_r_ready,   s_r_ready);
    alentar#(.DATA_WIDTH( 1), .DEPTH(DEPTH))  ar_valid_alen  (ds_ar_valid,  s_ar_valid);
    alentar#(.DATA_WIDTH( 1), .DEPTH(DEPTH))  b_ready_alen   (ds_b_ready,   s_b_ready);

    alentar#(.DATA_WIDTH(DWIDTH/8), .DEPTH(DEPTH))  w_strb_alen   (ds_w_strb,   s_w_strb);
    alentar#(.DATA_WIDTH( 1), .DEPTH(DEPTH))  _w_valid_alen   (ds_w_valid,   s_w_valid);
    
    
end
else begin
    assign s_w_data  = d_w_data; 
    assign s_aw_addr = d_aw_addr;
    assign s_ar_addr = d_ar_addr;
    assign s_ar_cache= d_ar_cache; 
    assign s_ar_id   = d_ar_id;    
    assign s_ar_len  = d_ar_len;   
    assign s_ar_user = d_ar_user;  
    assign s_aw_cache= d_aw_cache; 
    assign s_aw_id   = d_aw_id;    
    assign s_aw_len  = d_aw_len;   
    assign s_aw_user = d_aw_user;   
    assign s_w_id    = d_w_id;
    
    assign s_b_ready  = ds_b_ready;
    assign s_ar_valid = ds_ar_valid;
    assign s_b_ready  = ds_b_ready;
    
    assign s_r_ready =  ds_r_ready; 
    assign s_ar_valid = ds_ar_valid;
    assign s_b_ready =  ds_b_ready; 
    assign s_aw_valid = ds_aw_valid;
    assign s_w_last =   ds_w_last;  
    assign s_ar_burst = ds_ar_burst;
    assign s_ar_lock =  ds_ar_lock; 
    assign s_aw_burst = ds_aw_burst;
    assign s_aw_lock =  ds_aw_lock; 
    assign s_ar_prot =  ds_ar_prot; 
    assign s_ar_size =  ds_ar_size; 
    assign s_aw_prot =  ds_aw_prot; 
    assign s_aw_size =  ds_aw_size; 
    assign s_w_strb  =  ds_w_strb;
    assign s_w_valid =  ds_w_valid;
end       
endgenerate
f2s_rl_adp #( .DWIDTH(DWIDTH) ) f2s_rl_adp_inst (
	.clk( clk ),
	.f_ar_addr( f_ar_addr ),
	.f_ar_burst( f_ar_burst ),
	.f_ar_cache( f_ar_cache ),
	.f_ar_id( f_ar_id ),
	.f_ar_len( f_ar_len ),
	.f_ar_lock( f_ar_lock ),
	.f_ar_prot( f_ar_prot ),
	.f_ar_size( f_ar_size ),
	.f_ar_user( f_ar_user ),
	.f_ar_valid( f_ar_valid ),
	.f_aw_addr( f_aw_addr ),
	.f_aw_burst( f_aw_burst ),
	.f_aw_cache( f_aw_cache ),
	.f_aw_id( f_aw_id ),
	.f_aw_len( f_aw_len ),
	.f_aw_lock( f_aw_lock ),
	.f_aw_prot( f_aw_prot ),
	.f_aw_size( f_aw_size ),
	.f_aw_user( f_aw_user ),
	.f_aw_valid( f_aw_valid ),
	.f_b_ready( f_b_ready ),
	.f_r_ready( f_r_ready ),
	.f_w_data( f_w_data ),
	.f_w_id( f_w_id ),
	.f_w_last( f_w_last ),
	.f_w_strb( f_w_strb ),
	.f_w_valid( f_w_valid ),
	.rst_n( rst_n ),
	.s_ar_ready( s_ar_ready ),
	.s_aw_ready( s_aw_ready ),
	.s_b_id( s_b_id ),
	.s_b_resp( s_b_resp ),
	.s_b_valid( s_b_valid ),
	.s_r_data( s_r_data ),
	.s_r_id( s_r_id ),
	.s_r_last( s_r_last ),
	.s_r_resp( s_r_resp ),
	.s_r_valid( s_r_valid ),
	.s_ready_latency( s_ready_latency ),
	.s_w_ready( s_w_ready ),
	.f_ar_ready( f_ar_ready ),
	.f_aw_ready( f_aw_ready ),
	.f_b_id( f_b_id ),
	.f_b_resp( f_b_resp ),
	.f_b_valid( f_b_valid ),
	.f_r_data( f_r_data ),
	.f_r_id( f_r_id ),
	.f_r_last( f_r_last ),
	.f_r_resp( f_r_resp ),
	.f_r_valid( f_r_valid ),
	.f_w_ready( f_w_ready ),
	.s_ar_addr( d_ar_addr ),
	.s_ar_burst( ds_ar_burst ),
	.s_ar_cache( d_ar_cache ),
	.s_ar_id( d_ar_id ),
	.s_ar_len( d_ar_len ),
	.s_ar_lock( ds_ar_lock ),
	.s_ar_prot( ds_ar_prot ),
	.s_ar_size( ds_ar_size ),
	.s_ar_user( d_ar_user ),
	.s_ar_valid( ds_ar_valid ),
	.s_aw_addr( d_aw_addr ),
	.s_aw_burst( ds_aw_burst ),
	.s_aw_cache( d_aw_cache ),
	.s_aw_id( d_aw_id ),
	.s_aw_len( d_aw_len ),
	.s_aw_lock( ds_aw_lock ),
	.s_aw_prot( ds_aw_prot ),
	.s_aw_size( ds_aw_size ),
	.s_aw_user( d_aw_user ),
	.s_aw_valid( ds_aw_valid ),
	.s_b_ready( ds_b_ready ),
	.s_r_ready( ds_r_ready ),
	.s_w_data( d_w_data ),
	.s_w_id( d_w_id ),
	.s_w_last( ds_w_last ),
	.s_w_strb( ds_w_strb ),
	.s_w_valid( ds_w_valid )
);
endmodule


//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
`timescale 1 ps / 1 ps
module alentar #(parameter DATA_WIDTH=128, parameter DEPTH=3) (
  input [DATA_WIDTH-1:0] enter,
  output [DATA_WIDTH-1:0] exit);

  genvar i;
  genvar j;

  generate
    for (i=0; i<DATA_WIDTH; i=i+1) begin: dataw

      wire [DEPTH:0] connect;

      assign connect[0] = enter[i];
      assign exit[i] = connect[DEPTH];

      for (j=0; j<DEPTH; j=j+1) begin: lcell
        twentynm_lcell_comb wireluta( .dataa(connect[j]), .combout(connect[j+1]) );
            defparam wireluta.lut_mask   = 64'hAAAAAAAAAAAAAAAA ;
            defparam wireluta.dont_touch = "on";		  
      end//lcell

    end//dataw
  endgenerate
endmodule
