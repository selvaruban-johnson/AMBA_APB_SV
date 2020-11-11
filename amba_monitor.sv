`include"amba_packet.sv"
class amba_monitor;

	amba_packet dutpkt,dutpkt_2;

	mailbox #(amba_packet) mb_mon_scb;
	mailbox #(amba_packet) mb_mon_scb2;

	virtual intf dutintf;
	virtual intf dutintf_2;

	function new(mailbox #(amba_packet)mb_mon_scb,mailbox #(amba_packet)mb_mon_scb2, virtual intf dutintf, virtual intf dutintf_2);

		this.mb_mon_scb = mb_mon_scb;
		this.mb_mon_scb2 = mb_mon_scb2;
		this.dutintf = dutintf;
		this.dutintf_2 = dutintf_2;

	endfunction

	task run();

		$display("MONITOR OUTPUT");

		dutpkt = new();
		dutpkt_2 = new();
		
		@(dutintf.cb_amba);
		dutpkt.mpwrite = dutintf.cb_amba.mpwrite;
		dutpkt.apb_write_paddr = dutintf.cb_amba.apb_write_paddr;
		dutpkt.apb_write_data = dutintf.cb_amba.apb_write_data;
		dutpkt.apb_read_paddr = dutintf.cb_amba.apb_read_paddr;


		dutpkt.psel = dutintf.cb_amba.psel;
		dutpkt.penable = dutintf.cb_amba.penable;
		dutpkt.prdata = dutintf.cb_amba.prdata;
		dutpkt.apb_read_data_out = dutintf.cb_amba.apb_read_data_out;



		@(dutintf_2.cb_amba);
		dutpkt_2.mpwrite = dutintf_2.cb_amba.mpwrite;
		dutpkt_2.apb_write_paddr = dutintf_2.cb_amba.apb_write_paddr;
		dutpkt_2.apb_write_data = dutintf_2.cb_amba.apb_write_data;
		dutpkt_2.apb_read_paddr = dutintf_2.cb_amba.apb_read_paddr;


		dutpkt_2.psel = dutintf_2.cb_amba.psel;
		dutpkt_2.penable = dutintf_2.cb_amba.penable;
		dutpkt_2.prdata = dutintf_2.cb_amba.prdata;
		dutpkt_2.apb_read_data_out = dutintf_2.cb_amba.apb_read_data_out;

		
		mb_mon_scb.put(dutpkt);
		mb_mon_scb.put(dutpkt_2);

		$display("dutpkt : apb_write_paddr = %h\t apb_write_data = %h\t apb_read_paddr = %h\t mpwrite = %h\t psel = %h\t penable=%h\t prdata = %h\t apb_read_data_out = %h\t",dutpkt.apb_write_paddr,dutpkt.apb_write_data,dutpkt.apb_read_paddr,dutpkt.mpwrit,dutpkt.psel,dutpkt.penable,dutpkt.prdata,dutpkt.apb_read_data_out);
		$display("dutpkt_2 : apb_write_paddr = %h\t apb_write_data = %h\t apb_read_paddr = %h\t mpwrite = %h\t psel = %h\t penable=%h\t prdata = %h\t apb_read_data_out = %h\t",dutpkt_2.apb_write_paddr,dutpkt_2.apb_write_data,dutpkt_2.apb_read_paddr,dutpkt_2.mpwrit,dutpkt_2.psel,dutpkt_2.penable,dutpkt_2.prdata,dutpkt_2.apb_read_data_out);
		$display("");
		$display("");

	endtask

endclass