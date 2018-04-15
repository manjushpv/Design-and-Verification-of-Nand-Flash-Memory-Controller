//--------------------------------------------------------------------------------------------------------------------
// File         : Mmeory.sv --> Design of memory module
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 12 2018
// Description  : Design of Nand Flash Memory Controller, which is designed using FSM
//                Off state when cEn is de-asserted. And stays in other states when cEn is asserted
//		  Memory operations involved : Block erase, Page Read and Program Page
//		  After the completion of operation status is asserted as a handshaking signal to the Memory Controller
//		  The memory depth is 2^16 and Data, Address and Command are multipled on a single bus of 16 bit width
//--------------------------------------------------------------------------------------------------------------------
interface IMemory #(parameter DIOWidth = 16)(input logic clk);

tri [DIOWidth - 1 : 0] DIO_memCntrl;		//multiplexed bus which could hold Data or Address or Command
logic ALE, CLE, wEn, rEn, cEn;			//Enable signals for Address Latch, Command Latch, Write Enable, Read Enable and Chip Enable
logic status;					//status signal is input to Memory Controller, which is handshaking between memory and Memory Controller

modport MemoryPorts (inout DIO_memCntrl, input ALE, CLE, wEn, rEn, cEn, clk, output status);

modport MemoryPorts_tb (inout DIO_memCntrl, output ALE, CLE, wEn, rEn, cEn, input status, clk);

endinterface : IMemory
