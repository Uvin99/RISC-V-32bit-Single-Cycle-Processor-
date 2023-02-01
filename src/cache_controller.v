`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2023 06:49:10 PM
// Design Name: 
// Module Name: cache_controller
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


module cache_controller(clk,hit,read);
    input clk;
    input hit;
    
    output reg read;

    always@(posedge clk)
    begin
        if(hit == 1) begin
            read = 1;
        end
        else begin
            read = 0;
        end
    end
endmodule
