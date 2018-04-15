 //////////////////////////////////////////////////////////////
// TOP_Class.sv 
//
// Project Group:	Manjush , Manoja , Sumeeth and Yash 
// Date:		14-Mar-2018
//
// Description:
// ------------
// DUT and Testbench connects at this topmost file. 
// Consists of DUT, test and interface instances 
// DUT and test bench are connected by interface   
////////////////////////////////////////////////////////////////


//`include "NCTest.sv"
//`include "NCIntf.sv"
module Top;
logic clk;				// clock declaration
logic reset;				// reset declaration

initial begin
	clk = 0;			// clock generation
	forever #5 clk = ~clk;
end

initial begin
	reset = 1;			// reset generation
	#5 reset = 0;
end

NCIntf ncIntf(clk,reset);		// DUT and testcase connection by creating instances of interface. 
NCTest test(ncIntf);			// Interface handle is passed to test as argument.

// DUT ports are connected by interface signals  in DUT instance . 
DUT dut (.clk(clk), .Reset(reset), .buf_out(ncIntf.buf_out), .nfc_done(ncIntf.nfc_done), .command_error(ncIntf.command_error), .buf_in(ncIntf.buf_in), 
.buf_sel(ncIntf.buf_sel), .buf_we(ncIntf.buf_we), .buf_re(ncIntf.buf_re),
.nfc_cmd(ncIntf.nfc_cmd), .RWA(ncIntf.RWA), .nfc_start(ncIntf.nfc_start));



endmodule : Top
