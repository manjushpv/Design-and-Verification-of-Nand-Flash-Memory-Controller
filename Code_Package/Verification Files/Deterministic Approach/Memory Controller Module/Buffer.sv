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
module Buffer #(parameter DataWidth = 16)   //buffer data width
(input logic clk,                           //input clk provided on top module
input logic buf_sel, buf_we, buf_re,        //sel, re and we are control signlas between host and buffer
input logic cntrl_sel, cntrl_we, cntrl_re,  //sel, re and we are control signlas between controller and buffer
input logic [DataWidth - 1 : 0] buf_in,     //data from host received into buffer-->for write memory operation
input logic [DataWidth - 1 : 0] cntrl_in,   //data from controller is received into buffer---> for read memory operation
output logic [DataWidth - 1 : 0] cntrl_out, //data out of buffre onto controller --> for write operation
output logic [DataWidth - 1 : 0] buf_out,   //data out onto host --> for read opeartion
output logic buf_cntrl_status,              //status asserted when whole data is completely read from buffer by controller for write operation
output logic host_buf_status                //status asserted when whole data is completely read from buffer by host for read operation
);                                         

parameter Buf_Depth = 2048;
parameter AddrWidth = $clog2(Buf_Depth);

logic [DataWidth - 1 : 0] buf_mem [0 : Buf_Depth - 1];
int host_addr;
int cntrl_addr;

logic buf_read_flag = 0;
logic cntrl_read_flag = 0;
logic buf_write_flag = 0;
logic cntrl_write_flag = 0;

always_ff @(posedge clk) begin
	if(buf_sel && host_addr < Buf_Depth) begin
		host_buf_status <= 0;
		if(buf_we && !buf_cntrl_status && !buf_write_flag) begin
			buf_mem[host_addr] <= buf_in;
			host_addr <= host_addr + 1;
			cntrl_read_flag <= 1;
		end	
		else
			host_addr <= 0;

		if(buf_re && buf_read_flag) begin
			buf_out <= buf_mem[host_addr];
			host_addr <= host_addr + 1;
		end
		if(host_addr == Buf_Depth - 1) begin
			if(buf_read_flag)
				host_buf_status <= 1;
			else
				host_buf_status <= 0;
		end

	end
	else if(host_addr == Buf_Depth) begin
		if(buf_sel) begin
			//if(buf_re) begin
				//$display("read from buffer to host completed!!!! dont read for more @%0d",$time);
			//end
			if(buf_we) begin
				buf_write_flag <=1;
				//$display("write from host to buffer--> buffer full @%0d",$time);
			end
		end
		cntrl_write_flag <= 0;
		host_buf_status <= 0;
		buf_read_flag <= 0;
		host_addr <= 0;
	end
	else begin
		host_addr <= 0;
		host_buf_status <= 0;
	end

	if(cntrl_sel && cntrl_addr < Buf_Depth) begin
		buf_cntrl_status <= 0;
		if(cntrl_re && cntrl_read_flag) begin
			cntrl_out <= buf_mem[cntrl_addr];
			cntrl_addr <= cntrl_addr + 1;
		end


		if(cntrl_we && !host_buf_status && !cntrl_write_flag) begin
			buf_mem[cntrl_addr] <= cntrl_in;
			cntrl_addr <= cntrl_addr + 1;
			buf_read_flag <= 1;
		end
		//else
			//cntrl_addr <= 0;

		if(cntrl_addr == Buf_Depth - 1) begin
			if(cntrl_read_flag)
				buf_cntrl_status <= 1;
			else
				buf_cntrl_status <= 0;
		end
	end
	else if(cntrl_addr == Buf_Depth) begin
		if (cntrl_sel) begin
			//if(cntrl_re) begin
				//$display("read from buffer to controller completed!!!! dont read for more @%0d",$time);
			//end
			if(cntrl_we) begin
				cntrl_write_flag <= 1;
				//$display("write from controller to buffer--> buffer full @%0d",$time);
			end
		end
		buf_write_flag <= 0;
		buf_cntrl_status <= 0;
		cntrl_read_flag <= 0;
		cntrl_addr <= 0;
	end
	else begin
		cntrl_addr <= 0;
		buf_cntrl_status <= 0;
	end
	
end
endmodule : Buffer

