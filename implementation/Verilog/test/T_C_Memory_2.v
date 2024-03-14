`timescale 1ns / 1ps

module tb_C_Memory_2;

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
   
	//Test 2: Check whether writing and reading via port B (data) works
	initial begin
		 
		 $display("Initializing Test 2");
        // Initialize stuff
        data_write_b = 16'd0; 
        addr_inst = 10'd0; 
        addr_data = 10'd0; 
        save_b = 1'b0;
		  
        #(PERIOD); // Wait for one complete clock cycle
		  $display("Attempting to write data at negative clock edge (100ns)");
        data_write_b = 16'hFFFF; 
        addr_data = 10'd0; 
        save_b = 1'b1; // Enable write
		  #(HALF_PERIOD);
		  
		  $display("Disabling write at rising clock edge (150ns)");
        save_b = 1'b0; // Disable write
        #(HALF_PERIOD);
		  

		  
        // No change in addr_data, so we read from the same address
		  
		  $display("Reading what we wrote at negative clock edge (200ns) ");
        
        if (out_data != 16'hFFFF)
            $display("Write/Read Test Error: Expected data %h, read data %h at address %d", 16'hFFFF, out_data, addr_data);
		  else
				$display("Test Successful! Read data %h at address %d", out_data, addr_data);
    end
	 
endmodule