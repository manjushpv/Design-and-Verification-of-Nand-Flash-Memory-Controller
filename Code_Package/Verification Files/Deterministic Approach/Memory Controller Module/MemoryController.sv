//--------------------------------------------------------------------------------------------------------------------
// File         : MemoryController.sv --> Design of controller module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 1 2018
// Description  : Design of Controller Module
//--------------------------------------------------------------------------------------------------------------------
module MemoryController (IMemoryController.mcPorts mcBus);

parameter DataWidth = 16;

logic cntrl_sel, cntrl_we, cntrl_re;
logic [DataWidth - 1 : 0] cntrl_in;
logic [DataWidth - 1 : 0] cntrl_out;
logic buf_cntrl_status, host_buf_status;

tri [DataWidth - 1 : 0] DIO;

Controller cntrl
(
.clk             (mcbus.clk          ),  // Clock 
.DIO             (mcbus.DIO          ),  // tristated bus between controller and memory
.cntrl_in        (cntrl_in        ),     // Control signals between controller and the buffer - 16 bit data bus; controller to buffer
.cntrl_sel       (cntrl_sel       ),     // Control signals between controller and the buffer
.cntrl_we        (cntrl_we        ),     // Control signals between controller and the buffer
.cntrl_re        (cntrl_re        ),     // Control signals between controller and the buffer
.nfc_done        (mcbus.nfc_done     ),  // NFC Done signal to the host
.ALE             (mcbus.ALE          ),  // Address Latch Enable to the memory
.CLE             (mcbus.CLE          ),  // Command Latch Enable to the memory
.wEn             (mcbus.wEn          ),  // Controller - Memory interface
.rEn             (mcbus.rEn          ),  // Controller - Memory interface
.command_error   (mcbus.command_error),  // Command Error to host
.cEn             (mcbus.cEn          ),  // Chip Enable to memory module
.nfc_cmd         (mcbus.nfc_cmd      ),  // NFC command
.RWA             (mcbus.RWA          ),  // Address for Memory operation
.Reset           (mcbus.Reset        ),  // Active high Reset
.nfc_start       (mcbus.nfc_start    ),  // NFC Start
.status          (mcbus.status       ),  // Status signal from memory
.cntrl_out       (cntrl_out       ),     // Control signals between controller and the buffer - 16 bit data bus; buffer to controller
.buf_cntrl_status(buf_cntrl_status),     //status asserted when whole data is completely read from buffer by controller for write operation
.host_buf_status (host_buf_status )      //status asserted when whole data is completely read from buffer by host for read operation
);                                        
                                          
Buffer bufm
(
.clk             (mcbus.clk         ), // Clock 
.buf_sel         (mcbus.buf_sel     ), // Control signals between host and the buffer
.buf_we          (mcbus.buf_we      ), // Control signals between host and the buffer
.buf_re          (mcbus.buf_re      ), // Control signals between host and the buffer
.cntrl_sel       (cntrl_sel       ),   // Control signals between controller and the buffer
.cntrl_we        (cntrl_we        ),   // Control signals between controller and the buffer
.cntrl_re        (cntrl_re        ),   // Control signals between controller and the buffer
.buf_in          (mcbus.buf_in      ), // Control signals between host and the buffer - 16 bit data bus; host to buffer
.cntrl_in        (cntrl_in        ),   // Control signals between controller and the buffer
.cntrl_out       (cntrl_out       ),   // Control signals between controller and the buffer
.buf_out         (mcbus.buf_out     ), // Control signals between host and the buffer - 16 bit data bus; buffer to host
.buf_cntrl_status(buf_cntrl_status),   //status asserted when whole data is completely read from buffer by controller for write operation
.host_buf_status (host_buf_status )    //status asserted when whole data is completely read from buffer by host for read operation
);

//bus control within the module and between interfaces
assign mcBus.DIO_memCntrl = (mcBus.ALE || mcBus.CLE || mcBus.wEn) ? DIO : 'bz;
assign DIO = (mcBus.rEn) ? mcBus.DIO_memCntrl : 'bz;

endmodule : MemoryController
