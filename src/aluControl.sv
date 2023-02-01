// input: 2-bit alu_mem_write control signal and 6-bit funct field from instruction
// output: 4-bit alu control input
module alucontrol (aluop, funct7, funct3 , out_to_alu);
	input [1:0] aluop;
	input [6:0] funct7;
    input [2:0] funct3;
	output reg[3:0] out_to_alu;
    wire [11:0] ALUControlIn;
    assign ALUControlIn = {aluop,funct7,funct3};

    always @(ALUControlIn)
    casex (ALUControlIn)

        12'b00xxxxxxxxxx: out_to_alu=4'b0010; // add - ld , sd
        12'b01xxxxxxxxxx: out_to_alu=4'b0110 ;// subtract - beq
        12'b100000000000: out_to_alu=4'b0010; // R type - add 
        12'b100100000000: out_to_alu=4'b0110;// R type - subtract
        12'b100000000111: out_to_alu=4'b0000; // R type - AND
        12'b100000000110: out_to_alu=4'b0001; // R type - OR
    

        12'b100000000011: out_to_alu=4'b0011; // slt
        12'b100000000100: out_to_alu=4'b0100; // A<<B
        12'b100000000101: out_to_alu=4'b0101; // A>>B
        12'b100000000111: out_to_alu=4'b0111; // A^B
        12'b100000001000: out_to_alu=4'b1000; // ~A
        12'b100000001001: out_to_alu=4'b1001; // mov
        12'b100000001010: out_to_alu=4'b1010; // mov


    default: out_to_alu=4'b0010;
    endcase


endmodule
