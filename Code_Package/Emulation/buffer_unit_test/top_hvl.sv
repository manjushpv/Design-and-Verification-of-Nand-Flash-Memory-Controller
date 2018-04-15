////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// top_hvl.sv - HVL top module
//
// Author: Manoja & Yash
// Date: 14th March 2018
//
// Description:
// ------------
// A module with no timing controls. Only references to tasks defined in ibuffer.sv
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module top_hvl;

bit   [2047 : 0][15 : 0] program_data; // Used to send randomized data to the buffer
logic [2047 : 0][15 : 0] data;         // Used to hold data read from the buffer
logic [2047 : 0][15 : 0] int_data;     // Used to hold valid data returned by the task for 'data'

assign int_data = data;

// Implicit FSM to test buffer functionality
initial begin
void'(randomize(program_data));
top_hdl.ib1.writetobuf(program_data);
repeat(2) clock_wait;
top_hdl.ib1.readfromcntrl(data);
if(int_data == program_data) $display("It worked");
$display(" Time ",$time);
$stop;
end

endmodule
