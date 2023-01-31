// input: 6 bits mem_writecode
// output: all 1 bit except alu_mem_write which is 2-bits wide
module control (opcode, reg_dest, jump, branch, mem_read, mem_to_reg, alu_op, mem_write, alusrc, reg_write);
	input [6:0] opcode;
	output reg reg_dest, jump, branch, mem_read, mem_to_reg, mem_write, alusrc, reg_write;
	output reg[1:0] alu_op;

always @(*)
begin
 case(opcode) 
 7'b0110011:  // R-format 
   begin
    reg_dest = 1'b0;
    alusrc = 1'b0;
    mem_to_reg = 1'b0;
    reg_write = 1'b1;
    mem_read = 1'b0;
    mem_write = 1'b0;
    branch = 1 'b0;
    jump = 1'b0;  
    alu_op = 2'b10; 
   end

 7'b0000011:  // Id
   begin
    reg_dest = 1'b0;
    alusrc = 1'b1;
    mem_to_reg = 1'b1;
    reg_write = 1'b1;
    mem_read = 1'b1;
    mem_write = 1'b0;
    branch = 1 'b0;
    jump = 1'b0;  
    alu_op = 2'b00; 
   end

 7'b0100011:  // sd
   begin
    reg_dest = 1'b0;
    alusrc = 1'b1;
    mem_to_reg = 1'bx;
    reg_write = 1'b0;
    mem_read = 1'b0;
    mem_write = 1'b1;
    branch = 1 'b0;
    jump = 1'b0;  
    alu_op = 2'b00; 
   end

 7'b1100011:  // beq
   begin
    reg_dest = 1'b0;
    alusrc = 1'b0;
    mem_to_reg = 1'bx;
    reg_write = 1'b0;
    mem_read = 1'b0;
    mem_write = 1'b0;
    branch = 1 'b1;
    jump = 1'b0;  
    alu_op = 2'b01; 
   end

 
 7'b0001101:  // J
   begin
    reg_dest = 1'b0;
    alusrc = 1'b0;
    mem_to_reg = 1'b0;
    reg_write = 1'b0;
    mem_read = 1'b0;
    mem_write = 1'b0;
    branch = 0;
    alu_op = 2'b00;
    jump = 1'b1;   
   end   


 default: begin
    reg_dest = 1'b0;
    alusrc = 1'b0;
    mem_to_reg = 1'b0;
    reg_write = 1'b1;
    mem_read = 1'b0;
    mem_write = 1'b0;
    branch = 1'b0;
    alu_op = 2'b00;
    jump = 1'b0; 
   end
 endcase
 end

endmodule