`include"apb_slave.v"
`include "apb_master.v"

module amba_apb(input pclk,preset,transfer,mpwrite,
input [7:0] apb_write_paddr,apb_write_data,apb_read_paddr,
output [7:0]prdata,apb_read_data_out ,output psel,penable);

wire pready,pwrite;
wire [7:0] paddr,pwdata;

apb_master master(.pclk(pclk),.preset(preset),.transfer(transfer),.mpwrite(mpwrite),.pready(pready),
.apb_write_paddr(apb_write_paddr),.apb_write_data(apb_write_data),.apb_read_paddr(apb_read_paddr),.prdata(prdata),
.psel(psel),.penable(penable),.spwrite(pwrite),.paddr(paddr),.pwdata(pwdata),.apb_read_data_out(apb_read_data_out));

apb_slave slave(.pclk(pclk),.preset(preset),.psel(psel),.penable(penable),.pwrite(pwrite),
.paddr(paddr),.pwdata(pwdata),.pready(pready),.prdata(prdata));

endmodule 