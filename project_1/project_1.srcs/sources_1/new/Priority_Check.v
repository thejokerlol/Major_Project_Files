`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.12.2017 06:37:06
// Design Name: 
// Module Name: Priority_Check
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


module Priority_Check(
        ID1,
        ID2,
        enable1,
        enable2,
        priority1,
        priority2,
        
        interrupt_states1,
        interrupt_states2,
        
        HP_ID,
        output_priority,
        enabled,
        priority_state


    );
    input[5:0] ID1;
    input[5:0] ID2;
    input enable1;
    input enable2;
    input[7:0] priority1;
    input[7:0] priority2;
    
    input[1:0] interrupt_states1;
    input[1:0] interrupt_states2;
    
    output reg[7:0] HP_ID;
    output reg[7:0] output_priority;
    output reg enabled;
    output reg[1:0] priority_state;//the state of the highest priority
    
    
    always@(*)
    begin
        if(!enable1 && !enable2)
        begin
            HP_ID=ID1;
            output_priority=priority1;
            enabled=0;
            priority_state=interrupt_states1;
        end
        else if(!enable1 && enable2)
        begin
            if(interrupt_states2[1:0]==2'b01)//pending state
            begin
                HP_ID=ID2;
                output_priority=priority2;
                enabled=1;
                priority_state=interrupt_states2;
                
           end
           else
           begin
                HP_ID=ID2;
                output_priority=priority2;
                enabled=0;
                priority_state=interrupt_states2;
           end
        end
        else if(enable1 && !enable2)
        begin
            if(interrupt_states1[1:0]==2'b01)//pending state
            begin
                HP_ID=ID1;
                output_priority=priority1;
                enabled=1;
                priority_state=interrupt_states1;
           end
           else
           begin
                HP_ID=ID1;
                output_priority=priority1;
                enabled=0;
                priority_state=interrupt_states1;
           end
        end
        else
        begin
            if(interrupt_states1[1:0]==2'b01 && interrupt_states2[1:0]==2'b01)//both are pending
            begin
                if(priority1>priority2)
                begin
                    HP_ID=ID1;
                    output_priority=priority1;
                    enabled=1;
                    priority_state=interrupt_states1;
                end
                else
                begin
                    HP_ID=ID2;
                    output_priority=priority2;
                    enabled=1;
                    priority_state=interrupt_states2;
                end
            end
            else if(interrupt_states1[1:0]==2'b01 && interrupt_states2[1:0]!=2'b01)
            begin
                HP_ID=ID1;
                output_priority=priority1;
                enabled=1;
                priority_state=interrupt_states1;
            end
            else if(interrupt_states1[1:0]!=2'b01 && interrupt_states2[1:0]==2'b01)
            begin
                HP_ID=ID2;
                output_priority=priority2;
                enabled=1;
                priority_state=interrupt_states2;
            end
            else
            begin
                HP_ID=ID1;
                output_priority=priority1;
                enabled=0;
                priority_state=interrupt_states1;
            end
        end
            
    end
endmodule
