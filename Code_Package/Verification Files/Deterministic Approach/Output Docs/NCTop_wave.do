onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /NandControllerTop/clk
add wave -noupdate /NandControllerTop/ncIntf/clk
add wave -noupdate /NandControllerTop/ncIntf/buf_out
add wave -noupdate /NandControllerTop/ncIntf/nfc_done
add wave -noupdate /NandControllerTop/ncIntf/command_error
add wave -noupdate /NandControllerTop/ncIntf/buf_in
add wave -noupdate /NandControllerTop/ncIntf/buf_sel
add wave -noupdate /NandControllerTop/ncIntf/buf_we
add wave -noupdate /NandControllerTop/ncIntf/buf_re
add wave -noupdate /NandControllerTop/ncIntf/nfc_cmd
add wave -noupdate /NandControllerTop/ncIntf/RWA
add wave -noupdate /NandControllerTop/ncIntf/Reset
add wave -noupdate /NandControllerTop/ncIntf/nfc_start
add wave -noupdate /NandControllerTop/nc/DIO_memCntrl
add wave -noupdate /NandControllerTop/nc/ALE
add wave -noupdate /NandControllerTop/nc/CLE
add wave -noupdate /NandControllerTop/nc/wEn
add wave -noupdate /NandControllerTop/nc/rEn
add wave -noupdate /NandControllerTop/nc/cEn
add wave -noupdate /NandControllerTop/nc/status
add wave -noupdate /NandControllerTop/nc/ncBus/clk
add wave -noupdate /NandControllerTop/nc/ncBus/buf_out
add wave -noupdate /NandControllerTop/nc/ncBus/nfc_done
add wave -noupdate /NandControllerTop/nc/ncBus/command_error
add wave -noupdate /NandControllerTop/nc/ncBus/buf_in
add wave -noupdate /NandControllerTop/nc/ncBus/buf_sel
add wave -noupdate /NandControllerTop/nc/ncBus/buf_we
add wave -noupdate /NandControllerTop/nc/ncBus/buf_re
add wave -noupdate /NandControllerTop/nc/ncBus/nfc_cmd
add wave -noupdate /NandControllerTop/nc/ncBus/RWA
add wave -noupdate /NandControllerTop/nc/ncBus/Reset
add wave -noupdate /NandControllerTop/nc/ncBus/nfc_start
add wave -noupdate /NandControllerTop/nc/MC/DIO_memCntrl
add wave -noupdate /NandControllerTop/nc/MC/buf_out
add wave -noupdate /NandControllerTop/nc/MC/nfc_done
add wave -noupdate /NandControllerTop/nc/MC/command_error
add wave -noupdate /NandControllerTop/nc/MC/ALE
add wave -noupdate /NandControllerTop/nc/MC/CLE
add wave -noupdate /NandControllerTop/nc/MC/wEn
add wave -noupdate /NandControllerTop/nc/MC/rEn
add wave -noupdate /NandControllerTop/nc/MC/cEn
add wave -noupdate /NandControllerTop/nc/MC/buf_in
add wave -noupdate /NandControllerTop/nc/MC/buf_sel
add wave -noupdate /NandControllerTop/nc/MC/buf_we
add wave -noupdate /NandControllerTop/nc/MC/buf_re
add wave -noupdate /NandControllerTop/nc/MC/nfc_cmd
add wave -noupdate /NandControllerTop/nc/MC/RWA
add wave -noupdate /NandControllerTop/nc/MC/Reset
add wave -noupdate /NandControllerTop/nc/MC/nfc_start
add wave -noupdate /NandControllerTop/nc/MC/clk
add wave -noupdate /NandControllerTop/nc/MC/status
add wave -noupdate /NandControllerTop/nc/MC/cntrl_sel
add wave -noupdate /NandControllerTop/nc/MC/cntrl_we
add wave -noupdate /NandControllerTop/nc/MC/cntrl_re
add wave -noupdate /NandControllerTop/nc/MC/cntrl_in
add wave -noupdate /NandControllerTop/nc/MC/cntrl_out
add wave -noupdate /NandControllerTop/nc/MC/buf_cntrl_status
add wave -noupdate /NandControllerTop/nc/MC/host_buf_status
add wave -noupdate /NandControllerTop/nc/MC/DIO
add wave -noupdate /NandControllerTop/nc/MC/cntrl/clk
add wave -noupdate /NandControllerTop/nc/MC/cntrl/DIO
add wave -noupdate /NandControllerTop/nc/MC/cntrl/cntrl_in
add wave -noupdate /NandControllerTop/nc/MC/cntrl/cntrl_sel
add wave -noupdate /NandControllerTop/nc/MC/cntrl/cntrl_we
add wave -noupdate /NandControllerTop/nc/MC/cntrl/cntrl_re
add wave -noupdate /NandControllerTop/nc/MC/cntrl/nfc_done
add wave -noupdate /NandControllerTop/nc/MC/cntrl/ALE
add wave -noupdate /NandControllerTop/nc/MC/cntrl/CLE
add wave -noupdate /NandControllerTop/nc/MC/cntrl/wEn
add wave -noupdate /NandControllerTop/nc/MC/cntrl/rEn
add wave -noupdate /NandControllerTop/nc/MC/cntrl/command_error
add wave -noupdate /NandControllerTop/nc/MC/cntrl/cEn
add wave -noupdate /NandControllerTop/nc/MC/cntrl/nfc_cmd
add wave -noupdate /NandControllerTop/nc/MC/cntrl/RWA
add wave -noupdate /NandControllerTop/nc/MC/cntrl/Reset
add wave -noupdate /NandControllerTop/nc/MC/cntrl/nfc_start
add wave -noupdate /NandControllerTop/nc/MC/cntrl/status
add wave -noupdate /NandControllerTop/nc/MC/cntrl/cntrl_out
add wave -noupdate /NandControllerTop/nc/MC/cntrl/buf_cntrl_status
add wave -noupdate /NandControllerTop/nc/MC/cntrl/host_buf_status
add wave -noupdate /NandControllerTop/nc/MC/cntrl/DIO_out
add wave -noupdate /NandControllerTop/nc/MC/cntrl/command
add wave -noupdate /NandControllerTop/nc/MC/cntrl/cur_state
add wave -noupdate /NandControllerTop/nc/MC/cntrl/next_state
add wave -noupdate /NandControllerTop/nc/MC/bufm/clk
add wave -noupdate /NandControllerTop/nc/MC/bufm/buf_sel
add wave -noupdate /NandControllerTop/nc/MC/bufm/buf_we
add wave -noupdate /NandControllerTop/nc/MC/bufm/buf_re
add wave -noupdate /NandControllerTop/nc/MC/bufm/cntrl_sel
add wave -noupdate /NandControllerTop/nc/MC/bufm/cntrl_we
add wave -noupdate /NandControllerTop/nc/MC/bufm/cntrl_re
add wave -noupdate /NandControllerTop/nc/MC/bufm/buf_in
add wave -noupdate /NandControllerTop/nc/MC/bufm/cntrl_in
add wave -noupdate /NandControllerTop/nc/MC/bufm/cntrl_out
add wave -noupdate /NandControllerTop/nc/MC/bufm/buf_out
add wave -noupdate /NandControllerTop/nc/MC/bufm/buf_cntrl_status
add wave -noupdate /NandControllerTop/nc/MC/bufm/host_buf_status
add wave -noupdate /NandControllerTop/nc/MC/bufm/host_addr
add wave -noupdate /NandControllerTop/nc/MC/bufm/cntrl_addr
add wave -noupdate /NandControllerTop/nc/MC/bufm/buf_read_flag
add wave -noupdate /NandControllerTop/nc/MC/bufm/cntrl_read_flag
add wave -noupdate /NandControllerTop/nc/MC/bufm/buf_write_flag
add wave -noupdate /NandControllerTop/nc/MC/bufm/cntrl_write_flag
add wave -noupdate /NandControllerTop/nc/mem/clk
add wave -noupdate /NandControllerTop/nc/mem/DIO_memCntrl
add wave -noupdate /NandControllerTop/nc/mem/ALE
add wave -noupdate /NandControllerTop/nc/mem/CLE
add wave -noupdate /NandControllerTop/nc/mem/wEn
add wave -noupdate /NandControllerTop/nc/mem/rEn
add wave -noupdate /NandControllerTop/nc/mem/cEn
add wave -noupdate /NandControllerTop/nc/mem/status
add wave -noupdate /NandControllerTop/nc/mem/Address
add wave -noupdate /NandControllerTop/nc/mem/BaseAddress
add wave -noupdate /NandControllerTop/nc/mem/AddressCount
add wave -noupdate /NandControllerTop/nc/mem/Command
add wave -noupdate /NandControllerTop/nc/mem/DIO_out
add wave -noupdate /NandControllerTop/nc/mem/write_flag
add wave -noupdate /NandControllerTop/nc/mem/read_flag
add wave -noupdate /NandControllerTop/nc/mem/state
add wave -noupdate /NandControllerTop/nc/mem/next_state
add wave -noupdate /NandControllerTop/nc/mem/validEnable
add wave -noupdate /NandControllerTop/nc_tb/ncBus_tb/clk
add wave -noupdate /NandControllerTop/nc_tb/ncBus_tb/buf_out
add wave -noupdate /NandControllerTop/nc_tb/ncBus_tb/nfc_done
add wave -noupdate /NandControllerTop/nc_tb/ncBus_tb/command_error
add wave -noupdate /NandControllerTop/nc_tb/ncBus_tb/buf_in
add wave -noupdate /NandControllerTop/nc_tb/ncBus_tb/buf_sel
add wave -noupdate /NandControllerTop/nc_tb/ncBus_tb/buf_we
add wave -noupdate /NandControllerTop/nc_tb/ncBus_tb/buf_re
add wave -noupdate /NandControllerTop/nc_tb/ncBus_tb/nfc_cmd
add wave -noupdate /NandControllerTop/nc_tb/ncBus_tb/RWA
add wave -noupdate /NandControllerTop/nc_tb/ncBus_tb/Reset
add wave -noupdate /NandControllerTop/nc_tb/ncBus_tb/nfc_start
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
WaveRestoreZoom {59720 ns} {61957 ns}
