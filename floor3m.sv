module floor3m (Clock, Reset, Done, KEY, floor);

	input logic Clock, Reset, Done;

	input logic [2:0] KEY; //user input

	output logic floor; // floors that are pressed

	enum {on, off} ps, ns;


	// Next State logic
	always_comb begin
		case(ps)

			off: if(KEY == 3'b101) 		ns = on;
				  else						ns = off;
			on:  if(Done) 					ns = off;
				  else						ns = on;
			
		endcase
						
	
		if(ps == on)
			floor = 1;
		else
			floor = 0;

	end


	// DFFs
	always_ff @(posedge Clock) begin
		if (Reset)
			ps <= off;
		else
			ps <= ns;
	end

endmodule
