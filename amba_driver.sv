class amba_driver;

	amba_packet dutpkt;

	mailbox #(amba_packet) mb_gen_drv;

	virtual intf dutintf;

	function new(mailbox #(amba_packet) mb_gen_drv, virtual intf dutintf);

		this.mb_gen_drv = mb_gen_drv;
		this.dutintf = dutintf;

	endfunction

	task run();

		$display("DRIVER OUTPUT");
		mb_gen_drv.get(dutpkt);

		@(dutintf.cb_amba);
		dutintf.cb_amba.mpwrite <= dutpkt.mpwrite;
		dutintf.cb_amba.pready <= dutpkt.pready;
		dutintf.cb_amba.apb_write_paddr <= dutpkt.apb_write_paddr;
		dutintf.cb_amba.apb_write_data <= dutpkt.apb_write_data;
		dutintf.cb_amba.apb_read_paddr <= dutpkt.apb_read_paddr;

		$display("dutintf : apb_write_paddr = %h\t apb_write_data = %h",dutintf.apb_write_paddr,dutintf.apb_write_data);
		$display("dutpkt : apb_write_paddr = %h\t apb_write_data = %h",dutpkt.apb_write_paddr,dutpkt.apb_write_data);
		$display("");
		$display("");

	endtask

endclass