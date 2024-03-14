module L_Register_File(sel0, sel1, sel2, in, writeDisable, clk, rst, out0, out1, out2);

	input [2:0] sel0;
	input [2:0] sel1;
	input [2:0] sel2;
	
	input writeDisable;
	input clk;
	input rst;
	
	input [15:0] in;
	output [15:0] out0;
	output [15:0] out1;
	output [15:0] out2;
	
	wire x0WriteEnable;
	wire x1WriteEnable;
	wire x2WriteEnable;
	wire x3WriteEnable;
	wire x4WriteEnable;
	wire x5WriteEnable;
	wire x6WriteEnable;
	wire x7WriteEnable;
	
	wire [15:0] x0Value;
	wire [15:0] x1Value;
	wire [15:0] x2Value;
	wire [15:0] x3Value;
	wire [15:0] x4Value;
	wire [15:0] x5Value;
	wire [15:0] x6Value;
	wire [15:0] x7Value;
	
	C_Decoder_3 REGISTER_WRITE_SELECT (.dis(writeDisable), .sel(sel0), .out0(x0WriteEnable), .out1(x1WriteEnable), .out2(x2WriteEnable), .out3(x3WriteEnable), .out4(x4WriteEnable), .out5(x5WriteEnable), .out6(x6WriteEnable), .out7(x7WriteEnable));
	
	C_Register # (.BITS(16)) REGISTER_x0 (.clk(clk), .rst(rst), .save(x0WriteEnable), .in(in), .out(x0Value));
	C_Register # (.BITS(16)) REGISTER_x1 (.clk(clk), .rst(rst), .save(x1WriteEnable), .in(in), .out(x1Value));
	C_Register # (.BITS(16)) REGISTER_x2 (.clk(clk), .rst(rst), .save(x2WriteEnable), .in(in), .out(x2Value));
	C_Register # (.BITS(16)) REGISTER_x3 (.clk(clk), .rst(rst), .save(x3WriteEnable), .in(in), .out(x3Value));
	C_Register # (.BITS(16)) REGISTER_x4 (.clk(clk), .rst(rst), .save(x4WriteEnable), .in(in), .out(x4Value));
	C_Register # (.BITS(16)) REGISTER_x5 (.clk(clk), .rst(rst), .save(x5WriteEnable), .in(in), .out(x5Value));
	C_Register # (.BITS(16)) REGISTER_x6 (.clk(clk), .rst(rst), .save(x6WriteEnable), .in(in), .out(x6Value));
	C_Register # (.BITS(16)) REGISTER_x7 (.clk(clk), .rst(rst), .save(x7WriteEnable), .in(in), .out(x7Value));
	
	C_Mux_3 # (.BITS(16)) REGISTER_MUX_0 (.sel(sel0), .in0(x0Value), .in1(x1Value), .in2(x2Value), .in3(x3Value), .in4(x4Value), .in5(x5Value), .in6(x6Value), .in7(x7Value), .out(out0));
	C_Mux_3 # (.BITS(16)) REGISTER_MUX_1 (.sel(sel1), .in0(x0Value), .in1(x1Value), .in2(x2Value), .in3(x3Value), .in4(x4Value), .in5(x5Value), .in6(x6Value), .in7(x7Value), .out(out1));
	C_Mux_3 # (.BITS(16)) REGISTER_MUX_2 (.sel(sel2), .in0(x0Value), .in1(x1Value), .in2(x2Value), .in3(x3Value), .in4(x4Value), .in5(x5Value), .in6(x6Value), .in7(x7Value), .out(out2));
	
endmodule