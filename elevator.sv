module elevator(CLOCK_50, SW, KEY, LEDR, HEX0, HEX2, HEX3, HEX4);

	input logic CLOCK_50;

	input logic [3:0] KEY; //KEY[2:0]=floor input, KEY[3]=close door
	input logic [9:0] SW;
	
	output logic [6:0] HEX0, HEX2, HEX3, HEX4;
	output logic [9:0] LEDR;

	logic Reset;
	logic [5:0] inputfloors; // floors that are pressed
	logic [5:0] currentFloor; 
	logic [5:0] closeDoor;
	logic Up;
	logic Down;
	logic clockoverall;
	logic [31:0] clk;
	
	logic [3:0] button;


	assign button[3:0] = KEY[3:0];
	
	parameter whichClock = 23;
	
	assign clockoverall = CLOCK_50;
	assign Reset = SW[0];
	
//	clock_divider cdiv (.reset(Reset), .clock(CLOCK_50), .divided_clocks(clk));

	
	closing close(.currentFloor(currentFloor),.close(button[3]), .closeDoor(closeDoor));
	
	floorLights floors(.Clock(clockoverall), .Reset(Reset), .LEDR(LEDR), .SW(inputfloors), .Up(Up), .Down(Down), .currentFloor(currentFloor));
	
	doors door(.Clock(clockoverall), .Reset(Reset), .inputfloors(inputfloors), .closeDoor(button[3]), .currentFloor(currentFloor), .LEDR(LEDR));
	
	elevatorDirection direction(.Clock(clockoverall), .Reset(Reset), .currentFloor(currentFloor), .inputfloors(inputfloors), .LEDR(LEDR), .Up(Up), .Down(Down));
	
	floor1 f1(.Clock(clockoverall), .Reset(Reset), .Done(closeDoor[0]), .KEY(button[2:0]), .floor(inputfloors[0]));
	floor2 f2(.Clock(clockoverall), .Reset(Reset), .Done(closeDoor[1]), .KEY(button[2:0]), .floor(inputfloors[1]));
	floor2m f2m(.Clock(clockoverall), .Reset(Reset), .Done(closeDoor[2]), .KEY(button[2:0]), .floor(inputfloors[2]));
	floor3 f3(.Clock(clockoverall), .Reset(Reset), .Done(closeDoor[3]), .KEY(button[2:0]), .floor(inputfloors[3]));
	floor3m f3m(.Clock(clockoverall), .Reset(Reset), .Done(closeDoor[4]), .KEY(button[2:0]), .floor(inputfloors[4]));
	floor4 f4(.Clock(clockoverall), .Reset(Reset), .Done(closeDoor[5]), .KEY(button[2:0]), .floor(inputfloors[5]));
	
	hexdisplay display(.currentFloor(currentFloor), .Up(Up), .Down(Down), .HEX0(HEX0), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4));

endmodule
	

//	// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
//module clock_divider (reset, clock, divided_clocks);
//	input logic clock, reset;
//	output logic [31:0] divided_clocks;
//	
//	initial begin
//		divided_clocks <=0;
//	end
//		
//	always_ff @(posedge clock) begin	
//		divided_clocks <= divided_clocks + 1;
//	end

//endmodule	
	
	
module elevator_testbench();
	logic clk;
	logic [3:0] KEY;
	logic Reset;
	logic [9:0] LEDR;
	logic [9:0] SW;
	logic [6:0] HEX0, HEX2, HEX3, HEX4;


	elevator dut (.CLOCK_50(clk), .SW(SW), .KEY(KEY), .LEDR(LEDR), .HEX0(HEX0), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4));

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
																	
		SW[0] <= 1; 										@(posedge clk);
																@(posedge clk);
		SW[0] <= 0; KEY[3:0] = 4'b0000;				@(posedge clk);
		
		repeat(4)											@(posedge clk);
		KEY[3:0] = 4'b0011;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);
		
		KEY[3:0] = 4'b0110;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);				
		
		repeat(2)											@(posedge clk);
		KEY[3:0] = 4'b1000;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);
		
		repeat(4)											@(posedge clk);
		KEY[3:0] = 4'b1000;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);
		
		repeat(4)											@(posedge clk);
		KEY[3:0] = 4'b0010;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);				
		KEY[3:0] = 4'b0100;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);	
		KEY[3:0] = 4'b1000;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);
		repeat(4)											@(posedge clk);

		KEY[3:0] = 4'b0101;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);				
		KEY[3:0] = 4'b1000;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);

		repeat(4)											@(posedge clk);
		KEY[3:0] = 4'b0001;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);
		KEY[3:0] = 4'b1000;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);
		repeat(4)											@(posedge clk);
		KEY[3:0] = 4'b1000;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);		
		repeat(4)											@(posedge clk);


		KEY[3:0] = 4'b0001;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);				
		KEY[3:0] = 4'b0110;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);		
		KEY[3:0] = 4'b1000;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);
		repeat(4)											@(posedge clk);

		
		KEY[3:0] = 4'b1000;								@(posedge clk);
		KEY[3:0] = 4'b0000;								@(posedge clk);
		repeat(6)											@(posedge clk);		
		
		 $stop; // End the simulation.
	end
endmodule
 