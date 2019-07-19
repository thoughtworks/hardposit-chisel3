module ILC (
		input  wire        reset_n,     //      reset_n.reset_n
		input  wire        clk,         //          clk.clk
		input  wire [1:0]  irq,         //          irq.irq
		input  wire [5:0]  avmm_addr,   // avalon_slave.address
		input  wire [31:0] avmm_wrdata, //             .writedata
		input  wire        avmm_write,  //             .write
		input  wire        avmm_read,   //             .read
		output wire [31:0] avmm_rddata  //             .readdata
	);
endmodule

