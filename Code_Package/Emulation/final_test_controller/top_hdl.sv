////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// top_hdl.sv - Top HDL module (Everything that will be synthesized)
//
// Author: Manoja & Yash
// Date: 14th March 2018
//
// Description:
// ------------
// Encapsulates the interface and the design, by instantiating them here. And so port connections are made here
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module top_hdl; //pragma attribute hdl_top parition_module_xrtl 

logic clk;

// Generating the Clock 
// tbx clkgen
initial
  begin
    clk = 0;
    forever begin
      #10 clk = ~clk;
    end
  end

IMemoryController mcinf(clk); // Interface IMemoryController instantiation
MemoryController mc(mcinf.MCPorts); // Design encapsulation module MemoryController instantiation

endmodule 