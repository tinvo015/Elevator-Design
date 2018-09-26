module closing(currentFloor, close, closeDoor);

	input logic close;
	input logic [5:0] currentFloor; 
	output logic [5:0] closeDoor;
	
	
	always_comb begin
		
		
		if (close & currentFloor[0]==1)
			closeDoor = 6'b000001;
		else if (close & currentFloor[1]==1)
			closeDoor = 6'b000010;
		else if (close & currentFloor[2]==1)
			closeDoor = 6'b000100;	
		else if (close & currentFloor[3]==1)
			closeDoor = 6'b001000;	
		else if (close & currentFloor[4]==1)
			closeDoor = 6'b010000;
		else if (close & currentFloor[5]==1)
			closeDoor = 6'b100000;
		else
			closeDoor = 6'b000000;
	

	end

	
	
endmodule
	
	
	
	
 