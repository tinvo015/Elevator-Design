// takes in the requested floors as input and moves the elevator to that floor
// provides the current floor that the elevator is at as the output
module doors(Clock, Reset, inputfloors, closeDoor, currentFloor, LEDR);

	input logic Clock, Reset, closeDoor;
	
	input [5:0] inputfloors; // SW[0]=1st floor| SW[1] = 2| SW[2]=2M| SW[3] = 3| SW[4] = 3M| SW[5] = 4

	input logic [5:0] currentFloor;
	output logic [9:0] LEDR;
		
	
	enum {open, closed} ps, ns;

	// Next State logic
	always_comb begin
		case (ps)

			open: 	if (~closeDoor)														ns = open;
						else 																		ns = closed;
			
			closed: 	if (closeDoor)															ns = closed;
						else if (inputfloors[0]==1 & currentFloor[0]==1) 			ns = open;  
						else if (inputfloors[1]==1 & currentFloor[1]==1)			ns = open; 																										
						else if (inputfloors[2]==1 & currentFloor[2]==1)			ns = open; 															
						else if (inputfloors[3]==1 & currentFloor[3]==1)			ns = open; 																							
						else if (inputfloors[4]==1 & currentFloor[4]==1)			ns = open; 																									
						else if (inputfloors[5]==1 & currentFloor[5]==1)			ns = open; 
						else 																		ns = closed;
		endcase
		
		
		
		if(ps==open & currentFloor[0]==1 ) begin
			LEDR[0]=1;
			LEDR[9]=1;
		end else if (ps==open & currentFloor[1]==1) begin
			LEDR[0]=1;
			LEDR[9]=1;
		end else if (ps==open & currentFloor[2]==1) begin
			LEDR[0]=1;
			LEDR[9]=0;
		end else if (ps==open & currentFloor[3]==1) begin
			LEDR[0]=1;
			LEDR[9]=1;
		end else if (ps==open & currentFloor[4]==1) begin
			LEDR[0]=1;
			LEDR[9]=0;
		end else if (ps==open & currentFloor[5]==1) begin
			LEDR[0]=1;
			LEDR[9]=1;
		end else begin
			LEDR[0]=0;
			LEDR[9]=0;
		end
	end
	
		
	// DFFs
	always_ff @(posedge Clock) begin
		if (Reset)
			ps <= open;
		else
			ps <= ns;
	end

endmodule 

module doors_testbench();
	logic clk;
	logic [5:0] inputfloors;
	logic [5:0] currentFloor;
	logic [9:0] LEDR;
	logic Reset;
	logic closeDoor;


	doors dut (.Clock(clk), .Reset(Reset), .inputfloors(inputfloors), .closeDoor(closeDoor), .currentFloor(currentFloor), .LEDR(LEDR));

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
																	
		Reset <= 1; currentFloor<= 6'b000000; inputfloors<=6'b000000; closeDoor <=0;	@(posedge clk);
																							@(posedge clk);
		Reset <= 0; currentFloor <= 6'b010000;				@(posedge clk);
		repeat(5)													@(posedge clk);
		
		inputfloors <= 6'b010000;								@(posedge clk);			
		repeat(5)													@(posedge clk);

		closeDoor <= 1;								@(posedge clk);			
		repeat(10)											@(posedge clk);
		
				
		

		 $stop; // End the simulation.
	end
endmodule




