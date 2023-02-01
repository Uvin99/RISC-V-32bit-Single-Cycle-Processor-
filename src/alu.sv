/*
ALU module, which takes two operands of size 32-bits each and a 4-bit ALU_control as input.
Operation is performed on the basis of ALU_control value and output is 32-bit ALU_result. 
If the ALU_result is zero, a ZERO FLAG is set.
*/

/*
ALU Control lines | Function
-----------------------------
        0000    Bitwise-AND
        0001    Bitwise-OR
        0010	Add (A+B)
        0100	Subtract (A-B)
        1000	Set on less than
        0011    Shift left logical
        0101    Shift right logical
        0110    Multiply
        0111    Bitwise-XOR
        1001    Not
        1011    mov
        1010    div
        1101    mod
*/

module alu(
    input [31:0] A,B, 
    input[3:0] alu_control,
    output reg [31:0] alu_result,
    output reg zero_flag 
);
    always @(*)
    begin
        // Operating based on control input
        case(alu_control)

        4'b0000: alu_result = A&B;
        4'b0001: alu_result = A|B;
        4'b0010: alu_result = A+B;
        4'b0110: alu_result = A-B;
        4'b0011: begin 
            if(A<B)
            alu_result = 1;
            else
            alu_result = 0;
        end
        4'b0100: alu_result = A<<B;
        4'b0111: alu_result = A>>B;
        4'b0101: alu_result = A*B;  //multiply
        4'b0111: alu_result = A^B; //xor
        4'b1000: alu_result = ~A;  //not
        4'b1001: alu_result = B;  //mov
        4'b1010: alu_result = A/B; //div
        4'b1101: alu_result = A%B; //mod

        endcase

        // Setting Zero_flag if ALU_result is zero
        if (alu_result == 0)
            zero_flag = 1'b1;
        else
            zero_flag = 1'b0;
        
    end
endmodule