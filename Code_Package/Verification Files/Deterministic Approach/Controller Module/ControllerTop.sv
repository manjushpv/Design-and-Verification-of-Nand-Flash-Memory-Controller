//--------------------------------------------------------------------------------------------------------------------
// File         : ControllerTop.sv --> Top environment for controller and tb module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 1 2018
// Description  : Design of Controller Module, state machine is been designed
//		  It travels between states for diffrent operations based on different input signal controls
//		  from host interface interactions
//		  It controls data flow between memory and host which has communication between buffer and host too
//--------------------------------------------------------------------------------------------------------------------

module ControllerTop;

logic clk;

//clock generation
initial begin
	clk = 0;
	forever #5 clk=~clk;
end

//Interface controller and controller tb instantiation
IController cntrIntf(.clk(clk));
Controller cntr (.cntrBus(cntrIntf.ControllerPorts));
Controller_tb cntr_tb (.cntrBus_tb(cntrIntf.ControllerPorts_tb));

endmodule:ControllerTop
