//-------------------------------------------------------------------------------------------
// File         : WriteScript.sv --> transcript writing to log file
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 12 2018
// Description  : Writing the whole transcript result set onto log file
//                Summary is also stated at the end
//--------------------------------------------------------------------------------------------

class WriteScript;

int file; // for file declaration
bit set; //for initial message on summary set

function void openfile();
	file = $fopen("log.txt"); //open file to write onto file
endfunction 

function void initialise(); // write initial message onto file
	$fdisplay(file,"\t\t--------Trace result set begins---------\n\n");
	$fdisplay(file,"\t\t--------Operations Summary---------\n");
endfunction

function void write(string msg,int mode); //fumction to invoke message writing onto file based on verification of operations
		
	if(mode == 1) begin //mode 1 corresponds to messages for individual blocks and pages or operations
		$fdisplay(file,msg);
	end
	else if(mode == 2) begin //mode 2 corresponds to summary display
		if(!set) begin
			$fdisplay(file,"\t\t----------Statistics Summary----------\n");
			set = 1;
		end
		$fdisplay(file,msg);
	end
	else begin // any other mode  to close the file with closing message.
		$fdisplay(file,"\n\n\t\t--------Trace result set ends---------");
		$fclose(file); 
	end
endfunction

endclass : WriteScript // end of class of file write
