	component ILC is
		port (
			reset_n     : in  std_logic                     := 'X';             -- reset_n
			clk         : in  std_logic                     := 'X';             -- clk
			irq         : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- irq
			avmm_addr   : in  std_logic_vector(5 downto 0)  := (others => 'X'); -- address
			avmm_wrdata : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			avmm_write  : in  std_logic                     := 'X';             -- write
			avmm_read   : in  std_logic                     := 'X';             -- read
			avmm_rddata : out std_logic_vector(31 downto 0)                     -- readdata
		);
	end component ILC;

	u0 : component ILC
		port map (
			reset_n     => CONNECTED_TO_reset_n,     --      reset_n.reset_n
			clk         => CONNECTED_TO_clk,         --          clk.clk
			irq         => CONNECTED_TO_irq,         --          irq.irq
			avmm_addr   => CONNECTED_TO_avmm_addr,   -- avalon_slave.address
			avmm_wrdata => CONNECTED_TO_avmm_wrdata, --             .writedata
			avmm_write  => CONNECTED_TO_avmm_write,  --             .write
			avmm_read   => CONNECTED_TO_avmm_read,   --             .read
			avmm_rddata => CONNECTED_TO_avmm_rddata  --             .readdata
		);

