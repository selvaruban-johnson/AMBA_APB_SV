class amba_environment;

	amba_packet dutPkt;
	amba_generator dutGen;
	amba_driver dutDrv;
	amba_monitor dutMon;
	amba_coverage dutCov;
	amba_scoreboard dutScb;

	virtual Probe_Intf probeIntf;
	virtual intf dutintf;

	mailbox #(amba_packet) mb_gen_drv;
	mailbox #(Probe_Packet) mb_mon_scb;

	function new(virtual Probe_Intf probeIntf, virtual intf dutintf);
		this.probeIntf = probeIntf;
		this.dutintf = dutintf;
	endfunction

	task build();

		mb_gen_drv = new();
		mb_mon_scb = new();

		dutGen = new(mb_gen_drv);
		dutDrv = new(mb_gen_drv,dutintf);
		dutMon = new(mb_mon_scb,dutintf,probeIntf);
		dutScb = new(mb_mon_scb);
		dutCov = new(dutintf);
	endtask

	task run();

		dutGen.run();
		dutDrv.run();
		dutMon.run();
		dutCov.sample();
		dutScb.run();

	endtask

endclass