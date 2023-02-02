`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2023 06:46:28 PM
// Design Name: 
// Module Name: Cache_decode
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


module Cache_decode(clk, address, tag, index, blk_offset);
    input clk;
    input [9:0] address;

    output reg [3:0] tag;
    output reg [3:0] index;
    output reg [1:0] blk_offset;

    always@(posedge clk)
    begin
        tag <= address[9:6];
        index <= address[5:2];
        blk_offset <= address[1:0];
    end
endmodule