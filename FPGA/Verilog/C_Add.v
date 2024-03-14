module C_Add (in0, in1, ci, out, co);

	parameter BITS = 1;
	input [BITS-1:0] in0;
	input [BITS-1:0] in1;
	input ci;
	output [BITS-1:0] out;
	output co;

	assign {co, out} = in0 + in1 + ci;

endmodule
