module C_Switch(en, in, out);

	parameter BITS = 1;
	input en;
	input [BITS-1:0] in;
	output [BITS-1:0] out;
	reg [BITS-1:0] outval;

	always @ (en or in) begin
		case(en)
		1'b0 : outval = {BITS{1'b0}};
		1'b1 : outval = in;
		endcase
	end
	assign out = outval;

endmodule
