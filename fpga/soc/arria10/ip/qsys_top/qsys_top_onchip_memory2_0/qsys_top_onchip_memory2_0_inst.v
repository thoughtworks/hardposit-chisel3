	qsys_top_onchip_memory2_0 u0 (
		.clk         (_connected_to_clk_),         //   input,   width = 1,   clk1.clk
		.address     (_connected_to_address_),     //   input,  width = 12,     s1.address
		.clken       (_connected_to_clken_),       //   input,   width = 1,       .clken
		.chipselect  (_connected_to_chipselect_),  //   input,   width = 1,       .chipselect
		.write       (_connected_to_write_),       //   input,   width = 1,       .write
		.readdata    (_connected_to_readdata_),    //  output,   width = 8,       .readdata
		.writedata   (_connected_to_writedata_),   //   input,   width = 8,       .writedata
		.reset       (_connected_to_reset_),       //   input,   width = 1, reset1.reset
		.reset_req   (_connected_to_reset_req_),   //   input,   width = 1,       .reset_req
		.address2    (_connected_to_address2_),    //   input,  width = 12,     s2.address
		.chipselect2 (_connected_to_chipselect2_), //   input,   width = 1,       .chipselect
		.clken2      (_connected_to_clken2_),      //   input,   width = 1,       .clken
		.write2      (_connected_to_write2_),      //   input,   width = 1,       .write
		.readdata2   (_connected_to_readdata2_),   //  output,   width = 8,       .readdata
		.writedata2  (_connected_to_writedata2_),  //   input,   width = 8,       .writedata
		.clk2        (_connected_to_clk2_),        //   input,   width = 1,   clk2.clk
		.reset2      (_connected_to_reset2_),      //   input,   width = 1, reset2.reset
		.reset_req2  (_connected_to_reset_req2_)   //   input,   width = 1,       .reset_req
	);

