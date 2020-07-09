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


	Probe_Intf probeIntf
		(
		 .pclk(pclk),
		 .preset(preset),
		 .psel(apb.slave.psel),
		 .penable(apb.slave.penable),
		 .pwrite(apb.slave.pwrite),
		 .paddr(apb.slave.paddr),
		 .pwdata(apb.slave.pwdata),
		 .pready(apb.slave.pready),
		 .prdata(apb.slave.prdata)
		);


	amba_test t1(probeIntf,dutintf);

endmodule