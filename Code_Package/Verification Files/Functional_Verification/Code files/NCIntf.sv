 //////////////////////////////////////////////////////////////
// Interface_Class.sv 
//
// Project Group:	Manjush , Manoja , Sumeeth and Yash 
// Date:		14-Mar-2018
//
// Description:
// ------------
// Signals will be grouped , the direction will specified in modport. 
// Signals will be syncronized with clocking block.   
// clocking block - introduce input /output sampling/driving delays 
// Modport defines direction of signals and can be used to represent set of signals
////////////////////////////////////////////////////////////////


interface NCIntf(input logic clk, reset);

	parameter DIOWidth = 16; 
	parameter AddressWidth = 16;
	parameter CommandWidth = 3;

	//signals declarations
	logic [DIOWidth -1 :0] 	buf_out;
     	logic			nfc_done;
     	logic			command_error;
   	logic[DIOWidth -1:0]	buf_in;
   	logic			buf_sel;
   	logic			buf_we;
   	logic			buf_re;
   	logic[CommandWidth-1:0] nfc_cmd;
   	logic[AddressWidth-1:0]	RWA;
   	logic			nfc_start;
 

	//driver clocking block // 
	clocking NC_driver_cb @(posedge clk);
		default input #1 output #1; 

			input 	buf_out;
			input 	nfc_done;
			input 	command_error;
			output 	buf_in;
			output 	buf_sel;
			output 	buf_we;
			output 	buf_re;
			output 	nfc_cmd;
			output 	RWA;
			output 	nfc_start; 

	endclocking 

	//monitor clocking block
	clocking NC_monitor_cb @(posedge clk);
		default input #1 output #1; 

			input	buf_out;
			input 	nfc_done;
			input 	command_error;
			input 	buf_in;
			input 	buf_sel;
			input 	buf_we;
			input 	buf_re;
			input 	nfc_cmd;
			input 	RWA;
			input 	nfc_start; 

	endclocking 


	modport DRIVER (clocking NC_driver_cb , input clk,reset);
	modport MONITOR (clocking NC_monitor_cb , input clk,reset); 

endinterface : NCIntf
