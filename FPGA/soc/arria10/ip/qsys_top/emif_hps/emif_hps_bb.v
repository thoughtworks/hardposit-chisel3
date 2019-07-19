module emif_hps (
		input  wire          global_reset_n, // global_reset_reset_sink.reset_n,     Asynchronous reset causes the memory interface to be reset and recalibrated. The global reset signal applies to all memory interfaces placed within an I/O column.
		input  wire          pll_ref_clk,    //  pll_ref_clk_clock_sink.clk,         PLL reference clock input
		input  wire          oct_rzqin,      //         oct_conduit_end.oct_rzqin,   Calibrated On-Chip Termination (OCT) RZQ input pin
		output wire [0:0]    mem_ck,         //         mem_conduit_end.mem_ck,      CK clock
		output wire [0:0]    mem_ck_n,       //                        .mem_ck_n,    CK clock (negative leg)
		output wire [16:0]   mem_a,          //                        .mem_a,       Address
		output wire [0:0]    mem_act_n,      //                        .mem_act_n,   Activation command
		output wire [1:0]    mem_ba,         //                        .mem_ba,      Bank address
		output wire [0:0]    mem_bg,         //                        .mem_bg,      Bank group
		output wire [0:0]    mem_cke,        //                        .mem_cke,     Clock enable
		output wire [0:0]    mem_cs_n,       //                        .mem_cs_n,    Chip select
		output wire [0:0]    mem_odt,        //                        .mem_odt,     On-die termination
		output wire [0:0]    mem_reset_n,    //                        .mem_reset_n, Asynchronous reset
		output wire [0:0]    mem_par,        //                        .mem_par,     Command and address parity
		input  wire [0:0]    mem_alert_n,    //                        .mem_alert_n, Alert flag
		inout  wire [3:0]    mem_dqs,        //                        .mem_dqs,     Data strobe
		inout  wire [3:0]    mem_dqs_n,      //                        .mem_dqs_n,   Data strobe (negative leg)
		inout  wire [31:0]   mem_dq,         //                        .mem_dq,      Read/write data
		inout  wire [3:0]    mem_dbi_n,      //                        .mem_dbi_n,   Acts as either the data bus inversion pin, or the data mask pin, depending on configuration.
		input  wire [4095:0] hps_to_emif,    //    hps_emif_conduit_end.hps_to_emif, Signals coming from Hard Processor Subsystem to the memory interface
		output wire [4095:0] emif_to_hps,    //                        .emif_to_hps, Signals going to Hard Processor Subsystem from the memory interface
		input  wire [1:0]    hps_to_emif_gp, //                        .gp_to_emif,  Signals coming from Hard Processor Subsystem GPIO to the memory interface
		output wire [0:0]    emif_to_hps_gp  //                        .emif_to_gp,  Signals going to Hard Processor Subsystem GPIO from the memory interface
	);
endmodule

