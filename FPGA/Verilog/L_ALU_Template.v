
module L_ALU_Template (control, immediate, in0, in1, out, spIn, spOut, pcIn, pcOut, raIn, raOut, memoryAddress, memoryIn, memoryOut, inputLine, outputLine);

// Handles ?????????????????
// Control bits: instruction[:]
// Immediate bits: instruction[:]

	input [999:0] control;
	input [999:0] immediate;
	
	input [15:0] in0;
	input [15:0] in1;
	input [15:0] spIn;
	input [15:0] pcIn;
	input [15:0] raIn;
	input [15:0] memoryIn;
	
	output [15:0] out;
	output [15:0] spOut;
	output [15:0] pcOut;
	output [15:0] raOut;
	output [15:0] memoryAddress;
	output [15:0] memoryOut;
	
	
	input [15:0] inputLine;
	output [15:0] outputLine;
	
endmodule
