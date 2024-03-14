module C_Not(in, out);

	parameter BITS = 1;
	input [BITS-1:0] in;
	output [BITS-1:0] out;

	assign out = ~in;

endmodule
