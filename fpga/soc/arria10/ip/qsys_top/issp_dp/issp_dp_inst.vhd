	component issp_dp is
		port (
			source     : out std_logic_vector(0 downto 0);        -- source
			source_clk : in  std_logic                    := 'X'  -- clk
		);
	end component issp_dp;

	u0 : component issp_dp
		port map (
			source     => CONNECTED_TO_source,     --    sources.source
			source_clk => CONNECTED_TO_source_clk  -- source_clk.clk
		);

