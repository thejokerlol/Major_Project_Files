`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.02.2018 11:52:37
// Design Name: 
// Module Name: Interrupt_Controller_TestBench
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


module Interrupt_Controller_TestBench(

    );
    reg[1:0] CPU_ID;
    reg[31:0] address;
    reg[31:0] data_in;
    wire[31:0] data_out;
    reg read;
    reg enable_RW;
    reg clk;
    reg reset;
    reg[31:0] PPI_1;
    reg[31:0] PPI_2;
    reg[31:0] PPI_3;
    reg[31:0] PPI_4;
    reg[31:0] SPI;
    wire IRQ0;
    wire FIQ0;
    wire IRQ1;
    wire FIQ1;
    wire IRQ2;
    wire FIQ2;
    wire IRQ3;
    wire FIQ3;
    wire RW_err;
    wire ready;
    
    Interrupt_Controller IC(CPU_ID,address,data_in,data_out,read,enable_RW,clk,reset,
                        PPI_1,PPI_2,PPI_3,PPI_4,SPI,IRQ0,FIQ0,IRQ1,FIQ1,
                        IRQ2,FIQ2,IRQ3,FIQ3,RW_err,ready
        );
        
        initial
        begin
            clk=0;
            reset=1;
            read=0;
            enable_RW=0;
            CPU_ID=0;
            address=0;
            data_in=0;
            PPI_1=0;
            PPI_2=0;
            PPI_3=0;
            PPI_4=0;
            SPI=0;
        end
        
        always
            #5 clk=!clk;
        
        
        initial
            #150 $finish();
            
        initial
        begin
           #1 reset=1'b0;
           #2 reset=1'b1;
           #10 PPI_1=32'h00FF0000;
           #10 PPI_1=32'h0F000F00;
           //there shpuld be an IRQ signal output here
        end    
        
        
        
        
        
        
        
        
        
endmodule
