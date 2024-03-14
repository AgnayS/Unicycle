module C_Memory (
	input [15:0] in,
	input [9:0] addr_inst,
	input [9:0] addr_data,  //the addresses are 10 bits
	input save,
	input clk_inst,
	input clk_data,
	output [15:0] out_inst,
	output [15:0] out_data	//these are the 16 bit outputs that are stored at our 10 bit addresses
);
	
	// Port A is for instruction, read only, write permanently disabled
	// Port B is for data, both read and write

	true_dual_port_ram_dual_clock MEMORY (
		.data_a(16'b0),
		.data_b(in),
		.addr_a(addr_inst),
		.addr_b(addr_data),
		.we_a(1'b0),
		.we_b(save),
		.clk_a(clk_inst),
		.clk_b(clk_data),
		.q_a(out_inst),
		.q_b(out_data)
	);
	
endmodule
