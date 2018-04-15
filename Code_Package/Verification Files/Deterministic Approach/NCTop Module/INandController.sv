//--------------------------------------------------------------------------------------------------------------------
// File         : INandController.sv --> Design of memory controller module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 2 2018
// Description  : Interface module 
//--------------------------------------------------------------------------------------------------------------------
interface INandController (input logic clk);

parameter DIOWidth = 16;
parameter AddressWidth = 16; 
parameter CommandWidth = 3;

logic [DIOWidth - 1 : 0] buf_out;     // Control signals between host and the buffer - 16 bit data bus; buffer to host
logic nfc_done, command_error;        // NFC Done and Command Error O/Ps to host
logic [DIOWidth - 1 : 0] buf_in;      // Control signals between host and the buffer - 16 bit data bus; host to buffer
logic buf_sel, buf_we, buf_re;        // Control signals between host and the buffer
logic [CommandWidth - 1 : 0] nfc_cmd; // NFC Command 
logic [AddressWidth - 1 : 0] RWA;     // Address
logic Reset, nfc_start;               // Reset and NFC Start
                                      
modport NCPorts (output buf_out, nfc_done, command_error,
input buf_in, buf_sel, buf_we, buf_re, nfc_cmd, RWA, Reset, nfc_start, clk);

modport NCPorts_tb (input buf_out, nfc_done, command_error, clk,
output buf_in, buf_sel, buf_we, buf_re, nfc_cmd, RWA, Reset, nfc_start);

endinterface : INandController
