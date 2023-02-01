// shift-left-1 for branch instruction
// input width: 32 bits
// output width: 32 bits
// fill the void with 0 after shifting
module shiftLeft1 (shift_in, shift_out);
	input [31:0] shift_in;
	output [31:0] shift_out;
	assign shift_out[31:0]={shift_in[30:0],1'b0};
endmodule
