// qsys_top_onchip_memory2_0.v

// Generated using ACDS version 18.1 222

`timescale 1 ps / 1 ps
module qsys_top_onchip_memory2_0 (
		input  wire        clk,         //   clk1.clk
		input  wire [10:0] address,     //     s1.address
		input  wire        clken,       //       .clken
		input  wire        chipselect,  //       .chipselect
		input  wire        write,       //       .write
		output wire [15:0] readdata,    //       .readdata
		input  wire [15:0] writedata,   //       .writedata
		input  wire [1:0]  byteenable,  //       .byteenable
		input  wire        reset,       // reset1.reset
		input  wire        reset_req,   //       .reset_req
		input  wire [10:0] address2,    //     s2.address
		input  wire        chipselect2, //       .chipselect
		input  wire        clken2,      //       .clken
		input  wire        write2,      //       .write
		output wire [15:0] readdata2,   //       .readdata
		input  wire [15:0] writedata2,  //       .writedata
		input  wire [1:0]  byteenable2, //       .byteenable
		input  wire        clk2,        //   clk2.clk
		input  wire        reset2,      // reset2.reset
		input  wire        reset_req2   //       .reset_req
	);

	qsys_top_onchip_memory2_0_altera_avalon_onchip_memory2_181_t3dhtpy onchip_memory2_0 (
		.clk         (clk),         //   input,   width = 1,   clk1.clk
		.address     (address),     //   input,  width = 11,     s1.address
		.clken       (clken),       //   input,   width = 1,       .clken
		.chipselect  (chipselect),  //   input,   width = 1,       .chipselect
		.write       (write),       //   input,   width = 1,       .write
		.readdata    (readdata),    //  output,  width = 16,       .readdata
		.writedata   (writedata),   //   input,  width = 16,       .writedata
		.byteenable  (byteenable),  //   input,   width = 2,       .byteenable
		.reset       (reset),       //   input,   width = 1, reset1.reset
		.reset_req   (reset_req),   //   input,   width = 1,       .reset_req
		.address2    (address2),    //   input,  width = 11,     s2.address
		.chipselect2 (chipselect2), //   input,   width = 1,       .chipselect
		.clken2      (clken2),      //   input,   width = 1,       .clken
		.write2      (write2),      //   input,   width = 1,       .write
		.readdata2   (readdata2),   //  output,  width = 16,       .readdata
		.writedata2  (writedata2),  //   input,  width = 16,       .writedata
		.byteenable2 (byteenable2), //   input,   width = 2,       .byteenable
		.clk2        (clk2),        //   input,   width = 1,   clk2.clk
		.reset2      (reset2),      //   input,   width = 1, reset2.reset
		.reset_req2  (reset_req2),  //   input,   width = 1,       .reset_req
		.freeze      (1'b0)         // (terminated),                     
	);

endmodule
