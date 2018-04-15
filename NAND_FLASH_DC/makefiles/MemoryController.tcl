set ward "/u/sumeeth2/DI_Winter_2017/DC/MUX"

remove_design 

current_design 

set report_default_significant_digits 3

lappend search_path "$ward/models"

set link_library "saed32rvt_ff0p85v125c.db"

set target_library "saed32rvt_ff0p85v125c.db"

define_design_lib WORK -path "$ward/temp"
analyze -format sverilog "$ward/Buffer.sv"
analyze -format sverilog "$ward/Controller.sv"
analyze -format sverilog "$ward/MemoryController.sv"

elaborate MemoryController
compile 

write_file -f verilog -h -o "$ward/output/MemoryController.v"
write_file -f ddc     -h -o "$ward/output/MemoryController.ddc" 
write_sdc  -nosplit         "$ward/output/MemoryController.sdc"

report_area >> "$ward/results/area_report_memorycontroller"
report_cell >> "$ward/results/cell_report_memorycontroller"
report_power >> "$ward/results/power_report_memorycontroller"
report_timing >> "$ward/results/timing_report_memorycontroller"
report_qor >> "$ward/results/qor_report_memorycontroller"

