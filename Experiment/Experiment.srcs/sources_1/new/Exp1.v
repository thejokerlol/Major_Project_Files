`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.01.2018 05:59:32
// Design Name: 
// Module Name: Exp1
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


module Exp1(
    clk,
    in1,
    control,
    out
    );
    input clk;
    input in1;
    input control;
    output out;
    always@(posedge clk or in1)
    begin
        if(control)
        begin
            out=in1;
        end
        else
        begin
            
        end
    end
endmodule
