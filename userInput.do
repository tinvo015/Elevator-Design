onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /floorLights_testbench/dut/Clock
add wave -noupdate /floorLights_testbench/dut/Reset
add wave -noupdate /floorLights_testbench/dut/SW
add wave -noupdate /floorLights_testbench/dut/ps
add wave -noupdate /floorLights_testbench/dut/ns
add wave -noupdate /floorLights_testbench/Up
add wave -noupdate /floorLights_testbench/Down
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {276 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 100
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {2048 ps}
