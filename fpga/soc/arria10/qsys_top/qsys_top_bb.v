module qsys_top (
		output wire        hps_io_hps_io_phery_emac0_TX_CLK,           //                                hps_io.hps_io_phery_emac0_TX_CLK
		output wire        hps_io_hps_io_phery_emac0_TXD0,             //                                      .hps_io_phery_emac0_TXD0
		output wire        hps_io_hps_io_phery_emac0_TXD1,             //                                      .hps_io_phery_emac0_TXD1
		output wire        hps_io_hps_io_phery_emac0_TXD2,             //                                      .hps_io_phery_emac0_TXD2
		output wire        hps_io_hps_io_phery_emac0_TXD3,             //                                      .hps_io_phery_emac0_TXD3
		input  wire        hps_io_hps_io_phery_emac0_RX_CTL,           //                                      .hps_io_phery_emac0_RX_CTL
		output wire        hps_io_hps_io_phery_emac0_TX_CTL,           //                                      .hps_io_phery_emac0_TX_CTL
		input  wire        hps_io_hps_io_phery_emac0_RX_CLK,           //                                      .hps_io_phery_emac0_RX_CLK
		input  wire        hps_io_hps_io_phery_emac0_RXD0,             //                                      .hps_io_phery_emac0_RXD0
		input  wire        hps_io_hps_io_phery_emac0_RXD1,             //                                      .hps_io_phery_emac0_RXD1
		input  wire        hps_io_hps_io_phery_emac0_RXD2,             //                                      .hps_io_phery_emac0_RXD2
		input  wire        hps_io_hps_io_phery_emac0_RXD3,             //                                      .hps_io_phery_emac0_RXD3
		inout  wire        hps_io_hps_io_phery_emac0_MDIO,             //                                      .hps_io_phery_emac0_MDIO
		output wire        hps_io_hps_io_phery_emac0_MDC,              //                                      .hps_io_phery_emac0_MDC
		inout  wire        hps_io_hps_io_phery_sdmmc_CMD,              //                                      .hps_io_phery_sdmmc_CMD
		inout  wire        hps_io_hps_io_phery_sdmmc_D0,               //                                      .hps_io_phery_sdmmc_D0
		inout  wire        hps_io_hps_io_phery_sdmmc_D1,               //                                      .hps_io_phery_sdmmc_D1
		inout  wire        hps_io_hps_io_phery_sdmmc_D2,               //                                      .hps_io_phery_sdmmc_D2
		inout  wire        hps_io_hps_io_phery_sdmmc_D3,               //                                      .hps_io_phery_sdmmc_D3
		inout  wire        hps_io_hps_io_phery_sdmmc_D4,               //                                      .hps_io_phery_sdmmc_D4
		inout  wire        hps_io_hps_io_phery_sdmmc_D5,               //                                      .hps_io_phery_sdmmc_D5
		inout  wire        hps_io_hps_io_phery_sdmmc_D6,               //                                      .hps_io_phery_sdmmc_D6
		inout  wire        hps_io_hps_io_phery_sdmmc_D7,               //                                      .hps_io_phery_sdmmc_D7
		output wire        hps_io_hps_io_phery_sdmmc_CCLK,             //                                      .hps_io_phery_sdmmc_CCLK
		inout  wire        hps_io_hps_io_phery_usb0_DATA0,             //                                      .hps_io_phery_usb0_DATA0
		inout  wire        hps_io_hps_io_phery_usb0_DATA1,             //                                      .hps_io_phery_usb0_DATA1
		inout  wire        hps_io_hps_io_phery_usb0_DATA2,             //                                      .hps_io_phery_usb0_DATA2
		inout  wire        hps_io_hps_io_phery_usb0_DATA3,             //                                      .hps_io_phery_usb0_DATA3
		inout  wire        hps_io_hps_io_phery_usb0_DATA4,             //                                      .hps_io_phery_usb0_DATA4
		inout  wire        hps_io_hps_io_phery_usb0_DATA5,             //                                      .hps_io_phery_usb0_DATA5
		inout  wire        hps_io_hps_io_phery_usb0_DATA6,             //                                      .hps_io_phery_usb0_DATA6
		inout  wire        hps_io_hps_io_phery_usb0_DATA7,             //                                      .hps_io_phery_usb0_DATA7
		input  wire        hps_io_hps_io_phery_usb0_CLK,               //                                      .hps_io_phery_usb0_CLK
		output wire        hps_io_hps_io_phery_usb0_STP,               //                                      .hps_io_phery_usb0_STP
		input  wire        hps_io_hps_io_phery_usb0_DIR,               //                                      .hps_io_phery_usb0_DIR
		input  wire        hps_io_hps_io_phery_usb0_NXT,               //                                      .hps_io_phery_usb0_NXT
		output wire        hps_io_hps_io_phery_spim1_CLK,              //                                      .hps_io_phery_spim1_CLK
		output wire        hps_io_hps_io_phery_spim1_MOSI,             //                                      .hps_io_phery_spim1_MOSI
		input  wire        hps_io_hps_io_phery_spim1_MISO,             //                                      .hps_io_phery_spim1_MISO
		output wire        hps_io_hps_io_phery_spim1_SS0_N,            //                                      .hps_io_phery_spim1_SS0_N
		output wire        hps_io_hps_io_phery_spim1_SS1_N,            //                                      .hps_io_phery_spim1_SS1_N
		output wire        hps_io_hps_io_phery_trace_CLK,              //                                      .hps_io_phery_trace_CLK
		output wire        hps_io_hps_io_phery_trace_D0,               //                                      .hps_io_phery_trace_D0
		output wire        hps_io_hps_io_phery_trace_D1,               //                                      .hps_io_phery_trace_D1
		output wire        hps_io_hps_io_phery_trace_D2,               //                                      .hps_io_phery_trace_D2
		output wire        hps_io_hps_io_phery_trace_D3,               //                                      .hps_io_phery_trace_D3
		input  wire        hps_io_hps_io_phery_uart1_RX,               //                                      .hps_io_phery_uart1_RX
		output wire        hps_io_hps_io_phery_uart1_TX,               //                                      .hps_io_phery_uart1_TX
		inout  wire        hps_io_hps_io_phery_i2c1_SDA,               //                                      .hps_io_phery_i2c1_SDA
		inout  wire        hps_io_hps_io_phery_i2c1_SCL,               //                                      .hps_io_phery_i2c1_SCL
		inout  wire        hps_io_hps_io_gpio_gpio1_io5,               //                                      .hps_io_gpio_gpio1_io5
		inout  wire        hps_io_hps_io_gpio_gpio1_io14,              //                                      .hps_io_gpio_gpio1_io14
		inout  wire        hps_io_hps_io_gpio_gpio1_io16,              //                                      .hps_io_gpio_gpio1_io16
		inout  wire        hps_io_hps_io_gpio_gpio1_io17,              //                                      .hps_io_gpio_gpio1_io17
		input  wire        completed_external_connection_export,       //         completed_external_connection.export
		input  wire        emif_a10_hps_0_pll_ref_clk_clock_sink_clk,  // emif_a10_hps_0_pll_ref_clk_clock_sink.clk
		input  wire        emif_a10_hps_0_oct_conduit_end_oct_rzqin,   //        emif_a10_hps_0_oct_conduit_end.oct_rzqin
		output wire [0:0]  emif_a10_hps_0_mem_conduit_end_mem_ck,      //        emif_a10_hps_0_mem_conduit_end.mem_ck
		output wire [0:0]  emif_a10_hps_0_mem_conduit_end_mem_ck_n,    //                                      .mem_ck_n
		output wire [16:0] emif_a10_hps_0_mem_conduit_end_mem_a,       //                                      .mem_a
		output wire [0:0]  emif_a10_hps_0_mem_conduit_end_mem_act_n,   //                                      .mem_act_n
		output wire [1:0]  emif_a10_hps_0_mem_conduit_end_mem_ba,      //                                      .mem_ba
		output wire [0:0]  emif_a10_hps_0_mem_conduit_end_mem_bg,      //                                      .mem_bg
		output wire [0:0]  emif_a10_hps_0_mem_conduit_end_mem_cke,     //                                      .mem_cke
		output wire [0:0]  emif_a10_hps_0_mem_conduit_end_mem_cs_n,    //                                      .mem_cs_n
		output wire [0:0]  emif_a10_hps_0_mem_conduit_end_mem_odt,     //                                      .mem_odt
		output wire [0:0]  emif_a10_hps_0_mem_conduit_end_mem_reset_n, //                                      .mem_reset_n
		output wire [0:0]  emif_a10_hps_0_mem_conduit_end_mem_par,     //                                      .mem_par
		input  wire [0:0]  emif_a10_hps_0_mem_conduit_end_mem_alert_n, //                                      .mem_alert_n
		inout  wire [3:0]  emif_a10_hps_0_mem_conduit_end_mem_dqs,     //                                      .mem_dqs
		inout  wire [3:0]  emif_a10_hps_0_mem_conduit_end_mem_dqs_n,   //                                      .mem_dqs_n
		inout  wire [31:0] emif_a10_hps_0_mem_conduit_end_mem_dq,      //                                      .mem_dq
		inout  wire [3:0]  emif_a10_hps_0_mem_conduit_end_mem_dbi_n,   //                                      .mem_dbi_n
		input  wire        iopll_0_refclk_clk,                         //                        iopll_0_refclk.clk
		output wire        iopll_0_outclk1_clk,                        //                       iopll_0_outclk1.clk
		output wire [31:0] num1_export,                                //                                  num1.export
		output wire [31:0] num2_export,                                //                                  num2.export
		input  wire [11:0] onchip_memory2_0_s2_address,                //                   onchip_memory2_0_s2.address
		input  wire        onchip_memory2_0_s2_chipselect,             //                                      .chipselect
		input  wire        onchip_memory2_0_s2_clken,                  //                                      .clken
		input  wire        onchip_memory2_0_s2_write,                  //                                      .write
		output wire [7:0]  onchip_memory2_0_s2_readdata,               //                                      .readdata
		input  wire [7:0]  onchip_memory2_0_s2_writedata,              //                                      .writedata
		input  wire [11:0] onchip_memory2_1_s2_address,                //                   onchip_memory2_1_s2.address
		input  wire        onchip_memory2_1_s2_chipselect,             //                                      .chipselect
		input  wire        onchip_memory2_1_s2_clken,                  //                                      .clken
		input  wire        onchip_memory2_1_s2_write,                  //                                      .write
		output wire [7:0]  onchip_memory2_1_s2_readdata,               //                                      .readdata
		input  wire [7:0]  onchip_memory2_1_s2_writedata,              //                                      .writedata
		output wire        reset_pio_external_connection_export,       //         reset_pio_external_connection.export
		input  wire [31:0] result_export,                              //                                result.export
		output wire        hps_fpga_reset_reset,                       //                        hps_fpga_reset.reset
		input  wire        reset_reset_n,                              //                                 reset.reset_n
		output wire        start_external_connection_export            //             start_external_connection.export
	);
endmodule

