//--------------------------------------------------------------------------------------------------------------------
// File         : Mmeory.sv --> Design of memory module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 12 2018
// Description  : Design of Nand Flash Memory Controller, which is designed using FSM
//                Off state when cEn is de-asserted. And stays in other states when cEn is asserted
//		  Memory operations involved : Block erase, Page Read and Program Page
//		  After the completion of operation status is asserted as a handshaking signal to the Memory Controller
//		  The memory depth is 2^16 and Data, Address and Command are multipled on a single bus of 16 bit width
//--------------------------------------------------------------------------------------------------------------------

module Memory #(parameter DIOWidth = 16'h10)(input logic clk,		//multiplexed DIO width = 16 ,//input clock controlled by top module
inout tri [DIOWidth - 1 : 0] DIO_memCntrl,				//multiplexed bus which could hold Data or Address or Command
input logic ALE, CLE, wEn, rEn, cEn,					//Enable signals for Address Latch, Command Latch, Write Enable, Read Enable and Chip Enable
output logic status);							//status signal is input to Memory Controller, which is handshaking between memory and Memory Controller

parameter MemoryDepth = (2 ** DIOWidth);				//Memory Depth
parameter PageSize = 16'h800;						//Page Size
parameter BlockSize = 16'h4 * PageSize;					//Block Size

logic [DIOWidth - 1 : 0] Address;					//For changing address on page operations
logic [DIOWidth - 1 : 0] BaseAddress;					//To hold Initial address received on Bus from Memory Controller
int AddressCount;							//Count to keep up the size of Page
logic [DIOWidth - 1 : 0] Command;					//To hold the value of command when latched under CLE 
logic [DIOWidth - 1 : 0] DIO_out;					//signal used to drive tri net DIO multiplesd bus

parameter erase = 16'h0;						//Commands for the opertaions performed on Memory
parameter program_page = 16'h1;						//Program Page operation
parameter page_read = 16'h2;						//Page Read Operation

logic write_flag;							//Flag to indicate write operation started
logic read_flag;							//Flag to indicate read operation started

logic [DIOWidth - 1 : 0] mem [0 : MemoryDepth - 1];			//memory instantiation
typedef enum {Off, Hold, Command_Latch, Address_Latch, Memory_Read, Memory_Read_Wait, Memory_Write, Memory_Erase} state_t; 	// state declarations

state_t state, next_state;		// current and next state of state_t type declaration

assign DIO_memCntrl = rEn ? DIO_out : 'bz;		//controlling the DIO tri bus driving between Memory and Controller and tri-stated when not required

assign validEnable = (((!rEn & !wEn) & (ALE ^ CLE)) | ((rEn ^ wEn) & (!ALE & !CLE)));	//controlling the enable signal --> any one of the signals should be high at a time, no 2 or more can be asserted at the same time


always_ff @(posedge clk) begin
	if(!cEn)
		state <= Off;				//cEn de-asserted memory stays Off
	else
		state <= next_state;			//if cEn is asserted it is switched on and stayed in some operation mode
	
	if((read_flag || write_flag) && AddressCount < PageSize - 1) begin
		AddressCount <= AddressCount + 1;	//address count changes for page read and write operation
	end
	else if(AddressCount == PageSize - 1)
		AddressCount <= 0;			//reset the address count when it meets the page size
end

always_comb begin
	case(state)
		Off : begin
			status = 0;			//Off state of memory, status is de-asserted indicating no operation
			if(cEn)
				next_state = Hold;	//if on, it moves to hold state
		end

		Hold : begin				//When no operation and when cEn is asserted, it stays in Hold state
			status = 0;
			if (CLE && validEnable) begin	//If signals are valid and CLE is high, command is captured into Command and moved onto Command latch state
				next_state = Command_Latch;
				Command = DIO_memCntrl;
			end
			else
				next_state = Hold; 	//if any of the above 2 condition fails, move back to hold state
		end

		Command_Latch : begin			//Based upon the command received in the previous state, address is latched and moved onto respective operational states
			if(ALE && validEnable) begin	//If Valid signal and Address Latch Enable, capture address and convert it proper base address
				BaseAddress = DIO_memCntrl & 16'hF800;	//Base address is starting address of page for Page read and Program page
				case(Command)
					erase : begin 
						next_state = Memory_Erase;//if command is of erase operation, then base address would be of block base address
						BaseAddress = DIO_memCntrl & 16'hE000;
					end
					program_page : next_state = Address_Latch;	//to program page operation state
					page_read : next_state = Address_Latch;		//to page read opeartion state
					default : next_state = Hold;			//to hols state
				endcase
			end
			else
				next_state = Hold;					//enable conditions fails, go back to hold state
		end

		Address_Latch : begin							//initiate the write and read operation for page size, isolated due to adress initiation on first clock tick
			if(Command == program_page && wEn && validEnable) begin		//only if all the enable condition satisfies move onto Program page operation
				write_flag = 1;						//set flag to indicate start og program page operation
				Address = BaseAddress;					//initiate address og memory
				mem[Address] = DIO_memCntrl;				//write onto memory from data received on bus
				next_state = Memory_Write;				//move onto write state which would write next 2047 locations for page size completion
			end
			else if(Command == page_read && rEn && validEnable) begin	//only if all the enable condition satisfies move onto page read operation
				read_flag = 1;						//set flag to indicate start of page read operation
				Address = BaseAddress;					//initiate address og memory
				DIO_out = mem[Address];					//read from memory onto data bus
				next_state = Memory_Read;
			end
		end

		Memory_Read : begin							//For page read operation for rest of 2047 locations reads
			Address = BaseAddress + AddressCount;				//incrementing address loacations, spatial locality access
			if(Address > BaseAddress)
				DIO_out = mem[Address];					//read onto data bus
			if(Address == BaseAddress || !rEn) begin			//if it meets the page size exit reading or even if rEn is de-asserted
				next_state = Hold;					//move onto hold state
				read_flag = 0;						//reset read flag indicating read operation is stopped
				status = 1;						//assert handshaking between memory and memory controller for completion of operation
			end
		end

		Memory_Write : begin							//For program page operation for rest of 2047 locations reads
			Address = BaseAddress + AddressCount;				//incrementing address loacations, spatial locality access
			if(Address > BaseAddress)
				mem[Address] = DIO_memCntrl;				//write onto memory from data bus
			if(Address == BaseAddress || !wEn) begin			//if it meets the page size exit writing or even if wEn is de-asserted
				next_state = Hold;					//move onto hold state
				write_flag = 0;						//reset write flag indicating write operation is stopped
				status = 1;						//assert handshaking between memory and memory controller for completion of operation
			end
		end

		Memory_Erase : begin							//For block erase operation for the whole block size
			for(int i=BaseAddress; i<(BaseAddress+BlockSize);i++)		//for the whole size of block from base address of block
				mem[i] = 0;						//erase memory ie., reset data to 0
			status = 1;							//assert handshaking between memory and memory controller for completion of operation
			next_state = Hold;						//move onto hold state
		end

		
	endcase
end

endmodule : Memory

