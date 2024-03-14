
module L_ALU_17 (control, out, spIn, pcIn);	
	
// Handles GETSP, GETPC
// Control bits: instruction[9]
// Immediate bits: None

	input control;
	input [15:0] spIn;
	input [15:0] pcIn;
	
	output reg [15:0] out;
	
	always @(*) begin
        if (control) begin
            // If control high, output PC
            out = pcIn;
        end else begin
            // If control low, output SP
            out = spIn;
        end
    end
	 
	 // Could also benefit from default states here in case stuff messes up.
	
endmodule
