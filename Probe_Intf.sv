interface Probe_Intf
	(
		input bit pclk,preset,psel,penable,pwrite,
		input logic [7 : 0] paddr,pwdata,prdata,
		input logic pready
	);

clocking cb_Probe @(posedge pclk);
	default input #1 output #0;

	inout psel;
	inout penable,pwrite,pready;
	inout paddr,pwdata,prdata;

endclocking

endinterface