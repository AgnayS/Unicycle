
module L_ALU_8 (control, immediate, spIn, spOut, pcIn, pcOut);

// Handles CHGPCI, CHGSPI
// Control bits: instruction[10]
// Immediate bits: instruction[9:0]
// Each ALU is responsible for sign extending their own immediate

	input control;
	input [9:0] immediate;
	
	input [15:0] spIn;
	input [15:0] pcIn;
	output reg [15:0] spOut;
	output reg [15:0] pcOut;
	
	 // Sign extend the immediate value to 16 bits
    wire signed [15:0] imm_extended = {{6{immediate[9]}}, immediate} << 1;
	 

    always @(*) begin
        if (control) begin 
            // Update PC if control == 1
            pcOut = pcIn + imm_extended;
        end else begin
			    // Update SP if control == 0
            spOut = spIn + imm_extended;
        end
    end
	 
	 //Maybe add default states for pcOut and spIn?
	
endmodule
