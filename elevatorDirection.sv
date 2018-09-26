module elevatorDirection (Clock, Reset, currentFloor, inputfloors, LEDR, Up, Down);

	input logic Clock, Reset;
	
	input logic [5:0] inputfloors; 
	input logic [5:0] currentFloor;
	
	input logic [9:0] LEDR;

	output logic Up, Down; // whether elevator is currently going up or down
		
	
	enum {headingUp, headingDown} ps, ns;

	// Next State logic
	always_comb begin
		case (ps)
			headingUp: 	if (inputfloors > currentFloor & LEDR[0]==0 & LEDR[9]==0) 										ns = headingUp;
							else if (inputfloors[4]==1 & currentFloor[4]==1)													ns = headingUp;
							else if (inputfloors[3]==1 & currentFloor[3]==1)													ns = headingUp;
							else if (inputfloors[2]==1 & currentFloor[2]==1)													ns = headingUp;
							else if (inputfloors[1]==1 & currentFloor[1]==1)													ns = headingUp;
							else if (inputfloors==6'b000000) 																		ns = headingUp;
							else if (LEDR[0]==1 | LEDR[9]==1)																		ns = headingUp;
							else																												ns = headingDown;
			
			headingDown:if (inputfloors < currentFloor & LEDR[0]==0 & LEDR[9]==0)																			ns = headingDown;
							else if (inputfloors[4]==1 & currentFloor[4]==1)																						ns = headingDown;
							else if (inputfloors[3]==1 & currentFloor[3]==1)																						ns = headingDown;
							else if (inputfloors[2]==1 & currentFloor[2]==1)																						ns = headingDown;
							else if (inputfloors[1]==1 & currentFloor[1]==1)																						ns = headingDown;
							else if (currentFloor[4]==1 & inputfloors[4:0]==5'b00000 & inputfloors[5]==1 & LEDR[0]==0 & LEDR[9]==0)				ns = headingUp;
							else if (currentFloor[3]==1 & inputfloors[3:0]==4'b0000 & inputfloors[5:4]!=2'b00 & LEDR[0]==0 & LEDR[9]==0)		ns = headingUp;
							else if (currentFloor[2]==1 & inputfloors[2:0]==3'b000 & inputfloors[5:3]!=3'b000 & LEDR[0]==0 & LEDR[9]==0)		ns = headingUp;
							else if (currentFloor[1]==1 & inputfloors[1:0]==2'b00 & inputfloors[5:2]!=5'b0000 & LEDR[0]==0 & LEDR[9]==0)		ns = headingUp;
							else if (currentFloor[0]==1 & LEDR[0]==0 & LEDR[9]==0)																				ns = headingUp;
							else																																					ns = headingDown;
							

		endcase
		

		// gives floor outputs	
		if (ps==headingUp) begin
			Up=1;
			Down=0;
		end else begin 
			Up=0;
			Down=1;		
		end
	
	end

	
	

	// DFFs
	always_ff @(posedge Clock) begin
		if (Reset)
			ps <= headingUp;
		else
			ps <= ns;
	end

endmodule 

module elevatorDirection_testbench();
	logic clk, Reset;
	logic [5:0] currentFloor;
	logic [5:0] inputfloors;
	logic Up, Down;


	elevatorDirection dut (.Clock(clk), .Reset(Reset), .currentFloor(currentFloor), .inputfloors(inputfloors), .Up(Up), .Down(Down));
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
																	
		Reset <= 1;  				@(posedge clk);
																@(posedge clk);
		Reset <= 0; currentFloor[5:0]=6'b000010; inputfloors[5:0]=6'b000000;				@(posedge clk); 
		repeat(2)											@(posedge clk);

		
		inputfloors[5:0]=6'b010000;								@(posedge clk); //up
		repeat(2)											@(posedge clk);
		inputfloors[5:0]=6'b100001;								@(posedge clk); //Up			
		repeat(2)											@(posedge clk);

		inputfloors[5:0]=6'b000010;								@(posedge clk); //down		
		repeat(2)											@(posedge clk);
		inputfloors[5:0]=6'b010001;								@(posedge clk); //down			
		repeat(2)											@(posedge clk);

		

		 $stop; // End the simulation.
	end
endmodule




