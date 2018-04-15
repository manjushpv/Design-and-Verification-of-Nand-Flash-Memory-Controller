//--------------------------------------------------------------------------------------------------------------------
// File         : NandController.sv --> Design of Top module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 4 2018
// Description  : Design of Top Module, state machine is been designed
//		  It connects both memorycontroller and memory
//		  The interface is properly instantiated with proper tri-state bus driving in the lower modules
//--------------------------------------------------------------------------------------------------------------------
module NandController (INandController.NCPorts ncBus);

parameter DIOWidth = 16;

//intermediate connections
tri [DIOWidth - 1 : 0] DIO_memCntrl;
logic ALE, CLE, wEn, rEn, cEn;
logic status;

//Memory Controller instantiation 
MemoryController MC(.DIO_memCntrl(DIO_memCntrl),
.buf_out(ncBus.buf_out),
.nfc_done(ncBus.nfc_done), .command_error(ncBus.command_error),
.ALE(ALE), .CLE(CLE), .wEn(wEn), .rEn(rEn), .cEn(cEn), .buf_in(ncBus.buf_in), 
.buf_sel(ncBus.buf_sel), .buf_we(ncBus.buf_we), .buf_re(ncBus.buf_re), .nfc_cmd(ncBus.nfc_cmd), 
.RWA(ncBus.RWA), .Reset(ncBus.Reset), .nfc_start(ncBus.nfc_start), .clk(ncBus.clk), .status(status));

//Memory Intstantiation
Memory mem (.DIO_memCntrl(DIO_memCntrl),
.ALE(ALE), .CLE(CLE), .wEn(wEn), .rEn(rEn), .cEn(cEn), .status(status), .clk(ncBus.clk));

endmodule : NandController
