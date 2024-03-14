module T_L_Register_File();

	reg [2:0] sel0;
	reg [2:0] sel1;
	reg [2:0] sel2;
	reg [2:0] currentSel;
	reg [2:0] currentToWrite;
	reg [15:0] tests_failed;
	
	reg writeDisable;
	reg clk;
	reg rst;
	
	reg [15:0] in;
	wire [15:0] out0;
	wire [15:0] out1;
	wire [15:0] out2;
	
	L_Register_File uut
	(.sel0(sel0), .sel1(sel1), .sel2(sel2), .in(in), .writeDisable(writeDisable), 
	.clk(clk), .rst(rst), .out0(out0), .out1(out1), .out2(out2));
	
	 parameter HALF_PERIOD = 50;
    parameter PERIOD = HALF_PERIOD * 2;
    initial begin
        clk = 0;
        forever begin
            #(HALF_PERIOD);
            clk = ~clk;
        end
    end

	 
	 task test_single_write_0(input integer toWrite);
	 begin
	 currentSel = 0;
	 in = -16;
	 rst = 1;
	 #PERIOD;
	 rst = 0;
	 //writes to specified reg: other sel bits are random regs as these shouldnt affect results
	 sel1 = 5;
	 sel2 = 1;
	 sel0 = toWrite;
	 #PERIOD;
	 writeDisable = 0;
	 #PERIOD;
	 writeDisable = 1;
	 #(2*PERIOD);
	 
	 repeat(7) begin
	 sel0 = currentSel;
	 #(2*PERIOD);
	 if(currentSel != toWrite) //checks that other registers are empty
		if(out0 != 0) begin
			$display("Error: Value %d written to register %d, should have only written to R[%d]", out0, currentSel, toWrite);
			tests_failed = tests_failed + 1;
			end
	 if(currentSel == toWrite)
		if(out0 != 65520) begin
			$display("Error: Value not written to register %d. Out0 = %d, should be -16", currentSel,out0);
			tests_failed = tests_failed + 1;
			end
	 currentSel = currentSel + 1;
	 end
	 
	 end
	 endtask
	 
	 task test_simultaneous_read();
	 begin
	 #initializes values
	 writeDisable = 0;
	 #PERIOD;
	 //R5 <- 7
	 in = 7;
	 sel0 = 5;
	 #PERIOD;
	 //R3 <- 8
	 in = 8;
	 sel0 = 3;
	 //R0 <- 400
	 #PERIOD;
	 in = 400;
	 sel0 = 0;
	 #PERIOD;
	 writeDisable = 1;
	 #(2*PERIOD);
	 
	 //tests reads
	 sel0 = 3;
	 sel1 = 5;
	 sel2 = 0;
	 if(out0 != 8) begin
	 $display("Error: Value not read from register 3 correctly. Out0 = %d, should be 8", out0);
	 tests_failed = tests_failed + 1;
	 end
	 if(out1 != 7) begin
	 $display("Error: Value not read from register 5 correctly. Out1 = %d, should be 8", out1);
	 tests_failed = tests_failed + 1;
	 end
	 if(out2 != 400) begin
	 $display("Error: Value not read from register 0 correctly. Out2 = %d, should be 400", out2);
	 tests_failed = tests_failed + 1;
	 end
	 
	 end
	 endtask
	 
	 

	 
	 //run tests
	 initial begin
	 
	 tests_failed = 0;
	 
	 //single write: r0
	 currentToWrite = 0;
	 repeat(7) begin
	 test_single_write_0(currentToWrite);
	 currentToWrite = currentToWrite + 1;
	 end
	 
	 //multi read
	 test_simultaneous_read();
	 
	 $display("tests failed: %d",tests_failed);
	 $stop;
	 end
	 
	 
endmodule