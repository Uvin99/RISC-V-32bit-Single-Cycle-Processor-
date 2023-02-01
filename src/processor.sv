module processor(clk, reset);
	input clk, reset;       // fastclk (5m[6] Hz) feeds clock divider
	
	// pc signals
	wire [6:0] pc_in, pc_out;
	wire [31:0] pc_origin_al, pc_out_unsign_extended, pc_plus4;

	// Instruction Memory signals
	wire [31:0] instruction;

	// Register File signals
	wire [4:0] reg_write_addr;   // 5 bit register address
	wire [31:0] reg_write_data, reg_read_data_2; // reg_read_data_1 moved to output for simulation

	// Data memory signals
	wire [7:0] d_mem_addr;  // 8 bit data memory address
	wire [31:0] d_mem_read_data;


	// control signals
	wire  branch, mem_read, mem_to_reg, mem_write, aluSrc, reg_write;
	wire [1:0] aluop;
	wire [3:0] alu_control_out;

	// branch
	wire [31:0] generated_immidiate;
	wire [31:0] shifted_immidiate;
	wire [31:0] branch_out;
	wire [31:0] branch_result;
	wire branch_decided, zero;


	// alu
	wire [31:0] alu_in_b, alu_out;

	
	// multi-purpose I-MEM read_addr_1
	//wire [4:0] multi_purpose_read_addr;
	//wire multi_purpose_reg_write;

	// reg to resolve always block technicals
	//reg clkrf_reg, clk_reg, multi_purpose_reg_write_reg;
	//reg [4:0] multi_purpose_read_addr_reg;
	

	assign d_mem_addr = alu_out[7:0];
	assign pc_in = pc_origin_al[6:0];
	assign pc_out_unsign_extended = {25'b0000_0000_0000_0000_0000_00000, pc_out}; // from 7 bits to 32 bits
	



	programCounter program_counter1 (.clk(clk), .reset(reset), .pc_in(pc_in), .pc_out(pc_out));

	InstructionMemory instruction_memory1 (.read_addr(pc_out), .instruction(instruction), .reset(reset));

	registerFile register_file1 (.read_addr_1(instruction[19:15]),
                                 .read_addr_2(instruction[24:20]), 
                                 .write_addr(reg_write_addr), 
                                 .read_data_1(reg_read_data_1), 
                                 .read_data_2(reg_read_data_2), 
                                 .write_data(reg_write_data), 
                                 .reg_write(instruction[11:7]), 
                                 .clk(clk), 
                                 .reset(reset));


	dataMemory data_memory1 (.addr(d_mem_addr),
                             .write_data(reg_read_data_2),
                             .read_data(d_mem_read_data), 
                             .clk(clk), .reset(reset), 
                             .mem_read(mem_read), 
                             .mem_write(mem_write));


	controlUnit control1 (.opcode(instruction[6:0]), 
                          .branch(branch), 
                          .mem_read(mem_read), 
                          .mem_to_reg(mem_to_reg), 
                          .alu_op(aluop), 
                          .mem_write(mem_write), 
                          .alusrc(alusrc), 
                          .reg_write(reg_write));



	aluControl alucontrol1 (.aluop(aluop), 
                            .funct7(instruction[31:25]),
                            .funct3(instruction[14:12]), 
                            .out_to_alu(alu_control_out));

    immGenerator imediateGenerate1 (.instruction(instruction),.immOut(generated_immidiate));

	shiftLeft2 branch_shiftleft2 (.shift_in(generated_immidiate), .shift_out(shifted_immidiate));

	
	mux_N_bit #(32) mux1 (.in0(reg_read_data_2), .in1(generated_immidiate), .mux_out(alu_in_b), .control(aluSrc));

	mux_N_bit #(32) mux2 (.in0(alu_out), .in1(d_mem_read_data), .mux_out(reg_write_data), .control(mem_to_reg));

	mux_N_bit #(32) mux3 (.in0(pc_plus4), .in1(branch_out), .mux_out(branch_result), .control(branch_decided));

	mux_N_bit #(32) mux4(.in0(branch_result), .in1(jump_addr), .mux_out(pc_origin_al), .control(jump));

	alu mainAlu(.A(reg_read_data_1), 
                .B(alu_in_b), 
                .alu_control(alu_control_out),
                .alu_result(alu_out), 
                .zero_flag(zero));

	aluAdder addAlu1 (.in_a(pc_out_unsign_extended), .in_b(32'b0100), .add_out(pc_plus4)); // pc + 4

	aluAdder addAlu2 (.in_a(pc_plus4), .in_b(shifted_immidiate), .add_out(branch_out));

	and (branch_decided, zero, branch);

	

	//assign clkrf = clkrf_reg;
	//assign clk = clk_reg;
	

	
endmodule
