//--------------------------------------------------------------------------------------------------------------------
// File         : Controller.sv --> Design of controller module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 1 2018
// Description  : Design of Controller Module, state machine is been designed
//		  It travels between states for diffrent operations based on different input signal controls
//		  from host interface interactions
//		  It controls data flow between memory and host which has communication between buffer and host too
//--------------------------------------------------------------------------------------------------------------------
module Controller (IController.ControllerPorts cntrBus);

import ControllerDefs :: *;

assign cntrBus.DIO = (cntrBus.ALE || cntrBus.CLE || cntrBus.wEn) ? DIO_out : 'bz; //tri state multiplexed bus assignmnet

initial begin
	initialisation;				//initialising the signals
end

//signal initialisation
task initialisation;
	cntrBus.cntrl_in = 'bz;
	cntrBus.cntrl_sel = 0;
	cntrBus.cntrl_we = 0; cntrBus.cntrl_re = 0; cntrBus.cEn = 0;
	cntrBus.nfc_done = 0; cntrBus.ALE = 0; cntrBus.CLE = 0; 
	cntrBus.wEn = 0; cntrBus.rEn = 0;
	cntrBus.command_error = 0;
endtask

always_ff @(posedge cntrBus.clk) begin	//state assignment based upin reset and when in action
	if(cntrBus.Reset)
		cur_state <= Hold;
	else
		cur_state <= next_state;
end

always_comb begin
	case(cur_state)			// state operations

		Hold : begin
			initialisation;		//initialise all signals when on hold state
			
			if(cntrBus.nfc_start && !cntrBus.Reset) begin  //begin operation when start signal asserted
				next_state = Start;
				command = cntrBus.nfc_cmd;
			end
			else
				next_state = Hold;
		end

		Start : begin					//start the operation based upon command and address received
			if(command == host_erase) begin		//erase operation command capture
				next_state = Erase;
				cntrBus.cEn = 1;
			end
			else if(command == host_program_page) begin //program page operation command capture
				next_state = Program_Page;
				cntrBus.cEn = 1;
			end
			else if(command == host_page_read) begin  //page read operation command capture
				next_state = Page_Read;
				cntrBus.cEn = 1;
			end
			else begin				//invalid command operation		
				next_state = Hold;
				cntrBus.nfc_done = 1;
				cntrBus.command_error = 1;
			end
		end

		Erase : begin					//erase command capture
			//cEn = 1;
			cntrBus.CLE = 1;			//assert signlas for memory too
			DIO_out = mem_erase;
			next_state = AddressLatch;
		end

		Erase_Wait : begin				//erase operation is initiated after address is latched
			cntrBus.ALE = 0;
			DIO_out = 'bz;
			if(cntrBus.status) begin
				next_state = Hold;
				cntrBus.nfc_done = 1;
			end
			else begin
				next_state = Erase_Wait;
			end
		end

		Program_Page : begin				//Program page operation latching command
			//cEn = 1;
			cntrBus.CLE = 1;
			DIO_out = mem_program_page;
			next_state =  AddressLatch;
			
		end

		Page_Read : begin				// page read operation latching command
			//cEn = 1;
			cntrBus.CLE = 1;
			DIO_out = mem_page_read;
			next_state =  AddressLatch;
		end

		AddressLatch : begin				//address latch operation for diffrent commands captured
			if(command == host_program_page) begin
				next_state = Write_Memory;
			end
			else if(command == host_page_read) begin
				next_state = Read_Memory;
			end
			else if(command == host_erase) begin
				next_state = Erase_Wait;
			end
			cntrBus.CLE = 0;
			cntrBus.ALE = 1;
			DIO_out = cntrBus.RWA;
		end

		Write_Memory : begin		//Initial write operation signals latching for memory			
			cntrBus.cntrl_sel = 1;
			cntrBus.cntrl_re = 1;
			cntrBus.ALE = 0;
			next_state = Write_Memory_Wait;
			
		end

		Write_Memory_Wait : begin	//Wait for write operation completion on memory(till data is read out of buffer)
			cntrBus.wEn = 1;
			DIO_out = cntrBus.cntrl_out;
			if(cntrBus.buf_cntrl_status) begin
				next_state = Write_To_Memory;
				cntrBus.cntrl_sel = 0;
			end
		end

		Write_To_Memory : begin		//continue write operation till its completely written onto memory
			if(cntrBus.status) begin
				next_state = Hold;
				cntrBus.nfc_done = 1;
			end
		end

		Read_Memory : begin		//memory read till the status is asserted
			cntrBus.ALE = 0;
			cntrBus.rEn = 1;
			cntrBus.cntrl_sel = 1;
			cntrBus.cntrl_we = 1;
			cntrBus.cntrl_in = cntrBus.DIO;
			if(cntrBus.status) begin
				next_state = Read_Buffer;
				cntrBus.cntrl_sel = 0;
				cntrBus.cntrl_we = 0;
			end
		end
	
		Read_Buffer : begin		//remaining read happens onto host from buffer
			cntrBus.cEn = 0;
			cntrBus.rEn = 0;
			
			if(cntrBus.host_buf_status) begin
				next_state = Hold;
				cntrBus.nfc_done = 1;
				
			end
		end

	endcase
end

endmodule : Controller

