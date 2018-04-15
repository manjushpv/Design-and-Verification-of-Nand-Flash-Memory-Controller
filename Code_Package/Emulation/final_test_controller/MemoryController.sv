////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MemoryController.sv - Design module 
//
// Author: Yash & Manoja
// Date: 14th March 2018
//
// Description:
// ------------
// Instantiates the controller and the buffer modules. For signal descriptions see respective modules
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module MemoryController (IMemoryController.MCPorts bus);

parameter AddressWidth = 16; 
parameter CommandWidth = 3;
parameter DataWidth = 16;

logic cntrl_sel, cntrl_we, cntrl_re;
logic [DataWidth - 1 : 0] cntrl_in;
logic [DataWidth - 1 : 0] cntrl_out;
logic buf_cntrl_status, host_buf_status;

Controller cntrl
(
.clk             (bus.clk             ),
.DIO             (bus.DIO             ),
.cntrl_in        (cntrl_in        ),
.cntrl_sel       (cntrl_sel       ), 
.cntrl_we        (cntrl_we        ), 
.cntrl_re        (cntrl_re        ),
.nfc_done        (bus.nfc_done        ),
.ALE             (bus.ALE             ), 
.CLE             (bus.CLE             ), 
.wEn             (bus.wEn             ), 
.rEn             (bus.rEn             ),
.command_error   (bus.command_error   ),
.cEn             (bus.cEn             ),
.nfc_cmd         (bus.nfc_cmd         ),
.RWA             (bus.RWA             ),
.Reset           (bus.Reset           ), 
.nfc_start       (bus.nfc_start       ),
.status          (bus.status          ),
.cntrl_out       (cntrl_out       ),
.buf_cntrl_status(buf_cntrl_status),
.host_buf_status (host_buf_status )
);

Buffer bufm
(
.clk             (bus.clk             ),
.buf_sel         (bus.buf_sel         ), 
.buf_we          (bus.buf_we          ), 
.buf_re          (bus.buf_re          ),
.cntrl_sel       (cntrl_sel       ), 
.cntrl_we        (cntrl_we        ), 
.cntrl_re        (cntrl_re        ),
.buf_in          (bus.buf_in          ),
.cntrl_in        (cntrl_in        ), 
.cntrl_out       (cntrl_out       ),
.buf_out         (bus.buf_out         ),
.buf_cntrl_status(buf_cntrl_status),
.host_buf_status (host_buf_status )
);

endmodule : MemoryController
