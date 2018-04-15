 //////////////////////////////////////////////////////////////
// ScoreBoard_Class.sv 
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
`define cmd_erase 0
`define cmd_page_read 2
`define cmd_program_page 1
class NCScoreBoard;

mailbox monToscb;

int no_transactions;
logic operation = 0;
logic [15 : 0] mem [0 : (2**16) - 1];
logic [2:0] command;
logic [15:0] address,base_address;
int wait_count;
int error_count, error_operations;
int count;
int block_erase,page_read,program_page;
string message;
WriteScript ws = new();

function new(mailbox monToscb);
	this.monToscb = monToscb;
endfunction

task main();
	NCTransaction ncTrans;
	forever begin
		monToscb.get(ncTrans);
		if(ncTrans.nfc_start && !operation) begin
			operation = 1;
			command = ncTrans.nfc_cmd;
			case(ncTrans.nfc_cmd)
				`cmd_erase : begin
					block_erase++;
					address = ncTrans.RWA & 16'hE000;
					for(int i = address;i<address+(4*(2**11));i++)
						mem[i] = 0;
				end
				`cmd_program_page : begin
					program_page++;
					address = ncTrans.RWA & 16'hF800;
					base_address = address;
					mem[address] = ncTrans.buf_in;
				end
				`cmd_page_read : begin
					page_read++;
					address = ncTrans.RWA & 16'hF800;
					wait_count++;
					base_address = address;
				end
			endcase
		end

		else begin
			case(command)
				`cmd_program_page : begin
					address++;
					if(address < base_address + 16'h800)
						mem[address] = ncTrans.buf_in;
				end
				`cmd_page_read : begin
					if(wait_count<6)
						wait_count++;
					else if(count < 2048)begin
						count++;
						assert(ncTrans.buf_out ==? mem[address]) else
						begin
							error_count++;
							message = $sformatf("Error found @ address-->%h,buf_out --> %h,mem-->%h\t@%0d",address,ncTrans.buf_out,mem[address],$time);
							$error("Error found @ address-->%h,buf_out --> %h,mem-->%h\t@%0d",address,ncTrans.buf_out,mem[address],$time);
						end
						address++;
					end
				end
			endcase
		end

		if(ncTrans.nfc_done) begin
			case(command)
				`cmd_erase : begin
					message = $sformatf("Erase operation successful for block %d @%0d\n------------------------------------------------------",address[15:13],$time);
					 $display("Erase operation successful for block %d @%0d\n------------------------------------------------------",address[15:13],$time);
				end
				`cmd_program_page : begin
					message = $sformatf("Program Page operation successful for page %d @%0d\n------------------------------------------------------",base_address[15:11],$time);
					$display("Program Page operation successful for page %d @%0d\n------------------------------------------------------",base_address[15:11],$time);
				end
				`cmd_page_read : begin
					if(error_count>0) begin
						message = $sformatf("Page Read operation unsuccessful for page %d @%0d\n%0d Errors found------------------------------------------------------",base_address[15:11],$time,error_count);
						$display("Page Read operation unsuccessful for page %d @%0d\n%0d Errors found------------------------------------------------------",base_address[15:11],$time,error_count);
						error_operations++;
					end
					else begin
						message = $sformatf("Page Read operation successful for page %d @%0d\n------------------------------------------------------",base_address[15:11],$time);
						$display("Page Read operation successful for page %d @%0d\n------------------------------------------------------",base_address[15:11],$time);
					end
				end
			endcase
			ws.write(message,1);
			operation = 0;
			wait_count = 0;
			error_count = 0;
		end
	#10;
	no_transactions++;
	end
endtask

task statistics();
	$display("\nTotal number of erase operations performed -->");
	$display("\tBlock Erase : %d",block_erase);
	$display("\tProgram Page : %d",program_page);
	$display("\tPage Read : %d\n",page_read);

	$display("After Verification of the above Statistics -->");
	$display("\tError Operations found : %d\n",error_operations);
	
	message = {$sformatf("\nTotal number of erase operations performed -->\n"),$sformatf("\tBlock Erase : %d\n",block_erase),$sformatf("\tProgram Page : %d\n",program_page),$sformatf("\tPage Read : %d\n\n",page_read),$sformatf("After Verification of the above Statistics -->\n"),$sformatf("\tError Operations found : %d\n\n",error_operations)};
	ws.write(message,2);
	ws.write("",3);
endtask

endclass : NCScoreBoard
