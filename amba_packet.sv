class amba_packet;

	rand bit mpwrite;
	//rand bit pready;
	rand bit [7:0] apb_write_paddr;
	rand bit [7:0]apb_write_data;
	rand bit [7:0]apb_read_paddr;
	//These are inputs

	logic psel;
	logic penable;
	logic [7:0]prdata;
	logic [7:0]apb_read_data_out;
	//These are outputs


	function void pre_randomize();
	
	endfunction


	function void post_randomize();

	endfunction
endclass