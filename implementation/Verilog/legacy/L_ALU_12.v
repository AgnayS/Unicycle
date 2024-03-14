
module L_ALU_12 (in0, in1, memoryAddress, memoryOut);

// Handles STR
// Control bits: None
// Immediate bits: None

	input [15:0] in0;  //A
	input [15:0] in1;  //B
	
	output reg [15:0] memoryAddress;
	output reg [15:0] memoryOut;
	
	    always @(*) begin
        memoryAddress = in1; // Set memory address to the value in register A
        memoryOut = in0;     // Set the data to be written to the value in register B
    end
	
	
	// Also needs to be verified, unsure of logic
	
endmodule
