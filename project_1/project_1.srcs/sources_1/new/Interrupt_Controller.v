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


module Interrupt_Controller(CPU_ID,address,data_in,data_out,read,enable_RW,clk,reset,PPI_1,PPI_2,PPI_3,PPI_4,SPI,IRQ,FIQ

    );
    //CPU ID is got from the transaction ID of the AXI bus
    
    input[1:0] CPU_ID;//used to distinguish between the banked registers
    input[31:0] address;
    input[31:0] data_in;
    output reg[31:0] data_out;
    input read;
    input enable_RW;
    input reset;
    input clk;
    
    input[16:31] PPI_1;//PPIs for CPU0
    input[16:31] PPI_2;//PPIs for CPU1
    input[16:31] PPI_3;//PPIs for CPU2
    input[16:31] PPI_4;//PPIs for CPU3
    input[32:59] SPI;//These are the shared peripheral interrupts
    
    
    reg[5:0] HP_ID0;//Highest Priority Interrupt ID for CPU interface0
    reg[5:0] HP_ID1;//Highest Priority Interrupt ID for CPU interface1
    reg[5:0] HP_ID2;//Highest Priority Interrupt ID for CPU interface2
    reg[5:0] HP_ID3;//Highest Priority Interrupt ID for CPU interface3
    
    output IRQ;
    output FIQ;
    
    
    /*
    Internal Registers of the distributor
    
    */
    
    //Global interrupt Disable signal
    reg[31:0] ICDDCR;//Distributor Control Register(RW)
    
    
    reg[31:0] ICDICTR; //Interrupt Controller Type Register(RO)
    reg[31:0] ICDIIDR;//Distributor Implementor Identification Register(RO)
    reg[31:0] ICDISR;//Interuupt Security Register(RW)
    
    //Registers of Interrupts of CPU 0(Banked)
    
    reg[31:0] ICDISER0;//Interrupt Set Enable Register(RW)
    reg[31:0] ICDICER0;//Interrupt Clear Enable Register(RW)
    reg[31:0] ICDISPR0;//Interrupt Set Pending Register(RW)
    reg[31:0] ICDICPR0;//Interrupt Clear Pending Register(RW)
    reg[31:0] ICDABR0;//Active Bit Register(RO)
    //for handling the priority of 32 interrupts each one of 8 bits we need 8 registers
    reg[31:0] ICDIPR0 [0:7];//Interrupt Priority Register(RW) 
    reg[31:0] ICDIPTR;//Interrupt Processor Target Register(RO)
    reg[31:0] ICDICFR;//Interrupt Configuration Register(RW)
    reg[31:0] ICDSGIR;//Software generated Interrupt Register(WO)
    
    
    //Registers of Interrupts of CPU 1(Banked)
    reg[31:0] ICDISER1;//Interrupt Set Enable Register(RW)
    reg[31:0] ICDICER1;//Interrupt Clear Enable Register(RW)
    reg[31:0] ICDISPR1;//Interrupt Set Pending Register(RW)
    reg[31:0] ICDICPR1;//Interrupt Clear Pending Register(RW)
    //for handling the priority of 32 interrupts each one of 8 bits we need 8 registers
    reg[31:0] ICDIPR1 [0:7];//Interrupt Priority Register(RW) 
        
    //Registers of Inerrupts of CPU 2(Banked)
    reg[31:0] ICDISER2;//Interrupt Set Enable Register(RW)
    reg[31:0] ICDICER2;//Interrupt Clear Enable Register(RW)
    reg[31:0] ICDISPR2;//Interrupt Set Pending Register(RW)
    reg[31:0] ICDICPR2;//Interrupt Clear Pending Register(RW)    
    //for handling the priority of 32 interrupts each one of 8 bits we need 8 registers
    reg[31:0] ICDIPR2 [0:7];//Interrupt Priority Register(RW) 
    
    //Registers of Interrupts of CPU 3(Banked)
    reg[31:0] ICDISER3;//Interrupt Set Enable Register(RW)
    reg[31:0] ICDICER3;//Interrupt Clear Enable Register(RW)
    reg[31:0] ICDISPR3;//Interrupt Set Pending Register(RW)
    reg[31:0] ICDICPR3;//Interrupt Clear Pending Register(RW)
    //for handling the priority of 32 interrupts each one of 8 bits we need 8 registers
    reg[31:0] ICDIPR3 [0:7];//Interrupt Priority Register(RW) 
    
    //Registers of SPIs for 32 to 64
    reg[31:0] ICDISER_S;
    reg[31:0] ICDICER_S;
    reg[31:0] ICDISPR_S;
    reg[31:0] ICDICPR_S;
    //for handling the priority of 32 interrupts each one of 8 bits we need 8 registers
    reg[31:0] ICDIPR_S [8:15];//Interrupt Priority Register(RW) 
    
    
    //address information
    parameter DISTRIBUTOR_BASE_ADDRESS=0;
    
    
    //states of various interrupts in CPU0
    /*
        for inactive,interrupt state is 0
        for pending,interrupt state is 1
        for active,interrupt state is 2
        for active and pending,interrupt state is 3
    */
    reg[31:0] interrupt_states0[1:0];
    
    //states of various interrupts in CPU1
    /*
        for inactive,interrupt state is 0
        for pending,interrupt state is 1
        for active,interrupt state is 2
        for active and pending,interrupt state is 3
    */
    reg[31:0] interrupt_states1[1:0];
    
    //states of various interrupts in CPU2
    /*
        for inactive,interrupt state is 0
        for pending,interrupt state is 1
        for active,interrupt state is 2
        for active and pending,interrupt state is 3
    */
    reg[31:0] interrupt_states2[1:0];
    
    //states of various interrupts in CPU0
    /*
        for inactive,interrupt state is 0
        for pending,interrupt state is 1
        for active,interrupt state is 2
        for active and pending,interrupt state is 3
    */
    reg[31:0] interrupt_states3[1:0];
    
    //states of various interrupts in shared interrupts
    /*
        Since SPIs are handled using 1:N model only a single state regs can be maintained for all processors
        for inactive,interrupt state is 0
        for pending,interrupt state is 1
        for active,interrupt state is 2
        for active and pending,interrupt state is 3
    */
    reg[31:0] interrupt_states_S[1:0];
    
    //Register read write logic
    always@(posedge clk or negedge reset)
    begin
        if(!reset)//active low signal
        begin
            ICDDCR=0;//disable all the interrupts before programming the interrupt controller
        end
        else
        begin
            if(enable_RW)
            begin
                
                case(address)
                DISTRIBUTOR_BASE_ADDRESS+12'h0://Distributor control register(DCR)
                begin
                    if(read)
                    begin
                        data_out<=ICDDCR;
                    end
                    else
                    begin
                        ICDDCR<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h4://Interrupt Controller Type register(ICTR)
                begin
                    if(read)
                    begin
                        data_out<=ICDICTR;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h8://Distributor Implementor Identification Register(IIDR)
                begin
                    if(read)
                    begin
                        data_out<=ICDIIDR;
                    end
                    
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h100://set enable registers(ISER) for banked registers 0,1,2,3
                begin
                    
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h104://set enable for SPIs
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h180://clear enable for banked registers 0,1,2,3
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h184://clear enable for SPIs
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h200://set pending register for banked registers 0,1,2,3
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h204://set pending register for SPIs
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h280://clear pending register for banked registers 0,1,2,3
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h284://clear pending register for SPIs
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400://priority register 0(Banked)
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd4://priority register 1(Banked)
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd8://priority register 2(Banked)
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd12://priority register 3(Banked)
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd16://priority register 4(Banked)
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd20://priority register 5(Banked)
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd24://priority register 6(Banked)
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd28://priority register 7(Banked)
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd32://priority register 8(SPI)
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd36://priority register 9(SPI)
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd40://priority register 10(SPI)
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd44://priority register 11(SPI)
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd48://priority register 12(SPI)
                begin
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd52://priority register 13(SPI)
                begin
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd56://priority register 14(SPI)
                begin
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd60://priority register 15(SPI)
                begin
                end                
                endcase
            end
            
        end
    end
    
    //selecting the highest priority interrupt for CPU Interface0
    reg[5:0] counter;
    reg[7:0] temp_priority;
    always@(*)
    begin
        HP_ID0=0;//set to the least priority i.e, the highest value....actually I don't know how to put it
        temp_priority=8'd255;
        for(counter=0;counter<=63;counter=counter+1)//64 interrupt IDs
        begin
            //for each priority value select the value with the highest priority
            if(counter<32)//PPIs
            begin
                if(ICDISER0[counter]==1'b1 && ICDIPR0[counter[6:2]][(8*(counter[1:0])+7):8*counter[1:0]]<temp_priority && interrupt_states0==2'd1)//if it is enabled 
                begin
                    HP_ID0=counter;
                    temp_priority=ICDIPR0[counter[6:2]][(8*(counter[1:0])+7):8*counter[1:0]];
                end
            end
            else//SPIs
            begin
                if(ICDISER_S[counter[5:2]]==1'b1 && ICDIPR_S[counter[6:2]][(8*(counter[1:0])+7):8*counter[1:0]]<temp_priority && interrupt_states_S==2'd1)
                begin
                    HP_ID0=counter;
                    temp_priority=ICDIPR_S[counter[6:2]][(8*(counter[1:0])+7):8*counter[1:0]];
                end
            end
        end
    end
    
    //selecting the highest priority for CPU Interface1
    reg[5:0] counter1;
    reg[7:0] temp_priority1;
    always@(*)
    begin
        HP_ID1=0;//set to the least priority i.e, the highest value....actually I don't know how to put it
        temp_priority1=8'd255;
        for(counter1=0;counter1<=63;counter1=counter1+1)//64 interrupt IDs
        begin
            //for each priority value select the value with the highest priority
            if(counter1<32)//PPIs
            begin
                if(ICDISER1[counter1]==1'b1 && ICDIPR0[counter1[6:2]][(8*(counter1[1:0])+7):8*counter1[1:0]]<temp_priority1 && interrupt_states1==2'd1)//if it is enabled 
                begin
                    HP_ID1=counter1;
                    temp_priority1=ICDIPR1[counter1[6:2]][(8*(counter1[1:0])+7):8*counter1[1:0]];
                end
            end
            else//SPIs
            begin
                if(ICDISER_S[counter1[5:2]]==1'b1 && ICDIPR_S[counter1[6:2]][(8*(counter1[1:0])+7):8*counter1[1:0]]<temp_priority1 && interrupt_states_S==2'd1)
                begin
                    HP_ID1=counter1;
                    temp_priority1=ICDIPR_S[counter1[6:2]][(8*(counter1[1:0])+7):8*counter1[1:0]];
                end
            end
        end
    end 
    //selecting the highest priority for CPU Interface2
    reg[5:0] counter2;
    reg[7:0] temp_priority2;
    always@(*)
    begin
        HP_ID2=0;//set to the least priority i.e, the highest value....actually I don't know how to put it
        temp_priority2=8'd255;
        for(counter2=0;counter2<=63;counter2=counter2+1)//64 interrupt IDs
        begin
            //for each priority value select the value with the highest priority
            if(counter2<32)//PPIs
            begin
                if(ICDISER2[counter2]==1'b1 && ICDIPR2[counter2[6:2]][(8*(counter2[1:0])+7):8*counter2[1:0]]<temp_priority2 && interrupt_states2==2'd1)//if it is enabled 
                begin
                    HP_ID2=counter2;
                    temp_priority2=ICDIPR2[counter1[6:2]][(8*(counter2[1:0])+7):8*counter2[1:0]];
                end
            end
            else//SPIs
            begin
                if(ICDISER_S[counter2[5:2]]==1'b1 && ICDIPR_S[counter2[6:2]][(8*(counter2[1:0])+7):8*counter2[1:0]]<temp_priority2 && interrupt_states_S==2'd1)
                begin
                    HP_ID2=counter2;
                    temp_priority2=ICDIPR_S[counter2[6:2]][(8*(counter2[1:0])+7):8*counter2[1:0]];
                end
            end
        end
    end 
    //selecting the highest priority for CPU Interface3
    reg[5:0] counter3;
    reg[7:0] temp_priority3;
    always@(*)
    begin
        HP_ID3=0;//set to the least priority i.e, the highest value....actually I don't know how to put it
        temp_priority3=8'd255;
        for(counter3=0;counter3<=63;counter3=counter3+1)//64 interrupt IDs
        begin
            //for each priority value select the value with the highest priority
            if(counter3<32)//PPIs
            begin
                if(ICDISER3[counter3]==1'b1 && ICDIPR3[counter3[6:2]][(8*(counter3[1:0])+7):8*counter3[1:0]]<temp_priority3 && interrupt_states3==2'd1)//if it is enabled 
                begin
                    HP_ID3=counter3;
                    temp_priority3=ICDIPR3[counter3[6:2]][(8*(counter3[1:0])+7):8*counter3[1:0]];
                end
            end
            else//SPIs
            begin
                if(ICDISER_S[counter3[5:2]]==1'b1 && ICDIPR_S[counter3[6:2]][(8*(counter3[1:0])+7):8*counter3[1:0]]<temp_priority3 && interrupt_states_S==2'd1)
                begin
                    HP_ID3=counter3;
                    temp_priority3=ICDIPR_S[counter3[6:2]][(8*(counter3[1:0])+7):8*counter3[1:0]];
                end
            end
        end
    end 
    
        
endmodule
