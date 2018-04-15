//--------------------------------------------------------------------------------------------------------------------
// File         : NCMonitor.sv --> Design of memory controller module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 2 2018
// Description  : Monitor module to capture response from DUT for input packets forced to DUT
//		  It captures all signals and stores into mailbox in order to score it on scoreboard
//--------------------------------------------------------------------------------------------------------------------
//`include "NCTransaction.sv"
`define monitor ncIntf.NC_monitor_cb 
class NCMonitor;

virtual NCIntf ncIntf;
mailbox monToscb;

function new(virtual NCIntf ncIntf, mailbox monToscb);
	this.monToscb = monToscb;
	this.ncIntf = ncIntf;
endfunction

task main();
	forever begin
		NCTransaction ncTrans = new();

		ncTrans.nfc_done = `monitor.nfc_done;
		ncTrans.command_error = `monitor.command_error;
		ncTrans.buf_out = `monitor.buf_out;
		ncTrans.nfc_start = `monitor.nfc_start;
		ncTrans.nfc_cmd = `monitor.nfc_cmd;
		ncTrans.buf_in = `monitor.buf_in;
		ncTrans.buf_sel = `monitor.buf_sel;
		ncTrans.buf_re = `monitor.buf_re;
		ncTrans.buf_we = `monitor.buf_we;
		ncTrans.RWA = `monitor.RWA;

		monToscb.put(ncTrans);
		@(posedge ncIntf.DRIVER.clk);
	end
endtask

endclass : NCMonitor
