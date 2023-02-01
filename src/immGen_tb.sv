`include "immGenerator.sv"

module immGen_tb ();
    reg [31:0] instruct;
    
    wire [31:0] immOut1;

    // Instantiating modules
    immGenerator immgen(.instruction(instruct),.immOut(immOut1));
    
    

    // Test conditions
    initial
    begin
       instruct = 32'b000000001100xxxxxxxxxxxxx0010011 ;
    #20 instruct = 32'b000011000000xxxxxxxx000110100011;
    #20 instruct = 32'b000011000000xxxxxxxx000110100011;
    #20 instruct = 32'b000000000000xxxxxxxx000101100011;    
    
    end

    // Finish after 250 clock cycles
    initial
    #100 $finish;

endmodule
