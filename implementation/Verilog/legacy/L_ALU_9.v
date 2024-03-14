
module L_ALU_9 (immediate, spIn, pcIn, pcOut, raIn, raOut, memoryAddress, memoryIn, memoryOut);

// Handles Jump
// Control bits: None
// Immediate bits: instruction[9:0]
// Each ALU is responsible for sign extending their own immediate

	input [9:0] immediate;
	
	input [15:0] spIn;
	input [15:0] pcIn;
	input [15:0] raIn;
	input [15:0] memoryIn;  //useless?
	
	output reg [15:0] pcOut;
	output reg [15:0] raOut;
	output reg [15:0] memoryAddress;
	output reg [15:0] memoryOut;
	
	// Sign extend the immediate value to 16 bits
   wire signed [15:0] imm_extended = {{6{immediate[9]}}, immediate} << 1;
	
	always @(*) begin
	
        //store current RA at the address pointed by SP
        memoryAddress = spIn;
        memoryOut = raIn;

        //calculate new RA as PC + 2 (next instruction address)
        raOut = pcIn + 16'd2;

        //update PC with new addr (PC+ SE(imm))
        pcOut = pcIn + imm_extended;
    end
	
endmodule
