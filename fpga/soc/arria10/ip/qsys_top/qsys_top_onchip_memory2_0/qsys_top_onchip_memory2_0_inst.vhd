	component qsys_top_onchip_memory2_0 is
		port (
			clk         : in  std_logic                     := 'X';             -- clk
			address     : in  std_logic_vector(11 downto 0) := (others => 'X'); -- address
			clken       : in  std_logic                     := 'X';             -- clken
			chipselect  : in  std_logic                     := 'X';             -- chipselect
			write       : in  std_logic                     := 'X';             -- write
			readdata    : out std_logic_vector(7 downto 0);                     -- readdata
			writedata   : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- writedata
			reset       : in  std_logic                     := 'X';             -- reset
			reset_req   : in  std_logic                     := 'X';             -- reset_req
			address2    : in  std_logic_vector(11 downto 0) := (others => 'X'); -- address
			chipselect2 : in  std_logic                     := 'X';             -- chipselect
			clken2      : in  std_logic                     := 'X';             -- clken
			write2      : in  std_logic                     := 'X';             -- write
			readdata2   : out std_logic_vector(7 downto 0);                     -- readdata
			writedata2  : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- writedata
			clk2        : in  std_logic                     := 'X';             -- clk
			reset2      : in  std_logic                     := 'X';             -- reset
			reset_req2  : in  std_logic                     := 'X'              -- reset_req
		);
	end component qsys_top_onchip_memory2_0;

	u0 : component qsys_top_onchip_memory2_0
		port map (
			clk         => CONNECTED_TO_clk,         --   clk1.clk
			address     => CONNECTED_TO_address,     --     s1.address
			clken       => CONNECTED_TO_clken,       --       .clken
			chipselect  => CONNECTED_TO_chipselect,  --       .chipselect
			write       => CONNECTED_TO_write,       --       .write
			readdata    => CONNECTED_TO_readdata,    --       .readdata
			writedata   => CONNECTED_TO_writedata,   --       .writedata
			reset       => CONNECTED_TO_reset,       -- reset1.reset
			reset_req   => CONNECTED_TO_reset_req,   --       .reset_req
			address2    => CONNECTED_TO_address2,    --     s2.address
			chipselect2 => CONNECTED_TO_chipselect2, --       .chipselect
			clken2      => CONNECTED_TO_clken2,      --       .clken
			write2      => CONNECTED_TO_write2,      --       .write
			readdata2   => CONNECTED_TO_readdata2,   --       .readdata
			writedata2  => CONNECTED_TO_writedata2,  --       .writedata
			clk2        => CONNECTED_TO_clk2,        --   clk2.clk
			reset2      => CONNECTED_TO_reset2,      -- reset2.reset
			reset_req2  => CONNECTED_TO_reset_req2   --       .reset_req
		);

