module C_Neg (in, out);

	parameter BITS = 1;
	input [BITS-1:0] in;
	output [BITS-1:0] out;

	assign out = {BITS{1'b0}} - in;

endmodule
