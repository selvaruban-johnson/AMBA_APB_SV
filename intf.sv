interface intf(input bit pclk, preset,transfer);

	logic mpwrite;
	logic [7:0] apb_write_paddr,apb_write_data,apb_read_paddr;
	
	logic psel,penable;
	logic [7:0]prdata,apb_read_data_out;

clocking cb_amba @(posedge pclk);
	default input #1 output #0;

	output transfer;
	output mpwrite;
	output apb_write_paddr;
	output apb_write_data;
	output apb_read_paddr;

	input psel;
	input penable;
	input prdata;
	input apb_read_data_out;

endclocking



endinterface