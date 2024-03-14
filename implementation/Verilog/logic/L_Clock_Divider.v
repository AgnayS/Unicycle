module L_Clock_Divider(
    input clk,
	 output newClk
);
	wire [0:0] counterOut;

	C_Counter COUNTER(
		.clk(clk),
		.counterOut({newClk, counterOut})
	);
	
endmodule