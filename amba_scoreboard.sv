`include "amba_packet.sv"
class amba_scoreboard;

	amba_packet dutpkt,dutpkt_2;
	
	mailbox #(amba_packet) mb_mon_scb;
	mailbox #(amba_packet) mb_mon_scb2;


	function new(mailbox #(amba_packet) mb_mon_scb,mailbox #(amba_packet) mb_mon_scb2);
		this.mb_mon_scb = mb_mon_scb;
		this.mb_mon_scb2 = mb_mon_scb2;
	endfunction

	task run();

		$display("SCOREBOARD OUTPUT");

		mb_mon_scb.get(dutpkt);
		mb_mon_scb2.get(dutpkt2);

		logic psel;
		logic penable;
		logic [7:0]prdata;
		logic [7:0]apb_read_data_out

		assert(dutpkt.prdata == dutpkt2.prdata && dutpkt.apb_read_data_out==dutpkt2.apb_read_data_out)
			$display("HIT");
		else
			$error("MISS");

		$display("dutintf : prdata = %h\t apb_read_data_out = %h",dutintf.prdata,dutintf.apb_read_data_out);
		$display("dutintf_2 : prdata = %h\t apb_read_data_out = %h",dutintf_2.prdata,dutintf_2.apb_read_data_out);
		$display("");
		$display("");

	endtask


endclass