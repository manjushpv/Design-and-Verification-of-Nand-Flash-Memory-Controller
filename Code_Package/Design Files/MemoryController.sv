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
//parameters and signals intatiated for common interface between buffer and controller
(inout tri [DataWidth - 1 : 0] DIO_memCntrl,
output logic [DataWidth - 1 : 0] buf_out,
output logic nfc_done, command_error,
output logic ALE, CLE, wEn, rEn, cEn,
input logic [DataWidth - 1 : 0] buf_in,
input logic buf_sel, buf_we, buf_re,
input logic [CommandWidth - 1 : 0] nfc_cmd,
input logic [AddressWidth - 1 : 0] RWA,
input logic Reset, nfc_start,
input logic clk,
input logic status);

//intermediate signals connecting between modiles
logic cntrl_sel, cntrl_we, cntrl_re;
logic [DataWidth - 1 : 0] cntrl_in;
logic [DataWidth - 1 : 0] cntrl_out;
logic buf_cntrl_status, host_buf_status;

//multiplexed bus
tri [DataWidth - 1 : 0] DIO;

//both controller and buffer module instantiation
Controller cntrl (.*);
Buffer bufm (.*);

//bus control within the module and between interfaces
assign DIO_memCntrl = (ALE || CLE || wEn) ? DIO : 'bz;
assign DIO = (rEn) ? DIO_memCntrl : 'bz;

endmodule : MemoryController
