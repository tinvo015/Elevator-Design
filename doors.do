onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /doors_testbench/dut/Clock
add wave -noupdate /doors_testbench/dut/Reset
add wave -noupdate /doors_testbench/dut/closeDoor
add wave -noupdate /doors_testbench/dut/inputfloors
add wave -noupdate /doors_testbench/dut/currentFloor
add wave -noupdate /doors_testbench/dut/LEDR
add wave -noupdate /doors_testbench/dut/ps
add wave -noupdate /doors_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {212 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
