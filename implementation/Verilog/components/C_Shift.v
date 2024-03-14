
module C_SHIFT (immediate, in0, out);

	input signed [4:0] immediate;
	input [15:0] in0;
	output reg [15:0] out;
	
	always @(*) begin
		if (immediate < 0) begin
			// If immediate is negative, perform right shift
			out = in0 >> -immediate; // We flip the negative number to a positive one
		end else begin
			// If immediate is positive, perform standard left shit
			out = in0 << immediate;
		end
	end

	
endmodule
