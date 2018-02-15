`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.02.2018 19:24:49
// Design Name: 
// Module Name: APB_Interface_Test
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


module APB_Interface_Test(

    );
    
    reg PCLK;
    reg PRESET;
    reg PSEL;
    reg PENABLE;
    reg PWRITE;
    reg PWDATA;
    wire PREADY;
    wire PRDATA;
    wire PSLVERR;
    
    wire[31:0] address;
    reg[31:0] datain;
    wire[31:0] dataout;
    wire read;
    wire enable;
    
    
    APB_SLAVE_INTERFACE_NEW APB_Slave(
    
    
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
        
        
        //only for one clock cycle
        address,
        datain,
        dataout,
        read,
        enable
        
        );
        
        initial
        begin
            PCLK=1'b0;
            PRESET=1'b0;
            PADDR=32'b0;
            PSEL=1'b0;
            PENABLE=1'b0;
            PWRITE=1'b0;
            
            
        end
        
        always
            #5 PCLK=!PCLK;
endmodule
