
module L_ALU_13 (in0, out, memoryAddress, memoryIn);

// Handles RTV
// Control bits: None
// Immediate bits: None
	
	input [15:0] in0;
	input [15:0] memoryIn;
	
	output reg [15:0] out;
	output reg [15:0] memoryAddress;
	
	always @(*) begin
		memoryAddress = in0; // Set memory address to the value in register A
		out = memoryIn;      // Store the data read from memory into the output register
	end
	
	// Needs to be verified once, unsure of mappings
	
endmodule
