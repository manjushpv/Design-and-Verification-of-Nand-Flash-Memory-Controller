//-------------------------------------------------------------------------------------------
// File         : run.sv --> common compile file 
// Author       : Manjush Padmamma Venkatesha
// Date Created : March 12 2018
// Description  : Including all files in a single file which compiles in order of
//                dependencies. 
//--------------------------------------------------------------------------------------------

`include "WriteScript.sv"
`include "NCTransaction.sv"
`include "NCGenerator.sv"
`include "NCDriver.sv"
`include "NCMonitor.sv"
`include "NCScoreBoard.sv"
`include "NCEnv.sv"
`include "NCTest.sv"
`include "NCIntf.sv"
`include "Top.sv"