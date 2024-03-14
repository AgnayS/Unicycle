
module L_ALU_6 (immediate, in0, out);

// Handles LU
// Control bits: None
// Immediate bits: instruction[10:3]
// Each ALU is responsible for sign extending their own immediate

	input [7:0] immediate;
	
	input [15:0] in0;
	output [15:0] out;
	
	assign out = {immediate[7:0], in0[7:0]};
	
endmodule