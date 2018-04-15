#This makefile is for NAND Flash Controller verification
#Specify the mode- could be either puresim or veloce
#Always make sure that everything works fine in puresim before changing to veloce

MODE ?= veloce

#make all does everything
all: work build run

#Create respective work libs and map them
work:
	vlib work.$(MODE)
	vmap work work.$(MODE)

#Compile/synthesize the environment
build:
	vlog top_hvl.sv                 #Compile the testbench
ifeq ($(MODE),puresim)          	#If mode is puresim, compile everything else
	vlog Buffer.sv    				#Compile the Buffer module
	vlog Controller.sv 				#Compile the Controller module
	vlog IMemoryController.sv       #Compile the interface                                   
	vlog MemoryController.sv        #Compile the DUT
	vlog hdl.sv
	velhvl -sim $(MODE)
else                                            #else, synthesize!
	velanalyze -hdl verilog -extract_hvl_info +define+QUESTA top_hvl.sv   #Analyze the HVL for external task calls in BFM
	velanalyze IMemoryController.sv                 #Analyze the interface for synthesis
	velanalyze MemoryController.sv                  #Analyze the top for synthesis
	velanalyze Controller.sv                        #Analyze the DUT for synthesis
	velanalyze Buffer.sv                            #Analyze the DUT for synthesis
	velanalyze hdl.sv	
	velanalyze -hdl verilog -extract_hvl_info +define+QUESTA top_hvl.sv   #Analyze the HVL for external task calls in BFM
	velcomp -top hdl    #Synthesize!
	velhvl -sim $(MODE)
endif

run:
	vsim -novopt -c -do "run -all" top_hvl MemoryController TbxSvManager   #Run all
	cp transcript transcript.$(MODE)                #Record transcript

norun:  
	#No run lets you control stepping etc.
	vsim -novopt -c +tbxrun+norun top_hvl MemoryController -cpppath $(CPP_PATH)
	cp transcript transcript.$(MODE)

clean:
	 rm -rf tbxbindings.h modelsim.ini transcript.veloce transcript.puresim work work.puresim work.veloce transcript *~ vsim.wlf *.log dgs.dbg dmslogdir veloce.med veloce.wave veloce.map velrunopts.ini edsenv
