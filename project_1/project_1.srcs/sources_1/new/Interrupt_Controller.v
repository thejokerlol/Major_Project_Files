`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NITK
// Engineer: Uday Kiran
// 
// Create Date: 15.12.2017 04:22:47
// Design Name: 
// Module Name: Interrupt_Controller
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


module Interrupt_Controller(address,data,read,write,clk,reset,PPI_1,PPI_2,PPI_3,PPI_4,SPI,IRQ,FIQ

    );
    
    input address;
    input data;
    input read;
    input write;
    input reset;
    input[0:15] PPI_1;
    input[0:15] PPI_2;
    input[0:15] PPI_3;
    input[0:15] PPI_4;
    input[0:31] SPI;
    
    output IRQ;
    output FIQ;
    /*
    Internal Registers of the distributor
    
    */
    
    
    reg[31:0] ICDCR;//Distributor Control Register(RW)
    reg[31:0] ICDICTR; //Interrupt Controller Type Register(RO)
    reg[31:0] ICDIDR;//Distributor Implementor Identification Register(RO)
    reg[31:0] ICDISR;//Interuupt Security Register(RW)
    
    //Banked Registers of distributor
    
    reg[31:0] ICDISER;//Interrupt Set Enable Register(RW)
    reg[31:0] ICDICER;//Interrupt Clear Enable Register(RW)
    reg[31:0] ICDISPR;//Interrupt Set Pending Register(RW)
    reg[31:0] ICDICPR;//Interrupt Clear Pending Register(RW)
    reg[31:0] ICDABR;//Active Bit Register(RO)
    reg[31:0] ICDIPR;//Interrupt Priority Register(RW)
    reg[31:0] ICDIPTR;//Interrupt Processor Target Register(RO)
    reg[31:0] ICDICFR;//Interrupt Configuration Register(RW)
    reg[31:0] ICDSGIR;//Software generated Interrupt Register(WO)
    
    
    
    
endmodule
