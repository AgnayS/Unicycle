//module L_ALU_3 (immediate, out, spIn, memoryAddress, memoryIn);

// Handles RTVSP
// Control bits: None
// Immediate bits: instruction[11:3]
// Each ALU is responsible for sign extending their own immediate

	input [8:0] immediate;
	output [15:0] memoryAddress;
	
	input [15:0] spIn;
	input [15:0] memoryIn;
	
	output [15:0] out;
	
endmodule