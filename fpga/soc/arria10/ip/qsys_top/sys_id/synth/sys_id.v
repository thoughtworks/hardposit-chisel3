// sys_id.v

// Generated using ACDS version 18.1 221

`timescale 1 ps / 1 ps
module sys_id (
		input  wire        clock,    //           clk.clk
		input  wire        reset_n,  //         reset.reset_n
		output wire [31:0] readdata, // control_slave.readdata
		input  wire        address   //              .address
	);

	altera_avalon_sysid_qsys #(
		.ID_VALUE  (-1073194496),
		.TIMESTAMP (0)
	) altera_avalon_sysid_qsys_inst (
		.clock    (clock),    //   input,   width = 1,           clk.clk
		.reset_n  (reset_n),  //   input,   width = 1,         reset.reset_n
		.readdata (readdata), //  output,  width = 32, control_slave.readdata
		.address  (address)   //   input,   width = 1,              .address
	);

endmodule