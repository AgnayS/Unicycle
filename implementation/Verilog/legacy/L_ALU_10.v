
module L_ALU_10 (immediate, spIn, spOut, pcIn, pcOut, raIn, raOut, memoryIn);

// Handles RETURN
// Control bits: instruction[:]
// Immediate bits: instruction[:]
// Each ALU is responsible for sign extending their own immediate

	input [9:0] immediate;
	
	input [15:0] spIn;
	input [15:0] pcIn;
	input [15:0] raIn;
	input [15:0] memoryIn;
	
	output reg [15:0] spOut;
	output reg [15:0] pcOut;
	output reg [15:0] raOut;
	
	// Sign extend immediate: 6 times the MSB concat with rest of imm
	wire [15:0] imm_extended = {{6{immediate[9]}}, immediate[9:0]} << 1;

    always @(*) begin
	 
        //update PC to RA
        pcOut = raIn;

        //calculate new SP
        spOut = spIn + imm_extended;

        //update RA from memory
        raOut = memoryIn;
    end
	 
	 
	 // Logic needs verification yet again
	
endmodule
