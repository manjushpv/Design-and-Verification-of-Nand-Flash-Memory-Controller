//--------------------------------------------------------------------------------------------------------------------
// File         : MemoryController_tb.sv --> TB for Design of Memory Controller module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 4 2018
// Description  : Tb for Design of Memory Controller Module, 
//		  All cases covered for different operations performed
//		  Operations involves Program Page, Page read and block erase
//--------------------------------------------------------------------------------------------------------------------

module MemoryController_tb (IMemoryController.mcPorts_tb mcBus_tb);


parameter DataWidth = 16;

logic [DataWidth - 1 : 0] DIO_out;
//control of tri bus driver
assign mcBus_tb.DIO_memCntrl = (mcBus_tb.rEn) ? DIO_out : 'bz;

initial begin
//reset condition
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h00,3'hz,16'h0,16'h0}; DIO_out = 16'h0;
//erase operation
@(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h02,3'hz,16'h0,16'h0}; DIO_out = 16'h0; end

@(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h01,3'h0,16'h0,16'h0}; DIO_out = 16'h0; end

@(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h00,3'hz,16'h0,16'h0}; DIO_out = 16'h0; end
//page program operation
repeat(5) @(posedge mcBus_tb.clk);
@(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h04,3'hz,16'h0,16'h0}; DIO_out = 16'h0; end

@(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h00,3'hz,16'h0,16'h0}; DIO_out = 16'h0; end
//page read operation
repeat(5) @(posedge mcBus_tb.clk);
@(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h31,3'h1,16'h10,16'h30}; DIO_out = 16'h0; end

repeat(2047) @(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h30,3'hz,16'h10,mcBus_tb.buf_in+16'h1}; DIO_out = 16'h0; end

repeat(6) @(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h01,3'hz,16'h10,mcBus_tb.buf_in+16'h1}; DIO_out = 16'h0; end

@(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h04,3'hz,16'h10,mcBus_tb.buf_in+16'h1}; DIO_out = 16'h0; end

@(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h00,3'hz,16'h10,mcBus_tb.buf_in+16'h1}; DIO_out = 16'h0; end
//page program operation with subsequent write
repeat(5) @(posedge mcBus_tb.clk);
@(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h29,3'h2,16'h10,16'h30}; DIO_out = 16'h0; end

repeat(2050) @(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h28,3'hz,16'h10,mcBus_tb.buf_in+16'h1}; DIO_out = DIO_out+16'h1; end

@(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h2c,3'hz,16'h10,mcBus_tb.buf_in+16'h1}; DIO_out = DIO_out+16'h1; end

repeat(5) @(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h28,3'hz,16'h10,mcBus_tb.buf_in+16'h1}; DIO_out = DIO_out+16'h1; end
//deassert all signals
@(posedge mcBus_tb.clk) begin 
{mcBus_tb.buf_sel, mcBus_tb.buf_we, mcBus_tb.buf_re, mcBus_tb.status, mcBus_tb.Reset, 
mcBus_tb.nfc_start, mcBus_tb.nfc_cmd, mcBus_tb.RWA, mcBus_tb.buf_in} = {6'h00,3'hz,16'h10,mcBus_tb.buf_in+16'h1}; DIO_out = DIO_out+16'h1; end

repeat(5) @(posedge mcBus_tb.clk);
$stop;
end

endmodule : MemoryController_tb
