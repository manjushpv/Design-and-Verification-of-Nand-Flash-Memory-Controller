//--------------------------------------------------------------------------------------------------------------------
// File         : NandController_tb.sv --> TB for Design of Top module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 4 2018
// Description  : Tb for Design of Top Module, 
//		  All cases covered for different operations performed
//		  Operations involves Program Page, Page read and block erase
//--------------------------------------------------------------------------------------------------------------------
module NandController_tb(INandController.NCPorts_tb ncBus_tb);

initial begin

//reset memory controller
{ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in} = {5'hz,3'hz,16'hz,16'hz};

//for erase block operation
@(posedge ncBus_tb.clk) {ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in} = {5'h03,3'hz,16'h2048,16'hz};
@(posedge ncBus_tb.clk) {ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in} = {5'h01,3'h0,16'h2048,16'hz};
@(posedge ncBus_tb.clk) {ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in} = {5'h00,3'hz,16'h2048,16'hz};
repeat(5) @(posedge ncBus_tb.clk);

//for program page operation
@(posedge ncBus_tb.clk) {ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in} = {5'h19,3'h1,16'h20,16'h0};
repeat(2047) @(posedge ncBus_tb.clk) {ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in} = {5'h18,3'hz,16'h20,ncBus_tb.buf_in+16'h1};
repeat(5) @(posedge ncBus_tb.clk) {ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in} = {5'h00,3'hz,16'h20,ncBus_tb.buf_in+16'h1};
repeat(5) @(posedge ncBus_tb.clk);

//for page read operation
@(posedge ncBus_tb.clk) {ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in}= {5'h15,3'h2,16'h10,16'h00};
repeat(2054) @(posedge ncBus_tb.clk) {ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in} = {5'h14,3'hz,16'h10,ncBus_tb.buf_in};
@(posedge ncBus_tb.clk) {ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in} = {5'h00,3'hz,16'h10,ncBus_tb.buf_in};
repeat(5) @(posedge ncBus_tb.clk);

//other short reads and writes which is been handled with junk data
@(posedge ncBus_tb.clk) {ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in} = {5'h19,3'h1,16'h20,16'h20};
repeat(2000) @(posedge ncBus_tb.clk) {ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in} = {5'h18,3'hz,16'h20,ncBus_tb.buf_in+16'h1};
@(posedge ncBus_tb.clk) {ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in} = {5'h19,3'hz,16'h20,ncBus_tb.buf_in+16'h1};
repeat(46) @(posedge ncBus_tb.clk) {ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in} = {5'h18,3'hz,16'h20,ncBus_tb.buf_in+16'h1};
repeat(5) @(posedge ncBus_tb.clk) {ncBus_tb.buf_sel, ncBus_tb.buf_we, ncBus_tb.buf_re, ncBus_tb.Reset, 
ncBus_tb.nfc_start, ncBus_tb.nfc_cmd, ncBus_tb.RWA, ncBus_tb.buf_in} = {5'h00,3'hz,16'h20,ncBus_tb.buf_in+16'h1};
repeat(5) @(posedge ncBus_tb.clk);


$stop;

end



endmodule : NandController_tb
