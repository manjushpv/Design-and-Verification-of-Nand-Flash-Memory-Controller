 //////////////////////////////////////////////////////////////
// Environment_Class.sv 
//
// Project Group:	Manjush , Manoja , Sumeeth and Yash 
// Date:		14-Mar-2018
//
// Description:
// ------------
// Environment class is a base class which is used to implement verification environments 
// It Conatins Generator , Mailbox , Driver , Monitor  and Scoreboard 
////////////////////////////////////////////////////////////////


//`include "WriteScript.sv"
//`include "NCTransaction.sv"
//`include "NCGenerator.sv"
//`include "NCDriver.sv"
//`include "NCMonitor.sv"
//`include "NCScoreBoard.sv"

class NCEnv;

NCGenerator ncGen;			// generator instance 
NCDriver ncDriv;			// driver instance
NCMonitor ncMon;			// monitor instance 
NCScoreBoard ncScb;			// scoreboard instance 

virtual NCIntf ncIntf;			// virtual interface 
event finished;				// synchronization of event between generator and test 

mailbox genTodriv;			// mailbox handle - generator to driver 
mailbox monToscb;			// mailbox handle - monitor to scoreboard 

function new(virtual NCIntf ncIntf);	// constructor function for creating mailbox handle 
	this.ncIntf = ncIntf;		//  to get interface from test 
	
	genTodriv = new();		//Creating mailbox handle and same will be shared between generator and driver
	monToscb = new();		//Creating mailbox handle and same will be shared between monitor and scoreboard

	ncGen = new(genTodriv,finished); // creating generator , driver , monitor and scoreboard 
	ncDriv = new(ncIntf,genTodriv);
	ncMon = new(ncIntf,monToscb);
	ncScb = new(monToscb);

endfunction

task pre_test();			 // reset --> initialization
	ncDriv.reset();
endtask

task test();				// generating stimulus and driving stimulus
	fork
	ncGen.main();
	ncDriv.drive();
	ncMon.main();
	ncScb.main();
	join_any
endtask

task post_test();			// wait for completion of generating and driving . 
	wait(finished.triggered);
	wait(ncGen.packet_count == ncDriv.no_transactions);
	wait(ncGen.packet_count == ncScb.no_transactions);
	ncScb.statistics();
endtask

task run();				// Calling the generator and driving activity 
	pre_test();
	test();
	post_test();
	$stop;
endtask

endclass : NCEnv