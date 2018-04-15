 //////////////////////////////////////////////////////////////
// Transaction_Class.sv 
//
// Project Group:	Manjush , Manoja , Sumeeth and Yash 
// Date:		14-Mar-2018
//
// Description:
// ------------
// Generate the fields required for random stimulus by "rand keyword" and adds constraint to the fields 
////////////////////////////////////////////////////////////////

class NCTransaction;

parameter DIOWidth = 16; 
parameter AddressWidth = 16;
parameter CommandWidth = 3;

// Declaration of transaction items ie inputs and outputs of the block and decalaration of rand operator for inputs. 
     	logic [DIOWidth -1 :0] 	buf_out;
     	logic			nfc_done;
     	logic			command_error;
   rand logic[DIOWidth -1:0]	buf_in;
   rand logic			buf_sel;
   rand logic			buf_we;
   rand logic			buf_re;
   rand logic[CommandWidth-1:0] nfc_cmd;
   rand logic[AddressWidth-1:0]	RWA;
   rand logic			nfc_start;

static bit nfc_start_temp; 

function new(int seed = 0);
	srandom(seed);
endfunction


function void post_randomize;
	nfc_start_temp = nfc_start;	
endfunction

function void print();
	static int count;
	$display("Packet --> %d",count);
	$display("Outputs --> buf_out %h\tnfc_done %h\tcommand_error %h",buf_out,nfc_done,command_error);
	$display("Inputs --> buf_in %h\tbuf_sel %h\tbuf_we %h\t buf_re %h\tnfc_cmd %h\tRWA %h\tnfc_start %h\n",
	buf_in, buf_sel, buf_we, buf_re, nfc_cmd, RWA, nfc_start);
	count++;
endfunction


constraint weigtage {nfc_cmd dist{3'b001:=40,3'b010:=40,3'b000:=10}; // command code signal values = (1,2,0) 
			nfc_start dist{0:=80,1:=20};} // nfc_start - when asserted high starts operation

constraint cmd_range {nfc_cmd inside {0,1,2};} //command always lies in the range

constraint buf_sel_assert{if(nfc_cmd == 0) (buf_sel == 0);	//buf_sel is asserted as per commands and
			else {(buf_sel == 1); (buf_re ^ buf_we);}} //when buf sel, only re or we is asserted

constraint buf_re_we_assert{(!(buf_we & buf_re));} // buf re and we can never be asserted high at the same time
						//extra check upon the above constarint added

constraint buf_sel_nfc_start {if(nfc_start == 0) (buf_sel == 0);}// buf_sel is de-asserted if nfc start is not invoked

constraint buf_cmd_re_we {{nfc_cmd == 1} -> {buf_we};
			{nfc_cmd == 2} -> {buf_re};} // based upon cmd set re/we

constraint nfc_start_pulse {if(nfc_start_temp) {nfc_start == 0};}

endclass : NCTransaction
