set ward "/u/sumeeth2/DI_Winter_2017/DC/MUX"

remove_design 

// current_design 

set report_default_significant_digits 3

lappend search_path "$ward/models"

set link_library "saed32rvt_ff0p85v125c.db"

set target_library "saed32rvt_ff0p85v125c.db"

define_design_lib WORK -path "$ward/temp"

analyze -format sverilog "$ward/Controller.sv"

elaborate Controller
compile 

write_file -f verilog -h -o "$ward/output/Controller.v"
write_file -f ddc     -h -o "$ward/output/Controller.ddc" 
write_sdc  -nosplit         "$ward/output/Controller.sdc"

report_area >> "$ward/results/area_controller"
report_cell >> "$ward/results/cell_Controller"
report_power >> "$ward/results/power_Controller"
report_timing >> "$ward/results/timing_Controller"
report_qor >> "$ward/results/qor_Controller"

