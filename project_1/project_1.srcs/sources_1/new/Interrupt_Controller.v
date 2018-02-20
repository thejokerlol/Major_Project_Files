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


module Interrupt_Controller(CPU_ID,address,data_in,data_out,read,enable_RW,clk,reset,
                    PPI_1,PPI_2,PPI_3,PPI_4,SPI,IRQ,FIQ,RW_err,ready
        

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
    input[63:32] SPI;//These are the shared peripheral interrupts
    
    
    reg[16:31] PPI[0:3];
    
    //reg[5:0] HP_ID[0:3];//Highest Priority Interrupt ID for all CPU Interfaces
    
    /*
    
    IRQs and FIQs for all processors
    
    */
    output reg[3:0] IRQ;
    output reg[3:0] FIQ;
    
    
    
    
    //For the APB bus interface
    output ready;
    output reg RW_err;
    
    /*
    Internal Registers of the distributor
    
    */
    
    //Global interrupt Disable signal
    reg[31:0] ICDDCR;//Distributor Control Register(RW)
    
    
    reg[31:0] ICDICTR; //Interrupt Controller Type Register(RO)
    reg[31:0] ICDIIDR;//Distributor Implementor Identification Register(RO)
    reg[31:0] ICDISRE;//Interuupt Security Register(RW)
    
    //Registers of Interrupts of CPU 0 to 3 are banked(Banked)
    
    reg[31:0] ICDISER[0:3];//Interrupt Set Enable Register(RW)
    reg[31:0] ICDICER[0:3];//Interrupt Clear Enable Register(RW)
    reg[31:0] ICDISPR[0:3];//Interrupt Set Pending Register(RW)
    reg[31:0] ICDICPR[0:3];//Interrupt Clear Pending Register(RW)
    reg[31:0] ICDISR[0:3];//Interrupt Security Registers(RW)
    reg[31:0] ICDABR[0:3];//Active Bit Register(RO)
    //for handling the priority of 32 interrupts each one of 8 bits we need 8 registers
    reg[31:0] ICDIPR[0:3][0:7];//Interrupt Priority Register(RW) 
    reg[31:0] ICDIPTR[0:3][0:7];//Interrupt Processor Target Register(RO)
    reg[31:0] ICDICFR[0:3][0:1];//Interrupt Configuration Register(RW) 2 bits for each interrupt 1:N model or N:N model?
    reg[31:0] ICDSGIR[0:3];//Software generated Interrupt Register(WO)
    
    
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
    
    //for CPU Interface registers for all processors(Banked)
    
    reg[31:0] ICCPMR[0:3];//CPU Interface Priority Mask Register
    reg[31:0] ICCBPR[0:3];//CPU Interface Binary Point Register
    reg[31:0] ICCIAR[0:3];//Interrupt Acknowledge Register
    reg[31:0] ICCEOIR[0:3];//End of Interrupt Register
    reg[31:0] ICCRPR[0:3];//Running Priority Register
    reg[31:0] ICCHPIR[0:3];//Highest Pending Interrupt Register
    reg[31:0] ICCABPR[0:3];//Aliased Binary Point Register
    reg[31:0] ICCIIDR[0:3];//CPU Interface Identification Register
    
    //address information
    parameter DISTRIBUTOR_BASE_ADDRESS=32'd0;//should be a parameter because should be synthesizable for various base addresses
    parameter CPU_INTERFACE_BASE_ADDRESS=32'd0; //should be a parameter because should be synthesizable for various base addresses
    
    
    //states of various interrupts in all CPUs
    /*
        for inactive,interrupt state is 0
        for pending,interrupt state is 1
        for active,interrupt state is 2
        for active and pending,interrupt state is 3
    */
    reg[1:0] interrupt_states[0:3][0:31];
    
    reg[1:0] interrupt_states_S[32:63];
    
    
    
    /*
    intermediate signals for the priority logic
    */
    wire[5:0] Interrupt_IDs[0:63];//Interrupt IDs from 0 to 63
    wire[1:0] CPU_NOs[0:3];//CPU IDs one ID for each CPU
    wire[5:0] HP_ID[0:3][0:62];//Highest priority intermediate registers
    wire[7:0] output_priority[0:3][0:62];//output priority registers
    wire enabled[0:3][0:62];//intermediate enable signals
    wire[0:1] priority_state[0:3][0:62];//output priority states
    wire[3:0] out_target_proc_list[0:3][0:62];//target processors of output highest priority interrupt
    
    
    
    always@(*)
    begin
        PPI[0]=PPI_1;
        PPI[1]=PPI_2;
        PPI[2]=PPI_3;
        PPI[3]=PPI_4;
    end    
    always@(*)
    begin
        ICDICTR=32'd0;
        ICDIIDR=32'd0;
        
    end
    //Register read write logic
    always@(posedge clk or negedge reset)
    begin
        if(!reset)//active low signal
        begin
        //initialize all the registers on reset
            IC_reset;
            
            
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
                                data_out<=ICDISER[0];
                            end
                            else
                            begin
                                ICDISER[0]<=data_in;
                            end
                        end
                        2'd1:
                        begin
                            if(read)
                            begin
                                data_out<=ICDISER[1];
                            end
                            else
                            begin
                                ICDISER[1]<=data_in;
                            end
                        end
                        2'd2:
                        begin
                            if(read)
                            begin
                                data_out<=ICDISER[2];
                            end
                            else
                            begin
                                ICDISER[2]<=data_in;
                            end
                        end
                        2'd3:
                        begin
                            if(read)
                            begin
                                data_out<=ICDISER[3];
                            end
                            else
                            begin
                                ICDISER[3]<=data_in;
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
                                   data_out<=ICDICER[0];
                               end
                               else
                               begin
                                   ICDICER[0]<=data_in;
                               end
                           end
                           2'd1:
                           begin
                               if(read)
                               begin
                                   data_out<=ICDICER[1];
                               end
                               else
                               begin
                                   ICDICER[1]<=data_in;
                               end
                           end
                           2'd2:
                           begin
                               if(read)
                               begin
                                   data_out<=ICDICER[2];
                               end
                               else
                               begin
                                   ICDICER[2]<=data_in;
                               end
                           end
                           2'd3:
                           begin
                               if(read)
                               begin
                                   data_out<=ICDICER[3];
                               end
                               else
                               begin
                                   ICDICER[3]<=data_in;
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
                               data_out<=ICDISPR[0];
                           end
                           else
                           begin
                               ICDISPR[0]<=data_in;
                           end
                       end
                       2'd1:
                       begin
                           if(read)
                           begin
                               data_out<=ICDISPR[1];
                           end
                           else
                           begin
                               ICDISPR[1]<=data_in;
                           end
                       end
                       2'd2:
                       begin
                           if(read)
                           begin
                               data_out<=ICDISPR[2];
                           end
                           else
                           begin
                               ICDISPR[2]<=data_in;
                           end
                       end
                       2'd3:
                       begin
                           if(read)
                           begin
                               data_out<=ICDISPR[3];
                           end
                           else
                           begin
                               ICDISPR[3]<=data_in;
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
                               data_out<=ICDICPR[0];
                           end
                           else
                           begin
                               ICDICPR[0]<=data_in;
                           end
                       end
                       2'd1:
                       begin
                           if(read)
                           begin
                               data_out<=ICDICPR[1];
                           end
                           else
                           begin
                               ICDICPR[1]<=data_in;
                           end
                       end
                       2'd2:
                       begin
                           if(read)
                           begin
                               data_out<=ICDICPR[2];
                           end
                           else
                           begin
                               ICDICPR[2]<=data_in;
                           end
                       end
                       2'd3:
                       begin
                           if(read)
                           begin
                               data_out<=ICDICPR[3];
                           end
                           else
                           begin
                               ICDICPR[3]<=data_in;
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
                                data_out<=ICDIPR[0][0];
                            end
                            else
                            begin
                                ICDIPR[0][0]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[1][0];
                            end
                            else
                            begin
                                ICDIPR[1][0]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[2][0];
                            end
                            else
                            begin
                                ICDIPR[2][0]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[3][0];
                            end
                            else
                            begin
                                ICDIPR[3][0]<=data_in;
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
                            data_out<=ICDIPR[0][1];
                        end
                        else
                        begin
                            ICDIPR[0][1]<=data_in;
                        end
                    end
                    2'b01:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPR[1][1];
                        end
                        else
                        begin
                            ICDIPR[1][1]<=data_in;
                        end
                    end
                    2'b10:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPR[2][1];
                        end
                        else
                        begin
                            ICDIPR[2][1]<=data_in;
                        end
                    end
                    2'b11:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPR[3][1];
                        end
                        else
                        begin
                            ICDIPR[3][1]<=data_in;
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
                                data_out<=ICDIPR[0][2];
                            end
                            else
                            begin
                                ICDIPR[0][2]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[1][2];
                            end
                            else
                            begin
                                ICDIPR[1][2]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[2][2];
                            end
                            else
                            begin
                                ICDIPR[2][2]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[3][2];
                            end
                            else
                            begin
                                ICDIPR[3][2]<=data_in;
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
                                data_out<=ICDIPR[0][3];
                            end
                            else
                            begin
                                ICDIPR[0][3]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[1][3];
                            end
                            else
                            begin
                                ICDIPR[1][3]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[2][3];
                            end
                            else
                            begin
                                ICDIPR[2][3]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[3][3];
                            end
                            else
                            begin
                                ICDIPR[3][3]<=data_in;
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
                                data_out<=ICDIPR[0][4];
                            end
                            else
                            begin
                                ICDIPR[0][4]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[1][4];
                            end
                            else
                            begin
                                ICDIPR[1][4]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[2][4];
                            end
                            else
                            begin
                                ICDIPR[2][4]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[3][4];
                            end
                            else
                            begin
                                ICDIPR[3][4]<=data_in;
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
                                data_out<=ICDIPR[0][5];
                            end
                            else
                            begin
                                ICDIPR[0][5]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[1][5];
                            end
                            else
                            begin
                                ICDIPR[1][5]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[2][5];
                            end
                            else
                            begin
                                ICDIPR[2][5]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[3][5];
                            end
                            else
                            begin
                                ICDIPR[3][5]<=data_in;
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
                                data_out<=ICDIPR[0][6];
                            end
                            else
                            begin
                                ICDIPR[0][6]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[1][6];
                            end
                            else
                            begin
                                ICDIPR[1][6]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[2][6];
                            end
                            else
                            begin
                                ICDIPR[2][6]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[3][6];
                            end
                            else
                            begin
                                ICDIPR[3][6]<=data_in;
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
                                data_out<=ICDIPR[0][7];
                            end
                            else
                            begin
                                ICDIPR[0][7]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[1][7];
                            end
                            else
                            begin
                                ICDIPR[1][7]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[2][7];
                            end
                            else
                            begin
                                ICDIPR[2][7]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDIPR[3][7];
                            end
                            else
                            begin
                                ICDIPR[3][7]<=data_in;
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
                            data_out<=ICDIPTR[0][0];
                        end
                        else
                        begin
                            ICDIPTR[0][0]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[1][0];
                        end
                        else
                        begin
                            ICDIPTR[1][0]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[2][0];
                        end
                        else
                        begin
                            ICDIPTR[2][0]=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[3][0];
                        end
                        else
                        begin
                            ICDIPTR[3][0]<=data_in;
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
                            data_out<=ICDIPTR[0][1];
                        end
                        else
                        begin
                            ICDIPTR[0][1]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[1][1];
                        end
                        else
                        begin
                            ICDIPTR[1][1]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[2][1];
                        end
                        else
                        begin
                            ICDIPTR[2][1]=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[3][1];
                        end
                        else
                        begin
                            ICDIPTR[3][1]<=data_in;
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
                            data_out<=ICDIPTR[0][2];
                        end
                        else
                        begin
                            ICDIPTR[0][2]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[1][2];
                        end
                        else
                        begin
                            ICDIPTR[1][2]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[2][2];
                        end
                        else
                        begin
                            ICDIPTR[2][2]=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[3][2];
                        end
                        else
                        begin
                            ICDIPTR[3][2]<=data_in;
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
                            data_out<=ICDIPTR[0][3];
                        end
                        else
                        begin
                            ICDIPTR[0][3]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[1][3];
                        end
                        else
                        begin
                            ICDIPTR[1][3]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[2][3];
                        end
                        else
                        begin
                            ICDIPTR[2][3]=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[3][3];
                        end
                        else
                        begin
                            ICDIPTR[3][3]<=data_in;
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
                            data_out<=ICDIPTR[0][4];
                        end
                        else
                        begin
                            ICDIPTR[0][4]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[1][4];
                        end
                        else
                        begin
                            ICDIPTR[1][4]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[2][4];
                        end
                        else
                        begin
                            ICDIPTR[2][4]=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[3][4];
                        end
                        else
                        begin
                            ICDIPTR[3][4]<=data_in;
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
                            data_out<=ICDIPTR[0][5];
                        end
                        else
                        begin
                            ICDIPTR[0][5]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[1][5];
                        end
                        else
                        begin
                            ICDIPTR[1][5]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[2][5];
                        end
                        else
                        begin
                            ICDIPTR[2][5]=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[3][5];
                        end
                        else
                        begin
                            ICDIPTR[3][5]<=data_in;
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
                            data_out<=ICDIPTR[0][6];
                        end
                        else
                        begin
                            ICDIPTR[0][6]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[1][6];
                        end
                        else
                        begin
                            ICDIPTR[1][6]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[2][6];
                        end
                        else
                        begin
                            ICDIPTR[2][6]=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[3][6];
                        end
                        else
                        begin
                            ICDIPTR[3][6]<=data_in;
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
                            data_out<=ICDIPTR[0][7];
                        end
                        else
                        begin
                            ICDIPTR[0][7]<=data_in;
                        end
                    end
                    2'd1:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[1][7];
                        end
                        else
                        begin
                            ICDIPTR[1][7]<=data_in;
                        end
                        
                    end
                    2'd2:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[2][7];
                        end
                        else
                        begin
                            ICDIPTR[2][7]<=data_in;
                        end
                    end

                    2'd3:
                    begin
                        if(read)
                        begin
                            data_out<=ICDIPTR[3][7];
                        end
                        else
                        begin
                            ICDIPTR[3][7]<=data_in;
                        end
                    end
                    endcase
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd32:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[8];
                    end
                    else
                    begin
                        ICDIPTR_S[8]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd36:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[9];
                    end
                    else
                    begin
                        ICDIPTR_S[9]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd40:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[10];
                    end
                    else
                    begin
                        ICDIPTR_S[10]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd44:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[11];
                    end
                    else
                    begin
                        ICDIPTR_S[11]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd48:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[12];
                    end
                    else
                    begin
                        ICDIPTR_S[12]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd52:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[13];
                    end
                    else
                    begin
                        ICDIPTR_S[13]<=data_in;
                    end
                end
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd56:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[14];
                    end
                    else
                    begin
                        ICDIPTR_S[14]<=data_in;
                    end
                end                                                                                   
                DISTRIBUTOR_BASE_ADDRESS+12'h800+12'd60:
                begin
                    if(read)
                    begin
                        data_out<=ICDIPTR_S[15];
                    end
                    else
                    begin
                        ICDIPTR_S[15]<=data_in;
                    end
                end                                                                
                DISTRIBUTOR_BASE_ADDRESS+12'hC00://Interrupt configuration registers
                begin
                    case(CPU_ID)
                        2'b00:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR[0][0];
                            end
                            else
                            begin
                                ICDICFR[0][0]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR[1][0];
                            end
                            else
                            begin
                                ICDICFR[1][0]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR[2][0];
                            end
                            else
                            begin
                                ICDICFR[2][0]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR[3][0];
                            end
                            else
                            begin
                                ICDICFR[3][0]<=data_in;
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
                                data_out<=ICDICFR[0][1];
                            end
                            else
                            begin
                                ICDICFR[0][1]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR[1][1];
                            end
                            else
                            begin
                                ICDICFR[1][1]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR[2][1];
                            end
                            else
                            begin
                                ICDICFR[2][1]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICDICFR[3][1];
                            end
                            else
                            begin
                                ICDICFR[3][1]<=data_in;
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
                                ICDSGIR[0]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(!read)//SGI is write only
                            begin
                                ICDSGIR[1]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(!read)//SGI is write only
                            begin
                                ICDSGIR[2]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(!read)//SGI is write only
                            begin
                                ICDSGIR[3]<=data_in;
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
                                data_out<=ICCPMR[0];
                            end
                            else
                            begin
                                ICCPMR[0]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICCPMR[1];
                            end
                            else
                            begin
                                ICCPMR[1]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICCPMR[2];
                            end
                            else
                            begin
                                ICCPMR[2]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICCPMR[3];
                            end
                            else
                            begin
                                ICCPMR[3]<=data_in;
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
                                data_out<=ICCBPR[0];
                            end
                            else
                            begin
                                ICCBPR[0]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICCBPR[1];
                            end
                            else
                            begin
                                ICCBPR[1]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICCBPR[2];
                            end
                            else
                            begin
                                ICCBPR[2]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICCBPR[3];
                            end
                            else
                            begin
                                ICCBPR[3]<=data_in;
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
                                data_out<=ICCIAR[0];
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICCIAR[1];
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICCIAR[2];
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICCIAR[3];
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
                                ICCEOIR[0]<=data_in;
                            end
                        end
                        2'b01:
                        begin
                            if(!read)
                            begin
                                ICCEOIR[1]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(!read)
                            begin
                                ICCEOIR[2]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(!read)
                            begin
                                ICCEOIR[3]<=data_in;
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
                                data_out<=ICCRPR[0];
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICCRPR[1];
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICCRPR[2];
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICCRPR[3];
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
                                data_out<=ICCHPIR[0];
                            end
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICCHPIR[1];
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICCHPIR[2];
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICCHPIR[3];
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
                                data_out<=ICCABPR[0];
                            end
                            else
                            begin
                                ICCABPR[0]<=data_in;
                            end
                            
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICCABPR[1];
                            end
                            else
                            begin
                                ICCABPR[1]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICCABPR[2];
                            end
                            else
                            begin
                                ICCABPR[2]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICCABPR[3];
                            end
                            else
                            begin
                                ICCABPR[3]<=data_in;
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
                                data_out<=ICCIIDR[0];
                            end
                            else
                            begin
                                ICCIIDR[0]<=data_in;
                            end
                            
                        end
                        2'b01:
                        begin
                            if(read)
                            begin
                                data_out<=ICCIIDR[1];
                            end
                            else
                            begin
                                ICCIIDR[1]<=data_in;
                            end
                        end
                        2'b10:
                        begin
                            if(read)
                            begin
                                data_out<=ICCIIDR[2];
                            end
                            else
                            begin
                                ICCIIDR[2]<=data_in;
                            end
                        end
                        2'b11:
                        begin
                            if(read)
                            begin
                                data_out<=ICCIIDR[3];
                            end
                            else
                            begin
                                ICCIIDR[3]<=data_in;
                            end
                        end
                    endcase
                end
                default:
                begin
                    RW_err=1'b1;
                end
                                
                endcase
            end
            
        end
    end
    
    
    //Section Configuration registers end
    /*
    
    The end of distributor control registers configuration logic
    
    
    
    */
    parameter INACTIVE=2'b00;
    parameter PENDING=2'b01;
    parameter ACTIVE=2'b10;
    parameter ACTIVE_AND_PENDING=2'b11; 
    
    
    
    
    genvar k;
    generate
        for(k=0;k<64;k=k+1)
        begin
            if(k==0)
                assign Interrupt_IDs[k]=0;
            else
                assign Interrupt_IDs[k]=Interrupt_IDs[k-1]+1;
        end
    endgenerate
    
    genvar CPU_no;
    
    generate
        for(CPU_no=0;CPU_no<4;CPU_no=CPU_no+1)
        begin
            if(CPU_no==0)
                assign CPU_NOs[CPU_no]=0;
            else
                assign CPU_NOs[CPU_no]=CPU_NOs[CPU_no-1]+1;
            
        end
    endgenerate
    
    
    //Interrupt State Machines for SGIs for interrupts bit only for a single processor(SGIs are only edge trigggered)
    genvar int_num;
    genvar CPU_number;
    reg[1:0] SGI_CPU_regs[0:15];
    
    reg CPU_ID_SGI;
    generate
        for(CPU_number=0;CPU_number<4;CPU_number=CPU_number+1)
        begin
            for(int_num=0;int_num<16;int_num=int_num+1)
            begin
                always@(posedge clk or negedge reset)
                begin
                    if(!reset)
                    begin
                        interrupt_states[CPU_number][int_num]=INACTIVE;
                    end
                    else
                    begin
                        case(interrupt_states[CPU_number][int_num])
                            INACTIVE:
                            begin
                                if(enable_RW && !read && (address == DISTRIBUTOR_BASE_ADDRESS+12'hF00) && (CPU_ID==CPU_NOs[CPU_number]))//for a software generated interrupt a write to the SGI register, a CPUID doesn't matter i guess
                                begin
                                    if(data_in[3:0]==Interrupt_IDs[int_num] && data_in[16]==1'b1)//If the interrupt ID matches and the target processor list has the current processor in it's field i.e., data_in[16] is the bit for processor 0
                                    begin
                                        interrupt_states[CPU_number][int_num]<=PENDING;
                                        //ICCIAR0<={19'h0,1'b0,CPU_ID,10'd0};//generation of  a interrupt but i guess it's not here only if this is the highest priority interrupt
                                        //form the interrupt processor target registers and the CPU ID should be
                                        CPU_ID_SGI <= CPU_ID;//temporary save
                                        SGI_CPU_regs[int_num] <= CPU_ID;//saving the CPU ID which generaed the SGI 
                                    end
                                    else
                                    begin
                                        interrupt_states[CPU_number][int_num]<=INACTIVE;
                                    end
                                end
                            end
                            PENDING:
                            begin
                                if(enable_RW && read && (address == CPU_INTERFACE_BASE_ADDRESS+8'h0C) && (CPU_ID==CPU_NOs[CPU_number]))//a read to the interrupt acknowledge register
                                begin
                                    if(ICCIAR[CPU_number][5:0]==Interrupt_IDs[int_num])
                                    begin
                                        interrupt_states[CPU_number][int_num]<=ACTIVE;
                                    end
                                    else
                                    begin
                                        interrupt_states[CPU_number][int_num]<=PENDING;
                                    end
                                    
                                end
                            end
                            ACTIVE:
                            begin
                                if(enable_RW && (!read) && (address==CPU_INTERFACE_BASE_ADDRESS+8'h10) && (CPU_ID==CPU_NOs[CPU_number]))//a write to the CPU interface EOIR register
                                begin
                                    if(data_in[5:0]==Interrupt_IDs[int_num])
                                    begin
                                        interrupt_states[CPU_number][int_num]<=INACTIVE;
                                    end
                                    else
                                    begin
                                        interrupt_states[CPU_number][int_num]<=ACTIVE;
                                    end
                                end
                            end
                            ACTIVE_AND_PENDING:
                            begin
                                if(enable_RW && (!read) && (address==CPU_INTERFACE_BASE_ADDRESS+8'h10) && (CPU_ID==CPU_NOs[CPU_number]))//a write to the CPU interface EOIR register
                                begin
                                    if(data_in[5:0]==Interrupt_IDs[int_num])
                                    begin
                                        interrupt_states[CPU_number][int_num]<=PENDING;
                                    end
                                    else
                                    begin
                                        interrupt_states[CPU_number][int_num]<=ACTIVE;
                                    end
                                end
                            end
                        endcase
                    end
                end
            end
        end
    endgenerate
    
    /*
    
    Interrupts for multiple processors
    
    */
    genvar processor_number;
    genvar interrupt_number_PPI;
    
    //Interrupt state machines for PPIs(for both edge and level triggered interrupts)
    generate
        for(processor_number=0;processor_number<4;processor_number=processor_number+1)
        begin
            for(interrupt_number_PPI=16;interrupt_number_PPI<32;interrupt_number_PPI=interrupt_number_PPI+1)
            begin
                always@(posedge clk or negedge reset)
                begin
                    if(!reset)
                    begin
                        interrupt_states[processor_number][interrupt_number_PPI]<=INACTIVE;
                    end
                    else
                    begin
                        case(interrupt_states[processor_number][interrupt_number_PPI])
                            INACTIVE://Inactive state
                            begin
                                if(PPI[processor_number][interrupt_number_PPI]==1'b1)
                                begin
                                    interrupt_states[processor_number][interrupt_number_PPI]<=PENDING;
                                end
                                else
                                begin
                                    interrupt_states[processor_number][interrupt_number_PPI]<=INACTIVE;
                                end
                            end
                            PENDING://pending state
                            begin
                                if(enable_RW && read && (address == CPU_INTERFACE_BASE_ADDRESS+8'h0C) && (CPU_ID==CPU_NOs[processor_number]))//a read to the interrupt acknowledge register
                                begin
                                    if(ICCIAR[processor_number][5:0]==Interrupt_IDs[interrupt_number_PPI])
                                    begin
                                        interrupt_states[processor_number][interrupt_number_PPI]<=ACTIVE;
                                    end
                                    else
                                    begin
                                        if(ICDICFR[processor_number][interrupt_number_PPI / 16][(2*(interrupt_number_PPI % 16))+1]==1'b0)//level sensitive interrupts
                                        begin
                                            if(PPI[processor_number][interrupt_number_PPI]==1'b1)
                                            begin
                                                interrupt_states[processor_number][interrupt_number_PPI]=PENDING;
                                            end
                                            else
                                            begin
                                                interrupt_states[processor_number][interrupt_number_PPI]=INACTIVE;
                                            end
                                        end
                                        else
                                        begin
                                            interrupt_states[processor_number][interrupt_number_PPI]=PENDING;
                                        end
                                        
                                    end
                                    
                                end
                            end
                            ACTIVE://active state
                            begin
                                if(enable_RW && (!read) && (address==CPU_INTERFACE_BASE_ADDRESS+8'h10) && (CPU_ID==CPU_NOs[processor_number]))//a write to the CPU interface EOIR register
                                begin
                                    if(data_in[5:0]==Interrupt_IDs[interrupt_number_PPI])
                                    begin
                                        interrupt_states[processor_number][interrupt_number_PPI]<=INACTIVE;
                                    end
                                    else
                                    begin
                                        interrupt_states[processor_number][interrupt_number_PPI]<=ACTIVE;
                                    end
                                end
                            end
                            ACTIVE_AND_PENDING://active and pending state
                            begin
                                if(enable_RW && (!read) && (address==CPU_INTERFACE_BASE_ADDRESS+8'h10) && (CPU_ID==CPU_NOs[processor_number]))//a write to the CPU interface EOIR register
                                begin
                                    if(data_in[5:0]==Interrupt_IDs[interrupt_number_PPI])
                                    begin
                                        if(ICDICFR[processor_number][interrupt_number_PPI / 16][(2*(interrupt_number_PPI % 16))+1]==1'b0)//level sensitive interrupts
                                         begin
                                             if(PPI[processor_number][interrupt_number_PPI]==1'b1)
                                             begin
                                                 interrupt_states[processor_number][interrupt_number_PPI]=PENDING;
                                             end
                                            else
                                            begin
                                                interrupt_states[processor_number][interrupt_number_PPI]=INACTIVE;
                                            end
                                         end
                                         else
                                         begin
                                             interrupt_states[processor_number][interrupt_number_PPI]=PENDING;
                                         end    
                                    end
                                    else
                                    begin
                                        interrupt_states[processor_number][interrupt_number_PPI]<=ACTIVE;
                                    end
                                end
                            end
                        endcase
                    end
                end
            end
        end
    endgenerate
    
    genvar interrupt_number_SPI;
    //Interrupt state machines for SPIs, should be modified a little bit
    generate
        for(interrupt_number_SPI=32;interrupt_number_SPI<64;interrupt_number_SPI=interrupt_number_SPI+1)
        begin
            always@(posedge clk or negedge reset)
            begin
            if(!reset)
            begin
                interrupt_states_S[interrupt_number_SPI]<=INACTIVE;
            end
            else
            begin
                case(interrupt_states_S[interrupt_number_SPI])
                    INACTIVE://Inactive state
                    begin
                        if(SPI[interrupt_number_SPI]==1'b1)
                        begin
                            interrupt_states_S[interrupt_number_SPI]<=PENDING;
                        end
                        else
                        begin
                            interrupt_states_S[interrupt_number_SPI]<=INACTIVE;
                        end
                    end
                    PENDING://pending state
                    begin
                        if(enable_RW && read && (address == CPU_INTERFACE_BASE_ADDRESS+8'h0C))//a read to the interrupt acknowledge register
                        begin
                            //handled using 1:N model
                            if((ICCIAR[0][5:0]==Interrupt_IDs[interrupt_number_SPI]) || (ICCIAR[1][5:0]==Interrupt_IDs[interrupt_number_SPI]) || (ICCIAR[2][5:0]==Interrupt_IDs[interrupt_number_SPI]) || (ICCIAR[3][5:0]==Interrupt_IDs[interrupt_number_SPI]))
                            begin
                                interrupt_states_S[interrupt_number_SPI]<=ACTIVE;
                            end
                            else
                            begin
                               if(ICDICFR_S[(interrupt_number_SPI-32) / 16][(2*((interrupt_number_SPI-32)%16))+1]==1'b0)//level sensitive interrupt
                               begin
                                    if(SPI[interrupt_number_SPI]==1'b1)
                                    begin
                                        interrupt_states_S[interrupt_number_SPI]<=PENDING;
                                    end
                                    else
                                    begin
                                        interrupt_states_S[interrupt_number_SPI]<=INACTIVE;
                                    end
                               end
                               else
                               begin
                                    interrupt_states_S[interrupt_number_SPI]<=PENDING;
                               end
                            end
                            
                        end
                    end
                    ACTIVE://active state
                    begin
                        if(enable_RW && (!read) && (address==CPU_INTERFACE_BASE_ADDRESS+8'h10))//a write to the CPU interface EOIR register
                        begin
                            if(data_in[5:0]==Interrupt_IDs[interrupt_number_SPI])
                            begin
                                interrupt_states_S[interrupt_number_SPI]<=INACTIVE;
                            end
                            else
                            begin
                                interrupt_states_S[interrupt_number_SPI]<=ACTIVE;
                            end
                        end
                    end
                    ACTIVE_AND_PENDING://active and pending state
                    begin
                        if(enable_RW && (!read) && (address==CPU_INTERFACE_BASE_ADDRESS+8'h10))//a write to the CPU interface EOIR register
                        begin
                            if(data_in[5:0]==Interrupt_IDs[interrupt_number_SPI])
                            begin
                                interrupt_states_S[interrupt_number_SPI]<=PENDING;
                            end
                            else
                            begin
                                interrupt_states_S[interrupt_number_SPI]<=ACTIVE;
                            end
                        end
                    end
                endcase
              end
            end
        end    
    endgenerate
    
    
    //Finding the highest priority interrupt generation for processor 1 excluding the processor targets...next include the processor target register too
    genvar i;
    genvar processor_num;
    
    generate
        for(processor_num=0;processor_num<4;processor_num=processor_num+1)
        begin
            for(i=0;i<63;i=i+1)
            begin
                if(i<31)
                begin
                    
                    if(i==0)
                    begin
                      
                        Priority_Check P1(
                            Interrupt_IDs[i],Interrupt_IDs[i+1],CPU_NOs[processor_num],
                            ICDISER[processor_num][i],ICDISER[processor_num][i+1],
                            ICDIPR[processor_num][i/4][(8*(i%4))+7:(8*(i%4))],ICDIPR[processor_num][(i+1)/4][(8*((i+1)%4))+7:(8*((i+1)%4))],
                            
                            interrupt_states[processor_num][i],interrupt_states[processor_num][i+1],
                            ICDIPTR[processor_num][i/8][(4*(i%8))+3:(4*(i%8))],ICDIPTR[processor_num][(i+1)/8][(4*((i+1)%8))+3:(4*((i+1)%8))],//four are enough eight bits are not needed
                            
                            HP_ID[processor_num][i],
                            output_priority[processor_num][i],
                            enabled[processor_num][i],
                            priority_state[processor_num][i],
                            out_target_proc_list[processor_num][i]
                        );
                    end
                    else
                    begin
                        
                        Priority_Check P1(
                                        HP_ID[processor_num][i-1],Interrupt_IDs[i+1],CPU_NOs[processor_num],
                                        enabled[processor_num][i-1],ICDISER[processor_num][i+1],
                                        output_priority[processor_num][i-1],ICDIPR[processor_num][(i+1)/4][(8*((i+1)%4))+7:(8*((i+1)%4))],
                                        
                                        priority_state[processor_num][i-1],interrupt_states[processor_num][i+1],
                                        out_target_proc_list[processor_num][i-1],ICDIPTR[processor_num][(i+1)/8][(4*((i+1)%8))+3:(4*((i+1)%8))],
                                        
                                        HP_ID[processor_num][i],
                                        output_priority[processor_num][i],
                                        enabled[processor_num][i],
                                        priority_state[processor_num][i],
                                        out_target_proc_list[processor_num][i]
                                    );
                    end
                end
                else
                begin
                    
                    Priority_Check P1(
                                        HP_ID[processor_num][i-1],Interrupt_IDs[i+1],CPU_NOs[processor_num],
                                        enabled[processor_num][i-1],ICDISER_S[(i-32)+1],
                                        output_priority[processor_num][i-1],ICDIPR_S[(i+1)/4][(8*((i+1-32)%4))+7:(8*((i+1-32)%4))],
                                        
                                        priority_state[processor_num][i-1],interrupt_states_S[i+1],
                                        out_target_proc_list[processor_num][i-1],ICDIPTR_S[(i+1+32)/8][(4*((i+1-32)%8))+3:(4*((i+1-32)%8))],
                                        
                                        HP_ID[processor_num][i],
                                        output_priority[processor_num][i],
                                        enabled[processor_num][i],
                                        priority_state[processor_num][i],
                                        out_target_proc_list[processor_num][i]
                                    );
                
                end
            end
        end
    endgenerate
    
    
    //we need to find the Highest priority Active interrupt to implement the interrupt preemption
    reg[31:0] HP_Active_Interrupt[0:3];
    integer int_num_act;//acctive interrupt number
    integer num_by_four;
    integer proc_num;
        
            always@(*)
            begin
                for(proc_num=0;proc_num<4;proc_num=proc_num+1)
                begin
                    HP_Active_Interrupt[proc_num]={24'd0,8'h00};//this is the value on reset or if there is no highest priority active interrupt
                    for(int_num_act=0;int_num_act<64;int_num_act=int_num_act+1)
                    begin
                        num_by_four=int_num_act/4;
                        if(int_num_act<32)
                        begin
                            case(Interrupt_IDs[int_num_act][1:0])
                                2'b00:
                                begin
                                    if((ICDIPR[proc_num][int_num_act/4][7:0]>=ICCRPR[proc_num][7:0]) && (interrupt_states[proc_num][int_num_act] == ACTIVE))
                                    begin
                                        HP_Active_Interrupt[proc_num]={24'd0,ICDIPR[proc_num][int_num_act/4][7:0]};
                                    end
                                end
                                2'b01:
                                begin
                                    if((ICDIPR[proc_num][int_num_act/4][15:8]>=ICCRPR[proc_num][7:0])  && (interrupt_states[proc_num][int_num_act] == ACTIVE))
                                    begin
                                        HP_Active_Interrupt[proc_num]={24'd0,ICDIPR[proc_num][int_num_act/4][15:8]};
                                    end
                                end
                                2'b10:
                                begin
                                    if((ICDIPR[proc_num][int_num_act/4][23:16]>=ICCRPR[proc_num][7:0])  && (interrupt_states[proc_num][int_num_act] == ACTIVE))
                                    begin
                                        HP_Active_Interrupt[proc_num]={24'd0,ICDIPR[proc_num][int_num_act/4][23:16]};
                                    end
                                end
                                2'b11:
                                begin
                                    if((ICDIPR[proc_num][int_num_act/4][31:24]>=ICCRPR[proc_num][7:0])  && (interrupt_states[proc_num][int_num_act] == ACTIVE))
                                    begin
                                        HP_Active_Interrupt[proc_num]={24'd0,ICDIPR[proc_num][int_num_act/4][31:24]};
                                    end
                                end                
                            endcase
                        end
                        else
                        begin
                           case(Interrupt_IDs[int_num_act][1:0])
                                2'b00:
                                begin
                                    if((ICDIPR_S[num_by_four][7:0]>=ICCRPR[proc_num][7:0])  && (interrupt_states_S[int_num_act] == ACTIVE))
                                    begin
                                        HP_Active_Interrupt[proc_num]={24'd0,ICDIPR_S[int_num_act/4][7:0]};
                                    end
                                
                                end
                                2'b01:
                                begin
                                    if((ICDIPR_S[num_by_four][15:8]>=ICCRPR[proc_num][7:0])  && (interrupt_states_S[int_num_act] == ACTIVE))
                                    begin
                                        HP_Active_Interrupt[proc_num]={24'd0,ICDIPR_S[int_num_act/4][15:8]};
                                    end
                                end
                                2'b10:
                                begin
                                    if((ICDIPR_S[num_by_four][23:16]>=ICCRPR[proc_num][7:0])  && (interrupt_states_S[int_num_act] == ACTIVE))
                                    begin
                                        HP_Active_Interrupt[proc_num]={24'd0,ICDIPR_S[int_num_act/4][23:16]};
                                    end
                                end
                                2'b11:
                                begin
                                    if((ICDIPR_S[num_by_four][31:24]>=ICCRPR[proc_num][7:0])  && (interrupt_states_S[int_num_act] == ACTIVE))
                                    begin
                                        HP_Active_Interrupt[proc_num]={24'd0,ICDIPR_S[int_num_act/4][31:24]};
                                    end
                                end          
                            endcase 
                            
                        end
                    end
                end
            end
    //CPU Interface logic
    genvar proc_num_ICC;
    
    generate
        for(proc_num_ICC=0;proc_num_ICC<4;proc_num_ICC=proc_num_ICC+1)
        begin
           always@(posedge clk or negedge reset)
           begin
               if(!reset)
               begin
                    IRQ[proc_num_ICC]=0;
                    FIQ[proc_num_ICC]=0;
                    ICCPMR[proc_num_ICC]=32'h00000000;
               end
               else
               begin
                   if(ICCICR[proc_num_ICC])//check if the CPU interface is enabled
                   begin
                       if(enabled[proc_num_ICC][62])
                       begin
                           if((output_priority[proc_num_ICC][62]>ICCPMR[proc_num_ICC][7:0]) && (output_priority[proc_num_ICC][62]>HP_Active_Interrupt[proc_num_ICC][7:0]))//priority masking and preemption conttrol
                           begin
                               IRQ[proc_num_ICC]<=1'b1;
                           end
                           else
                           begin
                               IRQ[proc_num_ICC]<=1'b0;
                           end
                       end
                       else
                       begin
                           IRQ[proc_num_ICC]<=1'b0;
                       end
                       
                   end
                   else
                   begin
                       IRQ[proc_num_ICC]<=1'b0;
                   end
               end
           end
         end
    endgenerate
    
    
    
    integer proc_num_IAR;
    integer interrupt_number_ICC;
       //creating the values of IAR
       
       always@(*)
       begin
           for(proc_num_IAR=0;proc_num_IAR<4;proc_num_IAR=proc_num_IAR+1)
           begin
               if(enabled[proc_num_IAR][62])
               begin
                  if(output_priority[proc_num_IAR][62]>ICCPMR[proc_num_IAR][7:0] && output_priority[proc_num_IAR][62]>HP_Active_Interrupt[proc_num_IAR][7:0])//priority masking and preemption conttrol
                  begin
                      //form the interrupt acknowledge register here
                      if(HP_ID[proc_num_IAR][62]<16)//if it's a software generated interrupt
                      begin
                          for(interrupt_number_ICC=0;interrupt_number_ICC<16;interrupt_number_ICC=interrupt_number_ICC+1)
                          begin
                              if(Interrupt_IDs[interrupt_number_ICC]==HP_ID[proc_num_IAR][62])
                              begin
                                  ICCIAR[proc_num_IAR]={19'h0,SGI_CPU_regs[interrupt_number_ICC],HP_ID[proc_num_IAR][62]};//don't write into this just return this value when the interrupt acknowledge register is read
                              end
                          end
                      end
                      else//if it's a private peripheral interrupt or a shared peripheral interrupt
                      begin
                          for(interrupt_number_ICC=16;interrupt_number_ICC<64;interrupt_number_ICC=interrupt_number_ICC+1)
                          begin
                              if(Interrupt_IDs[interrupt_number_ICC]==HP_ID[proc_num_IAR][62])
                              begin
                                  ICCIAR[proc_num_IAR]={19'h0,2'b00,HP_ID[proc_num_IAR][62]};//don't write into this just return this value when the interrupt acknowledge register is read
                              end
                          end
                      end
                  end
                  else
                  begin
                        ICCIAR[proc_num_IAR]={19'd45,2'b00,HP_ID[proc_num_IAR][62]};//may be spurious interrupt
                  end
               end
               else
               begin
                    ICCIAR[proc_num_IAR]={19'd45,2'b00,HP_ID[proc_num_IAR][62]};//may be spurious interrupt
               end
           end
       end
   /* 
    genvar proc_num_IAR;
    integer interrupt_number_ICC;
       //creating the values of IAR
    generate
       for(proc_num_IAR=0;proc_num_IAR<4;proc_num_IAR=proc_num_IAR+1)
       begin
           always@(*)
           begin
              if(enabled[proc_num_IAR][62])
              begin
                  if(output_priority[proc_num_IAR][62]>ICCPMR[proc_num_IAR][7:0] && output_priority[proc_num_IAR][62]>HP_Active_Interrupt[proc_num_IAR][7:0])//priority masking and preemption conttrol
                  begin
                      //form the interrupt acknowledge register here
                      if(HP_ID[proc_num_IAR][62]<16)//if it's a software generated interrupt
                      begin
                          for(interrupt_number_ICC=0;interrupt_number_ICC<16;interrupt_number_ICC=interrupt_number_ICC+1)
                          begin
                              if(Interrupt_IDs[interrupt_number_ICC]==HP_ID[proc_num_IAR][62])
                              begin
                                  ICCIAR[proc_num_IAR]={19'h0,SGI_CPU_regs[interrupt_number_ICC],HP_ID[proc_num_IAR][62]};//don't write into this just return this value when the interrupt acknowledge register is read
                              end
                          end
                      end
                      else//if it's a private peripheral interrupt or a shared peripheral interrupt
                      begin
                          for(interrupt_number_ICC=16;interrupt_number_ICC<64;interrupt_number_ICC=interrupt_number_ICC+1)
                          begin
                              if(Interrupt_IDs[interrupt_number_ICC]==HP_ID[proc_num_IAR][62])
                              begin
                                  ICCIAR[proc_num_IAR]={19'h0,2'b00,HP_ID[proc_num_IAR][62]};//don't write into this just return this value when the interrupt acknowledge register is read
                              end
                          end
                      end
                  end
                  else
                  begin
                        ICCIAR[proc_num_IAR]={19'd45,2'b00,HP_ID[proc_num_IAR][62]};//may be spurious interrupt
                  end
               end
               else
               begin
                    ICCIAR[proc_num_IAR]={19'd45,2'b00,HP_ID[proc_num_IAR][62]};//may be spurious interrupt
               end
           end
       end
    endgenerate
       
       */
    integer CPU_nu;
    always@(posedge clk or negedge reset)
    begin
        if(!reset)
        begin
            for(CPU_nu=0;CPU_nu<4;CPU_nu=CPU_nu+1)
            begin
                ICCRPR[CPU_nu]=32'h00000000;
            end
        end
        else
        begin
            for(CPU_nu=0;CPU_nu<2;CPU_nu=CPU_nu+1)
            begin
                ICCRPR[CPU_nu]=HP_Active_Interrupt[CPU_nu];
            end
        end
    end
    
    /*
    integer interrupt_number_ICC;
    //CPU Interface logic for processor 0 while signalling itself write to the IAR register
    always@(posedge clk)
    begin
        if(ICCICR[0])//check if the CPU interface is enabled
        begin
            if(enabled[62])
            begin
                if(output_priority[62]<ICCPMR0[7:0] && output_priority[62]<ICCRPR0[7:0])//priority masking and preemption conttrol
                begin
                    IRQ0<=1'b1;
                    //form the interrupt acknowledge register here
                    if(HP_ID[62]<16)//if it's a software generated interrupt
                    begin
                        for(interrupt_number_ICC=0;interrupt_number_ICC<16;interrupt_number_ICC=interrupt_number_ICC+1)
                        begin
                            if(Interrupt_IDs[interrupt_number_ICC]==HP_ID[62])
                            begin
                                ICCIAR0<={19'h0,SGI_CPU_regs[interrupt_number_ICC],HP_ID[62]};
                            end
                        end
                    end
                    else//if it's a private peripheral interrupt or a shared peripheral interrupt
                    begin
                        for(interrupt_number_ICC=16;interrupt_number_ICC<64;interrupt_number_ICC=interrupt_number_ICC+1)
                        begin
                            if(Interrupt_IDs[interrupt_number_ICC]==HP_ID[62])
                            begin
                                ICCIAR0<={19'h0,2'b00,HP_ID[62]};
                            end
                        end
                    end
                end
                else
                begin
                    IRQ0=1'b0;
                end
            end
            else
            begin
                IRQ0=1'b0;
            end
            
        end
        else
        begin
            IRQ0=1'b0;
        end
    end*/
   integer p_number; 
   task IC_reset;
       begin
            ICDDCR=1'b1;
            for(p_number=0;p_number<4;p_number=p_number+1)
            begin
                ICDISER[p_number]=32'hFFFFFFFF;
                ICDIPR[p_number][0]=32'hF0F1F2F3;
                ICDIPR[p_number][1]=32'hF4F5F6F7;
                ICDIPR[p_number][2]=32'hE0E1E2E3;
                ICDIPR[p_number][3]=32'hE4E5E6E7;
                ICDIPR[p_number][4]=32'hE8E9EAEB;
                ICDIPR[p_number][5]=32'hD0D1D2D3;
                ICDIPR[p_number][6]=32'hD4D5D6D7;
                ICDIPR[p_number][7]=32'hD8D9DADB;
                
                //all are for first procesor
                ICDIPTR[p_number][0]=32'h01010101;
                ICDIPTR[p_number][1]=32'h01010101;
                ICDIPTR[p_number][2]=32'h01010101;
                ICDIPTR[p_number][3]=32'h01010101;
                ICDIPTR[p_number][4]=32'h01010101;
                ICDIPTR[p_number][5]=32'h01010101;
                ICDIPTR[p_number][6]=32'h01010101;
                ICDIPTR[p_number][7]=32'h01010101;
                
                //let's say all are edge triggerred
                ICDICFR[p_number][0]=32'hAAAAAAAA;
                ICDICFR[p_number][1]=32'hAAAAAAAA;
                
               // ICCRPR[p_number]={24'd0,8'hFF};
            end
            
            
            ICDISER_S=32'hFFFFFFFF;
            ICDIPR_S[8]=32'hF0F1F2F3;
            ICDIPR_S[9]=32'hF4F5F6F7;
            ICDIPR_S[10]=32'hE0E1E2E3;
            ICDIPR_S[11]=32'hE4E5E6E7;
            ICDIPR_S[12]=32'hE8E9EAEB;
            ICDIPR_S[13]=32'hD0D1D2D3;
            ICDIPR_S[14]=32'hD4D5D6D7;
            ICDIPR_S[15]=32'hD8D9DADB;
            
            ICDIPTR_S[8]=32'h01010101;
            ICDIPTR_S[9]=32'h01010101;
            ICDIPTR_S[10]=32'h01010101;
            ICDIPTR_S[11]=32'h01010101;
            ICDIPTR_S[12]=32'h01010101;
            ICDIPTR_S[13]=32'h01010101;
            ICDIPTR_S[14]=32'h01010101;
            ICDIPTR_S[15]=32'h01010101;
            
            
            ICDICFR_S[0]=32'hAAAAAAAA;
            ICDICFR_S[1]=32'hAAAAAAAA;
            
            
            //the CPU interface registers initialization
            ICCICR=32'hFFFFFFFF;
       end     
   endtask
   
   task incrementor;
   input in1;
   output out1;
    begin
        out1=in1+1;
    end
   endtask
        
endmodule
