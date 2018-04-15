onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /BufferTop/clk
add wave -noupdate /BufferTop/bufIntf/clk
add wave -noupdate /BufferTop/bufIntf/buf_sel
add wave -noupdate /BufferTop/bufIntf/buf_we
add wave -noupdate /BufferTop/bufIntf/buf_re
add wave -noupdate /BufferTop/bufIntf/cntrl_sel
add wave -noupdate /BufferTop/bufIntf/cntrl_we
add wave -noupdate /BufferTop/bufIntf/cntrl_re
add wave -noupdate /BufferTop/bufIntf/buf_in
add wave -noupdate /BufferTop/bufIntf/cntrl_in
add wave -noupdate /BufferTop/bufIntf/cntrl_out
add wave -noupdate /BufferTop/bufIntf/buf_out
add wave -noupdate /BufferTop/bufIntf/buf_cntrl_status
add wave -noupdate /BufferTop/bufIntf/host_buf_status
add wave -noupdate /BufferTop/bufm/bufBus/clk
add wave -noupdate /BufferTop/bufm/bufBus/buf_sel
add wave -noupdate /BufferTop/bufm/bufBus/buf_we
add wave -noupdate /BufferTop/bufm/bufBus/buf_re
add wave -noupdate /BufferTop/bufm/bufBus/cntrl_sel
add wave -noupdate /BufferTop/bufm/bufBus/cntrl_we
add wave -noupdate /BufferTop/bufm/bufBus/cntrl_re
add wave -noupdate /BufferTop/bufm/bufBus/buf_in
add wave -noupdate /BufferTop/bufm/bufBus/cntrl_in
add wave -noupdate /BufferTop/bufm/bufBus/cntrl_out
add wave -noupdate /BufferTop/bufm/bufBus/buf_out
add wave -noupdate /BufferTop/bufm/bufBus/buf_cntrl_status
add wave -noupdate /BufferTop/bufm/bufBus/host_buf_status
add wave -noupdate /BufferTop/bufm_tb/bufBus_tb/clk
add wave -noupdate /BufferTop/bufm_tb/bufBus_tb/buf_sel
add wave -noupdate /BufferTop/bufm_tb/bufBus_tb/buf_we
add wave -noupdate /BufferTop/bufm_tb/bufBus_tb/buf_re
add wave -noupdate /BufferTop/bufm_tb/bufBus_tb/cntrl_sel
add wave -noupdate /BufferTop/bufm_tb/bufBus_tb/cntrl_we
add wave -noupdate /BufferTop/bufm_tb/bufBus_tb/cntrl_re
add wave -noupdate /BufferTop/bufm_tb/bufBus_tb/buf_in
add wave -noupdate /BufferTop/bufm_tb/bufBus_tb/cntrl_in
add wave -noupdate /BufferTop/bufm_tb/bufBus_tb/cntrl_out
add wave -noupdate /BufferTop/bufm_tb/bufBus_tb/buf_out
add wave -noupdate /BufferTop/bufm_tb/bufBus_tb/buf_cntrl_status
add wave -noupdate /BufferTop/bufm_tb/bufBus_tb/host_buf_status
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {158725 ns} {164778 ns}
