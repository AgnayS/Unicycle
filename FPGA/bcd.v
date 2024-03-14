
module BCD (
	input [4:0] val,
	output reg [6:0] hex
);

// 1 is OFF
// 0 is ON

// Top segment is 0, going clockwise is 1-5, center is 6

	always @ val begin
		case (val)
			5'b00000 : hex = 7'b1000000;
			5'b00001 : hex = 7'b1111001;
			5'b00010 : hex = 7'b0100100;
			5'b00011 : hex = 7'b0110000;
			5'b00100 : hex = 7'b0011001;
			5'b00101 : hex = 7'b0010010;
			5'b00110 : hex = 7'b0000010;
			5'b00111 : hex = 7'b1111000;
			5'b01000 : hex = 7'b0000000;
			5'b01001 : hex = 7'b0010000;
			5'b01010 : hex = 7'b0001000;
			5'b01011 : hex = 7'b0000011;
			5'b01100 : hex = 7'b0100111;
			5'b01101 : hex = 7'b0100001;
			5'b01110 : hex = 7'b0000110;
			5'b01111 : hex = 7'b0001110;
			default  : hex = 7'b1111111;
		endcase
	end
endmodule
