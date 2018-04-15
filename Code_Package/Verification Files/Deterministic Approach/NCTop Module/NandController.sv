//--------------------------------------------------------------------------------------------------------------------
// File         : MemoryController.sv --> Design of controller module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 1 2018
// Description  : Top level module
//--------------------------------------------------------------------------------------------------------------------
module NandController (INandController.NCPorts ncBus);

parameter DIOWidth = 16;

tri [DIOWidth - 1 : 0] DIO_memCntrl; // Tri stated bus
logic ALE, CLE, wEn, rEn, cEn;       // Interface between Controller and the memory
logic status;                        // Status O/P from the memory to the controller

MemoryController MC(.DIO_memCntrl(DIO_memCntrl),
.buf_out(ncBus.buf_out),
.nfc_done(ncBus.nfc_done), .command_error(ncBus.command_error),
.ALE(ALE), .CLE(CLE), .wEn(wEn), .rEn(rEn), .cEn(cEn), .buf_in(ncBus.buf_in), 
.buf_sel(ncBus.buf_sel), .buf_we(ncBus.buf_we), .buf_re(ncBus.buf_re), .nfc_cmd(ncBus.nfc_cmd), 
.RWA(ncBus.RWA), .Reset(ncBus.Reset), .nfc_start(ncBus.nfc_start), .clk(ncBus.clk), .status(status));

Memory mem (.DIO_memCntrl(DIO_memCntrl),
.ALE(ALE), .CLE(CLE), .wEn(wEn), .rEn(rEn), .cEn(cEn), .status(status), .clk(ncBus.clk));

endmodule : NandController
