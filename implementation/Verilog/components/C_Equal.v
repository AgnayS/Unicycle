module C_Equal(in0, in1, out);

	parameter BITS = 1;
	input [BITS-1:0] in0;
	input [BITS-1:0] in1;
	output out;

	assign out = (in0 ^ in1) == {BITS{1'b0}};

endmodule
