`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/30/2023 06:42:49 PM
// Design Name: 
// Module Name: cache
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
`define BLOCKS 16
`define WORDS 4
`define SIZE 32
`define BLOCK_SIZE 128


module cache(clk,address,read,dataIn,dataOut,hit);

    input clk;
    input [9:0] address;
    input read;
    input [`BLOCK_SIZE-1:0] dataIn;

    output reg hit;
    output reg [31:0] dataOut;

    reg [`BLOCK_SIZE+4:0] buffer;// leaving 4 bits as Tag Directory
    reg [3:0] index;
    reg [1:0] blockOffset;
    reg [`BLOCK_SIZE + 4:0] cache [`BLOCKS-1:0];  // Initialiting registry for data+tag

    always@(posedge clk)
    begin
        index = address[5:2];
        blockOffset = address[1:0];
        
        if(read == 0) begin
            buffer[0] = 1;
            buffer[4:1] = address[31:28];
            buffer[132:5] = dataIn;
            cache[index] = buffer;
            dataOut = cache[index][32*blockOffset+5+31-:32];
            hit = 1;
        end
        if(read == 1) begin
            if(address[31:28] == cache[index][4:1]) begin
                hit = 1;
            end
            else begin
                hit = 0;
            end
            // hit = 0;
            dataOut = cache[index][32*blockOffset+5+31-:32];
        end
        else begin
            hit = 1;
        end
    end

endmodule


