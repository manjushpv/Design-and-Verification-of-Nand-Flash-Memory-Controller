module DUT #(parameter DIOWidth = 16,
parameter AddressWidth = 16,
parameter CommandWidth = 3)(input logic clk,
output logic [DIOWidth - 1 : 0] buf_out,
output logic nfc_done, command_error,
input logic [DIOWidth - 1 : 0] buf_in,
input logic buf_sel, buf_we, buf_re,
input logic [CommandWidth - 1 : 0] nfc_cmd,
input logic [AddressWidth - 1 : 0] RWA,
input logic Reset, nfc_start
);

tri [DIOWidth - 1 : 0] DIO_memCntrl;
logic ALE, CLE, wEn, rEn, cEn;
logic status;

MemoryController MC(.DIO_memCntrl(DIO_memCntrl),
.buf_out(buf_out),
.nfc_done(nfc_done), .command_error(command_error),
.ALE(ALE), .CLE(CLE), .wEn(wEn), .rEn(rEn), .cEn(cEn), .buf_in(buf_in), 
.buf_sel(buf_sel), .buf_we(buf_we), .buf_re(buf_re), .nfc_cmd(nfc_cmd), 
.RWA(RWA), .Reset(Reset), .nfc_start(nfc_start), .clk(clk), .status(status));

Memory mem (.DIO_memCntrl(DIO_memCntrl),
.ALE(ALE), .CLE(CLE), .wEn(wEn), .rEn(rEn), .cEn(cEn), .status(status), .clk(clk));

endmodule : DUT