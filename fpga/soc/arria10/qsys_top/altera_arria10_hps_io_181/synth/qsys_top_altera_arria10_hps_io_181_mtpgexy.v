// qsys_top_altera_arria10_hps_io_181_mtpgexy.v

// This file was auto-generated from altera_hps_arria10_io_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 18.1 222

`timescale 1 ps / 1 ps
module qsys_top_altera_arria10_hps_io_181_mtpgexy (
		output wire  hps_io_phery_emac0_TX_CLK, // hps_io.hps_io_phery_emac0_TX_CLK
		output wire  hps_io_phery_emac0_TXD0,   //       .hps_io_phery_emac0_TXD0
		output wire  hps_io_phery_emac0_TXD1,   //       .hps_io_phery_emac0_TXD1
		output wire  hps_io_phery_emac0_TXD2,   //       .hps_io_phery_emac0_TXD2
		output wire  hps_io_phery_emac0_TXD3,   //       .hps_io_phery_emac0_TXD3
		input  wire  hps_io_phery_emac0_RX_CTL, //       .hps_io_phery_emac0_RX_CTL
		output wire  hps_io_phery_emac0_TX_CTL, //       .hps_io_phery_emac0_TX_CTL
		input  wire  hps_io_phery_emac0_RX_CLK, //       .hps_io_phery_emac0_RX_CLK
		input  wire  hps_io_phery_emac0_RXD0,   //       .hps_io_phery_emac0_RXD0
		input  wire  hps_io_phery_emac0_RXD1,   //       .hps_io_phery_emac0_RXD1
		input  wire  hps_io_phery_emac0_RXD2,   //       .hps_io_phery_emac0_RXD2
		input  wire  hps_io_phery_emac0_RXD3,   //       .hps_io_phery_emac0_RXD3
		inout  wire  hps_io_phery_emac0_MDIO,   //       .hps_io_phery_emac0_MDIO
		output wire  hps_io_phery_emac0_MDC,    //       .hps_io_phery_emac0_MDC
		inout  wire  hps_io_phery_sdmmc_CMD,    //       .hps_io_phery_sdmmc_CMD
		inout  wire  hps_io_phery_sdmmc_D0,     //       .hps_io_phery_sdmmc_D0
		inout  wire  hps_io_phery_sdmmc_D1,     //       .hps_io_phery_sdmmc_D1
		inout  wire  hps_io_phery_sdmmc_D2,     //       .hps_io_phery_sdmmc_D2
		inout  wire  hps_io_phery_sdmmc_D3,     //       .hps_io_phery_sdmmc_D3
		inout  wire  hps_io_phery_sdmmc_D4,     //       .hps_io_phery_sdmmc_D4
		inout  wire  hps_io_phery_sdmmc_D5,     //       .hps_io_phery_sdmmc_D5
		inout  wire  hps_io_phery_sdmmc_D6,     //       .hps_io_phery_sdmmc_D6
		inout  wire  hps_io_phery_sdmmc_D7,     //       .hps_io_phery_sdmmc_D7
		output wire  hps_io_phery_sdmmc_CCLK,   //       .hps_io_phery_sdmmc_CCLK
		inout  wire  hps_io_phery_usb0_DATA0,   //       .hps_io_phery_usb0_DATA0
		inout  wire  hps_io_phery_usb0_DATA1,   //       .hps_io_phery_usb0_DATA1
		inout  wire  hps_io_phery_usb0_DATA2,   //       .hps_io_phery_usb0_DATA2
		inout  wire  hps_io_phery_usb0_DATA3,   //       .hps_io_phery_usb0_DATA3
		inout  wire  hps_io_phery_usb0_DATA4,   //       .hps_io_phery_usb0_DATA4
		inout  wire  hps_io_phery_usb0_DATA5,   //       .hps_io_phery_usb0_DATA5
		inout  wire  hps_io_phery_usb0_DATA6,   //       .hps_io_phery_usb0_DATA6
		inout  wire  hps_io_phery_usb0_DATA7,   //       .hps_io_phery_usb0_DATA7
		input  wire  hps_io_phery_usb0_CLK,     //       .hps_io_phery_usb0_CLK
		output wire  hps_io_phery_usb0_STP,     //       .hps_io_phery_usb0_STP
		input  wire  hps_io_phery_usb0_DIR,     //       .hps_io_phery_usb0_DIR
		input  wire  hps_io_phery_usb0_NXT,     //       .hps_io_phery_usb0_NXT
		output wire  hps_io_phery_spim1_CLK,    //       .hps_io_phery_spim1_CLK
		output wire  hps_io_phery_spim1_MOSI,   //       .hps_io_phery_spim1_MOSI
		input  wire  hps_io_phery_spim1_MISO,   //       .hps_io_phery_spim1_MISO
		output wire  hps_io_phery_spim1_SS0_N,  //       .hps_io_phery_spim1_SS0_N
		output wire  hps_io_phery_spim1_SS1_N,  //       .hps_io_phery_spim1_SS1_N
		output wire  hps_io_phery_trace_CLK,    //       .hps_io_phery_trace_CLK
		output wire  hps_io_phery_trace_D0,     //       .hps_io_phery_trace_D0
		output wire  hps_io_phery_trace_D1,     //       .hps_io_phery_trace_D1
		output wire  hps_io_phery_trace_D2,     //       .hps_io_phery_trace_D2
		output wire  hps_io_phery_trace_D3,     //       .hps_io_phery_trace_D3
		input  wire  hps_io_phery_uart1_RX,     //       .hps_io_phery_uart1_RX
		output wire  hps_io_phery_uart1_TX,     //       .hps_io_phery_uart1_TX
		inout  wire  hps_io_phery_i2c1_SDA,     //       .hps_io_phery_i2c1_SDA
		inout  wire  hps_io_phery_i2c1_SCL,     //       .hps_io_phery_i2c1_SCL
		inout  wire  hps_io_gpio_gpio1_io5,     //       .hps_io_gpio_gpio1_io5
		inout  wire  hps_io_gpio_gpio1_io14,    //       .hps_io_gpio_gpio1_io14
		inout  wire  hps_io_gpio_gpio1_io16,    //       .hps_io_gpio_gpio1_io16
		inout  wire  hps_io_gpio_gpio1_io17     //       .hps_io_gpio_gpio1_io17
	);

	qsys_top_altera_arria10_interface_generator_140_kcjsigq border (
		.hps_io_phery_emac0_TX_CLK (hps_io_phery_emac0_TX_CLK), //  output,  width = 1, hps_io.hps_io_phery_emac0_TX_CLK
		.hps_io_phery_emac0_TXD0   (hps_io_phery_emac0_TXD0),   //  output,  width = 1,       .hps_io_phery_emac0_TXD0
		.hps_io_phery_emac0_TXD1   (hps_io_phery_emac0_TXD1),   //  output,  width = 1,       .hps_io_phery_emac0_TXD1
		.hps_io_phery_emac0_TXD2   (hps_io_phery_emac0_TXD2),   //  output,  width = 1,       .hps_io_phery_emac0_TXD2
		.hps_io_phery_emac0_TXD3   (hps_io_phery_emac0_TXD3),   //  output,  width = 1,       .hps_io_phery_emac0_TXD3
		.hps_io_phery_emac0_RX_CTL (hps_io_phery_emac0_RX_CTL), //   input,  width = 1,       .hps_io_phery_emac0_RX_CTL
		.hps_io_phery_emac0_TX_CTL (hps_io_phery_emac0_TX_CTL), //  output,  width = 1,       .hps_io_phery_emac0_TX_CTL
		.hps_io_phery_emac0_RX_CLK (hps_io_phery_emac0_RX_CLK), //   input,  width = 1,       .hps_io_phery_emac0_RX_CLK
		.hps_io_phery_emac0_RXD0   (hps_io_phery_emac0_RXD0),   //   input,  width = 1,       .hps_io_phery_emac0_RXD0
		.hps_io_phery_emac0_RXD1   (hps_io_phery_emac0_RXD1),   //   input,  width = 1,       .hps_io_phery_emac0_RXD1
		.hps_io_phery_emac0_RXD2   (hps_io_phery_emac0_RXD2),   //   input,  width = 1,       .hps_io_phery_emac0_RXD2
		.hps_io_phery_emac0_RXD3   (hps_io_phery_emac0_RXD3),   //   input,  width = 1,       .hps_io_phery_emac0_RXD3
		.hps_io_phery_emac0_MDIO   (hps_io_phery_emac0_MDIO),   //   inout,  width = 1,       .hps_io_phery_emac0_MDIO
		.hps_io_phery_emac0_MDC    (hps_io_phery_emac0_MDC),    //  output,  width = 1,       .hps_io_phery_emac0_MDC
		.hps_io_phery_sdmmc_CMD    (hps_io_phery_sdmmc_CMD),    //   inout,  width = 1,       .hps_io_phery_sdmmc_CMD
		.hps_io_phery_sdmmc_D0     (hps_io_phery_sdmmc_D0),     //   inout,  width = 1,       .hps_io_phery_sdmmc_D0
		.hps_io_phery_sdmmc_D1     (hps_io_phery_sdmmc_D1),     //   inout,  width = 1,       .hps_io_phery_sdmmc_D1
		.hps_io_phery_sdmmc_D2     (hps_io_phery_sdmmc_D2),     //   inout,  width = 1,       .hps_io_phery_sdmmc_D2
		.hps_io_phery_sdmmc_D3     (hps_io_phery_sdmmc_D3),     //   inout,  width = 1,       .hps_io_phery_sdmmc_D3
		.hps_io_phery_sdmmc_D4     (hps_io_phery_sdmmc_D4),     //   inout,  width = 1,       .hps_io_phery_sdmmc_D4
		.hps_io_phery_sdmmc_D5     (hps_io_phery_sdmmc_D5),     //   inout,  width = 1,       .hps_io_phery_sdmmc_D5
		.hps_io_phery_sdmmc_D6     (hps_io_phery_sdmmc_D6),     //   inout,  width = 1,       .hps_io_phery_sdmmc_D6
		.hps_io_phery_sdmmc_D7     (hps_io_phery_sdmmc_D7),     //   inout,  width = 1,       .hps_io_phery_sdmmc_D7
		.hps_io_phery_sdmmc_CCLK   (hps_io_phery_sdmmc_CCLK),   //  output,  width = 1,       .hps_io_phery_sdmmc_CCLK
		.hps_io_phery_usb0_DATA0   (hps_io_phery_usb0_DATA0),   //   inout,  width = 1,       .hps_io_phery_usb0_DATA0
		.hps_io_phery_usb0_DATA1   (hps_io_phery_usb0_DATA1),   //   inout,  width = 1,       .hps_io_phery_usb0_DATA1
		.hps_io_phery_usb0_DATA2   (hps_io_phery_usb0_DATA2),   //   inout,  width = 1,       .hps_io_phery_usb0_DATA2
		.hps_io_phery_usb0_DATA3   (hps_io_phery_usb0_DATA3),   //   inout,  width = 1,       .hps_io_phery_usb0_DATA3
		.hps_io_phery_usb0_DATA4   (hps_io_phery_usb0_DATA4),   //   inout,  width = 1,       .hps_io_phery_usb0_DATA4
		.hps_io_phery_usb0_DATA5   (hps_io_phery_usb0_DATA5),   //   inout,  width = 1,       .hps_io_phery_usb0_DATA5
		.hps_io_phery_usb0_DATA6   (hps_io_phery_usb0_DATA6),   //   inout,  width = 1,       .hps_io_phery_usb0_DATA6
		.hps_io_phery_usb0_DATA7   (hps_io_phery_usb0_DATA7),   //   inout,  width = 1,       .hps_io_phery_usb0_DATA7
		.hps_io_phery_usb0_CLK     (hps_io_phery_usb0_CLK),     //   input,  width = 1,       .hps_io_phery_usb0_CLK
		.hps_io_phery_usb0_STP     (hps_io_phery_usb0_STP),     //  output,  width = 1,       .hps_io_phery_usb0_STP
		.hps_io_phery_usb0_DIR     (hps_io_phery_usb0_DIR),     //   input,  width = 1,       .hps_io_phery_usb0_DIR
		.hps_io_phery_usb0_NXT     (hps_io_phery_usb0_NXT),     //   input,  width = 1,       .hps_io_phery_usb0_NXT
		.hps_io_phery_spim1_CLK    (hps_io_phery_spim1_CLK),    //  output,  width = 1,       .hps_io_phery_spim1_CLK
		.hps_io_phery_spim1_MOSI   (hps_io_phery_spim1_MOSI),   //  output,  width = 1,       .hps_io_phery_spim1_MOSI
		.hps_io_phery_spim1_MISO   (hps_io_phery_spim1_MISO),   //   input,  width = 1,       .hps_io_phery_spim1_MISO
		.hps_io_phery_spim1_SS0_N  (hps_io_phery_spim1_SS0_N),  //  output,  width = 1,       .hps_io_phery_spim1_SS0_N
		.hps_io_phery_spim1_SS1_N  (hps_io_phery_spim1_SS1_N),  //  output,  width = 1,       .hps_io_phery_spim1_SS1_N
		.hps_io_phery_trace_CLK    (hps_io_phery_trace_CLK),    //  output,  width = 1,       .hps_io_phery_trace_CLK
		.hps_io_phery_trace_D0     (hps_io_phery_trace_D0),     //  output,  width = 1,       .hps_io_phery_trace_D0
		.hps_io_phery_trace_D1     (hps_io_phery_trace_D1),     //  output,  width = 1,       .hps_io_phery_trace_D1
		.hps_io_phery_trace_D2     (hps_io_phery_trace_D2),     //  output,  width = 1,       .hps_io_phery_trace_D2
		.hps_io_phery_trace_D3     (hps_io_phery_trace_D3),     //  output,  width = 1,       .hps_io_phery_trace_D3
		.hps_io_phery_uart1_RX     (hps_io_phery_uart1_RX),     //   input,  width = 1,       .hps_io_phery_uart1_RX
		.hps_io_phery_uart1_TX     (hps_io_phery_uart1_TX),     //  output,  width = 1,       .hps_io_phery_uart1_TX
		.hps_io_phery_i2c1_SDA     (hps_io_phery_i2c1_SDA),     //   inout,  width = 1,       .hps_io_phery_i2c1_SDA
		.hps_io_phery_i2c1_SCL     (hps_io_phery_i2c1_SCL),     //   inout,  width = 1,       .hps_io_phery_i2c1_SCL
		.hps_io_gpio_gpio1_io5     (hps_io_gpio_gpio1_io5),     //   inout,  width = 1,       .hps_io_gpio_gpio1_io5
		.hps_io_gpio_gpio1_io14    (hps_io_gpio_gpio1_io14),    //   inout,  width = 1,       .hps_io_gpio_gpio1_io14
		.hps_io_gpio_gpio1_io16    (hps_io_gpio_gpio1_io16),    //   inout,  width = 1,       .hps_io_gpio_gpio1_io16
		.hps_io_gpio_gpio1_io17    (hps_io_gpio_gpio1_io17)     //   inout,  width = 1,       .hps_io_gpio_gpio1_io17
	);

endmodule
