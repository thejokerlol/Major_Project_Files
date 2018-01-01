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
    reg[31:0] ICDISR0;//Interrupt Security Registers(RW)
    reg[31:0] ICDABR0;//Active Bit Register(RO)
    //for handling the priority of 32 interrupts each one of 8 bits we need 8 registers
    reg[31:0] ICDIPR0 [0:7];//Interrupt Priority Register(RW) 
    reg[31:0] ICDIPTR0[0:7];//Interrupt Processor Target Register(RO)
    reg[31:0] ICDICFR0[0:1];//Interrupt Configuration Register(RW) 2 bits for each interrupt 1:N model or N:N model?
    reg[31:0] ICDSGIR0;//Software generated Interrupt Register(WO)
    
    
    
    //Registers of Interrupts of CPU 1(Banked)
    reg[31:0] ICDISER1;//Interrupt Set Enable Register(RW)
    reg[31:0] ICDICER1;//Interrupt Clear Enable Register(RW)
    reg[31:0] ICDISPR1;//Interrupt Set Pending Register(RW)
    reg[31:0] ICDICPR1;//Interrupt Clear Pending Register(RW)
    reg[31:0] ICDISR1;//Interrupt Security Registers(RW)
    reg[31:0] ICDABR1;//Active Bit Register(RO)
    //for handling the priority of 32 interrupts each one of 8 bits we need 8 registers
    reg[31:0] ICDIPR1 [0:7];//Interrupt Priority Register(RW)
    reg[31:0] ICDIPTR1[0:7];//Interrupt Processor Target Register(RO) 8 bits for each interrupt
    reg[31:0] ICDICFR1[0:1];//Interrupt Configuration Register(RW) 2 bits for each interrupt 1:N model or N:N model?
    reg[31:0] ICDSGIR1;//Software generated Interrupt Register(WO)
        
    //Registers of Inerrupts of CPU 2(Banked)
    reg[31:0] ICDISER2;//Interrupt Set Enable Register(RW)
    reg[31:0] ICDICER2;//Interrupt Clear Enable Register(RW)
    reg[31:0] ICDISPR2;//Interrupt Set Pending Register(RW)
    reg[31:0] ICDICPR2;//Interrupt Clear Pending Register(RW)
    reg[31:0] ICDISR2;//Interrupt Security Registers(RW)
    reg[31:0] ICDABR2;//Active Bit Register(RO)    
    //for handling the priority of 32 interrupts each one of 8 bits we need 8 registers
    reg[31:0] ICDIPR2 [0:7];//Interrupt Priority Register(RW)
    reg[31:0] ICDIPTR2[0:7];//Interrupt Processor Target Register(RO)  8 bits for each interrupt
    reg[31:0] ICDICFR2[0:1];//Interrupt Configuration Register(RW) 2 bits for each interrupt 1:N model or N:N model?
    reg[31:0] ICDSGIR2;//Software generated Interrupt Register(WO)
    
    //Registers of Interrupts of CPU 3(Banked)
    reg[31:0] ICDISER3;//Interrupt Set Enable Register(RW)
    reg[31:0] ICDICER3;//Interrupt Clear Enable Register(RW)
    reg[31:0] ICDISPR3;//Interrupt Set Pending Register(RW)
    reg[31:0] ICDICPR3;//Interrupt Clear Pending Register(RW)
    reg[31:0] ICDISR3;//Interrupt Security Registers(RW)
    reg[31:0] ICDABR3;//Active Bit Register(RO)
    //for handling the priority of 32 interrupts each one of 8 bits we need 8 registers
    reg[31:0] ICDIPR3 [0:7];//Interrupt Priority Register(RW)
    reg[31:0] ICDIPTR3[0:7];//Interrupt Processor Target Register(RO)  8 bits for each interrupt
    reg[31:0] ICDICFR3[0:1];//Interrupt Configuration Register(RW) 2 bits for each interrupt 1:N model or N:N model?
    reg[31:0] ICDSGIR3;//Software generated Interrupt Register(WO)
    
    //Registers of SPIs for 32 to 64
    reg[31:0] ICDISER_S;
    reg[31:0] ICDICER_S;
    reg[31:0] ICDISPR_S;
    reg[31:0] ICDICPR_S;
    reg[31:0] ICDISR_S;
    //for handling the priority of 32 interrupts each one of 8 bits we need 8 registers
    reg[31:0] ICDIPR_S [8:15];//Interrupt Priority Register(RW) 
    reg[31:0] ICDIPTR_S[8:15];//Interrupt Processor Target Register(RO) 8 bits for each register
    reg[31:0] ICDICFR_S[0:1];//Interrupt Configuration Register(RW) 2 bits for each interrupt 1:N model or N:N model?
    reg[31:0] ICDSGIR_S;//Software generated Interrupt Register(WO)
    
    
    
    
    /*
    
    Internal registers of CPU Interfaces
    
    
    */
    
    //Single for all CPU Interfaces
    
    reg[31:0] ICCICR;//CPU Interface Control Register
    
    //for CPU Interface register set 0(Banked)
    
    reg[31:0] ICCPMR0;//CPU Interface Priority Mask Register
    reg[31:0] ICCBPR0;//CPU Interface Binary Point Register
    reg[31:0] ICCIAR0;//Interrupt Acknowledge Register
    reg[31:0] ICCEOIR0;//End of Interrupt Register
    reg[31:0] ICCRPR0;//Running Priority Register
    reg[31:0] ICCHPIR0;//Highest Pending Interrupt Register
    reg[31:0] ICCABPR0;//Aliased Binary Point Register
    reg[31:0] ICCIIDR0;//CPU Interface Identification Register
    
    //for CPU Interface register set 1(Banked)
    
    reg[31:0] ICCPMR1;//CPU Interface Priority Mask Register
    reg[31:0] ICCBPR1;//CPU Interface Binary Point Register
    reg[31:0] ICCIAR1;//Interrupt Acknowledge Register
    reg[31:0] ICCEOIR1;//End of Interrupt Register
    reg[31:0] ICCRPR1;//Running Priority Register
    reg[31:0] ICCHPIR1;//Highest Pending Interrupt Register
    reg[31:0] ICCABPR1;//Aliased Binary Point Register
    reg[31:0] ICCIIDR1;//CPU Interface Identification Register   
    
    //CPU Interface register set 2(Banked)
    
    reg[31:0] ICCPMR2;//CPU Interface Priority Mask Register
    reg[31:0] ICCBPR2;//CPU Interface Binary Point Register
    reg[31:0] ICCIAR2;//Interrupt Acknowledge Register
    reg[31:0] ICCEOIR2;//End of Interrupt Register
    reg[31:0] ICCRPR2;//Running Priority Register
    reg[31:0] ICCHPIR2;//Highest Pending Interrupt Register
    reg[31:0] ICCABPR2;//Aliased Binary Point Register
    reg[31:0] ICCIIDR2;//CPU Interface Identification Register
    
    
    //CPU Interface register set 3(Banked)
    
    reg[31:0] ICCPMR3;//CPU Interface Priority Mask Register
    reg[31:0] ICCBPR3;//CPU Interface Binary Point Register
    reg[31:0] ICCIAR3;//Interrupt Acknowledge Register
    reg[31:0] ICCEOIR3;//End of Interrupt Register
    reg[31:0] ICCRPR3;//Running Priority Register
    reg[31:0] ICCHPIR3;//Highest Pending Interrupt Register
    reg[31:0] ICCABPR3;//Aliased Binary Point Register
    reg[31:0] ICCIIDR3;//CPU Interface Identification Register
    
    //address information
    parameter DISTRIBUTOR_BASE_ADDRESS=32'h0;//should be a parameter because should be synthesizable for various base addresses
    parameter CPU_INTERFACE_BASE_ADDRESS=32'h0; //should be a parameter because should be synthesizable for various base addresses
    
    
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
                        data_out<=ICDDCR;//Distributor control register(enables or disables forwarding of pending interrupts to the CPU Interfaces)
                    end
                    else
                    begin
                        ICDDCR<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h4://Interrupt Controller Type register(ICTR),Read Only
                begin
                    if(read)
                    begin
                        data_out<=ICDICTR;//For 4 CPU Interfaces and 64 Interrupt lines  For this specific case the value is 0x61
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h8://Distributor Implementor Identification Register(IIDR)
                begin
                    if(read)
                    begin
                        data_out<=ICDIIDR;//can be set to 0 for time sake....irrelevant to the implementation
                    end
                    
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h100://set enable registers(ISER) for banked registers 0,1,2,3
                begin
                    case(CPU_ID)
                        2'd0:
                        begin
                            if(read)
                            begin
                                data_out<=ICDISER0;
                            end
                            else
                            begin
                                ICDISER0<=data_in;
                            end
                        end
                        2'd1:
                        begin
                            if(read)
                            begin
                                data_out<=ICDISER1;
                            end
                            else
                            begin
                                ICDISER1<=data_in;
                            end
                        end
                        2'd2:
                        begin
                            if(read)
                            begin
                                data_out<=ICDISER2;
                            end
                            else
                            begin
                                ICDISER2<=data_in;
                            end
                        end
                        2'd3:
                        begin
                            if(read)
                            begin
                                data_out<=ICDISER3;
                            end
                            else
                            begin
                                ICDISER3<=data_in;
                            end
                        end
                    endcase
                    
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h104://set enable for SPIs
                begin
                    if(read)
                    begin
                        data_out<=ICDISER_S;
                    end
                    else
                    begin
                        ICDISER_S<=data_in;
                    end
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h180://clear enable for banked registers 0,1,2,3
                begin
                     case(CPU_ID)
                           2'd0:
                           begin
                               if(read)
                               begin
                                   data_out<=ICDICER0;
                               end
                               else
                               begin
                                   ICDICER0<=data_in;
                               end
                           end
                           2'd1:
                           begin
                               if(read)
                               begin
                                   data_out<=ICDICER1;
                               end
                               else
                               begin
                                   ICDICER1<=data_in;
                               end
                           end
                           2'd2:
                           begin
                               if(read)
                               begin
                                   data_out<=ICDICER2;
                               end
                               else
                               begin
                                   ICDICER2<=data_in;
                               end
                           end
                           2'd3:
                           begin
                               if(read)
                               begin
                                   data_out<=ICDICER3;
                               end
                               else
                               begin
                                   ICDICER3<=data_in;
                               end
                           end
                       endcase            
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h184://clear enable for SPIs
                begin
                    if(read)
                    begin
                        data_out<=ICDICER_S;
                    end
                    else
                    begin
                        ICDICER_S<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h200://set pending register for banked registers 0,1,2,3
                begin
                    case(CPU_ID)
                       2'd0:
                       begin
                           if(read)
                           begin
                               data_out<=ICDISPR0;
                           end
                           else
                           begin
                               ICDISPR0<=data_in;
                           end
                       end
                       2'd1:
                       begin
                           if(read)
                           begin
                               data_out<=ICDISPR1;
                           end
                           else
                           begin
                               ICDISPR1<=data_in;
                           end
                       end
                       2'd2:
                       begin
                           if(read)
                           begin
                               data_out<=ICDISPR2;
                           end
                           else
                           begin
                               ICDISPR2<=data_in;
                           end
                       end
                       2'd3:
                       begin
                           if(read)
                           begin
                               data_out<=ICDISPR3;
                           end
                           else
                           begin
                               ICDISPR3<=data_in;
                           end
                       end
                   endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h204://set pending register for SPIs
                begin
                    if(read)
                    begin
                        data_out<=ICDISPR_S;
                    end
                    else
                    begin
                        ICDISPR_S<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h280://clear pending register for banked registers 0,1,2,3
                begin
                    case(CPU_ID)
                       2'd0:
                       begin
                           if(read)
                           begin
                               data_out<=ICDICPR0;
                           end
                           else
                           begin
                               ICDICPR0<=data_in;
                           end
                       end
                       2'd1:
                       begin
                           if(read)
                           begin
                               data_out<=ICDICPR1;
                           end
                           else
                           begin
                               ICDICPR1<=data_in;
                           end
                       end
                       2'd2:
                       begin
                           if(read)
                           begin
                               data_out<=ICDICPR2;
                           end
                           else
                           begin
                               ICDICPR2<=data_in;
                           end
                       end
                       2'd3:
                       begin
                           if(read)
                           begin
                               data_out<=ICDICPR3;
                           end
                           else
                           begin
                               ICDICPR3<=data_in;
                           end
                       end
                   endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h284://clear pending register for SPIs
                begin
                    if(read)
                    begin
                        data_out<=ICDICPR_S;
                    end
                    else
                    begin
                        ICDICPR_S<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400://priority register 0(Banked)
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR0[0];
                            end
                            else
                            begin
                                ICDIPR0[0]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR1[0];
                            end
                            else
                            begin
                                ICDIPR1[0]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR2[0];
                            end
                            else
                            begin
                                ICDIPR2[0]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR3[0];
                            end
                            else
                            begin
                                ICDIPR3[0]<=data_in;
                            end
                        end    
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd4://priority register 1(Banked)
                begin
                  case(CPU_ID)
                    2'b00:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPR0[1];
                        end
                        else
                        begin
                            ICDIPR0[1]<=data_in;
                        end
                    end
                    2'b01:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPR1[1];
                        end
                        else
                        begin
                            ICDIPR1[1]<=data_in;
                        end
                    end
                    2'b10:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPR2[1];
                        end
                        else
                        begin
                            ICDIPR2[1]<=data_in;
                        end
                    end
                    2'b11:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPR3[1];
                        end
                        else
                        begin
                            ICDIPR3[1]<=data_in;
                        end
                    end    
                endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd8://priority register 2(Banked)
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR0[2];
                            end
                            else
                            begin
                                ICDIPR0[2]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR1[2];
                            end
                            else
                            begin
                                ICDIPR1[2]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR2[2];
                            end
                            else
                            begin
                                ICDIPR2[2]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR3[2];
                            end
                            else
                            begin
                                ICDIPR3[2]<=data_in;
                            end
                        end    
                    endcase
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd12://priority register 3(Banked)
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR0[3];
                            end
                            else
                            begin
                                ICDIPR0[3]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR1[3];
                            end
                            else
                            begin
                                ICDIPR1[3]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR2[3];
                            end
                            else
                            begin
                                ICDIPR2[3]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR3[3];
                            end
                            else
                            begin
                                ICDIPR3[3]<=data_in;
                            end
                        end    
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd16://priority register 4(Banked)
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR0[4];
                            end
                            else
                            begin
                                ICDIPR0[4]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR1[4];
                            end
                            else
                            begin
                                ICDIPR1[4]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR2[4];
                            end
                            else
                            begin
                                ICDIPR2[4]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR3[4];
                            end
                            else
                            begin
                                ICDIPR3[4]<=data_in;
                            end
                        end    
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd20://priority register 5(Banked)
                begin
                     case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR0[5];
                            end
                            else
                            begin
                                ICDIPR0[5]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR1[5];
                            end
                            else
                            begin
                                ICDIPR1[5]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR2[5];
                            end
                            else
                            begin
                                ICDIPR2[5]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR3[5];
                            end
                            else
                            begin
                                ICDIPR3[5]<=data_in;
                            end
                        end    
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd24://priority register 6(Banked)
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR0[6];
                            end
                            else
                            begin
                                ICDIPR0[6]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR1[6];
                            end
                            else
                            begin
                                ICDIPR1[6]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR2[6];
                            end
                            else
                            begin
                                ICDIPR2[6]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR3[6];
                            end
                            else
                            begin
                                ICDIPR3[6]<=data_in;
                            end
                        end    
                    endcase
                
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd28://priority register 7(Banked)
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR0[7];
                            end
                            else
                            begin
                                ICDIPR0[7]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR1[7];
                            end
                            else
                            begin
                                ICDIPR1[7]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR2[7];
                            end
                            else
                            begin
                                ICDIPR2[7]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR3[7];
                            end
                            else
                            begin
                                ICDIPR3[7]<=data_in;
                            end
                        end    
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd32://priority register 8(SPI)
                begin
                    if(read)
                    begin
                        data_out<=ICDIPR_S[8];
                    end
                    else
                    begin
                        ICDIPR_S[8]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd36://priority register 9(SPI)
                begin
                    if(read)
                    begin
                        data_out<=ICDIPR_S[9];
                    end
                    else
                    begin
                        ICDIPR_S[9]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd40://priority register 10(SPI)
                begin
                    if(read)
                    begin
                        data_out<=ICDIPR_S[10];
                    end
                    else
                    begin
                        ICDIPR_S[10]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd44://priority register 11(SPI)
                begin
                    if(read)
                    begin
                        data_out<=ICDIPR_S[11];
                    end
                    else
                    begin
                        ICDIPR_S[11]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd48://priority register 12(SPI)
                begin
                    if(read)
                    begin
                        data_out<=ICDIPR_S[12];
                    end
                    else
                    begin
                        ICDIPR_S[12]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd52://priority register 13(SPI)
                begin
                    if(read)
                    begin
                        data_out<=ICDIPR_S[13];
                    end
                    else
                    begin
                        ICDIPR_S[13]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd56://priority register 14(SPI)
                begin
                    if(read)
                    begin
                        data_out<=ICDIPR_S[14];
                    end
                    else
                    begin
                        ICDIPR_S[14]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h400+12'd60://priority register 15(SPI)
                begin
                    if(read)
                    begin
                        data_out<=ICDIPR_S[15];
                    end
                    else
                    begin
                        ICDIPR_S[15]<=data_in;
                    end    
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800://Interrupt processor target registers(Target register0 banked)
                begin
                    case(CPU_ID)
                    2'd0:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR0[0];
                        end
                        else
                        begin
                            ICDIPTR0[0]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR1[0];
                        end
                        else
                        begin
                            ICDIPTR1[0]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR2[0];
                        end
                        else
                        begin
                            ICDIPTR2[0]=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR3[0];
                        end
                        else
                        begin
                            ICDIPTR3[0]<=data_in;
                        end
                    end
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd4://Interrupt processor target registers(Target register1 banked)
                begin
                    case(CPU_ID)
                    2'd0:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR0[1];
                        end
                        else
                        begin
                            ICDIPTR0[1]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR1[1];
                        end
                        else
                        begin
                            ICDIPTR1[1]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR2[1];
                        end
                        else
                        begin
                            ICDIPTR2[1]=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR3[1];
                        end
                        else
                        begin
                            ICDIPTR3[1]<=data_in;
                        end
                    end
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd8://Interrupt processor target registers(Target register2 banked)
                begin
                    case(CPU_ID)
                    2'd0:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR0[2];
                        end
                        else
                        begin
                            ICDIPTR0[2]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR1[2];
                        end
                        else
                        begin
                            ICDIPTR1[2]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR2[2];
                        end
                        else
                        begin
                            ICDIPTR2[2]=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR3[2];
                        end
                        else
                        begin
                            ICDIPTR3[2]<=data_in;
                        end
                    end
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd12://Interrupt processor target registers(Target register3 banked)
                begin
                    case(CPU_ID)
                    2'd0:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR0[3];
                        end
                        else
                        begin
                            ICDIPTR0[3]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR1[3];
                        end
                        else
                        begin
                            ICDIPTR1[3]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR2[3];
                        end
                        else
                        begin
                            ICDIPTR2[3]=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR3[3];
                        end
                        else
                        begin
                            ICDIPTR3[3]<=data_in;
                        end
                    end
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd16://Interrupt processor target registers(Target register4 banked)
                begin
                    case(CPU_ID)
                    2'd0:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR0[4];
                        end
                        else
                        begin
                            ICDIPTR0[4]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR1[4];
                        end
                        else
                        begin
                            ICDIPTR1[4]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR2[4];
                        end
                        else
                        begin
                            ICDIPTR2[4]=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR3[4];
                        end
                        else
                        begin
                            ICDIPTR3[4]<=data_in;
                        end
                    end
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd20://Interrupt processor target registers(Target register5 banked)
                begin
                    case(CPU_ID)
                    2'd0:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR0[5];
                        end
                        else
                        begin
                            ICDIPTR0[5]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR1[5];
                        end
                        else
                        begin
                            ICDIPTR1[5]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR2[5];
                        end
                        else
                        begin
                            ICDIPTR2[5]=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR3[5];
                        end
                        else
                        begin
                            ICDIPTR3[5]<=data_in;
                        end
                    end
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd24://Interrupt processor target registers(Target register6 banked)
                begin
                    case(CPU_ID)
                    2'd0:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR0[6];
                        end
                        else
                        begin
                            ICDIPTR0[6]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR1[6];
                        end
                        else
                        begin
                            ICDIPTR1[6]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR2[6];
                        end
                        else
                        begin
                            ICDIPTR2[6]=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR3[6];
                        end
                        else
                        begin
                            ICDIPTR3[6]<=data_in;
                        end
                    end
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd28://Interrupt processor target registers(Target register7 banked)
                begin
                    case(CPU_ID)
                    2'd0:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR0[7];
                        end
                        else
                        begin
                            ICDIPTR0[7]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR1[7];
                        end
                        else
                        begin
                            ICDIPTR1[7]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR2[7];
                        end
                        else
                        begin
                            ICDIPTR2[7]<=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR3[7];
                        end
                        else
                        begin
                            ICDIPTR3[7]<=data_in;
                        end
                    end
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd32:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[0];
                    end
                    else
                    begin
                        ICDIPTR_S[0]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd36:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[1];
                    end
                    else
                    begin
                        ICDIPTR_S[1]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd40:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[2];
                    end
                    else
                    begin
                        ICDIPTR_S[2]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd44:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[3];
                    end
                    else
                    begin
                        ICDIPTR_S[3]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd48:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[4];
                    end
                    else
                    begin
                        ICDIPTR_S[4]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd52:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[5];
                    end
                    else
                    begin
                        ICDIPTR_S[5]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd56:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[6];
                    end
                    else
                    begin
                        ICDIPTR_S[6]<=data_in;
                    end
                end                                                                                   
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd60:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[7];
                    end
                    else
                    begin
                        ICDIPTR_S[7]<=data_in;
                    end
                end                                                                
                DISTRIBUTOR_BASE_ADDRESS+12'hC00://Interrupt configuration registers
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR0[0];
                            end
                            else
                            begin
                                ICDICFR0[0]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR1[0];
                            end
                            else
                            begin
                                ICDICFR1[0]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR2[0];
                            end
                            else
                            begin
                                ICDICFR2[0]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR3[0];
                            end
                            else
                            begin
                                ICDICFR3[0]<=data_in;
                            end
                        end
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'hC00+12'd4:
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR0[1];
                            end
                            else
                            begin
                                ICDICFR0[1]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR1[1];
                            end
                            else
                            begin
                                ICDICFR1[1]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR2[1];
                            end
                            else
                            begin
                                ICDICFR2[1]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR3[1];
                            end
                            else
                            begin
                                ICDICFR3[1]<=data_in;
                            end
                        end
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'hC00+12'd8://configuration registers for SPIs
                begin
                    if(read)
                    begin
                        data_out<=ICDICFR_S[0];
                    end
                    else
                    begin
                        ICDICFR_S[0]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'hC00+12'd12:
                begin
                    if(read)
                    begin
                        data_out<=ICDICFR_S[1];
                    end
                    else
                    begin
                        ICDICFR_S[1]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'hF00://Software Generated Interrupt registers
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(!read)//SGI is write only
                            begin
                                ICDSGIR0<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(!read)//SGI is write only
                            begin
                                ICDSGIR1<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(!read)//SGI is write only
                            begin
                                ICDSGIR2<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(!read)//SGI is write only
                            begin
                                ICDSGIR3<=data_in;
                            end
                        end
                    endcase
                end
                CPU_INTERFACE_BASE_ADDRESS+8'h0://ICCICR register (RW) not banked
                begin
                    if(read)
                    begin
                        data_out<=ICCICR;
                    end
                    else
                    begin
                        ICCICR<=data_in;
                    end
                end
                CPU_INTERFACE_BASE_ADDRESS+8'h04://ICCPPMR register (RW) banked
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICCPMR0;
                            end
                            else
                            begin
                                ICCPMR0<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICCPMR1;
                            end
                            else
                            begin
                                ICCPMR1<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICCPMR2;
                            end
                            else
                            begin
                                ICCPMR2<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICCPMR3;
                            end
                            else
                            begin
                                ICCPMR3<=data_in;
                            end
                        end
                    endcase
                end
                CPU_INTERFACE_BASE_ADDRESS+8'h08://Binary point register(RW) banked
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICCBPR0;
                            end
                            else
                            begin
                                ICCBPR0<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICCBPR1;
                            end
                            else
                            begin
                                ICCBPR1<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICCBPR2;
                            end
                            else
                            begin
                                ICCBPR2<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICCBPR3;
                            end
                            else
                            begin
                                ICCBPR3<=data_in;
                            end
                        end
                    endcase
                end
                CPU_INTERFACE_BASE_ADDRESS+8'h0C://Interrupt Acknowledge register(RO) banked
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICCIAR0;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICCIAR1;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICCIAR2;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICCIAR3;
                            end
                        end
                    endcase
                end
                CPU_INTERFACE_BASE_ADDRESS+8'h10://End of Interrupt Register(WO) banked
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(!read)
                            begin
                                ICCEOIR0<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(!read)
                            begin
                                ICCEOIR1<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(!read)
                            begin
                                ICCEOIR2<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(!read)
                            begin
                                ICCEOIR3<=data_in;
                            end
                        end
                    endcase
                end
                CPU_INTERFACE_BASE_ADDRESS+8'h14://Running priority Register(RO) banked
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICCRPR0;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICCRPR1;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICCRPR2;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICCRPR3;
                            end
                        end
                    endcase
                end
                CPU_INTERFACE_BASE_ADDRESS+8'h18://Highest priority Interrupt register(RO) banked
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICCHPIR0;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICCHPIR1;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICCHPIR2;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICCHPIR3;
                            end
                        end
                    endcase
                end
                CPU_INTERFACE_BASE_ADDRESS+8'h1C://Aliased binary point register(RW) banked
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICCABPR0;
                            end
                            else
                            begin
                                ICCABPR0<=data_in;
                            end
                            
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICCABPR1;
                            end
                            else
                            begin
                                ICCABPR1<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICCABPR2;
                            end
                            else
                            begin
                                ICCABPR2<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICCABPR3;
                            end
                            else
                            begin
                                ICCABPR3<=data_in;
                            end
                        end
                    endcase
                end
                CPU_INTERFACE_BASE_ADDRESS+8'hFC:
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICCIIDR0;
                            end
                            else
                            begin
                                ICCIIDR0<=data_in;
                            end
                            
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICCIIDR1;
                            end
                            else
                            begin
                                ICCIIDR1<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICCIIDR2;
                            end
                            else
                            begin
                                ICCIIDR2<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICCIIDR3;
                            end
                            else
                            begin
                                ICCIIDR3<=data_in;
                            end
                        end
                    endcase
                end
                                
                endcase
            end
            
        end
    end
    
    always@(posedge clk)
    begin
        case(inerrupt_states0[0])
        2'b00://inactive state
        begin
            if(PPI_1[0]==1'b0)
            begin
                interrupt_states0[0]=2'b00;//inactive state
            end
            else
            begin
                interrupt_states0[0]=2'b01;//pending state
            end
        end
        2'b01://pending state
        begin
            if(ICDICFR0[0]==1'b0)//level sensitive
            begin
                if(PPI_2[0]==1'b0)
                begin
                    interrupt_states0[0]=2'b00;
                end
                else
                begin
                    interrupt_states0[0]=2'b01;
                end
            end
            else//edge triggered
            begin
                
            end
        end
        2'b10://active state
        begin
        
        end
        2'b11://active and pending state
        begin
        
        end
        endcase
    end
    
    
    
    
    //Section Configuration registers end
    /*
    
    The end of distributor control registers configuration logic
    
    
    
    */
    
    
    //Interrupt State Machine
    
    always@(posedge clk or negedge reset)
    begin
        case(interrupt_states0[0])
            2'b00:
            begin
            end
            2'b01:
            begin
            end
            2'b10:
            begin
            end
            2'b11:
            begin
            end
        endcase
    end
    
    
    
    //Interrupt Configuring as edge triggered or level sensitive 
    //configure logic for first processor 

    
    // always@(
    
    //Interrupt state change logic
    
    //always@(
    
    
    
/*    
    //selecting the highest priority interrupt for CPU Interface0
    integer i;
    for(i=0;i<=63;i=i+1)
    begin
        
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
    end*/ 
    
        
endmodule
