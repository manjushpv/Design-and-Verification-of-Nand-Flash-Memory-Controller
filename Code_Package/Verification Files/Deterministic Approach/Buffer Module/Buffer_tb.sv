//--------------------------------------------------------------------------------------------------------------------
// File         : Buffer_tb.sv --> TB for Design of Buffer module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 4 2018
// Description  : Tb for Design of Buffer Module, 
//		  All cases covered for different operations performed
//		  Operations involves Program Page, Page read and block erase
// 		  Cases of overwrite and over read are all covered
//		  bus length checks are performed
//--------------------------------------------------------------------------------------------------------------------
module Buffer_tb(IBuffer.BufferPorts_tb bufBus_tb);

always_ff @(posedge bufBus_tb.clk)begin
	if(bufBus_tb.buf_cntrl_status)
		$display("\nstatus is set for buf n cntrl @%0d",$time);
	if(bufBus_tb.host_buf_status)
		$display("\nstatus is set for host n buf @%0d",$time);
end

initial begin
	@(posedge bufBus_tb.clk);

//----> write operation
	//no overlap condition
	$display("\n@ %0d\tWrite --> no overlap",$time);
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re, bufBus_tb.buf_in} = {3'h0,16'h24};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re, bufBus_tb.buf_in} = {3'h6,16'h30};
	repeat(2047) @(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re, bufBus_tb.buf_in} = {3'h6,bufBus_tb.buf_in + 16'h1};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re, bufBus_tb.buf_in} = {3'h6,16'h132};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re} = 3'h0;
	repeat(2048) @(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re} = 3'h5;
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re} = 3'h0;
	repeat(5) @(posedge bufBus_tb.clk);

	//overlap condition
	$display("\n@ %0d\tWrite --> overlap",$time);
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re, bufBus_tb.buf_in} = {3'h0,16'h24};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re, bufBus_tb.buf_in} = {3'h6,16'h40};
	repeat(2) @(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re, bufBus_tb.buf_in} = {3'h6,bufBus_tb.buf_in + 16'h1};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re, bufBus_tb.buf_in, bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re} = {3'h6,bufBus_tb.buf_in + 16'h1,3'h0};
	repeat(2045) @(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re, bufBus_tb.buf_in, bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re} = {3'h6,bufBus_tb.buf_in + 16'h1,3'h5};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re, bufBus_tb.buf_in, bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re} = {3'h0,16'h12,3'h5};
	repeat(3) @(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re} = {3'h5};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re} = {3'h0};
	repeat(5) @(posedge bufBus_tb.clk);

	//first cycle overlap condition
	$display("\n@ %0d\tWrite --> first overlap",$time);
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re, bufBus_tb.buf_in} = {3'h0,16'h2f};
	repeat(2048) @(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re, bufBus_tb.buf_in, bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re} = {3'h6, bufBus_tb.buf_in + 16'h1,3'h5};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re, bufBus_tb.buf_in, bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re} = {3'h0, bufBus_tb.buf_in + 16'h1,3'h5};
	repeat(2) @(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re, bufBus_tb.buf_in, bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re} = {3'h0, bufBus_tb.buf_in + 16'h1,3'h0};
	repeat(5) @(posedge bufBus_tb.clk);

//--->read operation
	//no overlap condition
	$display("\n@ %0d\tRead --> no overlap",$time);
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re, bufBus_tb.cntrl_in} = {3'h0,16'h24};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re, bufBus_tb.cntrl_in} = {3'h6,16'h130};
	repeat(2047) @(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re, bufBus_tb.cntrl_in} = {3'h6,bufBus_tb.cntrl_in + 16'h1};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re, bufBus_tb.cntrl_in} = {3'h0,16'h32};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re} = {3'h0};
	repeat(2048) @(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re} = {3'h5};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re} = {3'h0};
	repeat(5) @(posedge bufBus_tb.clk);

	//overlap condition
	$display("\n@ %0d\tRead --> overlap",$time);
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re, bufBus_tb.cntrl_in} = {3'h0,16'h124};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re, bufBus_tb.cntrl_in} = {3'h6,16'h00};
	repeat(2) @(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re, bufBus_tb.cntrl_in} = {3'h6,bufBus_tb.cntrl_in + 16'h1};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re, bufBus_tb.cntrl_in, bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re} = {3'h6,bufBus_tb.cntrl_in + 16'h1,3'h0};
	repeat(2045) @(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re, bufBus_tb.cntrl_in, bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re} = {3'h6,bufBus_tb.cntrl_in + 16'h1,3'h5};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re, bufBus_tb.cntrl_in, bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re} = {3'h0,16'h32,3'h5};
	repeat(3) @(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re} = {3'h5};
	repeat(3) @(posedge bufBus_tb.clk) 
	{bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re} = {3'h0};
	repeat(5) @(posedge bufBus_tb.clk);

	//first cycle overlap condition
	$display("\n@ %0d\tRead --> first overlap",$time);
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re, bufBus_tb.cntrl_in} = {3'h0,16'h24};
	repeat(2048) @(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re, bufBus_tb.cntrl_in, bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re} = {3'h6,bufBus_tb.cntrl_in + 16'h1,3'h5};
	@(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re, bufBus_tb.cntrl_in, bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re} = {3'h0,bufBus_tb.cntrl_in + 16'h1,3'h5};
	repeat(2) @(posedge bufBus_tb.clk) 
	{bufBus_tb.cntrl_sel, bufBus_tb.cntrl_we, bufBus_tb.cntrl_re, bufBus_tb.cntrl_in, bufBus_tb.buf_sel, bufBus_tb.buf_we, bufBus_tb.buf_re}  = {3'h0,bufBus_tb.cntrl_in + 16'h1,3'h0};
	repeat(5) @(posedge bufBus_tb.clk);

	@(posedge bufBus_tb.clk) $stop;
end

endmodule : Buffer_tb
