module immGenerator(instruction, immOut);
   input [31:0] instruction;
   output[31:0] immOut;
   reg[31:0] IMM_OUT;
   wire[6:0] opcode;
   wire[2:0] funct3;

   assign immOut = IMM_OUT;
   assign opcode = instruction[6:0];
   assign funct3 = instruction[14:12];

   always @(instruction) #0.1
   casex(opcode)
        7'b0010011: IMM_OUT <= { {21{instruction[31]}}, instruction[30:25], instruction[24:21], instruction[20]};   // ADDI     -> I-Type
        7'b0100011: IMM_OUT <= { {21{instruction[31]}}, instruction[30:25], instruction[11:8], instruction[7]};     // Sd      -> S-Type
        7'b0000011: IMM_OUT <= { {21{instruction[31]}}, instruction[30:25], instruction[24:21], instruction[20]};   // LW       -> I-Type
        7'b1100011: IMM_OUT <= { {20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], {1{1'b0}}};  // BRANCH -> SB-Type
        default: IMM_OUT <= 32'bx;

        
    endcase
endmodule