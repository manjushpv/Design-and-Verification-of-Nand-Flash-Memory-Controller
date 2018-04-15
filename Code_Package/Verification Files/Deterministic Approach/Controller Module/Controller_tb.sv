//--------------------------------------------------------------------------------------------------------------------
// File         : Controller_tb.sv --> TB for Design of Controller module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 4 2018
// Description  : Tb for Design of Controller Module, 
//		  All cases covered for different operations performed
//		  Operations involves Program Page, Page read and block erase
//--------------------------------------------------------------------------------------------------------------------
module Controller_tb(IController.ControllerPorts_tb cntrBus_tb);

parameter AddressWidth = 16;
logic [AddressWidth - 1 : 0] DIO_out;

assign cntrBus_tb.DIO = (cntrBus_tb.rEn) ? DIO_out : 'bz;

initial begin
//initialise with reset
	@(posedge cntrBus_tb.clk)
	{cntrBus_tb.Reset, cntrBus_tb.nfc_start, cntrBus_tb.nfc_cmd, cntrBus_tb.RWA} = {2'h0,3'hz,16'h0};
//block erase operation
	@(posedge cntrBus_tb.clk)
	{cntrBus_tb.Reset, cntrBus_tb.nfc_start, cntrBus_tb.nfc_cmd, cntrBus_tb.RWA} = {2'h3,3'hz,16'h0};
	@(posedge cntrBus_tb.clk)
	{cntrBus_tb.Reset, cntrBus_tb.nfc_start, cntrBus_tb.nfc_cmd, cntrBus_tb.RWA} = {2'h1,3'h0,16'h0};
	@(posedge cntrBus_tb.clk)
	{cntrBus_tb.Reset, cntrBus_tb.nfc_start, cntrBus_tb.nfc_cmd, cntrBus_tb.RWA} = {2'h0,3'hz,16'h0};

//program page operation
	repeat(3) @(posedge cntrBus_tb.clk); 
	cntrBus_tb.status = 1;
	@(posedge cntrBus_tb.clk); cntrBus_tb.status = 0;
	@(posedge cntrBus_tb.clk)
	{cntrBus_tb.Reset, cntrBus_tb.buf_cntrl_status, cntrBus_tb.nfc_start, cntrBus_tb.nfc_cmd, cntrBus_tb.RWA, cntrBus_tb.cntrl_out} = {3'h1,3'h1,16'h13,16'h20};
	repeat(2050) @(posedge cntrBus_tb.clk)
	{cntrBus_tb.Reset, cntrBus_tb.buf_cntrl_status, cntrBus_tb.nfc_start, cntrBus_tb.nfc_cmd, cntrBus_tb.RWA, cntrBus_tb.cntrl_out} = {3'h0,3'hz,16'h13,cntrBus_tb.cntrl_out+16'h1};
	
	repeat(3) @(posedge cntrBus_tb.clk)
	{cntrBus_tb.Reset, cntrBus_tb.buf_cntrl_status, cntrBus_tb.nfc_start, cntrBus_tb.nfc_cmd, cntrBus_tb.RWA, cntrBus_tb.cntrl_out} = {3'h2,3'hz,16'h13,cntrBus_tb.cntrl_out+16'h1};

	@(posedge cntrBus_tb.clk); cntrBus_tb.status = 1;
	@(posedge cntrBus_tb.clk); cntrBus_tb.status = 0;

	repeat(7) @(posedge cntrBus_tb.clk)
	{cntrBus_tb.Reset, cntrBus_tb.buf_cntrl_status, cntrBus_tb.nfc_start, cntrBus_tb.nfc_cmd, cntrBus_tb.RWA, cntrBus_tb.cntrl_out} = {3'h0,3'hz,16'h13,cntrBus_tb.cntrl_out+16'h1};
	
//page read operation
	repeat(5) @(posedge cntrBus_tb.clk);
	@(posedge cntrBus_tb.clk) 
	{cntrBus_tb.Reset, cntrBus_tb.host_buf_status, cntrBus_tb.nfc_start, cntrBus_tb.nfc_cmd, cntrBus_tb.RWA, DIO_out} = {3'h1,3'h2,16'h13,16'h20};
	@(posedge cntrBus_tb.clk) 
	{cntrBus_tb.Reset, cntrBus_tb.host_buf_status, cntrBus_tb.nfc_start, cntrBus_tb.nfc_cmd, cntrBus_tb.RWA, DIO_out} = {3'h0,3'hz,16'h13,16'h30};
	repeat(2056) @(posedge cntrBus_tb.clk) 
	{cntrBus_tb.Reset, cntrBus_tb.host_buf_status, cntrBus_tb.nfc_start, cntrBus_tb.nfc_cmd, cntrBus_tb.RWA, DIO_out} = {3'h0,3'hz,16'h13,DIO_out + 16'h1};

	@(posedge cntrBus_tb.clk); cntrBus_tb.status = 1;
	@(posedge cntrBus_tb.clk); cntrBus_tb.status = 0;

	@(posedge cntrBus_tb.clk) 
	{cntrBus_tb.Reset, cntrBus_tb.host_buf_status, cntrBus_tb.nfc_start, cntrBus_tb.nfc_cmd, cntrBus_tb.RWA, DIO_out} = {3'h2,3'hz,16'h13,16'h1};
	repeat(7) @(posedge cntrBus_tb.clk) 
	{cntrBus_tb.Reset, cntrBus_tb.host_buf_status, cntrBus_tb.nfc_start, cntrBus_tb.nfc_cmd, cntrBus_tb.RWA, DIO_out} = {3'h0,3'hz,16'h13,16'hz};
	
	repeat(5) @(posedge cntrBus_tb.clk);
	$stop;
end

endmodule : Controller_tb
