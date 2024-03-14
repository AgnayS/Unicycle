module L_ALU_2 (immediate, in0, spIn, memoryAddress, memoryOut);

// Handles STRSP
// Control bits: None
// Immediate bits: instruction[11:3]
// Each ALU is responsible for sign extending their own immediate

	input [8:0] immediate;
	output reg [15:0] memoryAddress;
	
	input [15:0] in0;
	input [15:0] spIn;
	
	output reg [15:0] memoryOut;
	
	always @ (immediate or in0 or spIn) begin
		memoryOut = in0;
		memoryAddress = {{7{immediate[8]}}, immediate[8:0]} + spIn;
	end	
	
	
endmodule