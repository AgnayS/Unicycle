module C_Counter(
    input clk,
    output reg [1:0] counterOut
);
	initial counterOut = 0;
 
	always @ (posedge clk) begin
		counterOut = counterOut + 1;
	end
	
endmodule
