//--------------------------------------------------------------------------------------------------------------------
// File         : IMemoryController.sv --> Design of memory controller module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 2 2018
// Description  : Interface Module
//--------------------------------------------------------------------------------------------------------------------
interface IMemoryController #(parameter AddressWidth = 16, 
parameter CommandWidth = 3, parameter DataWidth = 16)(input logic clk);

tri [DataWidth - 1 : 0] DIO_memCntrl; // tristated bus between controller and memory
logic [DataWidth - 1 : 0] buf_out;    // Control signals between host and the buffer - 16 bit data bus; buffer to host
logic nfc_done, command_error;        // NFC Done and Command Error O/Ps to host
logic ALE, CLE, wEn, rEn, cEn;        // Control signals between controller and the memory
logic [DataWidth - 1 : 0] buf_in;     // Control signals between host and the buffer - 16 bit data bus; host to buffer
logic buf_sel, buf_we, buf_re;        // Control signals between host and the buffer
logic [CommandWidth - 1 : 0] nfc_cmd; // NFC Command 
logic [AddressWidth - 1 : 0] RWA;     // Address
logic Reset, nfc_start;               // Reset and NFC Start
logic status;                         // Status from the memory

modport mcPorts (inout DIO_memCntrl,
output buf_out, nfc_done, command_error, ALE, CLE, wEn, rEn, cEn,
input buf_in, buf_sel, buf_we, buf_re, nfc_cmd, RWA, Reset, nfc_start, clk, status);

modport mcPorts_tb (inout DIO_memCntrl,
input buf_out, nfc_done, command_error, ALE, CLE, wEn, rEn, cEn, clk,
output buf_in, buf_sel, buf_we, buf_re, nfc_cmd, RWA, Reset, nfc_start, status);

endinterface : IMemoryController
