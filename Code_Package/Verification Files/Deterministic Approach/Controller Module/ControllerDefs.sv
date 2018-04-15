//--------------------------------------------------------------------------------------------------------------------
// File         : Controller.sv --> Design of controller module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 1 2018
// Description  : Design of Controller Module, state machine is been designed
//		  It travels between states for diffrent operations based on different input signal controls
//		  from host interface interactions
//		  It controls data flow between memory and host which has communication between buffer and host too
//--------------------------------------------------------------------------------------------------------------------
package ControllerDefs;

parameter AddressWidth = 16;	//address width control for RWA from host
parameter CommandWidth = 3;	//command width for nfc_command

//commands for different opeartions as per the parameter names for controller
parameter host_erase = 0;
parameter host_program_page = 1;
parameter host_page_read = 2;

//commands for different opeartions as per the parameter names for memory
parameter mem_erase = 0;
parameter mem_program_page = 1;
parameter mem_page_read = 2;

//DIO and command capture signals
logic [AddressWidth - 1 : 0] DIO_out;
logic [CommandWidth - 1 : 0] command;

//states of the controller
typedef enum {Hold, Start, Erase, Erase_Wait, Program_Page, Page_Read, AddressLatch, Write_Memory, Write_Memory_Wait, Write_To_Memory, Read_Memory, Read_Memory_Wait, Read_Buffer} states_t;

states_t cur_state, next_state;

endpackage : ControllerDefs
