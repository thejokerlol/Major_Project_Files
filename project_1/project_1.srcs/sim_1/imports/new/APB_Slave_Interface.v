`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.01.2018 16:18:26
// Design Name: 
// Module Name: APB_Slave_Interface
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


module APB_Slave_Interface(

    PCLK,
    PRESET,
    PADDR,
    PSEL,
    
    PENABLE,
    PWRITE,
    PWDATA,
    PREADY,
    PRDATA,
    PSLVERR,
    
    //Interrupt controller signals
    
    PPI_1,
    PPI_2,
    PPI_3,
    PPI_4,
    SPI,
    
    IRQ0,
    FIQ0,
    IRQ1,
    FIQ1,
    IRQ2,
    FIQ2,
    IRQ3,
    FIQ3
    
    
    );
    
    //bus signals
    input PCLK;
    input PRESET;
    input[31:0] PADDR;
    input PSEL;
    input PENABLE;
    input PWRITE;
    input[31:0] PWDATA;
    input PREADY;
    output[31:0] PRDATA;
    output PSLVERR;
    
    
    //interrupt controller
    input[31:0] PPI_1;
    input[31:0] PPI_2;
    input[31:0] PPI_3;
    input[31:0] PPI_4;
    input[31:0] SPI;
    
    output IRQ0;
    output FIQ0;
    output IRQ1;
    output FIQ1;
    output IRQ2;
    output FIQ2;
    output IRQ3;
    output FIQ3; 
    
    reg[1:0] CPU_ID;
    reg[31:0] address;
    reg[31:0] data_in;
    reg[31:0] data_out;
    wire read;
    wire enable_RW;
    wire clk;
    reg reset;
    
    
    
    
    Interrupt_Controller IC(CPU_ID,PADDR,PWDATA,PRDATA,read,enable_RW,PCLK,PRESET,
                        
                        PPI_1,PPI_2,PPI_3,PPI_4,SPI,IRQ0,FIQ0,IRQ1,FIQ1,
                        
                        IRQ2,FIQ2,IRQ3,FIQ3,RW_error,PREADY//RW_error and PREADY should be still implemented
        );
    
    
    assign read=PWRITE;
    assign enable_RW=(PSEL) && (!PENABLE);//Assume all transfers take place in two cycles for now
    //assign PREADY=1'b1;//transfers take place in single cycle
    assign SLVERR=RW_error;
    
endmodule
