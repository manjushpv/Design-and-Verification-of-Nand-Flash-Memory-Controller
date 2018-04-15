onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MemoryTop/clk
add wave -noupdate /MemoryTop/memIntf/clk
add wave -noupdate /MemoryTop/memIntf/DIO_memCntrl
add wave -noupdate /MemoryTop/memIntf/ALE
add wave -noupdate /MemoryTop/memIntf/CLE
add wave -noupdate /MemoryTop/memIntf/wEn
add wave -noupdate /MemoryTop/memIntf/rEn
add wave -noupdate /MemoryTop/memIntf/cEn
add wave -noupdate /MemoryTop/memIntf/status
add wave -noupdate /MemoryTop/mem/validEnable
add wave -noupdate /MemoryTop/mem/MemBus/clk
add wave -noupdate /MemoryTop/mem/MemBus/DIO_memCntrl
add wave -noupdate /MemoryTop/mem/MemBus/ALE
add wave -noupdate /MemoryTop/mem/MemBus/CLE
add wave -noupdate /MemoryTop/mem/MemBus/wEn
add wave -noupdate /MemoryTop/mem/MemBus/rEn
add wave -noupdate /MemoryTop/mem/MemBus/cEn
add wave -noupdate /MemoryTop/mem/MemBus/status
add wave -noupdate /MemoryTop/mem_tb/DIO_out
add wave -noupdate /MemoryTop/mem_tb/MemBus_tb/clk
add wave -noupdate /MemoryTop/mem_tb/MemBus_tb/DIO_memCntrl
add wave -noupdate /MemoryTop/mem_tb/MemBus_tb/ALE
add wave -noupdate /MemoryTop/mem_tb/MemBus_tb/CLE
add wave -noupdate /MemoryTop/mem_tb/MemBus_tb/wEn
add wave -noupdate /MemoryTop/mem_tb/MemBus_tb/rEn
add wave -noupdate /MemoryTop/mem_tb/MemBus_tb/cEn
add wave -noupdate /MemoryTop/mem_tb/MemBus_tb/status
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
WaveRestoreZoom {35645 ns} {41698 ns}
