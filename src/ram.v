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


module ram(clk,address,data_out);
    input [9:0] address;
    input clk;

    output [127:0] data_out;

    reg [127:0] data_out;
    reg [9:0] intialAddress;
    integer i;
    integer p;
    integer q;


    always@(posedge clk)
    begin
        intialAddress = {address[9:2],{4'b0000}};
        q=31;
        for(i=0;i<4;i=i+1) begin
            data_out[q-:32] = intialAddress;
            // $display("%b\n",data_out[q-:32]);
            q = q+32;        
            intialAddress = intialAddress+1;
            
        end
        // $display("\n");
    end
endmodule