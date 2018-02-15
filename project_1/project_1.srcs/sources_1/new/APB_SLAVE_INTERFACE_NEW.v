`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.02.2018 15:42:44
// Design Name: 
// Module Name: APB_SLAVE_INTERFACE_NEW
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


module APB_SLAVE_INTERFACE_NEW(


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
    enable,
    RW_error
    
    );
    
    
    input PCLK;
    input PRESET;
    input[31:0] PADDR;
    input PSEL;
    
    input PENABLE;
    input PWRITE;
    input[31:0] PWDATA;
    output PREADY;
    output[31:0] PRDATA;
    output PSLVERR;
    
    //inputs to the interrupt controller
    output reg[31:0] address;
    input[31:0] read_data;
    output reg[31:0] write_data;
    output reg read;
    output reg enable;
    input RW_error;
        
    always@(*)
    begin
        address=PADDR;
        write_data=PWDATA;
        PRDATA=read_data;
        enable=(PSEL) && (!ENABLE);
        PSLVERR=RW_error;
        PREADY=1'b1;
    end
    
endmodule
