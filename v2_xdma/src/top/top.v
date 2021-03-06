module test_board # (		
        parameter PCIE_LANES = 4		

) (	
        
          // DDR3 interface
          output [15:0]ddr3_addr,
          output [2:0]ddr3_ba,
          output ddr3_cas_n,
          output [0:0]ddr3_ck_n,
          output [0:0]ddr3_ck_p,
          output [0:0]ddr3_cke,
          output [0:0]ddr3_cs_n,
          output [3:0]ddr3_dm,
          inout [31:0]ddr3_dq,
          inout [3:0]ddr3_dqs_n,
          inout [3:0]ddr3_dqs_p,
          output [0:0]ddr3_odt,
          output ddr3_ras_n,
          output ddr3_reset_n,
          output ddr3_we_n,
          
          //-- PCIe transceivers
          input  [PCIE_LANES - 1:0]pcie_7x_mgt_rxn,
          input  [PCIE_LANES - 1:0]pcie_7x_mgt_rxp,
          output [PCIE_LANES - 1:0]pcie_7x_mgt_txn,
          output [PCIE_LANES - 1:0]pcie_7x_mgt_txp,
          
          input [0:0]sys_clk_clk_n, //--100 MHz PCIe Clock (connect directly to input pin)
          input [0:0]sys_clk_clk_p,
          input sys_rst_n,          // --Reset to PCIe and DDR cores 
			
	
	// SPI AFE link		
	output spi_clk_o,
        output spi_mosi_o, // srdat
        input  spi_miso_i, 
        output spi_sel, // latch
        output sel0,
        output sel1,

	output [7:0]mlvds_fde_o,
      	
	// Backplane position
	input [3:0]board_id
		
);

assign mlvds_fde_o[7:0] = 8'hFF; // configured as output
assign ddr3_sdram_ras_n = 1'h1;
assign ddr3_sdram_reset_n = 1'h1;
assign ddr3_sdram_we_n = 1'h1;

DMA_core DMA_1 (
    .reset_rtl(sys_rst_n),
    .DIFF_REFCLK_clk_p(sys_clk_clk_p),
    .DIFF_REFCLK_clk_n(sys_clk_clk_n),
    .pcie_7x_mgt_rxn(pcie_7x_mgt_rxn),
    .pcie_7x_mgt_rxp(pcie_7x_mgt_rxp),
    .pcie_7x_mgt_txn(pcie_7x_mgt_txn),
    .pcie_7x_mgt_txp(pcie_7x_mgt_txp)
    
);

endmodule

