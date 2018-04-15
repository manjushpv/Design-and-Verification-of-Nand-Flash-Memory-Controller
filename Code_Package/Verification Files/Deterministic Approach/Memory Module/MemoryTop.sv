//--------------------------------------------------------------------------------------------------------------------
// File         : MemoryTop.sv --> Top environment for Memory module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 4 2018
// Description  : Top environment for Memory Module, 
//		  Clock generation and interface and lower module instantiations
//--------------------------------------------------------------------------------------------------------------------
module MemoryTop;
logic clk;

//interface and its lower modules instantiations
IMemory memIntf(.clk(clk));
Memory mem (.MemBus(memIntf.MemoryPorts));
Memory_tb mem_tb (.MemBus_tb(memIntf.MemoryPorts_tb));

//clock generation
initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

endmodule : MemoryTop
