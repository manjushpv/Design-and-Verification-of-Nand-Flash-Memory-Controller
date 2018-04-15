 //////////////////////////////////////////////////////////////
// Generator_Class.sv 
//
// Project Group:	Manjush , Manoja , Sumeeth and Yash 
// Date:		14-Mar-2018
//
// Description:
// ------------
// Generate the fields required for random stimulus by "rand keyword" 
// and declaring mailbox which is used  to send randomized transactions to Driver. 
////////////////////////////////////////////////////////////////


//`include "NCTransaction.sv"
class NCGenerator;

rand NCTransaction ncTrans,ncTrans1;			// transaction class declaration 

int seed_count;						
int packet_count;					// packet_counting - number of transactions to be generated.
event finished;						// event 
mailbox genTodrive;					// mailbox declaration

function new (mailbox genTodriv, event finished);	// constructor function for mailbox handling from env

this.finished = finished;
this.genTodrive = genTodriv;

endfunction 

task main();							// repeat packet_count-->  number of transaction packets and directs into mailbox.	
	repeat(packet_count) begin
		ncTrans = new(packet_count - seed_count);
		assert(ncTrans.randomize()) genTodrive.put(ncTrans); 
		else $fatal("NCGenerator :: randomization failed");
		seed_count++;
	end
-> finished;
endtask

endclass : NCGenerator
