module C_LessI(in0, in1, out);

	parameter BITS = 1;
	input signed [BITS-1:0] in0;
	input signed [BITS-1:0] in1;
	output out;

	assign out = in0 < in1;

endmodule
