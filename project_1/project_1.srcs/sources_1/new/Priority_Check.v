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
        Dist_no,
        enable1,
        enable2,
        priority1,
        priority2,
        
        interrupt_states1,
        interrupt_states2,
        
        target_proc_list1,
        target_proc_list2,
        
        HP_ID,
        output_priority,
        enabled,
        priority_state,
        target_proc_list


    );
    input[5:0] ID1;
    input[5:0] ID2;
    input[1:0] Dist_no;
    input enable1;
    input enable2;
    input[7:0] priority1;
    input[7:0] priority2;
    
    input[1:0] interrupt_states1;
    input[1:0] interrupt_states2;
    
    input[3:0] target_proc_list1;
    input[3:0] target_proc_list2;
    
    output reg[5:0] HP_ID;
    output reg[7:0] output_priority;
    output reg enabled;
    output reg[1:0] priority_state;//the state of the highest priority
    output reg[3:0] target_proc_list;
    
    
    reg target_proc1;
    reg target_proc2;
    
    initial
    begin
        $display("%m");
    end
    
    
    always@(*)
    begin
        case(Dist_no)
        2'b00:
        begin
            target_proc1=target_proc_list1[0];
            target_proc2=target_proc_list2[0];
        end
        2'b01:
        begin
            target_proc1=target_proc_list1[1];
            target_proc2=target_proc_list2[1];
        end
        2'b10:
        begin
            target_proc1=target_proc_list1[2];
            target_proc2=target_proc_list2[2];
        end
        2'b11:
        begin
            target_proc1=target_proc_list1[3];
            target_proc2=target_proc_list2[3];
        end
        endcase
    end
    
    
    always@(*)
    begin
        if(!enable1 && !enable2)
        begin
            HP_ID=ID1;
            output_priority=priority1;
            enabled=0;
            priority_state=interrupt_states1;
            target_proc_list=target_proc_list1;
        end
        else if(!enable1 && enable2)
        begin
            if(interrupt_states2[1:0]==2'b01 && target_proc2==1'b1)//pending state and the processor is in the target list
            begin
                HP_ID=ID2;
                output_priority=priority2;
                enabled=1;
                priority_state=interrupt_states2;
                target_proc_list=target_proc_list2;
                
           end
           else
           begin
                HP_ID=ID2;
                output_priority=priority2;
                enabled=0;
                priority_state=interrupt_states2;
                target_proc_list=target_proc_list2;
           end
        end
        else if(enable1 && !enable2)
        begin
            if(interrupt_states1[1:0]==2'b01 && target_proc1==1'b1)//pending state and the processor is in the target list
            begin
                HP_ID=ID1;
                output_priority=priority1;
                enabled=1;
                priority_state=interrupt_states1;
                target_proc_list=target_proc_list1;
           end
           else
           begin
                HP_ID=ID1;
                output_priority=priority1;
                enabled=0;
                priority_state=interrupt_states1;
                target_proc_list=target_proc_list1;
           end
        end
        else
        begin
            if(interrupt_states1[1:0]==2'b01 && interrupt_states2[1:0]==2'b01)//both are pending 
            begin
                case({target_proc1,target_proc2})
                    2'b00:
                    begin
                        HP_ID=ID1;
                        output_priority=priority1;
                        enabled=0;
                        priority_state=interrupt_states1;
                        target_proc_list=target_proc_list1;
                    end
                    2'b01:
                    begin
                        HP_ID=ID2;
                        output_priority=priority2;
                        priority_state=interrupt_states2;
                        enabled=1;
                        target_proc_list=target_proc_list2;
                    end
                    2'b10:
                    begin
                        HP_ID=ID1;
                        output_priority=priority1;
                        enabled=1;
                        priority_state=interrupt_states1;
                        target_proc_list=target_proc_list1;
                    end
                    2'b11:
                    begin
                        if(priority1>priority2)
                        begin
                            HP_ID=ID1;
                            output_priority=priority1;
                            priority_state=interrupt_states1;
                            enabled=1;
                            target_proc_list=target_proc_list1;
                        end
                        else
                        begin
                            HP_ID=ID2;
                            output_priority=priority2;
                            enabled=1;
                            priority_state=interrupt_states2;
                            target_proc_list=target_proc_list2;
                        end
                    end
                endcase
                
            end
            else if(interrupt_states1[1:0]==2'b01 && interrupt_states2[1:0]!=2'b01)
            begin
                HP_ID=ID1;
                output_priority=priority1;
                priority_state=interrupt_states1;
                target_proc_list=target_proc_list1;
                if(target_proc1==1'b1)
                    enabled=1;
                else
                    enabled=0;
                    
            end
            else if(interrupt_states1[1:0]!=2'b01 && interrupt_states2[1:0]==2'b01)
            begin
                HP_ID=ID2;
                output_priority=priority2;
                priority_state=interrupt_states2;
                target_proc_list=target_proc_list2;
                if(target_proc2==1'b1)
                    enabled=1;
                else
                    enabled=0;
            end
            else
            begin
                HP_ID=ID1;
                output_priority=priority1;
                enabled=0;
                priority_state=interrupt_states1;
                target_proc_list=target_proc_list1;
                
            end
        end
            
    end
endmodule
