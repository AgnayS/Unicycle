module P_Letscher (clk, rst, inputLine, outputLine);

	input clk;
	input rst;
	input [15:0] inputLine;
	output [15:0] outputLine;
	
	wire [15:0] instruction;
	
	wire [15:0] RegisterOut0;
	wire [15:0] RegisterOut1;
	wire [15:0] RegisterOut2;
	
	reg [15:0] RegisterDataInBus;
	reg [15:0] pcIncrementValue;
	reg [15:0] pcAlternateDataInBus;
	reg [15:0] MemoryDataInBus;
	
	reg [15:0] SPDataInBus;
	wire [15:0] PCDataInBus;
	reg [15:0] RADataInBus;
	
	wire x0WriteEnable;
	wire x1WriteEnable;
	wire x2WriteEnable;
	wire x3WriteEnable;
	wire x4WriteEnable;
	wire x5WriteEnable;
	wire x6WriteEnable;
	wire x7WriteEnable;
	wire GPRegisterWriteDisable;
	
	wire spWriteEnable;
	wire pcWriteEnable;
	wire raWriteEnable;
	
	
	wire pcWriteAlternate;
	
	wire x0Value;
	wire x1Value;
	wire x2Value;
	wire x3Value;
	wire x4Value;
	wire x5Value;
	wire x6Value;
	wire x7Value;
	wire spValue;
	wire pcValue;
	wire raValue;

//   ######                                                    
//   #     # ######  ####  #  ####  ##### ###### #####   ####  
//   #     # #      #    # # #        #   #      #    # #      
//   ######  #####  #      #  ####    #   #####  #    #  ####  
//   #   #   #      #  ### #      #   #   #      #####       # 
//   #    #  #      #    # # #    #   #   #      #   #  #    # 
//   #     # ######  ####  #  ####    #   ###### #    #  ####  

	assign pcWriteEnable = 1'b1;
	
	assign outputLine = RegisterOut0;
	
	C_Register # (.BITS(16)) REGISTER_x0 (.clk(clk), .rst(rst), .save(x0WriteEnable), .in(RegisterDataInBus), .out(x0Value));
	C_Register # (.BITS(16)) REGISTER_x1 (.clk(clk), .rst(rst), .save(x1WriteEnable), .in(RegisterDataInBus), .out(x1Value));
	C_Register # (.BITS(16)) REGISTER_x2 (.clk(clk), .rst(rst), .save(x2WriteEnable), .in(RegisterDataInBus), .out(x2Value));
	C_Register # (.BITS(16)) REGISTER_x3 (.clk(clk), .rst(rst), .save(x3WriteEnable), .in(RegisterDataInBus), .out(x3Value));
	C_Register # (.BITS(16)) REGISTER_x4 (.clk(clk), .rst(rst), .save(x4WriteEnable), .in(RegisterDataInBus), .out(x4Value));
	C_Register # (.BITS(16)) REGISTER_x5 (.clk(clk), .rst(rst), .save(x5WriteEnable), .in(RegisterDataInBus), .out(x5Value));
	C_Register # (.BITS(16)) REGISTER_x6 (.clk(clk), .rst(rst), .save(x6WriteEnable), .in(RegisterDataInBus), .out(x6Value));
	C_Register # (.BITS(16)) REGISTER_x7 (.clk(clk), .rst(rst), .save(x7WriteEnable), .in(RegisterDataInBus), .out(x7Value));
	
	C_Register # (.BITS(16)) REGISTER_sp (.clk(clk), .rst(rst), .save(spWriteEnable), .in(SPDataInBus), .out(spValue));
	C_Register # (.BITS(16)) REGISTER_pc (.clk(clk), .rst(rst), .save(pcWriteEnable), .in(PCDataInBus), .out(pcValue));
	C_Register # (.BITS(16)) REGISTER_ra (.clk(clk), .rst(rst), .save(raWriteEnable), .in(RADataInBus), .out(raValue));
	
	C_Decoder_3 REGISTER_WRITE_SELECT (.dis(GPRegisterWriteDisable), .sel(instruction[2:0]), .out0(x0WriteEnable), .out1(x1WriteEnable), .out2(x2WriteEnable), .out3(x3WriteEnable), .out4(x4WriteEnable), .out5(x5WriteEnable), .out6(x6WriteEnable), .out7(x7WriteEnable));
	
	C_Mux_3 # (.BITS(16)) REGISTER_MUX_0 (.sel(instruction[2:0]), .in0(x0Value), .in1(x1Value), .in2(x2Value), .in3(x3Value), .in4(x4Value), .in5(x5Value), .in6(x6Value), .in7(x7Value), .out(RegisterOut0));
	C_Mux_3 # (.BITS(16)) REGISTER_MUX_1 (.sel(instruction[5:3]), .in0(x0Value), .in1(x1Value), .in2(x2Value), .in3(x3Value), .in4(x4Value), .in5(x5Value), .in6(x6Value), .in7(x7Value), .out(RegisterOut1));
	C_Mux_3 # (.BITS(16)) REGISTER_MUX_2 (.sel(instruction[8:6]), .in0(x0Value), .in1(x1Value), .in2(x2Value), .in3(x3Value), .in4(x4Value), .in5(x5Value), .in6(x6Value), .in7(x7Value), .out(RegisterOut2));
	
	C_Memory # (.BITS(16)) MEMORY (.in(), .addr_inst(pcValue), .addr_data(), .save(), .clk(clk), .out_inst(instruction), .out_data());
	
	C_Mux # (.BITS(16)) PC_SELECT (.sel(pcWriteAlternate), .in0(pcIncrementValue), .in1(pcAlternateDataInBus), .out(PCDataInBus));
	
	always @ (pcValue) begin
		pcIncrementValue = pcValue + 2;
	end
endmodule