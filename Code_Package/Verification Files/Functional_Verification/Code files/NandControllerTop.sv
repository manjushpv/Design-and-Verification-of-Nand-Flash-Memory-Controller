module NandControllerTop;

logic clk;

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

INandController ncIntf (.clk(clk));
NandController nc (.ncBus(ncIntf.NCPorts));
NandController_tb nc_tb (.ncBus_tb(ncIntf.NCPorts_tb));


endmodule : NandControllerTop
