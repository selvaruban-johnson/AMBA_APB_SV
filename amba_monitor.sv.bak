`include"amba_packet.sv"
`include"Probe_Packet.sv"
class amba_monitor;

	amba_packet dutpkt;
	Probe_Packet probePkt;

	mailbox #(Probe_Packet) mb_mon_scb;

	virtual intf dutIntf;
	virtual Probe_Intf probeIntf;

	function new(mailbox #(Probe_Packet) mb_mon_scb, virtual intf dutintf, virtual Probe_Intf probeIntf);

		this.mb_mon_scb = mb_mon_scb;
		this.dutintf = dutintf;
		this.probeIntf = probeIntf;

	endfunction

	task run();

		$display("MONITOR OUTPUT");

		probePkt = new();
		dutpkt = new();
		
		@(dutintf.cb_amba);
		dutpkt.mpwrite = dutintf.cb_amba.mpwrite;
		//dutpkt.pready = dutintf.cb_amba.pready;
		dutpkt.apb_write_paddr = dutintf.cb_amba.apb_write_paddr;
		dutpkt.apb_write_data = dutintf.cb_amba.apb_write_data;
		dutpkt.apb_read_paddr = dutintf.cb_amba.apb_read_paddr;


		dutpkt.psel = dutintf.cb_amba.psel;
		dutpkt.penable = dutintf.cb_amba.penable;
		dutpkt.prdata = dutintf.cb_amba.prdata;
		dutpkt.apb_read_data_out = dutintf.cb_amba.apb_read_data_out;

		@(probeIntf.cb_Probe);
		probePkt.psel = probeIntf.cb_Probe.psel;
		probePkt.penable = probeIntf.cb_Probe.penable;
		probePkt.pwrite = probeIntf.cb_Probe.pwrite;
		probePkt.paddr = probeIntf.cb_Probe.paddr;

		probePkt.pwdata = probeIntf.cb_Probe.pwdata;
		probePkt.prdata = probeIntf.cb_Probe.prdata;
		probePkt.pready = probeIntf.cb_Probe.pready;

		
		mb_mon_scb.put(probePkt);

		$display("mb_mon_scb : psel = %h\t penable = %h\t pwrite = %h\t paddr = %h\t pwdata = %h\t prdata = %h\t pready = %h",probePkt.psel,probePkt.penable,probePkt.pwrite,probePkt.paddr,probePkt.pwdata,probePkt.prdata,probePkt.pready);
		$display("probeIntf : psel = %h\t penable = %h\t pwrite = %h\t paddr = %h\t pwdata = %h\t prdata = %h\t pready = %h",probeIntf.psel,probeIntf.penable,probeIntf.pwrite,probeIntf.paddr,probeIntf.pwdata,probeIntf.prdata,probeIntf.pready);
		$display("dutpkt : apb_write_paddr = %h\t apb_write_data = %h\t apb_read_paddr = %h\t mpwrite = %h\t psel = %h\t penable=%h\t prdata = %h\t apb_read_data_out = %h\t",dutpkt.apb_write_paddr,dutpkt.apb_write_data,dutpkt.apb_read_paddr,dutpkt.mpwrit,dutpkt.psel,dutpkt.penable,dutpkt.prdata,dutpkt.apb_read_data_out);
		$display("");
		$display("");

	endtask

endclass