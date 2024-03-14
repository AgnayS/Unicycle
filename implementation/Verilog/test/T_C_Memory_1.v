`timescale 1ns / 1ps

module tb_C_Memory_1;

    reg [15:0] data_write_b;
    reg [9:0] addr_inst, addr_data;
    reg save_b, CLK;
    wire [15:0] out_inst, out_data;

  
    C_Memory uut (
        .data_write_b(data_write_b),
        .addr_inst(addr_inst),
        .addr_data(addr_data),
        .save_b(save_b),
        .clk(CLK),
        .out_inst(out_inst),
        .out_data(out_data)
    );

    parameter HALF_PERIOD = 50;
    parameter PERIOD = HALF_PERIOD * 2;
    initial begin
        CLK = 0;
        forever begin
            #(HALF_PERIOD);
            CLK = ~CLK;
        end
    end
	 
	 
	 //Test 1 : Check whether we are loading the correct stuff via port A (instruction)
initial begin

	  $display("Do nothing for 100ns");
	 #(PERIOD)
	 
	 $display("Initialize port A for reading at 100 ns");
    addr_inst = 10'd0; 
	 
	 //out_inst should have updated at 150ns
	 
    #(PERIOD); 	

    $display("Instruction at address %d is %h, (reading at 200ns)", addr_inst, out_inst);
	 
	 $display("Test 1 Complete");


end

	 
endmodule
