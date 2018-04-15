interface INandController (input logic clk);

parameter DIOWidth = 16;
parameter AddressWidth = 16; 
parameter CommandWidth = 3;

logic [DIOWidth - 1 : 0] buf_out;
logic nfc_done, command_error;
logic [DIOWidth - 1 : 0] buf_in;
logic buf_sel, buf_we, buf_re;
logic [CommandWidth - 1 : 0] nfc_cmd;
logic [AddressWidth - 1 : 0] RWA;
logic Reset, nfc_start;

modport NCPorts (output buf_out, nfc_done, command_error,
input buf_in, buf_sel, buf_we, buf_re, nfc_cmd, RWA, Reset, nfc_start, clk);

modport NCPorts_tb (input buf_out, nfc_done, command_error, clk,
output buf_in, buf_sel, buf_we, buf_re, nfc_cmd, RWA, Reset, nfc_start);

endinterface : INandController
