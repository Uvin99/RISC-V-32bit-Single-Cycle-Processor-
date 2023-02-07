`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2023 11:02:51 AM
// Design Name: 
// Module Name: cache_ram
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


module cache_ram(addr, write_data, read_data, clk, reset, mem_read, mem_write);
    input [9:0] addr;
	input [31:0] write_data;
	output [31:0] read_data;
	input clk, reset, mem_read, mem_write;
	
	wire [127:0] ram_to_cache;
	wire read;
	wire hit;
	
	ram RAM_1(clk,addr,ram_to_cache, mem_read, write_data, mem_write,reset);
	cache Cache_1(clk,addr,read,ram_to_cache,read_data,hit);
	cache_controller u0(clk,hit,read);
	
    
    
endmodule
