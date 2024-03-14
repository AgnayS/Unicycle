
module L_ALU_15 (control, in0, spIn, spOut, pcIn, pcOut);

// Handles CHGSP, SETSP, CHGPC, SETPC
// Control bits: {instruction[9], instruction[3]}
//instruction[9] is f4 and instuction[3] is the rightmost bit of f-10
// Immediate bits: None

	input [1:0] control;
	input [15:0] in0;
	input [15:0] spIn;
	input [15:0] pcIn;

	output reg [15:0] spOut;
	output reg [15:0] pcOut;
	
	// Define operations (localparams are constants that we can also use in switch cases)
    localparam CHGSP = 2'b00;
    localparam SETSP = 2'b01;
    localparam CHGPC = 2'b10;
    localparam SETPC = 2'b11;

    always @(*) begin
          case (control)
            CHGSP: spOut = spIn + in0;  // Change SP by adding in0 to current SP
            SETSP: spOut = in0;         // Set SP to in0
            CHGPC: pcOut = pcIn + in0;  // Change PC by adding in0 to current PC
            SETPC: pcOut = in0;         // Set PC to in0
        endcase
    end
	
endmodule
