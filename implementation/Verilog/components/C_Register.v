module C_Register (clk, rst, save, in, out);

	parameter BITS = 16;
	input clk;
	input rst;
	input save;
	input [BITS-1:0] in;
	output reg [BITS-1:0] out;

	reg [BITS-1:0] value;
	reg reset;

	initial begin
		out = {BITS{1'b0}};
		value = {BITS{1'b0}};
	end
	
	always @ (posedge clk, posedge rst) begin
	   if (rst)
			value = {BITS{1'b0}};
		else if (save)
			value = in;
		out = value;
	end

endmodule
  