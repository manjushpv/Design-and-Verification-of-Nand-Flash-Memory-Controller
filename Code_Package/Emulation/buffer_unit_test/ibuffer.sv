////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ibuffer.sv - Interface module 
//
// Author: Yash & Manoja
// Date: 11th March 2018
//
// Description:
// ------------
// Controller pins are driven and O/Ps are captured through the ports defined here. Tasks are defined for 
// HVL calls. All tasks are basically Implicit FSMs
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface ibuffer(input clk); // pragma attribute ibuffer partition_interface_xif

//Inputs
logic buf_sel, buf_we, buf_re;
logic cntrl_sel, cntrl_we, cntrl_re; 
logic [DataWidth - 1 : 0] buf_in; 
logic [DataWidth - 1 : 0] cntrl_in;

//Outputs
logic [DataWidth - 1 : 0] cntrl_out;
logic [DataWidth - 1 : 0] buf_out;
logic buf_cntrl_status;
logic host_buf_status;

task clock_wait; //pragma tbx xtf
@(posedge clk);
endtask

task readfromcntrl(output logic [2047 : 0][15 : 0] out_data); //pragma tbx xtf
@(posedge clk);
cntrl_sel <= 1;
cntrl_re <= 1;
@(posedge clk);
for(int i=0;i<2048;i++) begin
@(posedge clk);
out_data[i] <= cntrl_out;;
end
@(posedge clk);
cntrl_sel <= 0;
cntrl_re <= 0;
endtask

task writetobuf(input logic [2047 : 0][15 : 0] in_data); //pragma tbx xtf
@(posedge clk);
buf_sel <= 1;
buf_we <= 1;
for(int i=0;i<2048;i++) begin
buf_in <= in_data[i];
@(posedge clk);
end
@(posedge clk);
buf_sel <= 0;
buf_we <= 0;
endtask

endinterface:ibuffer