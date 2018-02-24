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
    reg[16:31] PPI_1;
    reg[16:31] PPI_2;
    reg[16:31] PPI_3;
    reg[16:31] PPI_4;
    reg[31:0] SPI;
    wire[3:0] IRQ;
    wire[3:0] FIQ;
    wire RW_err;
    wire ready;
    
    
   /* wire[7:0] HP1;
    wire[7:0] HP2;
    wire[7:0] HP3;
    wire[7:0] HP4;
    
    wire[5:0] HP_ID1;
    wire[5:0] HP_ID2;
    wire[5:0] HP_ID3;
    wire[5:0] HP_ID4;
    
    wire[7:0] Active1;
    wire[7:0] Active2;
    wire[7:0] Active3;
    wire[7:0] Active4;
    
    wire en1;
    wire en2;
    wire en3;
    wire en4;*/
    
    parameter CPU_INTERFACE_BASE_ADDRESS=32'd4096;
    parameter DISTRIBUTOR_BASE_ADDRESS=32'd0;
    
    Interrupt_Controller IC(CPU_ID,address,data_in,data_out,read,enable_RW,clk,reset,
                        PPI_1,PPI_2,PPI_3,PPI_4,SPI,IRQ,FIQ,RW_err,ready
                       /* HP_ID1,HP_ID2,HP_ID3,HP_ID4,
                                            HP1,HP2,HP3,HP4,
                                            Active1,Active2,Active3,Active4,
                                            en1,en2,en3,en4*/
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
            #20 clk=!clk;
        
        
        initial
            #1400 $finish();
            
        initial
        begin
            #100
           #25 reset=1'b0;
           #5 reset=1'b1;
           #40 PPI_1=16'h00FF;
           //there shpuld be an IRQ signal output here
           #80 PPI_1=16'h0F00;
           
           
           //there shpuld be an IRQ signal output here
           #40 address=CPU_INTERFACE_BASE_ADDRESS+8'h0C;
               read=1'b1;
               enable_RW=1'b1;
           #40 enable_RW=1'b0; 
           //for a software generated interrupt
           #80 read=1'b0;
               enable_RW=1'b1;
               address=DISTRIBUTOR_BASE_ADDRESS+12'hF00;
               data_in=32'hFFFFFFF3;
           #40 enable_RW=1'b0;
           //for a shared peripheral interrupt
          // #10 SPI=32'h000F;
           //an IRQ signal here should be generated ofcourse
          // #10 SPI=32'h0000;
           
           //EOI handling a read
           #40 read=1'b0;
               enable_RW=1'b1;
               address=CPU_INTERFACE_BASE_ADDRESS+8'h10;
               data_in=32'hFFFFFFD8;
           #40 enable_RW=1'b0;
           
           //enable the other CPU interrupts
           
           #40 PPI_2=16'hF0F0;
               PPI_3=16'h000F;
               PPI_4=16'h0F0F;
               
           //for a software genrated interrupt
           #40 CPU_ID=2'b01;
               read=1'b0;
               enable_RW=1'b1;
               address=DISTRIBUTOR_BASE_ADDRESS+12'hF00;
               data_in=32'hFFFFFFF3;
            
            //for another software generated interrupt for processor 3   
           #40 CPU_ID=2'b10;
               read=1'b0;
               enable_RW=1'b1;
               address=DISTRIBUTOR_BASE_ADDRESS+12'hF00;
               data_in=32'hFFFFFFF7;
               
           #40 enable_RW=1'b0;    
           //an interrupt acknowledge register
           #40 CPU_ID=2'b01;
               read=1'b1;
               enable_RW=1'b1;
               address=CPU_INTERFACE_BASE_ADDRESS+8'h0C;
               read=1'b1;
               enable_RW=1'b1;
               
           #40 enable_RW=1'b0;
           
           
           //an end of interrupt for processor2
           #80 CPU_ID=2'b01;
               read=1'b0; 
               enable_RW=1'b1;
               address=CPU_INTERFACE_BASE_ADDRESS+8'h10;
               data_in=32'hFFFFFFFA;
               
           #40 enable_RW=1'b0;                 
        end    
        
        
        
        
        
        
        
        
        
endmodule
