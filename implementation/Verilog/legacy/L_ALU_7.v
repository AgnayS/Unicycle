
module L_ALU_7 (immediate, in0, out);

// Handles SHIFT
// Control bits: None
// Immediate bits: instruction[10:6]
// Each ALU is responsible for sign extending their own immediate

	input [4:0] immediate;
	input [15:0] in0;
	output reg [15:0] out;
	
	
	//Sign extend our 5 bit immediate (11 + original 5 = 16)
	
	wire signed [15:0] imm_extended = {{11{immediate[4]}}, immediate};
	
	 always @(*) begin
        if (imm_extended < 0) begin
            // If immediate is negative, perform right shift
            out = in0 >> -imm_extended; // We flip the negative number to a positive one
        end else begin
            // If immediate is positive, perform standard left shit
            out = in0 << imm_extended;
        end
    end
	
	
endmodule
