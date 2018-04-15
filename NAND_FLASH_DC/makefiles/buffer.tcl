set ward "/u/sumeeth2/DI_Winter_2017/DC/MUX"

remove_design 

current_design 

set report_default_significant_digits 3

lappend search_path "$ward/models"

set link_library "saed32rvt_ff0p85v125c.db"

set target_library "saed32rvt_ff0p85v125c.db"

define_design_lib WORK -path "$ward/temp"

analyze -format sverilog "$ward/Buffer.sv"

elaborate Buffer
compile 

write_file -f verilog -h -o "$ward/output/buffer.v"
write_file -f ddc     -h -o "$ward/output/buffer.ddc" 
write_sdc  -nosplit         "$ward/output/buffer.sdc"

report_area >> "$ward/results/area_report_buffer"
report_cell >> "$ward/results/cell_report_buffer"
report_power >> "$ward/results/power_report_buffer"
report_timing >> "$ward/results/timing_report_buffer"
report_qor >> "$ward/results/qor_report_buffer"

