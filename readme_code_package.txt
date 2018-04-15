NAND Flash based Memory Controller
-----------------------------------
1. The folder Code_Package contains codes of the project.
2. The details of files in this folder
 
Code_Package  	#Codes of project

    __ Design Files 	# Codes of design     
		__Buffer.sv 	# Buffer design
		__Controller.sv	# Controller design
		__INandController.sv	#Interface for design
		__Memory.sv	# Memory Design
		__MemoryController.sv	#Memory controller instantiated with buffer and controller.
		__NandController.sv   #Top module 

    __ Verification Files # Codes of verification

		__Deterministic Approach  # First type of verification
				___Buffer Module 	#Unit testing of Buffer
					__Buffer.sv   	# Buffer design
					__Buffer_tb.sv	#Testbench of buffer
					__BufferDefs.sv # Buffer Package
					__BufferTop.sv	#Top module of buffer
					__IBuffer.sv	#Interface for buffer
				___Controller Module 	#Unit testing of Controller
					__Controller.sv	 # Controller design
					__Controller_tb.sv 	#Testbench of controller
					__ControllerDefs.sv	#Controller Package
					__ControllerTop.sv	#Top module of Controller
					__IController.sv	#Interface for Controller
 				___Memory Controller Module 	#Unit testing of Memory Controller
					__Buffer.sv		# Buffer design
					__Controller.sv		# Controller design
					__IMemoryController.sv  #Interface for Memory Controller
					__MemoryController.sv	#Memory controller instantiated with buffer and controller.
					__MemoryController_tb.sv #Testbench of memory controller
					__MemoryControllerTop.sv #Top module of memory controller
				___Memory Module 		#Unit testing of Memory		
					__IMemory.sv		#Interface for Memory
					__Memory.sv		# Memory Design
					__Memory_tb.sv		#Testbench of memory
					__MemoryDefs.sv		#Package for Memory
					__MemoryTop.sv		#Top module of memory
				___NCTop Module			#Unit testing of complete Nand Flash Controller
					__Buffer.sv 		# Buffer design
					__Controller.sv 	# Controller design
					__INandController.sv	#Interface for Flash Controller
					__MEmory.sv		# Memory Design
					__MemoryController.sv	#Memory controller instantiated with buffer and controller.
					__NandController.sv	#Top module of flash controller
					__NandController_tb.sv	#Testbench of flash controller
				___Output Docs			# Outputs of all unit testing modules
					__Buffer_Transcript	# Transcript for buffer module
					__BufferWave.do		#Waveform of buffer module
					__ControllerWave.do	#Waveform of Controller module	
					__MemoryController_wave.do	#Waveform of Memory controller module		
					__MemoryWave.do			#Waveform of memory
					__NCTop_wave.do			#Waveform of Flash controller module
		
		__Functional_Verification	# Second type of verification
				__Code files		#Codes 
					__Buffer.sv	# Buffer design
					__Controller.sv	# Controller design
					__DUT.sv	#Main design
					__INandController.sv #Interface for Flash Controller
					__Memory.sv     	# Memory Design
					__MemoryController.sv	#Memory controller instantiated with buffer and controller.
					__NandController.sv	#Flash Controller design
 					__NandController_tb.sv 	#Testbench of Flash controller
					__NandControllerTop.sv  #Flash Controller
					__NCDriver.sv		#Driver class	
					__NCEnv.sv		#Environment class	
					__NCGenerator.sv 	#Generator
					__NCIntf.sv		#Interface	
					__NCMonitor.sv		#Monitor class
					__NCScoreBoard.sv	#Scoreboard class
					__NCTest.sv		#Test Program
					__NCTransaction.sv	#Transaction class
					__run.sv		#common compile file
					__Top.sv		# Top with interface,DUT and Test
					__WriteScript.sv	#transcript writing to log file
				__Output Docs		#Outputs of Verification
					__log		#log file with details of no. of page reads,block erase and program page
					__ncTop_Verification_Transcript	#Transcript for entire functional verification
					__NCTop_Verification_wave.do	#Its corresponding waveform