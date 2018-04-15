//--------------------------------------------------------------------------------------------------------------------
// File         : MemoryController.sv --> Design of memory controller module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 2 2018
// Description  : Design of Memory Controller Module, 
//		  It is interconnected model of both buffer and controller.
//		  multipled tri state bus is controlled within the module and as well as between the interface
//--------------------------------------------------------------------------------------------------------------------
module MemoryController #(parameter AddressWidth = 16, 
parameter CommandWidth = 3, parameter DataWidth = 16)
(
inout tri [DataWidth - 1 : 0] DIO_memCntrl,    // tristated bus between controller and memory
output logic [DataWidth - 1 : 0] buf_out,      // Control signals between host and the buffer - 16 bit data bus; buffer to host
output logic nfc_done, command_error,          // NFC Done and Command Error O/Ps to host
output logic ALE, CLE, wEn, rEn, cEn,          // Control signals between controller and the memory
input logic [DataWidth - 1 : 0] buf_in,        // Control signals between host and the buffer - 16 bit data bus; host to buffer
input logic buf_sel, buf_we, buf_re,           // Control signals between host and the buffer
input logic [CommandWidth - 1 : 0] nfc_cmd,    // NFC Command 
input logic [AddressWidth - 1 : 0] RWA,        // Address
input logic Reset, nfc_start,                  // Reset and NFC Start
input logic clk,                               // Clock
input logic status                             // Status from the memory
);

logic cntrl_sel, cntrl_we, cntrl_re;
logic [DataWidth - 1 : 0] cntrl_in;
logic [DataWidth - 1 : 0] cntrl_out;
logic buf_cntrl_status, host_buf_status;

tri [DataWidth - 1 : 0] DIO;

// Controller module instantiation
Controller cntrl (.*);
// Buffer module instantiation
Buffer bufm (.*);

//bus control within the module and between interfaces
assign DIO_memCntrl = (ALE || CLE || wEn) ? DIO : 'bz;
assign DIO = (rEn) ? DIO_memCntrl : 'bz;

endmodule : MemoryController
