module apb_master(input pclk,preset,transfer,mpwrite,pready,
input [7:0] apb_write_paddr,apb_write_data,apb_read_paddr,prdata,
output reg psel,penable,spwrite,
output reg [7:0]paddr,pwdata,apb_read_data_out);


reg [1:0] state,next;

parameter IDLE = 2'b00,
	  SETUP = 2'b01,
	  ACCESS = 2'b10;

always @(posedge pclk)
begin
	if(preset)
		state= IDLE;
	else
		state = next;
end

always @(state,transfer,mpwrite,pready,apb_write_paddr,apb_write_data,apb_read_paddr,prdata)
begin
paddr = apb_write_paddr;
pwdata = apb_write_data;
spwrite = mpwrite;
apb_read_data_out=prdata;
	case(state)
		IDLE:begin
		     if(transfer)
			next=SETUP;
		     else
		     begin
			next = IDLE;
			apb_read_data_out = 8'b0;
			psel = 0;
			penable = 0;
			paddr = 0;
			pwdata = 0;
		     end
		     end
		
		SETUP:begin
		      next = ACCESS;
		      psel = 1'b1;
		      penable = 1'b0;
		      end
		
		ACCESS: begin
			psel = 1'b1;
			penable = 1'b1;
			if(pready==1'b1 && transfer == 1'b1)
			next = SETUP;
			else if (pready == 1'b1 && transfer == 1'b0)
			next = IDLE;
			else if(pready == 1'b0)
			next = ACCESS;
			end
		endcase
end
endmodule