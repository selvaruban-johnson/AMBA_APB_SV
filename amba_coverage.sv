class amba_coverage;

	virtual intf dutintf;
	bit pclk;

	covergroup cg @(posedge intf.pclk);

		PSEL: coverpoint dutintf.cb_amba.psel;
		PENABLE : coverpoint dutintf.cb_amba.penable;

		PADDR : coverpoint dutintf.cb_apb.paddr ;

		PWDATA : coverpoint dutintf.cb_apb.pwdata ;

		PREADY : coverpoint dutintf.cb_apb.pready;

		PRDATA : coverpoint dutintf.cb_apb.prdata;

	endgroup

	function new(virtual intf dutintf);
		this.dutintf = dutintf;
		this.pclk = pclk;
		cg = new();
	endfunction

	task sample();
		cg.sample();
	endtask

endclass