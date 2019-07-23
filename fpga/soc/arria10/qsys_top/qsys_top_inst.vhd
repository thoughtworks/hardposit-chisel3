	component qsys_top is
		port (
			hps_io_hps_io_phery_emac0_TX_CLK           : out   std_logic;                                        -- hps_io_phery_emac0_TX_CLK
			hps_io_hps_io_phery_emac0_TXD0             : out   std_logic;                                        -- hps_io_phery_emac0_TXD0
			hps_io_hps_io_phery_emac0_TXD1             : out   std_logic;                                        -- hps_io_phery_emac0_TXD1
			hps_io_hps_io_phery_emac0_TXD2             : out   std_logic;                                        -- hps_io_phery_emac0_TXD2
			hps_io_hps_io_phery_emac0_TXD3             : out   std_logic;                                        -- hps_io_phery_emac0_TXD3
			hps_io_hps_io_phery_emac0_RX_CTL           : in    std_logic                     := 'X';             -- hps_io_phery_emac0_RX_CTL
			hps_io_hps_io_phery_emac0_TX_CTL           : out   std_logic;                                        -- hps_io_phery_emac0_TX_CTL
			hps_io_hps_io_phery_emac0_RX_CLK           : in    std_logic                     := 'X';             -- hps_io_phery_emac0_RX_CLK
			hps_io_hps_io_phery_emac0_RXD0             : in    std_logic                     := 'X';             -- hps_io_phery_emac0_RXD0
			hps_io_hps_io_phery_emac0_RXD1             : in    std_logic                     := 'X';             -- hps_io_phery_emac0_RXD1
			hps_io_hps_io_phery_emac0_RXD2             : in    std_logic                     := 'X';             -- hps_io_phery_emac0_RXD2
			hps_io_hps_io_phery_emac0_RXD3             : in    std_logic                     := 'X';             -- hps_io_phery_emac0_RXD3
			hps_io_hps_io_phery_emac0_MDIO             : inout std_logic                     := 'X';             -- hps_io_phery_emac0_MDIO
			hps_io_hps_io_phery_emac0_MDC              : out   std_logic;                                        -- hps_io_phery_emac0_MDC
			hps_io_hps_io_phery_sdmmc_CMD              : inout std_logic                     := 'X';             -- hps_io_phery_sdmmc_CMD
			hps_io_hps_io_phery_sdmmc_D0               : inout std_logic                     := 'X';             -- hps_io_phery_sdmmc_D0
			hps_io_hps_io_phery_sdmmc_D1               : inout std_logic                     := 'X';             -- hps_io_phery_sdmmc_D1
			hps_io_hps_io_phery_sdmmc_D2               : inout std_logic                     := 'X';             -- hps_io_phery_sdmmc_D2
			hps_io_hps_io_phery_sdmmc_D3               : inout std_logic                     := 'X';             -- hps_io_phery_sdmmc_D3
			hps_io_hps_io_phery_sdmmc_D4               : inout std_logic                     := 'X';             -- hps_io_phery_sdmmc_D4
			hps_io_hps_io_phery_sdmmc_D5               : inout std_logic                     := 'X';             -- hps_io_phery_sdmmc_D5
			hps_io_hps_io_phery_sdmmc_D6               : inout std_logic                     := 'X';             -- hps_io_phery_sdmmc_D6
			hps_io_hps_io_phery_sdmmc_D7               : inout std_logic                     := 'X';             -- hps_io_phery_sdmmc_D7
			hps_io_hps_io_phery_sdmmc_CCLK             : out   std_logic;                                        -- hps_io_phery_sdmmc_CCLK
			hps_io_hps_io_phery_usb0_DATA0             : inout std_logic                     := 'X';             -- hps_io_phery_usb0_DATA0
			hps_io_hps_io_phery_usb0_DATA1             : inout std_logic                     := 'X';             -- hps_io_phery_usb0_DATA1
			hps_io_hps_io_phery_usb0_DATA2             : inout std_logic                     := 'X';             -- hps_io_phery_usb0_DATA2
			hps_io_hps_io_phery_usb0_DATA3             : inout std_logic                     := 'X';             -- hps_io_phery_usb0_DATA3
			hps_io_hps_io_phery_usb0_DATA4             : inout std_logic                     := 'X';             -- hps_io_phery_usb0_DATA4
			hps_io_hps_io_phery_usb0_DATA5             : inout std_logic                     := 'X';             -- hps_io_phery_usb0_DATA5
			hps_io_hps_io_phery_usb0_DATA6             : inout std_logic                     := 'X';             -- hps_io_phery_usb0_DATA6
			hps_io_hps_io_phery_usb0_DATA7             : inout std_logic                     := 'X';             -- hps_io_phery_usb0_DATA7
			hps_io_hps_io_phery_usb0_CLK               : in    std_logic                     := 'X';             -- hps_io_phery_usb0_CLK
			hps_io_hps_io_phery_usb0_STP               : out   std_logic;                                        -- hps_io_phery_usb0_STP
			hps_io_hps_io_phery_usb0_DIR               : in    std_logic                     := 'X';             -- hps_io_phery_usb0_DIR
			hps_io_hps_io_phery_usb0_NXT               : in    std_logic                     := 'X';             -- hps_io_phery_usb0_NXT
			hps_io_hps_io_phery_spim1_CLK              : out   std_logic;                                        -- hps_io_phery_spim1_CLK
			hps_io_hps_io_phery_spim1_MOSI             : out   std_logic;                                        -- hps_io_phery_spim1_MOSI
			hps_io_hps_io_phery_spim1_MISO             : in    std_logic                     := 'X';             -- hps_io_phery_spim1_MISO
			hps_io_hps_io_phery_spim1_SS0_N            : out   std_logic;                                        -- hps_io_phery_spim1_SS0_N
			hps_io_hps_io_phery_spim1_SS1_N            : out   std_logic;                                        -- hps_io_phery_spim1_SS1_N
			hps_io_hps_io_phery_trace_CLK              : out   std_logic;                                        -- hps_io_phery_trace_CLK
			hps_io_hps_io_phery_trace_D0               : out   std_logic;                                        -- hps_io_phery_trace_D0
			hps_io_hps_io_phery_trace_D1               : out   std_logic;                                        -- hps_io_phery_trace_D1
			hps_io_hps_io_phery_trace_D2               : out   std_logic;                                        -- hps_io_phery_trace_D2
			hps_io_hps_io_phery_trace_D3               : out   std_logic;                                        -- hps_io_phery_trace_D3
			hps_io_hps_io_phery_uart1_RX               : in    std_logic                     := 'X';             -- hps_io_phery_uart1_RX
			hps_io_hps_io_phery_uart1_TX               : out   std_logic;                                        -- hps_io_phery_uart1_TX
			hps_io_hps_io_phery_i2c1_SDA               : inout std_logic                     := 'X';             -- hps_io_phery_i2c1_SDA
			hps_io_hps_io_phery_i2c1_SCL               : inout std_logic                     := 'X';             -- hps_io_phery_i2c1_SCL
			hps_io_hps_io_gpio_gpio1_io5               : inout std_logic                     := 'X';             -- hps_io_gpio_gpio1_io5
			hps_io_hps_io_gpio_gpio1_io14              : inout std_logic                     := 'X';             -- hps_io_gpio_gpio1_io14
			hps_io_hps_io_gpio_gpio1_io16              : inout std_logic                     := 'X';             -- hps_io_gpio_gpio1_io16
			hps_io_hps_io_gpio_gpio1_io17              : inout std_logic                     := 'X';             -- hps_io_gpio_gpio1_io17
			clk_clk                                    : in    std_logic                     := 'X';             -- clk
			emif_a10_hps_0_pll_ref_clk_clock_sink_clk  : in    std_logic                     := 'X';             -- clk
			emif_a10_hps_0_oct_conduit_end_oct_rzqin   : in    std_logic                     := 'X';             -- oct_rzqin
			emif_a10_hps_0_mem_conduit_end_mem_ck      : out   std_logic_vector(0 downto 0);                     -- mem_ck
			emif_a10_hps_0_mem_conduit_end_mem_ck_n    : out   std_logic_vector(0 downto 0);                     -- mem_ck_n
			emif_a10_hps_0_mem_conduit_end_mem_a       : out   std_logic_vector(16 downto 0);                    -- mem_a
			emif_a10_hps_0_mem_conduit_end_mem_act_n   : out   std_logic_vector(0 downto 0);                     -- mem_act_n
			emif_a10_hps_0_mem_conduit_end_mem_ba      : out   std_logic_vector(1 downto 0);                     -- mem_ba
			emif_a10_hps_0_mem_conduit_end_mem_bg      : out   std_logic_vector(0 downto 0);                     -- mem_bg
			emif_a10_hps_0_mem_conduit_end_mem_cke     : out   std_logic_vector(0 downto 0);                     -- mem_cke
			emif_a10_hps_0_mem_conduit_end_mem_cs_n    : out   std_logic_vector(0 downto 0);                     -- mem_cs_n
			emif_a10_hps_0_mem_conduit_end_mem_odt     : out   std_logic_vector(0 downto 0);                     -- mem_odt
			emif_a10_hps_0_mem_conduit_end_mem_reset_n : out   std_logic_vector(0 downto 0);                     -- mem_reset_n
			emif_a10_hps_0_mem_conduit_end_mem_par     : out   std_logic_vector(0 downto 0);                     -- mem_par
			emif_a10_hps_0_mem_conduit_end_mem_alert_n : in    std_logic_vector(0 downto 0)  := (others => 'X'); -- mem_alert_n
			emif_a10_hps_0_mem_conduit_end_mem_dqs     : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			emif_a10_hps_0_mem_conduit_end_mem_dqs_n   : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			emif_a10_hps_0_mem_conduit_end_mem_dq      : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			emif_a10_hps_0_mem_conduit_end_mem_dbi_n   : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dbi_n
			num1_export                                : out   std_logic_vector(31 downto 0);                    -- export
			num2_export                                : out   std_logic_vector(31 downto 0);                    -- export
			result_export                              : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			hps_fpga_reset_reset                       : out   std_logic;                                        -- reset
			reset_reset_n                              : in    std_logic                     := 'X'              -- reset_n
		);
	end component qsys_top;

	u0 : component qsys_top
		port map (
			hps_io_hps_io_phery_emac0_TX_CLK           => CONNECTED_TO_hps_io_hps_io_phery_emac0_TX_CLK,           --                                hps_io.hps_io_phery_emac0_TX_CLK
			hps_io_hps_io_phery_emac0_TXD0             => CONNECTED_TO_hps_io_hps_io_phery_emac0_TXD0,             --                                      .hps_io_phery_emac0_TXD0
			hps_io_hps_io_phery_emac0_TXD1             => CONNECTED_TO_hps_io_hps_io_phery_emac0_TXD1,             --                                      .hps_io_phery_emac0_TXD1
			hps_io_hps_io_phery_emac0_TXD2             => CONNECTED_TO_hps_io_hps_io_phery_emac0_TXD2,             --                                      .hps_io_phery_emac0_TXD2
			hps_io_hps_io_phery_emac0_TXD3             => CONNECTED_TO_hps_io_hps_io_phery_emac0_TXD3,             --                                      .hps_io_phery_emac0_TXD3
			hps_io_hps_io_phery_emac0_RX_CTL           => CONNECTED_TO_hps_io_hps_io_phery_emac0_RX_CTL,           --                                      .hps_io_phery_emac0_RX_CTL
			hps_io_hps_io_phery_emac0_TX_CTL           => CONNECTED_TO_hps_io_hps_io_phery_emac0_TX_CTL,           --                                      .hps_io_phery_emac0_TX_CTL
			hps_io_hps_io_phery_emac0_RX_CLK           => CONNECTED_TO_hps_io_hps_io_phery_emac0_RX_CLK,           --                                      .hps_io_phery_emac0_RX_CLK
			hps_io_hps_io_phery_emac0_RXD0             => CONNECTED_TO_hps_io_hps_io_phery_emac0_RXD0,             --                                      .hps_io_phery_emac0_RXD0
			hps_io_hps_io_phery_emac0_RXD1             => CONNECTED_TO_hps_io_hps_io_phery_emac0_RXD1,             --                                      .hps_io_phery_emac0_RXD1
			hps_io_hps_io_phery_emac0_RXD2             => CONNECTED_TO_hps_io_hps_io_phery_emac0_RXD2,             --                                      .hps_io_phery_emac0_RXD2
			hps_io_hps_io_phery_emac0_RXD3             => CONNECTED_TO_hps_io_hps_io_phery_emac0_RXD3,             --                                      .hps_io_phery_emac0_RXD3
			hps_io_hps_io_phery_emac0_MDIO             => CONNECTED_TO_hps_io_hps_io_phery_emac0_MDIO,             --                                      .hps_io_phery_emac0_MDIO
			hps_io_hps_io_phery_emac0_MDC              => CONNECTED_TO_hps_io_hps_io_phery_emac0_MDC,              --                                      .hps_io_phery_emac0_MDC
			hps_io_hps_io_phery_sdmmc_CMD              => CONNECTED_TO_hps_io_hps_io_phery_sdmmc_CMD,              --                                      .hps_io_phery_sdmmc_CMD
			hps_io_hps_io_phery_sdmmc_D0               => CONNECTED_TO_hps_io_hps_io_phery_sdmmc_D0,               --                                      .hps_io_phery_sdmmc_D0
			hps_io_hps_io_phery_sdmmc_D1               => CONNECTED_TO_hps_io_hps_io_phery_sdmmc_D1,               --                                      .hps_io_phery_sdmmc_D1
			hps_io_hps_io_phery_sdmmc_D2               => CONNECTED_TO_hps_io_hps_io_phery_sdmmc_D2,               --                                      .hps_io_phery_sdmmc_D2
			hps_io_hps_io_phery_sdmmc_D3               => CONNECTED_TO_hps_io_hps_io_phery_sdmmc_D3,               --                                      .hps_io_phery_sdmmc_D3
			hps_io_hps_io_phery_sdmmc_D4               => CONNECTED_TO_hps_io_hps_io_phery_sdmmc_D4,               --                                      .hps_io_phery_sdmmc_D4
			hps_io_hps_io_phery_sdmmc_D5               => CONNECTED_TO_hps_io_hps_io_phery_sdmmc_D5,               --                                      .hps_io_phery_sdmmc_D5
			hps_io_hps_io_phery_sdmmc_D6               => CONNECTED_TO_hps_io_hps_io_phery_sdmmc_D6,               --                                      .hps_io_phery_sdmmc_D6
			hps_io_hps_io_phery_sdmmc_D7               => CONNECTED_TO_hps_io_hps_io_phery_sdmmc_D7,               --                                      .hps_io_phery_sdmmc_D7
			hps_io_hps_io_phery_sdmmc_CCLK             => CONNECTED_TO_hps_io_hps_io_phery_sdmmc_CCLK,             --                                      .hps_io_phery_sdmmc_CCLK
			hps_io_hps_io_phery_usb0_DATA0             => CONNECTED_TO_hps_io_hps_io_phery_usb0_DATA0,             --                                      .hps_io_phery_usb0_DATA0
			hps_io_hps_io_phery_usb0_DATA1             => CONNECTED_TO_hps_io_hps_io_phery_usb0_DATA1,             --                                      .hps_io_phery_usb0_DATA1
			hps_io_hps_io_phery_usb0_DATA2             => CONNECTED_TO_hps_io_hps_io_phery_usb0_DATA2,             --                                      .hps_io_phery_usb0_DATA2
			hps_io_hps_io_phery_usb0_DATA3             => CONNECTED_TO_hps_io_hps_io_phery_usb0_DATA3,             --                                      .hps_io_phery_usb0_DATA3
			hps_io_hps_io_phery_usb0_DATA4             => CONNECTED_TO_hps_io_hps_io_phery_usb0_DATA4,             --                                      .hps_io_phery_usb0_DATA4
			hps_io_hps_io_phery_usb0_DATA5             => CONNECTED_TO_hps_io_hps_io_phery_usb0_DATA5,             --                                      .hps_io_phery_usb0_DATA5
			hps_io_hps_io_phery_usb0_DATA6             => CONNECTED_TO_hps_io_hps_io_phery_usb0_DATA6,             --                                      .hps_io_phery_usb0_DATA6
			hps_io_hps_io_phery_usb0_DATA7             => CONNECTED_TO_hps_io_hps_io_phery_usb0_DATA7,             --                                      .hps_io_phery_usb0_DATA7
			hps_io_hps_io_phery_usb0_CLK               => CONNECTED_TO_hps_io_hps_io_phery_usb0_CLK,               --                                      .hps_io_phery_usb0_CLK
			hps_io_hps_io_phery_usb0_STP               => CONNECTED_TO_hps_io_hps_io_phery_usb0_STP,               --                                      .hps_io_phery_usb0_STP
			hps_io_hps_io_phery_usb0_DIR               => CONNECTED_TO_hps_io_hps_io_phery_usb0_DIR,               --                                      .hps_io_phery_usb0_DIR
			hps_io_hps_io_phery_usb0_NXT               => CONNECTED_TO_hps_io_hps_io_phery_usb0_NXT,               --                                      .hps_io_phery_usb0_NXT
			hps_io_hps_io_phery_spim1_CLK              => CONNECTED_TO_hps_io_hps_io_phery_spim1_CLK,              --                                      .hps_io_phery_spim1_CLK
			hps_io_hps_io_phery_spim1_MOSI             => CONNECTED_TO_hps_io_hps_io_phery_spim1_MOSI,             --                                      .hps_io_phery_spim1_MOSI
			hps_io_hps_io_phery_spim1_MISO             => CONNECTED_TO_hps_io_hps_io_phery_spim1_MISO,             --                                      .hps_io_phery_spim1_MISO
			hps_io_hps_io_phery_spim1_SS0_N            => CONNECTED_TO_hps_io_hps_io_phery_spim1_SS0_N,            --                                      .hps_io_phery_spim1_SS0_N
			hps_io_hps_io_phery_spim1_SS1_N            => CONNECTED_TO_hps_io_hps_io_phery_spim1_SS1_N,            --                                      .hps_io_phery_spim1_SS1_N
			hps_io_hps_io_phery_trace_CLK              => CONNECTED_TO_hps_io_hps_io_phery_trace_CLK,              --                                      .hps_io_phery_trace_CLK
			hps_io_hps_io_phery_trace_D0               => CONNECTED_TO_hps_io_hps_io_phery_trace_D0,               --                                      .hps_io_phery_trace_D0
			hps_io_hps_io_phery_trace_D1               => CONNECTED_TO_hps_io_hps_io_phery_trace_D1,               --                                      .hps_io_phery_trace_D1
			hps_io_hps_io_phery_trace_D2               => CONNECTED_TO_hps_io_hps_io_phery_trace_D2,               --                                      .hps_io_phery_trace_D2
			hps_io_hps_io_phery_trace_D3               => CONNECTED_TO_hps_io_hps_io_phery_trace_D3,               --                                      .hps_io_phery_trace_D3
			hps_io_hps_io_phery_uart1_RX               => CONNECTED_TO_hps_io_hps_io_phery_uart1_RX,               --                                      .hps_io_phery_uart1_RX
			hps_io_hps_io_phery_uart1_TX               => CONNECTED_TO_hps_io_hps_io_phery_uart1_TX,               --                                      .hps_io_phery_uart1_TX
			hps_io_hps_io_phery_i2c1_SDA               => CONNECTED_TO_hps_io_hps_io_phery_i2c1_SDA,               --                                      .hps_io_phery_i2c1_SDA
			hps_io_hps_io_phery_i2c1_SCL               => CONNECTED_TO_hps_io_hps_io_phery_i2c1_SCL,               --                                      .hps_io_phery_i2c1_SCL
			hps_io_hps_io_gpio_gpio1_io5               => CONNECTED_TO_hps_io_hps_io_gpio_gpio1_io5,               --                                      .hps_io_gpio_gpio1_io5
			hps_io_hps_io_gpio_gpio1_io14              => CONNECTED_TO_hps_io_hps_io_gpio_gpio1_io14,              --                                      .hps_io_gpio_gpio1_io14
			hps_io_hps_io_gpio_gpio1_io16              => CONNECTED_TO_hps_io_hps_io_gpio_gpio1_io16,              --                                      .hps_io_gpio_gpio1_io16
			hps_io_hps_io_gpio_gpio1_io17              => CONNECTED_TO_hps_io_hps_io_gpio_gpio1_io17,              --                                      .hps_io_gpio_gpio1_io17
			clk_clk                                    => CONNECTED_TO_clk_clk,                                    --                                   clk.clk
			emif_a10_hps_0_pll_ref_clk_clock_sink_clk  => CONNECTED_TO_emif_a10_hps_0_pll_ref_clk_clock_sink_clk,  -- emif_a10_hps_0_pll_ref_clk_clock_sink.clk
			emif_a10_hps_0_oct_conduit_end_oct_rzqin   => CONNECTED_TO_emif_a10_hps_0_oct_conduit_end_oct_rzqin,   --        emif_a10_hps_0_oct_conduit_end.oct_rzqin
			emif_a10_hps_0_mem_conduit_end_mem_ck      => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_ck,      --        emif_a10_hps_0_mem_conduit_end.mem_ck
			emif_a10_hps_0_mem_conduit_end_mem_ck_n    => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_ck_n,    --                                      .mem_ck_n
			emif_a10_hps_0_mem_conduit_end_mem_a       => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_a,       --                                      .mem_a
			emif_a10_hps_0_mem_conduit_end_mem_act_n   => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_act_n,   --                                      .mem_act_n
			emif_a10_hps_0_mem_conduit_end_mem_ba      => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_ba,      --                                      .mem_ba
			emif_a10_hps_0_mem_conduit_end_mem_bg      => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_bg,      --                                      .mem_bg
			emif_a10_hps_0_mem_conduit_end_mem_cke     => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_cke,     --                                      .mem_cke
			emif_a10_hps_0_mem_conduit_end_mem_cs_n    => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_cs_n,    --                                      .mem_cs_n
			emif_a10_hps_0_mem_conduit_end_mem_odt     => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_odt,     --                                      .mem_odt
			emif_a10_hps_0_mem_conduit_end_mem_reset_n => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_reset_n, --                                      .mem_reset_n
			emif_a10_hps_0_mem_conduit_end_mem_par     => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_par,     --                                      .mem_par
			emif_a10_hps_0_mem_conduit_end_mem_alert_n => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_alert_n, --                                      .mem_alert_n
			emif_a10_hps_0_mem_conduit_end_mem_dqs     => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_dqs,     --                                      .mem_dqs
			emif_a10_hps_0_mem_conduit_end_mem_dqs_n   => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_dqs_n,   --                                      .mem_dqs_n
			emif_a10_hps_0_mem_conduit_end_mem_dq      => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_dq,      --                                      .mem_dq
			emif_a10_hps_0_mem_conduit_end_mem_dbi_n   => CONNECTED_TO_emif_a10_hps_0_mem_conduit_end_mem_dbi_n,   --                                      .mem_dbi_n
			num1_export                                => CONNECTED_TO_num1_export,                                --                                  num1.export
			num2_export                                => CONNECTED_TO_num2_export,                                --                                  num2.export
			result_export                              => CONNECTED_TO_result_export,                              --                                result.export
			hps_fpga_reset_reset                       => CONNECTED_TO_hps_fpga_reset_reset,                       --                        hps_fpga_reset.reset
			reset_reset_n                              => CONNECTED_TO_reset_reset_n                               --                                 reset.reset_n
		);

