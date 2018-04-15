//--------------------------------------------------------------------------------------------------------------------
// File         : MemoryController.sv --> Design of controller module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 1 2018
// Description  : Top level module
//--------------------------------------------------------------------------------------------------------------------
module MemoryControllerTop;

logic clk;

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

// Interface module IMemoryController instantiation
IMemoryController mcIntf (.clk(clk));
// Design module MemoryController instantiation
MemoryController mc (.mcBus(mcIntf.mcPorts));
// Test bench module MemoryController_tb instantiation
MemoryController_tb mc_tb (.mcBus_tb(mcIntf.mcPorts_tb));

endmodule : MemoryControllerTop
