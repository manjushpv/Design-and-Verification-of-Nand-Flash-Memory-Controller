 //////////////////////////////////////////////////////////////
// TEST_Class.sv 
//
// Project Group:	Manjush , Manoja , Sumeeth and Yash 
// Date:		14-Mar-2018
//
// Description:
// ------------
// Program Block used for writing testcode .  
////////////////////////////////////////////////////////////////

//`include "NCEnv.sv"

program NCTest(NCIntf ncIntf);

NCEnv env; 				// environment class declaration 

initial begin
env = new(ncIntf);			// environment creating 
env.ncGen.packet_count = 50000;		// generate 50000 packets by repeating count in generator 
env.run();				// from env calling the run functions which inturn will call generator and driver main tasks 
end

endprogram : NCTest
