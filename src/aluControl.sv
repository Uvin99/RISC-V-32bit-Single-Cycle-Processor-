// input: 2-bit alu_mem_write control signal and 6-bit funct field from instruction
// output: 4-bit alu control input
module alucontrol (aluop, funct7, funct3 , out_to_alu);
	input [1:0] aluop;
	input [6:0] funct7;
    input [2:0] funct3;
	output reg[3:0] out_to_alu;
    wire [7:0] ALUControlIn;
    assign ALUControlIn = {aluop,funct7,funct3};

    always @(ALUControlIn)
    casex (ALUControlIn)
        8'b10xxxxxx: out_to_alu=4'b0010; //add - R
        8'b01xxxxxx: out_to_alu=4'b0110; //sub - beq
        8'b00000010: out_to_alu=4'b0010;
        8'b00000011: out_to_alu=4'b0110;
        8'b00000100: out_to_alu=4'b0011;
        8'b00000101: out_to_alu=4'b0100;
        8'b00000110: out_to_alu=4'b0110;
        8'b00000111: out_to_alu=4'b0111;
        8'b00001000: out_to_alu=4'b1000;
        8'b00001001: out_to_alu=4'b1001;
        8'b00001010: out_to_alu=4'b1010;
        8'b00001011: out_to_alu=4'b1011; 
        8'b00001100: out_to_alu=4'b1100; 
        8'b00001101: out_to_alu=4'b1101; 

    default: out_to_alu=4'b0010;
    endcase


endmodule
