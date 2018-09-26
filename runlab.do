# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./floor1.sv"
vlog "./floor2.sv"
vlog "./floor2m.sv"
vlog "./floor3.sv"
vlog "./floor3m.sv"
vlog "./floor4.sv"
vlog "./floorLights.sv"
vlog "./doors.sv"
vlog "./closing.sv"
vlog "./elevator.sv"
vlog "./elevatorDirection.sv"
vlog "./hexdisplay.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work elevator_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do elevator.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
