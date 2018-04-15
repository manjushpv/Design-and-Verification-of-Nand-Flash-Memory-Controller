//--------------------------------------------------------------------------------------------------------------------
// File         : Controller.sv --> Design of controller module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 1 2018
// Description  : Design of Controller Module, state machine is been designed
//		  It travels between states for diffrent operations based on different input signal controls
//		  from host interface interactions
//		  It controls data flow between memory and host which has communication between buffer and host too
//--------------------------------------------------------------------------------------------------------------------

module Controller 
#(
parameter AddressWidth = 16,
parameter CommandWidth = 3,
parameter DataWidth = 16
)
(
input  logic                        clk,							//data width for host interface	
inout  tri   [DataWidth - 1 : 0]    DIO,                            //DIO  multiplexed tri bus for memory interaction
output logic [DataWidth - 1 : 0]    cntrl_in,                       //data inout from buffer
output logic                        cntrl_sel, cntrl_we, cntrl_re,  //control signals between buffer and cotroller
output logic                        nfc_done,                       //status of operation completion
output logic                        ALE, CLE, wEn, rEn,             //control signals to latch address, command, and for read/write operation
output logic                        command_error,                  //command error which states invalid command
output logic                        cEn,                            //chip enable for memory
input  logic [CommandWidth - 1 : 0] nfc_cmd,                        //command from host
input  logic [AddressWidth - 1 : 0] RWA,                            //Address from host to controoller
input  logic                        Reset, nfc_start,               //global reset and start operation signal
input  logic                        status,                         //status asserted from memory after completion of operation
input  logic [DataWidth - 1 : 0]    cntrl_out,                      //output from buffre, which is input to controller, data read from buffer
input  logic                        buf_cntrl_status,               //status of read completion and idle state of buffer available for new load
input  logic                        host_buf_status                 //status of read completion and idle state of buffer available for new load
);                                                                  

parameter host_erase = 0;
parameter host_program_page = 1;
parameter host_page_read = 2;

parameter mem_erase = 0;
parameter mem_program_page = 1;
parameter mem_page_read = 2;

logic [AddressWidth - 1 : 0] DIO_out;
logic [CommandWidth - 1 : 0] command;

typedef enum {Hold, Start, Erase, Erase_Wait, Program_Page, Page_Read, AddressLatch, Write_Memory, Write_Memory_Wait, Write_To_Memory, Read_Memory, Read_Memory_Wait, Read_Buffer} states_t;

states_t cur_state, next_state;

assign DIO = (ALE || CLE || wEn) ? DIO_out : 'bz;

initial begin
	initialisation;
end

task initialisation;
	cntrl_in = 'bz;
	cntrl_sel = 0;
	cntrl_we = 0; cntrl_re = 0; cEn = 0;
	nfc_done = 0; ALE = 0; CLE = 0; 
	wEn = 0; rEn = 0;
	command_error = 0;
endtask

always_ff @(posedge clk) begin
	if(Reset)
		cur_state <= Hold;
	else
		cur_state <= next_state;
end

always_comb begin
	case(cur_state)

		Hold : begin
			initialisation;
			
			if(nfc_start && !Reset) begin
				next_state = Start;
				command = nfc_cmd;
			end
			else
				next_state = Hold;
		end

		Start : begin
			if(command == host_erase) begin
				next_state = Erase;
				cEn = 1;
			end
			else if(command == host_program_page) begin
				next_state = Program_Page;
				cEn = 1;
			end
			else if(command == host_page_read) begin
				next_state = Page_Read;
				cEn = 1;
			end
			else begin
				next_state = Hold;
				nfc_done = 1;
				command_error = 1;
			end
		end

		Erase : begin
			//cEn = 1;
			CLE = 1;
			DIO_out = mem_erase;
			next_state = AddressLatch;
		end

		Erase_Wait : begin
			ALE = 0;
			DIO_out = 'bz;
			if(status) begin
				next_state = Hold;
				nfc_done = 1;
			end
			else begin
				next_state = Erase_Wait;
			end
		end

		Program_Page : begin
			//cEn = 1;
			CLE = 1;
			DIO_out = mem_program_page;
			next_state =  AddressLatch;
			
		end

		Page_Read : begin
			//cEn = 1;
			CLE = 1;
			DIO_out = mem_page_read;
			next_state =  AddressLatch;
		end

		AddressLatch : begin
			if(command == host_program_page) begin
				next_state = Write_Memory;
			end
			else if(command == host_page_read) begin
				next_state = Read_Memory;
			end
			else if(command == host_erase) begin
				next_state = Erase_Wait;
			end
			CLE = 0;
			ALE = 1;
			DIO_out = RWA;
		end

		Write_Memory : begin
			cntrl_sel = 1;
			cntrl_re = 1;
			ALE = 0;
			next_state = Write_Memory_Wait;
			
		end

		Write_Memory_Wait : begin
			wEn = 1;
			DIO_out = cntrl_out;
			if(buf_cntrl_status) begin
				next_state = Write_To_Memory;
				cntrl_sel = 0;
			end
		end

		Write_To_Memory : begin
			if(status) begin
				next_state = Hold;
				nfc_done = 1;
			end
		end

		Read_Memory : begin
			ALE = 0;
			rEn = 1;
			next_state = Read_Memory_Wait;
		end
		
		Read_Memory_Wait : begin
			cntrl_sel = 1;
			cntrl_we = 1;
			cntrl_in = DIO;
			if(status) begin
				next_state = Read_Buffer;
				cntrl_sel = 0;
				cntrl_we = 0;
			end
		end
	
		Read_Buffer : begin
			cEn = 0;
			rEn = 0;
			if(host_buf_status) begin
				next_state = Hold;
				nfc_done = 1;
				
			end
		end

	endcase
end

endmodule : Controller
