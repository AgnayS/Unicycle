module C_And3(in0, in1, in2, out);

	parameter BITS = 1;
	input [BITS-1:0] in0;
	input [BITS-1:0] in1;
	input [BITS-1:0] in2;
	output [BITS-1:0] out;

	assign out = in0 & in1 & in2;

endmodule
