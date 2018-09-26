// takes in the requested floors as input and moves the elevator to that floor
// provides the current floor that the elevator is at as the output
module floorLights (Clock, Reset, LEDR, SW, Up, Down, currentFloor);

	input logic Clock, Reset;
	
	input logic [5:0] SW; // inputfloor SW[0]=1st floor| SW[1] = 2| SW[2]=2M| SW[3] = 3| SW[4] = 3M| SW[5] = 4
	
	input logic [9:0] LEDR;
	
	input logic Up, Down; // whether elevator is currently going up or down
	output logic [5:0] currentFloor;
		
	
	enum {one, two, twoM, three, threeM, four} ps, ns;

	// Next State logic
	always_comb begin
		case (ps)
			one: 	if ((SW[1] | SW[2] | SW[3] | SW[4] | SW[5]) & ~SW[0] & LEDR[9]==0 & LEDR[0]==0) 								ns = two; // go up if any floors other than current is pressed 
					else 																																	ns = one;
			
			two: 	if (Up & (SW[2] | SW[3] | SW[4] | SW[5]) & ~SW[1] & LEDR[9]==0 & LEDR[0]==0)									ns = twoM; // continues up if upper floors are pressed regardless whether lower floors are pressed
					else if (Down & ~(SW[0] | SW[1]) & (SW[2] | SW[3] | SW[4] | SW[5]) & LEDR[9]==0 & LEDR[0]==0)  			ns = twoM; // goes up if only upper floors are pressed
					else if (Down & SW[0] & ~SW[1] & LEDR[9]==0 & LEDR[0]==0)									 						ns = one; // continues down if lower floor is pressed regardless whether upper floors are pressed
					else if (Up & ~(SW[1] | SW[2] | SW[3] | SW[4] | SW[5]) & SW[0] & LEDR[9]==0 & LEDR[0]==0)					ns = one; // goes down only if no lower floors are pressed and lower floor is pressed
					else 																																	ns = two;
			
			twoM: if (Up & (SW[3] | SW[4] | SW[5]) & ~SW[2] & LEDR[9]==0 & LEDR[0]==0) 												ns = three;
					else if (Down & ~(SW[0] | SW[1] | SW[2]) & (SW[3] | SW[4] | SW[5]) & LEDR[9]==0 & LEDR[0]==0)			ns = three;
					else if (Down & (SW[0] | SW[1]) & ~SW[2] & LEDR[9]==0 & LEDR[0]==0)												ns = two;
					else if (Up & ~(SW[2] | SW[3] | SW[4] | SW[5]) & (SW[0] | SW[1]) & LEDR[9]==0 & LEDR[0]==0)				ns = two;
					else 																																	ns = twoM;
			
			three: if (Up & (SW[4] | SW[5]) & ~SW[3] & LEDR[9]==0 & LEDR[0]==0)														ns = threeM;
					 else if (Down & ~(SW[3] | SW[2] | SW[1] | SW[0]) & (SW[4] | SW[5]) & LEDR[9]==0 & LEDR[0]==0)			ns = threeM;
					 else if (Down & (SW[2] | SW[1] | SW[0]) & ~SW[3] & LEDR[9]==0 & LEDR[0]==0)									ns = twoM;
					 else if (Up & ~(SW[3] | SW[4] | SW[5]) & (SW[2] & SW[1] & SW[0]) & LEDR[9]==0 & LEDR[0]==0)				ns = twoM;
					 else																																	ns = three;
					 
			threeM: if (Up & SW[5] & ~SW[4] & LEDR[9]==0 & LEDR[0]==0)																	ns = four;
					  else if (Down & ~(SW[4] | SW[3] | SW[2] | SW[1] | SW[0]) & SW[5] & LEDR[9]==0 & LEDR[0]==0)			ns = four;
					  else if (Down & (SW[3] | SW[2] | SW[1] | SW[0]) & ~SW[4] & LEDR[9]==0 & LEDR[0]==0)						ns = three;
					  else if (Up & ~(SW[4] | SW[5]) & (SW[3] | SW[2] | SW[1] | SW[0]) & LEDR[9]==0 & LEDR[0]==0)			ns = three;
					  else 																																ns = threeM;
					  
		  four: 	if ((SW[0] | SW[1] | SW[2] | SW[3] | SW[4]) & ~SW[5] & LEDR[9]==0 & LEDR[0]==0)								ns = threeM;
					else 																																	ns = four;

		endcase
		

		// gives floor outputs	
		if (ps==one) begin
			currentFloor =6'b000001; 
		end else if (ps==two) begin
			currentFloor =6'b000010; 
		end else if (ps==twoM) begin
			currentFloor =6'b000100; 
		end else if (ps==three) begin
			currentFloor =6'b001000; 
		end else if (ps==threeM) begin
			currentFloor =6'b010000; 
		end else begin 
			currentFloor =6'b100000; 
		end
	
	end
	

	// DFFs
	always_ff @(posedge Clock) begin
		if (Reset)
			ps <= one;
		else
			ps <= ns;
	end

endmodule 

module floorLights_testbench();
	logic clk;
	logic [9:0] SW;
	logic [5:0] currentFloor;
	logic Up, Down;


	floorLights dut (.Clock(clk), .Reset(SW[9]), .SW(SW[5:0]), .Up(Up), .Down(Down), .currentFloor(currentFloor));

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
																	
		SW[9] <= 1; Up <=0; Down <=0; 				@(posedge clk);
																@(posedge clk);
		SW[9] <= 0; SW[5:0]=6'b000010;				@(posedge clk);
		repeat(5)											@(posedge clk);
		
		SW[5:0]=6'b011000;								@(posedge clk);			
		repeat(5)											@(posedge clk);

		SW[5:0]=6'b000100;								@(posedge clk);			
		repeat(5)											@(posedge clk);

		
//		SW[9] <= 1; Up <=1; Down <=0; 				@(posedge clk);
//		SW[5:0]=6'b000100;								@(posedge clk);			
//		repeat(5)											@(posedge clk);		
		

		 $stop; // End the simulation.
	end
endmodule




