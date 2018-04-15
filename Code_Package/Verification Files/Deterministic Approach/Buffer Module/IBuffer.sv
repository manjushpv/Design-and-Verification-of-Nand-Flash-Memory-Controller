//--------------------------------------------------------------------------------------------------------------------
// File         : Buffer.sv --> Design of buffer module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 12 2018
// Description  : Design of Buffer Module, used counter logic to move onto location to location 
//		  either for read or write operation. Data Coherence is handled within the module
//		  Depth is of page size.
//		  Write cant happen from both sides of buffer, either host can write or controller
//		  If one is writing the other could read the same and vice versa.
//		  Once writing of data starts it should write upto complete buffer depth else junk data would be stored on the buffer
//		  Similarly the same happens with read operation
//		  Status signals are asserted once the read operation is completed on both host and controller side
//-------------------------------------------------------------------------------------------------------------------- 
interface IBuffer #(parameter DataWidth = 16)(input logic clk); //buffer data width //input clk provided on top module
logic buf_sel, buf_we, buf_re;		//sel, re and we are control signlas between host and buffer
logic cntrl_sel, cntrl_we, cntrl_re; 	//sel, re and we are control signlas between controller and buffer
logic [DataWidth - 1 : 0] buf_in;	//data from host received into buffer-->for write memory operation
logic [DataWidth - 1 : 0] cntrl_in; 	//data from controller is received into buffer---> for read memory operation	
logic [DataWidth - 1 : 0] cntrl_out;	//data out of buffre onto controller --> for write operation
logic [DataWidth - 1 : 0] buf_out;	//data out onto host --> for read opeartion
logic buf_cntrl_status;			//status asserted when whole data is completely read from buffer by controller for write operation
logic host_buf_status;			//status asserted when whole data is completely read from buffer by host for read operation

modport BufferPorts (input buf_sel, buf_we, buf_re, clk, cntrl_sel, cntrl_we, cntrl_re, buf_in, cntrl_in, 
output cntrl_out, buf_out, buf_cntrl_status, host_buf_status);

modport BufferPorts_tb (output buf_sel, buf_we, buf_re, cntrl_sel, cntrl_we, cntrl_re, buf_in, cntrl_in, 
input clk, cntrl_out, buf_out, buf_cntrl_status, host_buf_status);

endinterface : IBuffer
