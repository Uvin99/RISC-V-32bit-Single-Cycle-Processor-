`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2023 06:43:51 PM
// Design Name: 
// Module Name: ram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ram(clk,address,data_out, mem_read, write_data, mem_write,reset);
    input [9:0] address;
    input clk, mem_read, mem_write,reset;
    input [31:0] write_data;
    output [127:0] data_out;

    //reg [127:0] data_out;
    //reg [9:0] intialAddress;
    reg[1:0] offset;
    reg[7:0] index;
    reg [127:0] dmemory [255:0];
    
    integer k;
   

    assign data_out = (mem_read) ? dmemory[address[9:2]] : 128'bx;
    
    
    always @(posedge clk or posedge reset)// Ou modifies reset to posedge
	begin
	   index  = address[9:2];
	   offset = address[1:0];
		if (reset == 1'b1) 
			begin
				for (k=0; k<256; k=k+1) begin
					dmemory[k] = 128'b0;
				end
			end
		else
			if (mem_write) dmemory[index][32*offset+31-:32] = write_data;
	end
endmodule