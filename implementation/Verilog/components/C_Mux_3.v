module C_Mux_3 (sel, in0, in1, in2, in3, in4, in5, in6, in7, out);

   parameter BITS = 1;
	input [2:0] sel;
	input [BITS-1:0] in0;
	input [BITS-1:0] in1;
	input [BITS-1:0] in2;
	input [BITS-1:0] in3;
	input [BITS-1:0] in4;
	input [BITS-1:0] in5;
	input [BITS-1:0] in6;
	input [BITS-1:0] in7;
	output reg [BITS-1:0] out;

	always @ * begin
		case (sel)
			default : out = in0;
			3'b001 : out = in1;
			3'b010 : out = in2;
			3'b011 : out = in3;
			3'b100 : out = in4;
			3'b101 : out = in5;
			3'b110 : out = in6;
			3'b111 : out = in7;
		endcase
	end
endmodule
