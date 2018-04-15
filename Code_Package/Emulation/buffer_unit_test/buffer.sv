//------------------------------------------------------------------------------------------------------------------------------------
// File         : Buffer.sv --> Design of buffer module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 12 2018
// Description  : Design of Buffer Module, used counter logic to move onto location to location 
//		  		  either for read or write operation. Data Coherence is handled within the module
//		  		  Depth is of page size.
//		  		  Write cant happen from both sides of buffer, either host can write or controller
//		  		  If one is writing the other could read the same and vice versa.
//		  		  Once writing of data starts it should write upto complete buffer depth else junk data would be stored on the buffer
//		  		  Similarly the same happens with read operation
//		  		  Status signals are asserted once the read operation is completed on both host and controller side
//------------------------------------------------------------------------------------------------------------------------------------

module buffer #(parameter DataWidth = 16)
(ibuffer ib1);

parameter Buf_Depth = 2048;
parameter AddrWidth = $clog2(Buf_Depth);

logic [DataWidth - 1 : 0] buf_mem [0 : Buf_Depth - 1];
int host_addr = 0;
int cntrl_addr = 0;

logic ib1.buf_read_flag = 0;
logic ib1.cntrl_read_flag = 0;

always_ff @(posedge clk) begin
	if(ib1.ib1.buf_sel && host_addr < Buf_Depth) begin
		if(ib1.buf_we) begin
			buf_mem[host_addr] <= ib1.buf_in;
			host_addr <= host_addr + 1;
			ib1.cntrl_read_flag <= 1;
		end	

		if(ib1.buf_re && ib1.buf_read_flag) begin
			ib1.buf_out <= buf_mem[host_addr];
			host_addr <= host_addr + 1;
		end
	end
	else if(host_addr == Buf_Depth) begin
		if(ib1.ib1.buf_sel) begin
			if(ib1.buf_re)
				$display("read from buffer to host completed!!!! dont read for more @%0d",$time);
			if(ib1.buf_we)
				$display("write from host to buffer--> buffer full @%0d",$time);
		end
		if(ib1.buf_read_flag)
			ib1.host_buf_status <= 1;
		else
			ib1.host_buf_status <= 0;
		ib1.buf_read_flag <= 0;
		host_addr <= 0;
	end
	else begin
		host_addr <= 0;
		ib1.host_buf_status <= 0;
	end

	if(ib1.cntrl_sel && cntrl_addr < Buf_Depth) begin
		if(ib1.cntrl_re && ib1.cntrl_read_flag) begin
			ib1.cntrl_out <= buf_mem[cntrl_addr];
			cntrl_addr <= cntrl_addr + 1;
		end

		if(ib1.cntrl_we) begin
			buf_mem[cntrl_addr] <= ib1.cntrl_in;
			cntrl_addr <= cntrl_addr + 1;
			ib1.buf_read_flag <= 1;
		end
	end
	else if(cntrl_addr == Buf_Depth) begin
		if (ib1.cntrl_sel) begin
			if(ib1.cntrl_re)
				$display("read from buffer to controller completed!!!! dont read for more @%0d",$time);
			if(ib1.cntrl_we)
				$display("write from controller to buffer--> buffer full @%0d",$time);
		end
		if(ib1.cntrl_read_flag)
			ib1.buf_cntrl_status <= 1;
		else
			ib1.buf_cntrl_status <= 0;
		ib1.cntrl_read_flag <= 0;
		cntrl_addr <= 0;
	end
	else begin
		cntrl_addr <= 0;
		ib1.buf_cntrl_status <= 0;
	end
	
end

endmodule : buffer
