module C_Xor(in0, in1, out);
	
	parameter BITS = 1;
	input [BITS-1:0] in0;
	input [BITS-1:0] in1;
	output [BITS-1:0] out;

	assign out = in0 ^ in1;
	 
endmodule
