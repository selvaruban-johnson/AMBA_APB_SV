class amba_environment;

	amba_packet dutPkt;
	amba_generator dutGen;
	amba_driver dutDrv;
	amba_monitor dutMon;
	amba_scoreboard dutScb;

	virtual intf dutintf_2;
	virtual intf dutintf;

	mailbox #(amba_packet) mb_gen_drv;
	mailbox #(amba_packet) mb_mon_scb;
	mailbox #(amba_packet) mb_mon_scb2;

	function new(virtual intf dutintf, virtual intf dutintf_2);
		this.dutintf = dutintf;
		this.dutintf_2 = dutintf_2;
	endfunction

	task build();

		mb_gen_drv = new();
		mb_mon_scb = new();

		dutGen = new(mb_gen_drv);
		dutDrv = new(mb_gen_drv,dutintf,dutintf_2);
		dutMon = new(mb_mon_scb,mb_mon_scb2,dutintf,dutintf_2);
		dutScb = new(mb_mon_scb,mb_mon_scb2);
		endtask

	task run();

		dutGen.run();
		dutDrv.run();
		dutMon.run();
		dutScb.run();

	endtask

endclass