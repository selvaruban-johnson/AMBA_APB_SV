class amba_enerator;

	amba_packet dutpkt;
	mailbox #(amba_packet) mb_gen_drv;

	function new(mailbox #(amba_packet) mb_gen_drv);

		this.mb_gen_drv = mb_gen_drv;

	endfunction

	task run();

		$display("GENERATOR OUTPUT");

		dutpkt = new();

		assert(dutpkt.randomize())
		begin
			$display("apb_write_paddr = %h\t apb_write_data = %h",dutpkt.apb_write_paddr,dutpkt.apb_write_data);
			mb_gen_drv.put(dutpkt);
		end

		else
			$fatal("Randomization failed!");
		
		$display("");
		$display("");

	endtask

endclass