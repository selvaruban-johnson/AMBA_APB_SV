`include "Probr_Packet.sv"
class amba_scoreboard;

	Probe_Packet probePkt;
	
	mailbox #(Probe_Packet) mb_mon_scb;

	logic scb_psel,scb_penable,scb_pwrite;
	logic [7 : 0] scb_paddr,scb_pwdata,scb_prdata;
	logic scb_pready;
	reg [7:0] mem [63:0];

	function new(mailbox #(Probe_Packet) mb_mon_scb);
		this.mb_mon_scb = mb_mon_scb;
	endfunction

	task run();

		$display("SCOREBOARD OUTPUT");

		probePkt = new();
		mb_mon_scb.get(probePkt);

		scb_psel = probePkt.psel;
		scb_penable = probePkt.penable;
		scb_pwrite = probePkt.pwrite;
		scb_paddr = probePkt.paddr;
		scb_pwdata = probePkt.pwdata;
		scb_prdata = probePkt.prdata;
		scb_pready = probePkt.pready;

		if((scb_psel==1'b1)&&(scb_penable==1'b1)&&(scb_pwrite==1'b1))
			mem[scb_paddr]<=scb_pwdata;
		else
		if((scb_psel==1'b1)&&(scb_penable==1'b1)&&(scb_pwrite==1'b0))
			scb_prdata<=mem[scb_paddr];

		if(scb_psel==1'b1&&scb_penable==1'b1)
			scb_pready = 1'b1;
		else
			scb_pready = 1'b0;


		assert(probePkt.pready == scb_pready)
			$display("pready match");
		else
			$error("pready mismatch");

		assert(probePkt.prdata == scb_prdata)
			$display("prdata match");
		else
			$error("prdata mismatch");


		$display("probePkt : psel = %h\t penable = %h\t pwrite = %h\t paddr = %h\t pwdata = %h\t prdata = %h\t pready = %h",probePkt.psel,probePkt.penable,probePkt.pwrite,probePkt.paddr,probePkt.pwdata,probePkt.prdata,probePkt.pready);
		$display("Dummy : psel = %h\t penable = %h\t pwrite = %h\t paddr = %h\t pwdata = %h\t prdata = %h\t pready = %h",scb_psel,scb_penable,scb_pwrite,scb_paddr,scb_pwdata,scb_prdata,scb_pready);
		$display("");
		$display("");

	endtask

	task pcInit();
		scb_prdata = 8'b0;
	endtask

endclass