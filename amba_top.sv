`include "amba_header.svh"
module amba_top;

	bit pclk,preset,transfer;

	always #5 pclk++;

	initial
	begin
		preset = 1'b1;
		transfer = 1'b0;
		#100 preset = 1'b0;
		transfer = 1'b1;
	end

	intf dutintf(pclk,preset,transfer);
	intf dutintf_2(pclk,preset,transfer);

	amba_apb apb
		(
			.pclk(pclk),
			.preset(preset),
			.transfer(transfer),
			.mpwrite(dutintf.mpwrite),
			.apb_write_paddr(dutintf.apb_write_paddr),
			.apb_write_data(dutintf.apb_write_data),
			.apb_read_paddr(dutintf.apb_read_paddr),
			.prdata(dutintf.prdata),
			.apb_read_data_out(dutintf.apb_read_data_out),
			.psel(dutintf.psel),
			.penable(dutintf.penable)
		);

	amba_apb apb_model
		(
			.pclk(pclk),
			.preset(preset),
			.transfer(transfer),
			.mpwrite(dutintf_2.mpwrite),
			.apb_write_paddr(dutintf_2.apb_write_paddr),
			.apb_write_data(dutintf_2.apb_write_data),
			.apb_read_paddr(dutintf_2.apb_read_paddr),
			.prdata(dutintf_2.prdata),
			.apb_read_data_out(dutintf_2.apb_read_data_out),
			.psel(dutintf_2.psel),
			.penable(dutintf_2.penable)
		);

	amba_test t1(dutintf,dutintf_2);

endmodule