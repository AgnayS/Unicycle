module L_ALU_4 (immediate, in0, out);

// Handles ADDI
// Control bits: None
// Immediate bits: instruction[11:3]
// Each ALU is responsible for sign extending their own immediate

	input [8:0] immediate;
	input [15:0] in0;
	output [15:0] out;
	
	assign out = in0 + {{7{immediate[8]}}, immediate[8:0]};
	
endmodule