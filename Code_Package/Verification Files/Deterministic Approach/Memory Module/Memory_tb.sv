//--------------------------------------------------------------------------------------------------------------------
// File         : Memory_tb.sv --> TB for Design of Memory module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 4 2018
// Description  : Tb for Design of Memory Module, 
//		  All cases covered for different operations performed
//		  Operations involves Program Page, Page read and block erase
//--------------------------------------------------------------------------------------------------------------------
module Memory_tb(IMemory.MemoryPorts_tb MemBus_tb);
parameter DIOWidth = 16;

logic [DIOWidth - 1 : 0] DIO_out;

//control of tri bus driver
assign MemBus_tb.DIO_memCntrl = (MemBus_tb.ALE || MemBus_tb.CLE || MemBus_tb.wEn) ? DIO_out : 'bz;

initial begin

	//chip enable for memory kept high
	MemBus_tb.cEn = 1;
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h0,16'hz};
	
	//erase
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h4,16'h0}; end
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h8,16'h0}; end
	repeat(2) @(posedge MemBus_tb.clk)begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h0,16'h0}; end

	//program page
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h4,16'h1}; end
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h8,16'h40}; end
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h2,16'h00}; end
	repeat(2050) @(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h2,DIO_out + 16'h1}; end
	@(posedge MemBus_tb.clk) begin
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h0,16'hz}; end

	//page read
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h4,16'h2}; end
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h8,16'h30}; end
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h1,16'h00}; end
	repeat(2050) @(posedge MemBus_tb.clk);
	@(posedge MemBus_tb.clk) begin
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h0,16'hz}; end

	//insertions
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h4,16'h1}; end
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h4,16'h30}; end
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h4,16'h2}; end
/*
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h3,16'h1}; end
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'hc,16'h1}; end
*/
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h8,16'h40}; end
	@(posedge MemBus_tb.clk) begin 
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h1,16'h40}; end
	repeat(20) @(posedge MemBus_tb.clk);
	@(posedge MemBus_tb.clk) begin
	{MemBus_tb.ALE, MemBus_tb.CLE, MemBus_tb.wEn, MemBus_tb.rEn, DIO_out} = {4'h0,16'hz}; end
/*
	repeat(2045) @(posedge MemBus_tb.clk) begin DIO_out = DIO_out+1; end
	@(posedge MemBus_tb.clk) begin DIO_out = 5; end
	@(posedge MemBus_tb.clk) begin MemBus_tb.CLE = 1; end
	@(posedge MemBus_tb.clk) begin MemBus_tb.wEn = 0; end
	@(posedge MemBus_tb.clk) begin MemBus_tb.wEn = 0;MemBus_tb.CLE = 1; DIO_out = 2; end
	@(posedge MemBus_tb.clk) begin MemBus_tb.CLE = 1;DIO_out=0; end
	@(posedge MemBus_tb.clk) begin MemBus_tb.CLE = 0;MemBus_tb.ALE=1; end
	@(posedge MemBus_tb.clk) begin MemBus_tb.ALE = 0; MemBus_tb.rEn = 1; end
	repeat(2047) @(posedge MemBus_tb.clk);
	@(posedge MemBus_tb.clk) begin MemBus_tb.rEn = 0; MemBus_tb.cEn = 0; end*/
	repeat(2) @(posedge MemBus_tb.clk);
	$stop;
end

endmodule : Memory_tb
