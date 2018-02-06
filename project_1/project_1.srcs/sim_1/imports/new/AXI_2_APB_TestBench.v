`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2018 16:21:14
// Design Name: 
// Module Name: AXI_2_APB_TestBench
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


module AXI_2_APB_TestBench(

    );
    
    
    reg ACLK;
    reg ARESET;
            
    reg[31:0] ARADDR;
    reg ARVALID;
    wire ARREADY;
    reg[1:0] ARSIZE;
    reg[1:0] ARLEN;
             
    reg[31:0] AWADDR;
    reg AWVALID;
    wire AWREADY;
    reg[1:0] AWSIZE;
    reg[1:0] AWLEN;
             
    wire[31:0] RDATA;
    wire RVALID;
    reg RREADY;
             
    reg[31:0] WDATA;
    reg WVALID;
    wire WREADY;
             
    wire[1:0]BRESP;
    wire BVALID;
    reg BREADY;
             
             //APB interface signals
             
    wire PCLK;
    wire PRESET;
    wire[31:0] PADDR;
    wire PSEL;
             
    wire PENABLE;
    wire PWRITE;
    wire[31:0] PWDATA;
    reg PREADY;
    reg[31:0] PRDATA;
    reg PSLVERR;
    
    AXI_to_APB A1(
        
        
        //AXI interface signals
         ACLK,
         ARESET,
        
         ARADDR,
         ARVALID,
         ARREADY,
         ARSIZE,
         ARLEN,
         
         AWADDR,
         AWVALID,
         AWREADY,
         AWSIZE,
         AWLEN,
         
         RDATA,
         RVALID,
         RREADY,
         
         WDATA,
         WVALID,
         WREADY,
         
         BRESP,
         BVALID,
         BREADY,
         
         //APB interface signals
         
         PCLK,
         PRESET,
         PADDR,
         PSEL,
         
         PENABLE,
         PWRITE,
         PWDATA,
         PREADY,
         PRDATA,
         PSLVERR
        );
        
        //intial values of all inputs
        initial
        begin
            ACLK=0;
            ARESET=0;
            
            ARADDR=0;
            ARVALID=0;
            ARSIZE=0;
            ARLEN=0;
            
            AWADDR=0;
            AWVALID=0;
            AWSIZE=0;
            AWLEN=0;
           
            RREADY=0;
           
            WDATA=0;
            WVALID=0;
            
            BREADY=0;
            
            
            //APB Signals
            PREADY=1'b0;
            PSLVERR=1'b0;
        end
        
        always
            #5 ACLK=!ACLK;
            
            
        initial
            #300 $finish;
            
            
        initial
        begin
        //write testing
            #2 ARESET=1'b1;
            #1 ARESET=1'b0;
            #7 AWADDR=32'd45;
               AWVALID=1'b1;
               AWLEN=2'b10;
               
            #10 WVALID=1'b1;
                WDATA=32'd56;
                
            
                
            #10 PREADY=1'b1;
                
                
            #10 WDATA=32'd78;
                WVALID=1'b1;
                PREADY=1'b0;
                
            #20 PREADY=1'b1;
            #30 WVALID=1'b0;
                
            #10 BREADY=1'b1;
                AWVALID=1'b0;
            #20 BREADY=1'b0;
            
        //Read testing
        
            #10 ARADDR=32'd78;
                ARVALID=1'b1;
                ARLEN=2'b10;
                PREADY=1'b0;
            #30 PRDATA=32'd70;
                PREADY=1'b1;
                ARVALID=1'b0;
            #10 PREADY=1'b0;    
            #30 PRDATA=32'd47;
                PREADY=1'b1;
                
            #10 PREADY=1'b0;
                RREADY=1'b1;
            #10 RREADY=1'b0;
            
            #10 PREADY=1'b1;
            #10 PREADY=1'b0;
            #20 RREADY=1'b1;
            #10 RREADY=1'b0;
                   
            
            
        end    
        
endmodule
