 //////////////////////////////////////////////////////////////
// Driver_Class.sv 
//
// Project Group:	Manjush , Manoja , Sumeeth and Yash 
// Date:		14-Mar-2018
//
// Description:
// ------------
// Recieve the stimulus from generator and then drives it to the DUT input 
// interface and pushes the packet in to mailbox . 
////////////////////////////////////////////////////////////////


//`include "NCTransaction.sv"
//`include "WriteScript.sv"
`define driver ncIntf.NC_driver_cb 
`define cmd_erase 0
`define cmd_page_read 2
`define cmd_program_page 1

class NCDriver;						

int no_transactions;					// counting number of transactions 		
virtual NCIntf ncIntf;					// virtual interface handle 
mailbox genTodriv;					// mailbox handle 
logic operation = 0;	
logic [3:0] command;
logic set = 0;
string message;
WriteScript ws = new();

function new(virtual NCIntf intf, mailbox genTodriv);	// constructor for mailbox handle and virtual interface. 
	this.ncIntf = intf;				
	this.genTodriv = genTodriv;
endfunction
							
task reset();						// reset the interface signal values to initial or default to avaoid propagation of garbage values .
	wait(ncIntf.reset);
	`driver.buf_in <= 0;
	`driver.buf_sel <= 0;
	`driver.buf_we <= 0;
	`driver.buf_re <= 0;
	`driver.nfc_cmd <= 0;
	`driver.RWA <= 0;
	`driver.nfc_start <= 0;
	wait(!ncIntf.reset);
endtask : reset

task drive();
	forever begin 					// driving the transaction items to interface signals . 
	NCTransaction ncTrans;
	genTodriv.get(ncTrans);
	@(posedge ncIntf.DRIVER.clk);
	`driver.nfc_start <= ncTrans.nfc_start;
	`driver.nfc_cmd <= ncTrans.nfc_cmd;
	`driver.buf_in <= ncTrans.buf_in;
	
if(!operation) begin					
	`driver.buf_sel <= ncTrans.buf_sel;
	`driver.buf_re <= ncTrans.buf_re;
	`driver.buf_we <= ncTrans.buf_we;
	`driver.RWA <= ncTrans.RWA;
	if(`driver.nfc_start) begin
		command <= ncTrans.nfc_cmd;
		operation <= 1;
	end
end
else begin
	if(!set) begin
		`driver.nfc_start <= 0;
		set <= 1;
		case(command)
			`cmd_erase : begin
				message = $sformatf("\n-----------------------------------------------------\nErase operation started for block %d @%0d",`driver.RWA[15:13],$time);
				$display("\n-----------------------------------------------------\nErase operation started for block %d @%0d",`driver.RWA[15:13],$time);
			end
			`cmd_program_page : begin
				message = $sformatf("\n------------------------------------------------------\nProgram Page operation started for page %d @%0d",`driver.RWA[15:11],$time);
				$display("\n------------------------------------------------------\nProgram Page operation started for page %d @%0d",`driver.RWA[15:11],$time);
			end
			`cmd_page_read : begin
				message = $sformatf("\n------------------------------------------------------\nPage Read operation started for page %d @%0d",`driver.RWA[15:11],$time);
				$display("\n------------------------------------------------------\nPage Read operation started for page %d @%0d",`driver.RWA[15:11],$time);
			end
		endcase
		ws.write(message,1);
	end
	`driver.buf_sel <= `driver.buf_sel;
	`driver.buf_re <= `driver.buf_re;
	`driver.buf_we <= `driver.buf_we;
	`driver.RWA <= `driver.RWA;
end
if(ncIntf.nfc_done) begin			
	operation <= 0;
	set <= 0;
end

	no_transactions++;			// increment the count of no_transactions if randomizations fails 
	end
endtask : drive

endclass : NCDriver 
