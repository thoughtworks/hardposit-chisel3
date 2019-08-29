module qsys_top_pio_1 (
		input  wire        clk,      //                 clk.clk
		input  wire        reset_n,  //               reset.reset_n
		input  wire [1:0]  address,  //                  s1.address
		output wire [31:0] readdata, //                    .readdata
		input  wire        in_port   // external_connection.export
	);
endmodule

