
module L_ALU_5 (immediate, out);

// Handles LL
// Control bits: None
// Immediate bits: instruction[10:3]
// Each ALU is responsible for sign extending their own immediate

	input [7:0] immediate;
	
	output [15:0] out;
	
	assign out = {{8{immediate[7]}}, immediate[7:0]};
	
endmodule