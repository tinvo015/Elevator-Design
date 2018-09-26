module hexdisplay(currentFloor, Up, Down, HEX0, HEX2, HEX3, HEX4);

	input logic [5:0] currentFloor;
	input logic Up, Down;
	
	output logic [6:0] HEX0, HEX2, HEX3, HEX4;
	
	always_comb begin
		if (currentFloor == 6'b000001) begin //1
			HEX4 = 7'b1001111;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
		end else if (currentFloor == 6'b000010) begin //2
			HEX4 = 7'b0100100;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
		end else if (currentFloor == 6'b000100) begin //2m
			HEX4 = 7'b0100100;
			HEX3 = 7'b1001000;
			HEX2 = 7'b1001000;
		end else if (currentFloor == 6'b001000) begin //3
			HEX4 = 7'b0110000;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
		end else if (currentFloor == 6'b010000) begin //3m
			HEX4 = 7'b0110000;
			HEX3 = 7'b1001000;
			HEX2 = 7'b1001000;
		end else begin //4
			HEX4 = 7'b0011001;
			HEX3 = 7'b1111111;
			HEX2 = 7'b1111111;
		end
		
		if (Up)
			HEX0 = 7'b1000001;
		else 
			HEX0 = 7'b0100001;
	end
endmodule

		