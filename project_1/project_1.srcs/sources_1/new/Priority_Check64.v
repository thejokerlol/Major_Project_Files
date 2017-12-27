`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.12.2017 05:11:40
// Design Name: 
// Module Name: Priority_Check64
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


module Priority_Check64(
    ICDISER,
    ICDISER_S,
    HP_ID,
    valid
    );
    
    input[31:0] ICDISER;
    input[31:0] ICDISER_S;
    reg[0:7] ICDIPR[31:0];
    reg[0:7] ICDIPR_S[31:0];
    input reg[0:63] interrupt_states[1:0];
    
    
    output reg[5:0] HP_ID;
    output reg valid;
    
    reg[0:63] comparator_inputs[5:0];
    
    reg HP_ids[0:63][5:0];
    
    integer m;
    always@(*)
    begin
        for(m=0;m<=63;m=m+1)
        begin
            if(m==0)
            begin
                comparator_inputs[m]=0;
            end
            else
            begin
                comparator_inputs[m]=comparator_inputs[m-1]+1'b1;
            end
        end
    end
    
    genvar i;
    
    
    generate
    for(i=0;i<62;i=i+1)
    begin
        if(i==0)
        begin
            Priority_Check P1(
                    comparator_inputs[i],comparator_inputs[i+1],
                    ICDISER[i],ICDISER[i+1],
                    ICDIPR[comparator_inputs[i][5:2]][((8*comparator_inputs[i][1:0])+7):(8*comparator_inputs[i][1:0])],
                    ICDIPR[comparator_inputs[i+1][5:2]][((8*comparator_inputs[i+1][1:0])+7):(8*comparator_inputs[i+1][1:0])],
                    
                    interrupt_states1[i],interrupt_states2[i+1],
                    
                    HP_ID[i],enabled
                );
        end
        if(i<31)
        begin
            Priority_Check P1(
                    HP_ID[i-1],comparator_inputs[i+1],
                    ICDISER[i],ICDISER[i+1],
                    output_priority,
                    ICDIPR[comparator_inputs[i+1][5:2]][((8*comparator_inputs[i+1][1:0])+7):(8*comparator_inputs[i+1][1:0])],
                    
                    interrupt_states1[i],interrupt_states2[i+1],
                    
                    HP_ID[i],enabled
                );
        end
        else
        begin
            Priority_Check P1(
                    HP_ID[i-1],comparator_inputs[i+1],
                    ICDISER_S[i-31],ICDISER_S[i+1-31],
                    ICDIPR_S[comparator_inputs[i-31][5:2]][((8*comparator_inputs[i-31][1:0])+7):(8*comparator_inputs[i-31][1:0])],
                    ICDIPR[comparator_inputs[i+1-31][5:2]][((8*comparator_inputs[i+1-31][1:0])+7):(8*comparator_inputs[i+1][1:0])],
                    
                    interrupt_states1[i],interrupt_states2[i+1],
                    
                    HP_ID[i],enabled
                );
        end 
    end
    endgenerate
    
    always@(*)
    begin
        HP_ID=HP_ID[62];
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
