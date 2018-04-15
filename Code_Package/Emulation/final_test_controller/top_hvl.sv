////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// top_hvl.sv - HVL top module
//
// Author: Manoja & Yash
// Date: 14th March 2018
//
// Description:
// ------------
// A module with no timing controls. Only references to tasks defined in IMemoryController.sv
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module top_hvl;

logic [2047 : 0][15 : 0] program_data; // Used to send randomized data to the buffer
logic [2047 : 0][15 : 0] data;         // Used to hold data read from the buffer

// Implicit FSM to test protocol
initial begin
void'(randomize(program_data));
top_hdl.mcinf.reset;
repeat(10) begin
	fork
	$display(" Time ",$time);
	top_hdl.mcinf.buff_write(program_data);
	top_hdl.mcinf.nfc_write($urandom_range(0,(2**16 - 1)),data);
	join
	$display(" Time ",$time);
	write_DIO_ckeck : assert (data == program_data) $info("NAND page program protocol tested");
	else $error("Page Program protocol test failed");
	top_hdl.mcinf.nfc_read($urandom_range(0,(2**16 - 1)));
	top_hdl.mcinf.buff_read;
	$display(" Time ",$time);
	$display("NAND page read protocol tested");
	top_hdl.mcinf.erase_block($urandom_range(0,(2**16 - 1)));
	$display(" Time ",$time);
	$display("NAND block erase protocol tested");
end
$stop;
end

endmodule