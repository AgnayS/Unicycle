
module L_ALU_14 (out, inputLine);

// Handles READ
// Control bits: None
// Immediate bits: None

	output [15:0] out;
	
	input [15:0] inputLine;
	
	assign out = inputLine;
	
endmodule
