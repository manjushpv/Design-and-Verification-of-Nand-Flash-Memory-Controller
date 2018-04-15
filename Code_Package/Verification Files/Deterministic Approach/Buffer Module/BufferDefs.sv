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

package BufferDefs;

parameter DataWidth = 16;		//buffer data width
parameter Buf_Depth = 2048;		//buffer depth of page size 
parameter AddrWidth = $clog2(Buf_Depth);	//address width equal to 11 bits based upon buffer depth

logic [DataWidth - 1 : 0] buf_mem [0 : Buf_Depth - 1];//buffer memory instantiation
int host_addr;				//address control for host side operations
int cntrl_addr;				//address control for controller side operations

logic buf_read_flag = 0;		//flags for read start on host to buf
logic cntrl_read_flag = 0;		//flags for read start on cntrl to buf
logic buf_write_flag = 0;		//flags for write start on host to buf
logic cntrl_write_flag = 0;		//flags for write start on cntrl to buf



endpackage
