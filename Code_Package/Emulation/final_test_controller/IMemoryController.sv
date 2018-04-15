////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// IMemoryController.sv - Interface module 
//
// Author: Yash & Manoja
// Date: 14th March 2018
//
// Description:
// ------------
// Controller pins are driven and O/Ps are captured through the ports defined here. Tasks are defined for 
// HVL calls. All tasks are basically Implicit FSMs
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface IMemoryController (input logic clk); //pragma attribute IMemoryController partition_interface_xif

parameter DIOWidth = 16;
parameter PageSize = 2048;
parameter AddressWidth = 16; 
parameter CommandWidth = 3;
parameter DataWidth = 16;
parameter erase = 16'h0;
parameter program_page = 16'h1;
parameter page_read = 16'h2;

logic [DataWidth - 1 : 0] buf_out;   // Control signals between host and the buffer - 16 bit data bus; buffer to host
logic nfc_done, command_error;       // NFC Done and Command Error O/Ps to host
logic ALE, CLE, wEn, rEn, cEn;       // Control signals between controller and the memory
logic [DataWidth - 1 : 0] buf_in;    // Control signals between host and the buffer - 16 bit data bus; host to buffer
logic buf_sel, buf_we, buf_re;       // Control signals between host and the buffer
logic [CommandWidth - 1 : 0] nfc_cmd;// NFC Command 
logic [AddressWidth - 1 : 0] RWA;    // Address
logic Reset, nfc_start;              // Reset and NFC Start
logic status;                        // Status from the memory
                                     
                                     

logic cntrl_sel, cntrl_we, cntrl_re;
logic [DataWidth - 1 : 0] cntrl_in;
logic [DataWidth - 1 : 0] cntrl_out;
logic buf_cntrl_status, host_buf_status;
tri [DataWidth - 1 : 0] DIO;

modport MCPorts (inout DIO, output buf_out, nfc_done, command_error, ALE, CLE, wEn, rEn, cEn,
input buf_in, buf_sel, buf_we, buf_re, nfc_cmd, RWA, Reset, nfc_start, clk, status);

// Task performs reset operation
task reset; // pragma tbx xtf
@(posedge clk);
Reset <= 1;
@(posedge clk);
@(posedge clk);
Reset <= 0;
@(posedge clk);
endtask

// Task performs page read operation (NAND FLASH Memory read)
task nfc_read(input logic [AddressWidth - 1 : 0] addr); // pragma tbx xtf
@(posedge clk);
nfc_cmd <= page_read;
nfc_start <= 1;
RWA <= addr;
status <= 0;
@(posedge clk);
nfc_cmd <= 'z;
nfc_start <= 0;
wait(cEn & CLE)
@(posedge clk);
wait(ALE)
@(posedge clk);
wait(rEn)
@(posedge clk);
for(int i=0;i<PageSize;i++) begin
@(posedge clk);
end
status <= 1;
@(posedge clk);
status <= 0;
@(posedge clk);
endtask

// Task is used to complete page read operation (Buffer read)
task buff_read; // pragma tbx xtf
@(posedge clk);
buf_sel <= 1;
buf_re <= 1;
buf_we <= 0;
@(posedge clk);
for(int i=0;i<PageSize;i++) begin
@(posedge clk);
end
wait(nfc_done);
@(posedge clk);
buf_sel <= 0;
buf_re <= 0;
buf_we <= 0;
@(posedge clk);
endtask

// Task performs page read operation (NAND FLASH Memory read)
task nfc_write(input logic [AddressWidth - 1 : 0] addr, output logic [PageSize - 1 : 0][DIOWidth - 1 : 0] DIO_out); // pragma tbx xtf
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
@(posedge clk);
nfc_cmd <= program_page;
nfc_start <= 1;
RWA <= addr;
@(posedge clk);
nfc_cmd <= 'z;
nfc_start <= 0;
wait(cEn & CLE);
@(posedge clk);
wait(ALE)
@(posedge clk);
wait(wEn)
@(posedge clk);
for(int i=0;i<PageSize;i++) begin
DIO_out[i] <= DIO;
@(posedge clk);
end
@(posedge clk);
status <= 1;
@(posedge clk);
status <= 0;
wait(nfc_done);
@(posedge clk);
endtask

// Task is used to initiate page write operation (Buffer write)
task buff_write(input logic [PageSize - 1 : 0][DIOWidth - 1 : 0] in_data); // pragma tbx xtf
@(posedge clk);
buf_sel <= 1;
buf_re <= 0;
buf_we <= 1;
for(int i=0;i<PageSize;i++) begin
buf_in <= in_data[i];
@(posedge clk);
end
buf_sel <= 0;
buf_re <= 0;
buf_we <= 0;
@(posedge clk);
endtask

// Task performs block erase operation (NAND FLASH Memory block erase)
task erase_block(input logic [AddressWidth - 1 : 0] addr); // pragma tbx xtf
@(posedge clk);
nfc_cmd <= erase;
nfc_start <= 1;
RWA <= addr;
@(posedge clk);
nfc_cmd <= 'z;
nfc_start <= 0;
wait(cEn & CLE);
@(posedge clk);
wait(ALE)
@(posedge clk);
status <= 1;
@(posedge clk);
status <= 0;
wait(nfc_done);
@(posedge clk);
endtask

endinterface : IMemoryController