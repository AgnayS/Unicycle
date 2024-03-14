
module L_ALU_16 (in0, out);

// Handles WRITE
// Control bits: None
// Immediate bits: None

	input [15:0] in0;
	
	output [15:0] out;
	
	// No really, that's it. This doesn't even feel like it should be a component.
	assign out = in0;
	
endmodule
