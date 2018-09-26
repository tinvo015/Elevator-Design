onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /elevator_testbench/dut/CLOCK_50
add wave -noupdate /elevator_testbench/dut/Reset
add wave -noupdate /elevator_testbench/dut/KEY
add wave -noupdate /elevator_testbench/dut/LEDR
add wave -noupdate /elevator_testbench/dut/inputfloors
add wave -noupdate /elevator_testbench/dut/currentFloor
add wave -noupdate /elevator_testbench/dut/closeDoor
add wave -noupdate /elevator_testbench/dut/Up
add wave -noupdate /elevator_testbench/dut/Down
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3573 ps} 0}
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
WaveRestoreZoom {0 ps} {7823 ps}
