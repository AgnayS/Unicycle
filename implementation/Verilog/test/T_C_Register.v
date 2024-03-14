`timescale 1 ns/100 ps
module T_C_Register();

	reg clk;
	reg rst;
	reg save;
	reg [15:0] din;
	wire [15:0] dout;
	
	C_Register 
	#
	(.BITS(16))
	uut (.clk(clk), .rst(rst), .save(save), .in(din), .out(dout));
	
	 parameter HALF_PERIOD = 50;
    parameter PERIOD = HALF_PERIOD * 2;
    initial begin
        clk = 0;
        forever begin
            #(HALF_PERIOD);
            clk = ~clk;
        end
    end
	 
	 initial begin

	 //Test 1: Test reset
	 $display("Do nothing for 100ns");
	 #(PERIOD);
	 rst = 1;
	 #(PERIOD);
	 rst = 0;
	 if(dout != 0)
	 $display("Error: reset not functional");
	 
	 //Test 2: Should write when save is high
	 #(PERIOD);
	 save = 1;
	 din = -16;
	 #(PERIOD);
	 save = 0;
	 #(PERIOD);
	 if(dout != -16)
	 $display("Error: write not functional");
	 #(PERIOD);
	 save = 0;
	 
	 //Test 3: Should not write when save is high
	 #(PERIOD);
	 din = 32;
	 #(PERIOD);
	 if(dout != -16)
	 $display("Error: register is writing when disabled");
	 end
	 

	 
	 
endmodule