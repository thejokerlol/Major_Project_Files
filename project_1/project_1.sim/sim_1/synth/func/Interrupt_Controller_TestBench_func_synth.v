// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
// Date        : Wed Feb 14 16:09:12 2018
// Host        : G-TIRUPATHI running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               C:/Users/vamsi/Desktop/MAJOR_PROJECT/Major_Project_Files/project_1/project_1.sim/sim_1/synth/func/Interrupt_Controller_TestBench_func_synth.v
// Design      : AXI_to_APB
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* DATA_TRANSFERRED_STATE = "4'b0100" *) (* IDLE_STATE = "4'b0000" *) (* PENABLE_READ_SIGNAL = "4'b0111" *) 
(* PENABLE_SIGNAL = "4'b0011" *) (* READ_ADDRESS_RECEIVED_STATE = "4'b0110" *) (* READ_DATA_TRANSFERRED_STATE = "4'b1000" *) 
(* TRANSFER_COMPLETE_STATE = "4'b0101" *) (* WRITE_ADDRESS_RECEIVED_STATE = "4'b0001" *) (* WRITE_DATA_RECEIVED_STATE = "4'b0010" *) 
(* NotValidForBitStream *)
module AXI_to_APB
   (ACLK,
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
    PCLK,
    PRESET,
    PADDR,
    PSEL,
    PENABLE,
    PWRITE,
    PWDATA,
    PREADY,
    PRDATA,
    PSLVERR);
  input ACLK;
  input ARESET;
  input [31:0]ARADDR;
  input ARVALID;
  output ARREADY;
  input ARSIZE;
  input [1:0]ARLEN;
  input [31:0]AWADDR;
  input AWVALID;
  output AWREADY;
  input AWSIZE;
  input [1:0]AWLEN;
  output [31:0]RDATA;
  output RVALID;
  input RREADY;
  input [31:0]WDATA;
  input WVALID;
  output WREADY;
  output [1:0]BRESP;
  output BVALID;
  input BREADY;
  output PCLK;
  output PRESET;
  output [31:0]PADDR;
  output PSEL;
  output PENABLE;
  output PWRITE;
  output [31:0]PWDATA;
  input PREADY;
  input [31:0]PRDATA;
  input PSLVERR;

  wire ACLK;
  wire [31:0]ARADDR;
  wire [31:0]ARADDR_IBUF;
  wire ARESET;
  wire [1:0]ARLEN;
  wire [1:0]ARLEN_IBUF;
  wire ARREADY;
  wire ARVALID;
  wire ARVALID_IBUF;
  wire [31:0]AWADDR;
  wire [31:0]AWADDR_IBUF;
  wire [1:0]AWLEN;
  wire [1:0]AWLEN_IBUF;
  wire AWREADY;
  wire AWREADY_OBUF;
  wire AWVALID;
  wire AWVALID_IBUF;
  wire BREADY;
  wire BREADY_IBUF;
  wire [1:0]BRESP;
  wire \BRESP[1]_i_1_n_0 ;
  wire [0:0]BRESP_OBUF;
  wire BVALID;
  wire BVALID_OBUF;
  wire \FSM_sequential_present_state[0]_i_1_n_0 ;
  wire \FSM_sequential_present_state[0]_i_3_n_0 ;
  wire \FSM_sequential_present_state[0]_i_5_n_0 ;
  wire \FSM_sequential_present_state[0]_i_6_n_0 ;
  wire \FSM_sequential_present_state[1]_i_1_n_0 ;
  wire \FSM_sequential_present_state[1]_i_2_n_0 ;
  wire \FSM_sequential_present_state[2]_i_1_n_0 ;
  wire \FSM_sequential_present_state[2]_i_2_n_0 ;
  wire \FSM_sequential_present_state[3]_i_1_n_0 ;
  wire \FSM_sequential_present_state_reg[0]_i_4_n_0 ;
  wire [31:0]PADDR;
  wire \PADDR[31]_i_1_n_0 ;
  wire [31:0]PADDR_OBUF;
  wire PCLK;
  wire PCLK_OBUF;
  wire PCLK_OBUF_BUFG;
  wire PENABLE;
  wire PENABLE_OBUF;
  wire [31:0]PRDATA;
  wire [31:0]PRDATA_IBUF;
  wire PREADY;
  wire PREADY_IBUF;
  wire PRESET;
  wire PRESET_OBUF;
  wire PSEL;
  wire PSEL_OBUF;
  wire PSLVERR;
  wire PSLVERR_IBUF;
  wire [31:0]PWDATA;
  wire [31:0]PWDATA_OBUF;
  wire PWRITE;
  wire PWRITE_OBUF;
  wire [31:0]RDATA;
  wire RDATA0;
  wire [31:0]RDATA_OBUF;
  wire RREADY;
  wire RREADY_IBUF;
  wire RVALID;
  wire RVALID_OBUF;
  wire [31:0]WDATA;
  wire [31:0]WDATA_IBUF;
  wire WREADY;
  wire WREADY_OBUF;
  wire WVALID;
  wire WVALID_IBUF;
  wire next_state110_out;
  wire next_state2;
  wire p_0_in;
  wire [31:0]p_1_in;
  (* RTL_KEEP = "yes" *) wire [3:0]present_state;
  wire [31:0]sampled_address;
  wire [31:1]sampled_address0;
  wire sampled_address17_out;
  wire sampled_address18_out;
  wire \sampled_address[12]_i_3_n_0 ;
  wire \sampled_address[12]_i_4_n_0 ;
  wire \sampled_address[12]_i_5_n_0 ;
  wire \sampled_address[12]_i_6_n_0 ;
  wire \sampled_address[16]_i_3_n_0 ;
  wire \sampled_address[16]_i_4_n_0 ;
  wire \sampled_address[16]_i_5_n_0 ;
  wire \sampled_address[16]_i_6_n_0 ;
  wire \sampled_address[20]_i_3_n_0 ;
  wire \sampled_address[20]_i_4_n_0 ;
  wire \sampled_address[20]_i_5_n_0 ;
  wire \sampled_address[20]_i_6_n_0 ;
  wire \sampled_address[24]_i_3_n_0 ;
  wire \sampled_address[24]_i_4_n_0 ;
  wire \sampled_address[24]_i_5_n_0 ;
  wire \sampled_address[24]_i_6_n_0 ;
  wire \sampled_address[28]_i_3_n_0 ;
  wire \sampled_address[28]_i_4_n_0 ;
  wire \sampled_address[28]_i_5_n_0 ;
  wire \sampled_address[28]_i_6_n_0 ;
  wire \sampled_address[31]_i_1_n_0 ;
  wire \sampled_address[31]_i_3_n_0 ;
  wire \sampled_address[31]_i_5_n_0 ;
  wire \sampled_address[31]_i_6_n_0 ;
  wire \sampled_address[31]_i_7_n_0 ;
  wire \sampled_address[4]_i_3_n_0 ;
  wire \sampled_address[4]_i_4_n_0 ;
  wire \sampled_address[4]_i_5_n_0 ;
  wire \sampled_address[4]_i_6_n_0 ;
  wire \sampled_address[8]_i_3_n_0 ;
  wire \sampled_address[8]_i_4_n_0 ;
  wire \sampled_address[8]_i_5_n_0 ;
  wire \sampled_address[8]_i_6_n_0 ;
  wire \sampled_address_reg[12]_i_2_n_0 ;
  wire \sampled_address_reg[12]_i_2_n_1 ;
  wire \sampled_address_reg[12]_i_2_n_2 ;
  wire \sampled_address_reg[12]_i_2_n_3 ;
  wire \sampled_address_reg[16]_i_2_n_0 ;
  wire \sampled_address_reg[16]_i_2_n_1 ;
  wire \sampled_address_reg[16]_i_2_n_2 ;
  wire \sampled_address_reg[16]_i_2_n_3 ;
  wire \sampled_address_reg[20]_i_2_n_0 ;
  wire \sampled_address_reg[20]_i_2_n_1 ;
  wire \sampled_address_reg[20]_i_2_n_2 ;
  wire \sampled_address_reg[20]_i_2_n_3 ;
  wire \sampled_address_reg[24]_i_2_n_0 ;
  wire \sampled_address_reg[24]_i_2_n_1 ;
  wire \sampled_address_reg[24]_i_2_n_2 ;
  wire \sampled_address_reg[24]_i_2_n_3 ;
  wire \sampled_address_reg[28]_i_2_n_0 ;
  wire \sampled_address_reg[28]_i_2_n_1 ;
  wire \sampled_address_reg[28]_i_2_n_2 ;
  wire \sampled_address_reg[28]_i_2_n_3 ;
  wire \sampled_address_reg[31]_i_4_n_2 ;
  wire \sampled_address_reg[31]_i_4_n_3 ;
  wire \sampled_address_reg[4]_i_2_n_0 ;
  wire \sampled_address_reg[4]_i_2_n_1 ;
  wire \sampled_address_reg[4]_i_2_n_2 ;
  wire \sampled_address_reg[4]_i_2_n_3 ;
  wire \sampled_address_reg[8]_i_2_n_0 ;
  wire \sampled_address_reg[8]_i_2_n_1 ;
  wire \sampled_address_reg[8]_i_2_n_2 ;
  wire \sampled_address_reg[8]_i_2_n_3 ;
  wire [1:0]sampled_wlen;
  wire sampled_wlen1;
  wire \sampled_wlen[0]_i_1_n_0 ;
  wire \sampled_wlen[1]_i_1_n_0 ;
  wire \sampled_wlen[1]_i_2_n_0 ;
  wire [3:2]\NLW_sampled_address_reg[31]_i_4_CO_UNCONNECTED ;
  wire [3:3]\NLW_sampled_address_reg[31]_i_4_O_UNCONNECTED ;

  IBUF ACLK_IBUF_inst
       (.I(ACLK),
        .O(PCLK_OBUF));
  IBUF \ARADDR_IBUF[0]_inst 
       (.I(ARADDR[0]),
        .O(ARADDR_IBUF[0]));
  IBUF \ARADDR_IBUF[10]_inst 
       (.I(ARADDR[10]),
        .O(ARADDR_IBUF[10]));
  IBUF \ARADDR_IBUF[11]_inst 
       (.I(ARADDR[11]),
        .O(ARADDR_IBUF[11]));
  IBUF \ARADDR_IBUF[12]_inst 
       (.I(ARADDR[12]),
        .O(ARADDR_IBUF[12]));
  IBUF \ARADDR_IBUF[13]_inst 
       (.I(ARADDR[13]),
        .O(ARADDR_IBUF[13]));
  IBUF \ARADDR_IBUF[14]_inst 
       (.I(ARADDR[14]),
        .O(ARADDR_IBUF[14]));
  IBUF \ARADDR_IBUF[15]_inst 
       (.I(ARADDR[15]),
        .O(ARADDR_IBUF[15]));
  IBUF \ARADDR_IBUF[16]_inst 
       (.I(ARADDR[16]),
        .O(ARADDR_IBUF[16]));
  IBUF \ARADDR_IBUF[17]_inst 
       (.I(ARADDR[17]),
        .O(ARADDR_IBUF[17]));
  IBUF \ARADDR_IBUF[18]_inst 
       (.I(ARADDR[18]),
        .O(ARADDR_IBUF[18]));
  IBUF \ARADDR_IBUF[19]_inst 
       (.I(ARADDR[19]),
        .O(ARADDR_IBUF[19]));
  IBUF \ARADDR_IBUF[1]_inst 
       (.I(ARADDR[1]),
        .O(ARADDR_IBUF[1]));
  IBUF \ARADDR_IBUF[20]_inst 
       (.I(ARADDR[20]),
        .O(ARADDR_IBUF[20]));
  IBUF \ARADDR_IBUF[21]_inst 
       (.I(ARADDR[21]),
        .O(ARADDR_IBUF[21]));
  IBUF \ARADDR_IBUF[22]_inst 
       (.I(ARADDR[22]),
        .O(ARADDR_IBUF[22]));
  IBUF \ARADDR_IBUF[23]_inst 
       (.I(ARADDR[23]),
        .O(ARADDR_IBUF[23]));
  IBUF \ARADDR_IBUF[24]_inst 
       (.I(ARADDR[24]),
        .O(ARADDR_IBUF[24]));
  IBUF \ARADDR_IBUF[25]_inst 
       (.I(ARADDR[25]),
        .O(ARADDR_IBUF[25]));
  IBUF \ARADDR_IBUF[26]_inst 
       (.I(ARADDR[26]),
        .O(ARADDR_IBUF[26]));
  IBUF \ARADDR_IBUF[27]_inst 
       (.I(ARADDR[27]),
        .O(ARADDR_IBUF[27]));
  IBUF \ARADDR_IBUF[28]_inst 
       (.I(ARADDR[28]),
        .O(ARADDR_IBUF[28]));
  IBUF \ARADDR_IBUF[29]_inst 
       (.I(ARADDR[29]),
        .O(ARADDR_IBUF[29]));
  IBUF \ARADDR_IBUF[2]_inst 
       (.I(ARADDR[2]),
        .O(ARADDR_IBUF[2]));
  IBUF \ARADDR_IBUF[30]_inst 
       (.I(ARADDR[30]),
        .O(ARADDR_IBUF[30]));
  IBUF \ARADDR_IBUF[31]_inst 
       (.I(ARADDR[31]),
        .O(ARADDR_IBUF[31]));
  IBUF \ARADDR_IBUF[3]_inst 
       (.I(ARADDR[3]),
        .O(ARADDR_IBUF[3]));
  IBUF \ARADDR_IBUF[4]_inst 
       (.I(ARADDR[4]),
        .O(ARADDR_IBUF[4]));
  IBUF \ARADDR_IBUF[5]_inst 
       (.I(ARADDR[5]),
        .O(ARADDR_IBUF[5]));
  IBUF \ARADDR_IBUF[6]_inst 
       (.I(ARADDR[6]),
        .O(ARADDR_IBUF[6]));
  IBUF \ARADDR_IBUF[7]_inst 
       (.I(ARADDR[7]),
        .O(ARADDR_IBUF[7]));
  IBUF \ARADDR_IBUF[8]_inst 
       (.I(ARADDR[8]),
        .O(ARADDR_IBUF[8]));
  IBUF \ARADDR_IBUF[9]_inst 
       (.I(ARADDR[9]),
        .O(ARADDR_IBUF[9]));
  IBUF ARESET_IBUF_inst
       (.I(ARESET),
        .O(PRESET_OBUF));
  IBUF \ARLEN_IBUF[0]_inst 
       (.I(ARLEN[0]),
        .O(ARLEN_IBUF[0]));
  IBUF \ARLEN_IBUF[1]_inst 
       (.I(ARLEN[1]),
        .O(ARLEN_IBUF[1]));
  OBUF ARREADY_OBUF_inst
       (.I(AWREADY_OBUF),
        .O(ARREADY));
  LUT4 #(
    .INIT(16'h0001)) 
    ARREADY_OBUF_inst_i_1
       (.I0(present_state[3]),
        .I1(present_state[2]),
        .I2(present_state[0]),
        .I3(present_state[1]),
        .O(AWREADY_OBUF));
  IBUF ARVALID_IBUF_inst
       (.I(ARVALID),
        .O(ARVALID_IBUF));
  IBUF \AWADDR_IBUF[0]_inst 
       (.I(AWADDR[0]),
        .O(AWADDR_IBUF[0]));
  IBUF \AWADDR_IBUF[10]_inst 
       (.I(AWADDR[10]),
        .O(AWADDR_IBUF[10]));
  IBUF \AWADDR_IBUF[11]_inst 
       (.I(AWADDR[11]),
        .O(AWADDR_IBUF[11]));
  IBUF \AWADDR_IBUF[12]_inst 
       (.I(AWADDR[12]),
        .O(AWADDR_IBUF[12]));
  IBUF \AWADDR_IBUF[13]_inst 
       (.I(AWADDR[13]),
        .O(AWADDR_IBUF[13]));
  IBUF \AWADDR_IBUF[14]_inst 
       (.I(AWADDR[14]),
        .O(AWADDR_IBUF[14]));
  IBUF \AWADDR_IBUF[15]_inst 
       (.I(AWADDR[15]),
        .O(AWADDR_IBUF[15]));
  IBUF \AWADDR_IBUF[16]_inst 
       (.I(AWADDR[16]),
        .O(AWADDR_IBUF[16]));
  IBUF \AWADDR_IBUF[17]_inst 
       (.I(AWADDR[17]),
        .O(AWADDR_IBUF[17]));
  IBUF \AWADDR_IBUF[18]_inst 
       (.I(AWADDR[18]),
        .O(AWADDR_IBUF[18]));
  IBUF \AWADDR_IBUF[19]_inst 
       (.I(AWADDR[19]),
        .O(AWADDR_IBUF[19]));
  IBUF \AWADDR_IBUF[1]_inst 
       (.I(AWADDR[1]),
        .O(AWADDR_IBUF[1]));
  IBUF \AWADDR_IBUF[20]_inst 
       (.I(AWADDR[20]),
        .O(AWADDR_IBUF[20]));
  IBUF \AWADDR_IBUF[21]_inst 
       (.I(AWADDR[21]),
        .O(AWADDR_IBUF[21]));
  IBUF \AWADDR_IBUF[22]_inst 
       (.I(AWADDR[22]),
        .O(AWADDR_IBUF[22]));
  IBUF \AWADDR_IBUF[23]_inst 
       (.I(AWADDR[23]),
        .O(AWADDR_IBUF[23]));
  IBUF \AWADDR_IBUF[24]_inst 
       (.I(AWADDR[24]),
        .O(AWADDR_IBUF[24]));
  IBUF \AWADDR_IBUF[25]_inst 
       (.I(AWADDR[25]),
        .O(AWADDR_IBUF[25]));
  IBUF \AWADDR_IBUF[26]_inst 
       (.I(AWADDR[26]),
        .O(AWADDR_IBUF[26]));
  IBUF \AWADDR_IBUF[27]_inst 
       (.I(AWADDR[27]),
        .O(AWADDR_IBUF[27]));
  IBUF \AWADDR_IBUF[28]_inst 
       (.I(AWADDR[28]),
        .O(AWADDR_IBUF[28]));
  IBUF \AWADDR_IBUF[29]_inst 
       (.I(AWADDR[29]),
        .O(AWADDR_IBUF[29]));
  IBUF \AWADDR_IBUF[2]_inst 
       (.I(AWADDR[2]),
        .O(AWADDR_IBUF[2]));
  IBUF \AWADDR_IBUF[30]_inst 
       (.I(AWADDR[30]),
        .O(AWADDR_IBUF[30]));
  IBUF \AWADDR_IBUF[31]_inst 
       (.I(AWADDR[31]),
        .O(AWADDR_IBUF[31]));
  IBUF \AWADDR_IBUF[3]_inst 
       (.I(AWADDR[3]),
        .O(AWADDR_IBUF[3]));
  IBUF \AWADDR_IBUF[4]_inst 
       (.I(AWADDR[4]),
        .O(AWADDR_IBUF[4]));
  IBUF \AWADDR_IBUF[5]_inst 
       (.I(AWADDR[5]),
        .O(AWADDR_IBUF[5]));
  IBUF \AWADDR_IBUF[6]_inst 
       (.I(AWADDR[6]),
        .O(AWADDR_IBUF[6]));
  IBUF \AWADDR_IBUF[7]_inst 
       (.I(AWADDR[7]),
        .O(AWADDR_IBUF[7]));
  IBUF \AWADDR_IBUF[8]_inst 
       (.I(AWADDR[8]),
        .O(AWADDR_IBUF[8]));
  IBUF \AWADDR_IBUF[9]_inst 
       (.I(AWADDR[9]),
        .O(AWADDR_IBUF[9]));
  IBUF \AWLEN_IBUF[0]_inst 
       (.I(AWLEN[0]),
        .O(AWLEN_IBUF[0]));
  IBUF \AWLEN_IBUF[1]_inst 
       (.I(AWLEN[1]),
        .O(AWLEN_IBUF[1]));
  OBUF AWREADY_OBUF_inst
       (.I(AWREADY_OBUF),
        .O(AWREADY));
  IBUF AWVALID_IBUF_inst
       (.I(AWVALID),
        .O(AWVALID_IBUF));
  IBUF BREADY_IBUF_inst
       (.I(BREADY),
        .O(BREADY_IBUF));
  LUT6 #(
    .INIT(64'h0000000000080000)) 
    \BRESP[1]_i_1 
       (.I0(PSLVERR_IBUF),
        .I1(\sampled_address[31]_i_3_n_0 ),
        .I2(present_state[0]),
        .I3(present_state[1]),
        .I4(PREADY_IBUF),
        .I5(BRESP_OBUF),
        .O(\BRESP[1]_i_1_n_0 ));
  OBUF \BRESP_OBUF[0]_inst 
       (.I(BRESP_OBUF),
        .O(BRESP[0]));
  OBUF \BRESP_OBUF[1]_inst 
       (.I(BRESP_OBUF),
        .O(BRESP[1]));
  FDRE #(
    .INIT(1'b0)) 
    \BRESP_reg[1] 
       (.C(PCLK_OBUF_BUFG),
        .CE(1'b1),
        .D(\BRESP[1]_i_1_n_0 ),
        .Q(BRESP_OBUF),
        .R(1'b0));
  OBUF BVALID_OBUF_inst
       (.I(BVALID_OBUF),
        .O(BVALID));
  LUT4 #(
    .INIT(16'h1000)) 
    BVALID_OBUF_inst_i_1
       (.I0(present_state[3]),
        .I1(present_state[0]),
        .I2(present_state[1]),
        .I3(present_state[2]),
        .O(BVALID_OBUF));
  LUT6 #(
    .INIT(64'h0020FFFF00200000)) 
    \FSM_sequential_present_state[0]_i_1 
       (.I0(next_state2),
        .I1(present_state[0]),
        .I2(RREADY_IBUF),
        .I3(\FSM_sequential_present_state[0]_i_3_n_0 ),
        .I4(present_state[3]),
        .I5(\FSM_sequential_present_state_reg[0]_i_4_n_0 ),
        .O(\FSM_sequential_present_state[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_sequential_present_state[0]_i_2 
       (.I0(sampled_wlen[1]),
        .I1(sampled_wlen[0]),
        .O(next_state2));
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_sequential_present_state[0]_i_3 
       (.I0(present_state[1]),
        .I1(present_state[2]),
        .O(\FSM_sequential_present_state[0]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h3B38)) 
    \FSM_sequential_present_state[0]_i_5 
       (.I0(WVALID_IBUF),
        .I1(present_state[1]),
        .I2(present_state[0]),
        .I3(ARVALID_IBUF),
        .O(\FSM_sequential_present_state[0]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h00F0EFE0)) 
    \FSM_sequential_present_state[0]_i_6 
       (.I0(sampled_wlen[1]),
        .I1(sampled_wlen[0]),
        .I2(present_state[0]),
        .I3(PREADY_IBUF),
        .I4(present_state[1]),
        .O(\FSM_sequential_present_state[0]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h4444444444454444)) 
    \FSM_sequential_present_state[1]_i_1 
       (.I0(present_state[3]),
        .I1(\FSM_sequential_present_state[1]_i_2_n_0 ),
        .I2(present_state[2]),
        .I3(present_state[1]),
        .I4(AWVALID_IBUF),
        .I5(ARVALID_IBUF),
        .O(\FSM_sequential_present_state[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h50300FF05F300FF0)) 
    \FSM_sequential_present_state[1]_i_2 
       (.I0(PREADY_IBUF),
        .I1(next_state110_out),
        .I2(present_state[0]),
        .I3(present_state[1]),
        .I4(present_state[2]),
        .I5(BREADY_IBUF),
        .O(\FSM_sequential_present_state[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h0E)) 
    \FSM_sequential_present_state[1]_i_3 
       (.I0(sampled_wlen[0]),
        .I1(sampled_wlen[1]),
        .I2(WVALID_IBUF),
        .O(next_state110_out));
  LUT6 #(
    .INIT(64'h1111111100101010)) 
    \FSM_sequential_present_state[2]_i_1 
       (.I0(present_state[3]),
        .I1(\FSM_sequential_present_state[2]_i_2_n_0 ),
        .I2(present_state[2]),
        .I3(BREADY_IBUF),
        .I4(present_state[1]),
        .I5(present_state[0]),
        .O(\FSM_sequential_present_state[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h88880000C0000000)) 
    \FSM_sequential_present_state[2]_i_2 
       (.I0(PREADY_IBUF),
        .I1(present_state[2]),
        .I2(WVALID_IBUF),
        .I3(next_state2),
        .I4(present_state[0]),
        .I5(present_state[1]),
        .O(\FSM_sequential_present_state[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000C00000110000)) 
    \FSM_sequential_present_state[3]_i_1 
       (.I0(RREADY_IBUF),
        .I1(present_state[0]),
        .I2(PREADY_IBUF),
        .I3(present_state[2]),
        .I4(present_state[3]),
        .I5(present_state[1]),
        .O(\FSM_sequential_present_state[3]_i_1_n_0 ));
  (* KEEP = "yes" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_sequential_present_state_reg[0] 
       (.C(PCLK_OBUF_BUFG),
        .CE(1'b1),
        .CLR(PRESET_OBUF),
        .D(\FSM_sequential_present_state[0]_i_1_n_0 ),
        .Q(present_state[0]));
  MUXF7 \FSM_sequential_present_state_reg[0]_i_4 
       (.I0(\FSM_sequential_present_state[0]_i_5_n_0 ),
        .I1(\FSM_sequential_present_state[0]_i_6_n_0 ),
        .O(\FSM_sequential_present_state_reg[0]_i_4_n_0 ),
        .S(present_state[2]));
  (* KEEP = "yes" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_sequential_present_state_reg[1] 
       (.C(PCLK_OBUF_BUFG),
        .CE(1'b1),
        .CLR(PRESET_OBUF),
        .D(\FSM_sequential_present_state[1]_i_1_n_0 ),
        .Q(present_state[1]));
  (* KEEP = "yes" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_sequential_present_state_reg[2] 
       (.C(PCLK_OBUF_BUFG),
        .CE(1'b1),
        .CLR(PRESET_OBUF),
        .D(\FSM_sequential_present_state[2]_i_1_n_0 ),
        .Q(present_state[2]));
  (* KEEP = "yes" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_sequential_present_state_reg[3] 
       (.C(PCLK_OBUF_BUFG),
        .CE(1'b1),
        .CLR(PRESET_OBUF),
        .D(\FSM_sequential_present_state[3]_i_1_n_0 ),
        .Q(present_state[3]));
  LUT5 #(
    .INIT(32'h01180010)) 
    \PADDR[31]_i_1 
       (.I0(present_state[2]),
        .I1(present_state[0]),
        .I2(present_state[3]),
        .I3(present_state[1]),
        .I4(WVALID_IBUF),
        .O(\PADDR[31]_i_1_n_0 ));
  OBUF \PADDR_OBUF[0]_inst 
       (.I(PADDR_OBUF[0]),
        .O(PADDR[0]));
  OBUF \PADDR_OBUF[10]_inst 
       (.I(PADDR_OBUF[10]),
        .O(PADDR[10]));
  OBUF \PADDR_OBUF[11]_inst 
       (.I(PADDR_OBUF[11]),
        .O(PADDR[11]));
  OBUF \PADDR_OBUF[12]_inst 
       (.I(PADDR_OBUF[12]),
        .O(PADDR[12]));
  OBUF \PADDR_OBUF[13]_inst 
       (.I(PADDR_OBUF[13]),
        .O(PADDR[13]));
  OBUF \PADDR_OBUF[14]_inst 
       (.I(PADDR_OBUF[14]),
        .O(PADDR[14]));
  OBUF \PADDR_OBUF[15]_inst 
       (.I(PADDR_OBUF[15]),
        .O(PADDR[15]));
  OBUF \PADDR_OBUF[16]_inst 
       (.I(PADDR_OBUF[16]),
        .O(PADDR[16]));
  OBUF \PADDR_OBUF[17]_inst 
       (.I(PADDR_OBUF[17]),
        .O(PADDR[17]));
  OBUF \PADDR_OBUF[18]_inst 
       (.I(PADDR_OBUF[18]),
        .O(PADDR[18]));
  OBUF \PADDR_OBUF[19]_inst 
       (.I(PADDR_OBUF[19]),
        .O(PADDR[19]));
  OBUF \PADDR_OBUF[1]_inst 
       (.I(PADDR_OBUF[1]),
        .O(PADDR[1]));
  OBUF \PADDR_OBUF[20]_inst 
       (.I(PADDR_OBUF[20]),
        .O(PADDR[20]));
  OBUF \PADDR_OBUF[21]_inst 
       (.I(PADDR_OBUF[21]),
        .O(PADDR[21]));
  OBUF \PADDR_OBUF[22]_inst 
       (.I(PADDR_OBUF[22]),
        .O(PADDR[22]));
  OBUF \PADDR_OBUF[23]_inst 
       (.I(PADDR_OBUF[23]),
        .O(PADDR[23]));
  OBUF \PADDR_OBUF[24]_inst 
       (.I(PADDR_OBUF[24]),
        .O(PADDR[24]));
  OBUF \PADDR_OBUF[25]_inst 
       (.I(PADDR_OBUF[25]),
        .O(PADDR[25]));
  OBUF \PADDR_OBUF[26]_inst 
       (.I(PADDR_OBUF[26]),
        .O(PADDR[26]));
  OBUF \PADDR_OBUF[27]_inst 
       (.I(PADDR_OBUF[27]),
        .O(PADDR[27]));
  OBUF \PADDR_OBUF[28]_inst 
       (.I(PADDR_OBUF[28]),
        .O(PADDR[28]));
  OBUF \PADDR_OBUF[29]_inst 
       (.I(PADDR_OBUF[29]),
        .O(PADDR[29]));
  OBUF \PADDR_OBUF[2]_inst 
       (.I(PADDR_OBUF[2]),
        .O(PADDR[2]));
  OBUF \PADDR_OBUF[30]_inst 
       (.I(PADDR_OBUF[30]),
        .O(PADDR[30]));
  OBUF \PADDR_OBUF[31]_inst 
       (.I(PADDR_OBUF[31]),
        .O(PADDR[31]));
  OBUF \PADDR_OBUF[3]_inst 
       (.I(PADDR_OBUF[3]),
        .O(PADDR[3]));
  OBUF \PADDR_OBUF[4]_inst 
       (.I(PADDR_OBUF[4]),
        .O(PADDR[4]));
  OBUF \PADDR_OBUF[5]_inst 
       (.I(PADDR_OBUF[5]),
        .O(PADDR[5]));
  OBUF \PADDR_OBUF[6]_inst 
       (.I(PADDR_OBUF[6]),
        .O(PADDR[6]));
  OBUF \PADDR_OBUF[7]_inst 
       (.I(PADDR_OBUF[7]),
        .O(PADDR[7]));
  OBUF \PADDR_OBUF[8]_inst 
       (.I(PADDR_OBUF[8]),
        .O(PADDR[8]));
  OBUF \PADDR_OBUF[9]_inst 
       (.I(PADDR_OBUF[9]),
        .O(PADDR[9]));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[0] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[0]),
        .Q(PADDR_OBUF[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[10] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[10]),
        .Q(PADDR_OBUF[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[11] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[11]),
        .Q(PADDR_OBUF[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[12] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[12]),
        .Q(PADDR_OBUF[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[13] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[13]),
        .Q(PADDR_OBUF[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[14] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[14]),
        .Q(PADDR_OBUF[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[15] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[15]),
        .Q(PADDR_OBUF[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[16] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[16]),
        .Q(PADDR_OBUF[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[17] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[17]),
        .Q(PADDR_OBUF[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[18] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[18]),
        .Q(PADDR_OBUF[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[19] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[19]),
        .Q(PADDR_OBUF[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[1] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[1]),
        .Q(PADDR_OBUF[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[20] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[20]),
        .Q(PADDR_OBUF[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[21] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[21]),
        .Q(PADDR_OBUF[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[22] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[22]),
        .Q(PADDR_OBUF[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[23] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[23]),
        .Q(PADDR_OBUF[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[24] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[24]),
        .Q(PADDR_OBUF[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[25] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[25]),
        .Q(PADDR_OBUF[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[26] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[26]),
        .Q(PADDR_OBUF[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[27] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[27]),
        .Q(PADDR_OBUF[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[28] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[28]),
        .Q(PADDR_OBUF[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[29] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[29]),
        .Q(PADDR_OBUF[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[2] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[2]),
        .Q(PADDR_OBUF[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[30] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[30]),
        .Q(PADDR_OBUF[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[31] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[31]),
        .Q(PADDR_OBUF[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[3] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[3]),
        .Q(PADDR_OBUF[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[4] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[4]),
        .Q(PADDR_OBUF[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[5] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[5]),
        .Q(PADDR_OBUF[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[6] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[6]),
        .Q(PADDR_OBUF[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[7] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[7]),
        .Q(PADDR_OBUF[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[8] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[8]),
        .Q(PADDR_OBUF[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PADDR_reg[9] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\PADDR[31]_i_1_n_0 ),
        .D(sampled_address[9]),
        .Q(PADDR_OBUF[9]),
        .R(1'b0));
  BUFG PCLK_OBUF_BUFG_inst
       (.I(PCLK_OBUF),
        .O(PCLK_OBUF_BUFG));
  OBUF PCLK_OBUF_inst
       (.I(PCLK_OBUF_BUFG),
        .O(PCLK));
  OBUF PENABLE_OBUF_inst
       (.I(PENABLE_OBUF),
        .O(PENABLE));
  LUT4 #(
    .INIT(16'h4004)) 
    PENABLE_OBUF_inst_i_1
       (.I0(present_state[3]),
        .I1(present_state[2]),
        .I2(present_state[0]),
        .I3(present_state[1]),
        .O(PENABLE_OBUF));
  IBUF \PRDATA_IBUF[0]_inst 
       (.I(PRDATA[0]),
        .O(PRDATA_IBUF[0]));
  IBUF \PRDATA_IBUF[10]_inst 
       (.I(PRDATA[10]),
        .O(PRDATA_IBUF[10]));
  IBUF \PRDATA_IBUF[11]_inst 
       (.I(PRDATA[11]),
        .O(PRDATA_IBUF[11]));
  IBUF \PRDATA_IBUF[12]_inst 
       (.I(PRDATA[12]),
        .O(PRDATA_IBUF[12]));
  IBUF \PRDATA_IBUF[13]_inst 
       (.I(PRDATA[13]),
        .O(PRDATA_IBUF[13]));
  IBUF \PRDATA_IBUF[14]_inst 
       (.I(PRDATA[14]),
        .O(PRDATA_IBUF[14]));
  IBUF \PRDATA_IBUF[15]_inst 
       (.I(PRDATA[15]),
        .O(PRDATA_IBUF[15]));
  IBUF \PRDATA_IBUF[16]_inst 
       (.I(PRDATA[16]),
        .O(PRDATA_IBUF[16]));
  IBUF \PRDATA_IBUF[17]_inst 
       (.I(PRDATA[17]),
        .O(PRDATA_IBUF[17]));
  IBUF \PRDATA_IBUF[18]_inst 
       (.I(PRDATA[18]),
        .O(PRDATA_IBUF[18]));
  IBUF \PRDATA_IBUF[19]_inst 
       (.I(PRDATA[19]),
        .O(PRDATA_IBUF[19]));
  IBUF \PRDATA_IBUF[1]_inst 
       (.I(PRDATA[1]),
        .O(PRDATA_IBUF[1]));
  IBUF \PRDATA_IBUF[20]_inst 
       (.I(PRDATA[20]),
        .O(PRDATA_IBUF[20]));
  IBUF \PRDATA_IBUF[21]_inst 
       (.I(PRDATA[21]),
        .O(PRDATA_IBUF[21]));
  IBUF \PRDATA_IBUF[22]_inst 
       (.I(PRDATA[22]),
        .O(PRDATA_IBUF[22]));
  IBUF \PRDATA_IBUF[23]_inst 
       (.I(PRDATA[23]),
        .O(PRDATA_IBUF[23]));
  IBUF \PRDATA_IBUF[24]_inst 
       (.I(PRDATA[24]),
        .O(PRDATA_IBUF[24]));
  IBUF \PRDATA_IBUF[25]_inst 
       (.I(PRDATA[25]),
        .O(PRDATA_IBUF[25]));
  IBUF \PRDATA_IBUF[26]_inst 
       (.I(PRDATA[26]),
        .O(PRDATA_IBUF[26]));
  IBUF \PRDATA_IBUF[27]_inst 
       (.I(PRDATA[27]),
        .O(PRDATA_IBUF[27]));
  IBUF \PRDATA_IBUF[28]_inst 
       (.I(PRDATA[28]),
        .O(PRDATA_IBUF[28]));
  IBUF \PRDATA_IBUF[29]_inst 
       (.I(PRDATA[29]),
        .O(PRDATA_IBUF[29]));
  IBUF \PRDATA_IBUF[2]_inst 
       (.I(PRDATA[2]),
        .O(PRDATA_IBUF[2]));
  IBUF \PRDATA_IBUF[30]_inst 
       (.I(PRDATA[30]),
        .O(PRDATA_IBUF[30]));
  IBUF \PRDATA_IBUF[31]_inst 
       (.I(PRDATA[31]),
        .O(PRDATA_IBUF[31]));
  IBUF \PRDATA_IBUF[3]_inst 
       (.I(PRDATA[3]),
        .O(PRDATA_IBUF[3]));
  IBUF \PRDATA_IBUF[4]_inst 
       (.I(PRDATA[4]),
        .O(PRDATA_IBUF[4]));
  IBUF \PRDATA_IBUF[5]_inst 
       (.I(PRDATA[5]),
        .O(PRDATA_IBUF[5]));
  IBUF \PRDATA_IBUF[6]_inst 
       (.I(PRDATA[6]),
        .O(PRDATA_IBUF[6]));
  IBUF \PRDATA_IBUF[7]_inst 
       (.I(PRDATA[7]),
        .O(PRDATA_IBUF[7]));
  IBUF \PRDATA_IBUF[8]_inst 
       (.I(PRDATA[8]),
        .O(PRDATA_IBUF[8]));
  IBUF \PRDATA_IBUF[9]_inst 
       (.I(PRDATA[9]),
        .O(PRDATA_IBUF[9]));
  IBUF PREADY_IBUF_inst
       (.I(PREADY),
        .O(PREADY_IBUF));
  OBUF PRESET_OBUF_inst
       (.I(PRESET_OBUF),
        .O(PRESET));
  OBUF PSEL_OBUF_inst
       (.I(PSEL_OBUF),
        .O(PSEL));
  LUT4 #(
    .INIT(16'h4544)) 
    PSEL_OBUF_inst_i_1
       (.I0(present_state[3]),
        .I1(present_state[0]),
        .I2(present_state[1]),
        .I3(present_state[2]),
        .O(PSEL_OBUF));
  IBUF PSLVERR_IBUF_inst
       (.I(PSLVERR),
        .O(PSLVERR_IBUF));
  LUT5 #(
    .INIT(32'h02000008)) 
    \PWDATA[31]_i_1 
       (.I0(WVALID_IBUF),
        .I1(present_state[1]),
        .I2(present_state[3]),
        .I3(present_state[0]),
        .I4(present_state[2]),
        .O(p_0_in));
  OBUF \PWDATA_OBUF[0]_inst 
       (.I(PWDATA_OBUF[0]),
        .O(PWDATA[0]));
  OBUF \PWDATA_OBUF[10]_inst 
       (.I(PWDATA_OBUF[10]),
        .O(PWDATA[10]));
  OBUF \PWDATA_OBUF[11]_inst 
       (.I(PWDATA_OBUF[11]),
        .O(PWDATA[11]));
  OBUF \PWDATA_OBUF[12]_inst 
       (.I(PWDATA_OBUF[12]),
        .O(PWDATA[12]));
  OBUF \PWDATA_OBUF[13]_inst 
       (.I(PWDATA_OBUF[13]),
        .O(PWDATA[13]));
  OBUF \PWDATA_OBUF[14]_inst 
       (.I(PWDATA_OBUF[14]),
        .O(PWDATA[14]));
  OBUF \PWDATA_OBUF[15]_inst 
       (.I(PWDATA_OBUF[15]),
        .O(PWDATA[15]));
  OBUF \PWDATA_OBUF[16]_inst 
       (.I(PWDATA_OBUF[16]),
        .O(PWDATA[16]));
  OBUF \PWDATA_OBUF[17]_inst 
       (.I(PWDATA_OBUF[17]),
        .O(PWDATA[17]));
  OBUF \PWDATA_OBUF[18]_inst 
       (.I(PWDATA_OBUF[18]),
        .O(PWDATA[18]));
  OBUF \PWDATA_OBUF[19]_inst 
       (.I(PWDATA_OBUF[19]),
        .O(PWDATA[19]));
  OBUF \PWDATA_OBUF[1]_inst 
       (.I(PWDATA_OBUF[1]),
        .O(PWDATA[1]));
  OBUF \PWDATA_OBUF[20]_inst 
       (.I(PWDATA_OBUF[20]),
        .O(PWDATA[20]));
  OBUF \PWDATA_OBUF[21]_inst 
       (.I(PWDATA_OBUF[21]),
        .O(PWDATA[21]));
  OBUF \PWDATA_OBUF[22]_inst 
       (.I(PWDATA_OBUF[22]),
        .O(PWDATA[22]));
  OBUF \PWDATA_OBUF[23]_inst 
       (.I(PWDATA_OBUF[23]),
        .O(PWDATA[23]));
  OBUF \PWDATA_OBUF[24]_inst 
       (.I(PWDATA_OBUF[24]),
        .O(PWDATA[24]));
  OBUF \PWDATA_OBUF[25]_inst 
       (.I(PWDATA_OBUF[25]),
        .O(PWDATA[25]));
  OBUF \PWDATA_OBUF[26]_inst 
       (.I(PWDATA_OBUF[26]),
        .O(PWDATA[26]));
  OBUF \PWDATA_OBUF[27]_inst 
       (.I(PWDATA_OBUF[27]),
        .O(PWDATA[27]));
  OBUF \PWDATA_OBUF[28]_inst 
       (.I(PWDATA_OBUF[28]),
        .O(PWDATA[28]));
  OBUF \PWDATA_OBUF[29]_inst 
       (.I(PWDATA_OBUF[29]),
        .O(PWDATA[29]));
  OBUF \PWDATA_OBUF[2]_inst 
       (.I(PWDATA_OBUF[2]),
        .O(PWDATA[2]));
  OBUF \PWDATA_OBUF[30]_inst 
       (.I(PWDATA_OBUF[30]),
        .O(PWDATA[30]));
  OBUF \PWDATA_OBUF[31]_inst 
       (.I(PWDATA_OBUF[31]),
        .O(PWDATA[31]));
  OBUF \PWDATA_OBUF[3]_inst 
       (.I(PWDATA_OBUF[3]),
        .O(PWDATA[3]));
  OBUF \PWDATA_OBUF[4]_inst 
       (.I(PWDATA_OBUF[4]),
        .O(PWDATA[4]));
  OBUF \PWDATA_OBUF[5]_inst 
       (.I(PWDATA_OBUF[5]),
        .O(PWDATA[5]));
  OBUF \PWDATA_OBUF[6]_inst 
       (.I(PWDATA_OBUF[6]),
        .O(PWDATA[6]));
  OBUF \PWDATA_OBUF[7]_inst 
       (.I(PWDATA_OBUF[7]),
        .O(PWDATA[7]));
  OBUF \PWDATA_OBUF[8]_inst 
       (.I(PWDATA_OBUF[8]),
        .O(PWDATA[8]));
  OBUF \PWDATA_OBUF[9]_inst 
       (.I(PWDATA_OBUF[9]),
        .O(PWDATA[9]));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[0] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[0]),
        .Q(PWDATA_OBUF[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[10] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[10]),
        .Q(PWDATA_OBUF[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[11] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[11]),
        .Q(PWDATA_OBUF[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[12] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[12]),
        .Q(PWDATA_OBUF[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[13] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[13]),
        .Q(PWDATA_OBUF[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[14] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[14]),
        .Q(PWDATA_OBUF[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[15] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[15]),
        .Q(PWDATA_OBUF[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[16] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[16]),
        .Q(PWDATA_OBUF[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[17] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[17]),
        .Q(PWDATA_OBUF[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[18] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[18]),
        .Q(PWDATA_OBUF[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[19] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[19]),
        .Q(PWDATA_OBUF[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[1] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[1]),
        .Q(PWDATA_OBUF[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[20] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[20]),
        .Q(PWDATA_OBUF[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[21] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[21]),
        .Q(PWDATA_OBUF[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[22] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[22]),
        .Q(PWDATA_OBUF[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[23] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[23]),
        .Q(PWDATA_OBUF[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[24] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[24]),
        .Q(PWDATA_OBUF[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[25] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[25]),
        .Q(PWDATA_OBUF[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[26] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[26]),
        .Q(PWDATA_OBUF[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[27] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[27]),
        .Q(PWDATA_OBUF[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[28] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[28]),
        .Q(PWDATA_OBUF[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[29] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[29]),
        .Q(PWDATA_OBUF[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[2] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[2]),
        .Q(PWDATA_OBUF[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[30] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[30]),
        .Q(PWDATA_OBUF[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[31] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[31]),
        .Q(PWDATA_OBUF[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[3] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[3]),
        .Q(PWDATA_OBUF[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[4] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[4]),
        .Q(PWDATA_OBUF[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[5] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[5]),
        .Q(PWDATA_OBUF[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[6] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[6]),
        .Q(PWDATA_OBUF[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[7] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[7]),
        .Q(PWDATA_OBUF[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[8] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[8]),
        .Q(PWDATA_OBUF[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \PWDATA_reg[9] 
       (.C(PCLK_OBUF_BUFG),
        .CE(p_0_in),
        .D(WDATA_IBUF[9]),
        .Q(PWDATA_OBUF[9]),
        .R(1'b0));
  OBUF PWRITE_OBUF_inst
       (.I(PWRITE_OBUF),
        .O(PWRITE));
  LUT4 #(
    .INIT(16'h0062)) 
    PWRITE_OBUF_inst_i_1
       (.I0(present_state[2]),
        .I1(present_state[1]),
        .I2(present_state[0]),
        .I3(present_state[3]),
        .O(PWRITE_OBUF));
  LUT6 #(
    .INIT(64'h0000000008000000)) 
    \RDATA[31]_i_1 
       (.I0(present_state[1]),
        .I1(present_state[2]),
        .I2(present_state[3]),
        .I3(present_state[0]),
        .I4(PREADY_IBUF),
        .I5(PSLVERR_IBUF),
        .O(RDATA0));
  OBUF \RDATA_OBUF[0]_inst 
       (.I(RDATA_OBUF[0]),
        .O(RDATA[0]));
  OBUF \RDATA_OBUF[10]_inst 
       (.I(RDATA_OBUF[10]),
        .O(RDATA[10]));
  OBUF \RDATA_OBUF[11]_inst 
       (.I(RDATA_OBUF[11]),
        .O(RDATA[11]));
  OBUF \RDATA_OBUF[12]_inst 
       (.I(RDATA_OBUF[12]),
        .O(RDATA[12]));
  OBUF \RDATA_OBUF[13]_inst 
       (.I(RDATA_OBUF[13]),
        .O(RDATA[13]));
  OBUF \RDATA_OBUF[14]_inst 
       (.I(RDATA_OBUF[14]),
        .O(RDATA[14]));
  OBUF \RDATA_OBUF[15]_inst 
       (.I(RDATA_OBUF[15]),
        .O(RDATA[15]));
  OBUF \RDATA_OBUF[16]_inst 
       (.I(RDATA_OBUF[16]),
        .O(RDATA[16]));
  OBUF \RDATA_OBUF[17]_inst 
       (.I(RDATA_OBUF[17]),
        .O(RDATA[17]));
  OBUF \RDATA_OBUF[18]_inst 
       (.I(RDATA_OBUF[18]),
        .O(RDATA[18]));
  OBUF \RDATA_OBUF[19]_inst 
       (.I(RDATA_OBUF[19]),
        .O(RDATA[19]));
  OBUF \RDATA_OBUF[1]_inst 
       (.I(RDATA_OBUF[1]),
        .O(RDATA[1]));
  OBUF \RDATA_OBUF[20]_inst 
       (.I(RDATA_OBUF[20]),
        .O(RDATA[20]));
  OBUF \RDATA_OBUF[21]_inst 
       (.I(RDATA_OBUF[21]),
        .O(RDATA[21]));
  OBUF \RDATA_OBUF[22]_inst 
       (.I(RDATA_OBUF[22]),
        .O(RDATA[22]));
  OBUF \RDATA_OBUF[23]_inst 
       (.I(RDATA_OBUF[23]),
        .O(RDATA[23]));
  OBUF \RDATA_OBUF[24]_inst 
       (.I(RDATA_OBUF[24]),
        .O(RDATA[24]));
  OBUF \RDATA_OBUF[25]_inst 
       (.I(RDATA_OBUF[25]),
        .O(RDATA[25]));
  OBUF \RDATA_OBUF[26]_inst 
       (.I(RDATA_OBUF[26]),
        .O(RDATA[26]));
  OBUF \RDATA_OBUF[27]_inst 
       (.I(RDATA_OBUF[27]),
        .O(RDATA[27]));
  OBUF \RDATA_OBUF[28]_inst 
       (.I(RDATA_OBUF[28]),
        .O(RDATA[28]));
  OBUF \RDATA_OBUF[29]_inst 
       (.I(RDATA_OBUF[29]),
        .O(RDATA[29]));
  OBUF \RDATA_OBUF[2]_inst 
       (.I(RDATA_OBUF[2]),
        .O(RDATA[2]));
  OBUF \RDATA_OBUF[30]_inst 
       (.I(RDATA_OBUF[30]),
        .O(RDATA[30]));
  OBUF \RDATA_OBUF[31]_inst 
       (.I(RDATA_OBUF[31]),
        .O(RDATA[31]));
  OBUF \RDATA_OBUF[3]_inst 
       (.I(RDATA_OBUF[3]),
        .O(RDATA[3]));
  OBUF \RDATA_OBUF[4]_inst 
       (.I(RDATA_OBUF[4]),
        .O(RDATA[4]));
  OBUF \RDATA_OBUF[5]_inst 
       (.I(RDATA_OBUF[5]),
        .O(RDATA[5]));
  OBUF \RDATA_OBUF[6]_inst 
       (.I(RDATA_OBUF[6]),
        .O(RDATA[6]));
  OBUF \RDATA_OBUF[7]_inst 
       (.I(RDATA_OBUF[7]),
        .O(RDATA[7]));
  OBUF \RDATA_OBUF[8]_inst 
       (.I(RDATA_OBUF[8]),
        .O(RDATA[8]));
  OBUF \RDATA_OBUF[9]_inst 
       (.I(RDATA_OBUF[9]),
        .O(RDATA[9]));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[0] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[0]),
        .Q(RDATA_OBUF[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[10] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[10]),
        .Q(RDATA_OBUF[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[11] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[11]),
        .Q(RDATA_OBUF[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[12] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[12]),
        .Q(RDATA_OBUF[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[13] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[13]),
        .Q(RDATA_OBUF[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[14] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[14]),
        .Q(RDATA_OBUF[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[15] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[15]),
        .Q(RDATA_OBUF[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[16] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[16]),
        .Q(RDATA_OBUF[16]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[17] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[17]),
        .Q(RDATA_OBUF[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[18] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[18]),
        .Q(RDATA_OBUF[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[19] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[19]),
        .Q(RDATA_OBUF[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[1] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[1]),
        .Q(RDATA_OBUF[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[20] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[20]),
        .Q(RDATA_OBUF[20]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[21] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[21]),
        .Q(RDATA_OBUF[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[22] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[22]),
        .Q(RDATA_OBUF[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[23] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[23]),
        .Q(RDATA_OBUF[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[24] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[24]),
        .Q(RDATA_OBUF[24]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[25] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[25]),
        .Q(RDATA_OBUF[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[26] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[26]),
        .Q(RDATA_OBUF[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[27] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[27]),
        .Q(RDATA_OBUF[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[28] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[28]),
        .Q(RDATA_OBUF[28]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[29] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[29]),
        .Q(RDATA_OBUF[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[2] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[2]),
        .Q(RDATA_OBUF[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[30] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[30]),
        .Q(RDATA_OBUF[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[31] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[31]),
        .Q(RDATA_OBUF[31]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[3] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[3]),
        .Q(RDATA_OBUF[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[4] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[4]),
        .Q(RDATA_OBUF[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[5] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[5]),
        .Q(RDATA_OBUF[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[6] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[6]),
        .Q(RDATA_OBUF[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[7] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[7]),
        .Q(RDATA_OBUF[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[8] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[8]),
        .Q(RDATA_OBUF[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \RDATA_reg[9] 
       (.C(PCLK_OBUF_BUFG),
        .CE(RDATA0),
        .D(PRDATA_IBUF[9]),
        .Q(RDATA_OBUF[9]),
        .R(1'b0));
  IBUF RREADY_IBUF_inst
       (.I(RREADY),
        .O(RREADY_IBUF));
  OBUF RVALID_OBUF_inst
       (.I(RVALID_OBUF),
        .O(RVALID));
  LUT4 #(
    .INIT(16'h0010)) 
    RVALID_OBUF_inst_i_1
       (.I0(present_state[0]),
        .I1(present_state[2]),
        .I2(present_state[3]),
        .I3(present_state[1]),
        .O(RVALID_OBUF));
  IBUF \WDATA_IBUF[0]_inst 
       (.I(WDATA[0]),
        .O(WDATA_IBUF[0]));
  IBUF \WDATA_IBUF[10]_inst 
       (.I(WDATA[10]),
        .O(WDATA_IBUF[10]));
  IBUF \WDATA_IBUF[11]_inst 
       (.I(WDATA[11]),
        .O(WDATA_IBUF[11]));
  IBUF \WDATA_IBUF[12]_inst 
       (.I(WDATA[12]),
        .O(WDATA_IBUF[12]));
  IBUF \WDATA_IBUF[13]_inst 
       (.I(WDATA[13]),
        .O(WDATA_IBUF[13]));
  IBUF \WDATA_IBUF[14]_inst 
       (.I(WDATA[14]),
        .O(WDATA_IBUF[14]));
  IBUF \WDATA_IBUF[15]_inst 
       (.I(WDATA[15]),
        .O(WDATA_IBUF[15]));
  IBUF \WDATA_IBUF[16]_inst 
       (.I(WDATA[16]),
        .O(WDATA_IBUF[16]));
  IBUF \WDATA_IBUF[17]_inst 
       (.I(WDATA[17]),
        .O(WDATA_IBUF[17]));
  IBUF \WDATA_IBUF[18]_inst 
       (.I(WDATA[18]),
        .O(WDATA_IBUF[18]));
  IBUF \WDATA_IBUF[19]_inst 
       (.I(WDATA[19]),
        .O(WDATA_IBUF[19]));
  IBUF \WDATA_IBUF[1]_inst 
       (.I(WDATA[1]),
        .O(WDATA_IBUF[1]));
  IBUF \WDATA_IBUF[20]_inst 
       (.I(WDATA[20]),
        .O(WDATA_IBUF[20]));
  IBUF \WDATA_IBUF[21]_inst 
       (.I(WDATA[21]),
        .O(WDATA_IBUF[21]));
  IBUF \WDATA_IBUF[22]_inst 
       (.I(WDATA[22]),
        .O(WDATA_IBUF[22]));
  IBUF \WDATA_IBUF[23]_inst 
       (.I(WDATA[23]),
        .O(WDATA_IBUF[23]));
  IBUF \WDATA_IBUF[24]_inst 
       (.I(WDATA[24]),
        .O(WDATA_IBUF[24]));
  IBUF \WDATA_IBUF[25]_inst 
       (.I(WDATA[25]),
        .O(WDATA_IBUF[25]));
  IBUF \WDATA_IBUF[26]_inst 
       (.I(WDATA[26]),
        .O(WDATA_IBUF[26]));
  IBUF \WDATA_IBUF[27]_inst 
       (.I(WDATA[27]),
        .O(WDATA_IBUF[27]));
  IBUF \WDATA_IBUF[28]_inst 
       (.I(WDATA[28]),
        .O(WDATA_IBUF[28]));
  IBUF \WDATA_IBUF[29]_inst 
       (.I(WDATA[29]),
        .O(WDATA_IBUF[29]));
  IBUF \WDATA_IBUF[2]_inst 
       (.I(WDATA[2]),
        .O(WDATA_IBUF[2]));
  IBUF \WDATA_IBUF[30]_inst 
       (.I(WDATA[30]),
        .O(WDATA_IBUF[30]));
  IBUF \WDATA_IBUF[31]_inst 
       (.I(WDATA[31]),
        .O(WDATA_IBUF[31]));
  IBUF \WDATA_IBUF[3]_inst 
       (.I(WDATA[3]),
        .O(WDATA_IBUF[3]));
  IBUF \WDATA_IBUF[4]_inst 
       (.I(WDATA[4]),
        .O(WDATA_IBUF[4]));
  IBUF \WDATA_IBUF[5]_inst 
       (.I(WDATA[5]),
        .O(WDATA_IBUF[5]));
  IBUF \WDATA_IBUF[6]_inst 
       (.I(WDATA[6]),
        .O(WDATA_IBUF[6]));
  IBUF \WDATA_IBUF[7]_inst 
       (.I(WDATA[7]),
        .O(WDATA_IBUF[7]));
  IBUF \WDATA_IBUF[8]_inst 
       (.I(WDATA[8]),
        .O(WDATA_IBUF[8]));
  IBUF \WDATA_IBUF[9]_inst 
       (.I(WDATA[9]),
        .O(WDATA_IBUF[9]));
  OBUF WREADY_OBUF_inst
       (.I(WREADY_OBUF),
        .O(WREADY));
  LUT4 #(
    .INIT(16'h1004)) 
    WREADY_OBUF_inst_i_1
       (.I0(present_state[3]),
        .I1(present_state[1]),
        .I2(present_state[2]),
        .I3(present_state[0]),
        .O(WREADY_OBUF));
  IBUF WVALID_IBUF_inst
       (.I(WVALID),
        .O(WVALID_IBUF));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[0]_i_1 
       (.I0(ARADDR_IBUF[0]),
        .I1(AWADDR_IBUF[0]),
        .I2(sampled_address17_out),
        .I3(sampled_address[0]),
        .I4(sampled_address18_out),
        .O(p_1_in[0]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[10]_i_1 
       (.I0(ARADDR_IBUF[10]),
        .I1(AWADDR_IBUF[10]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[10]),
        .I4(sampled_address18_out),
        .O(p_1_in[10]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[11]_i_1 
       (.I0(ARADDR_IBUF[11]),
        .I1(AWADDR_IBUF[11]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[11]),
        .I4(sampled_address18_out),
        .O(p_1_in[11]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[12]_i_1 
       (.I0(ARADDR_IBUF[12]),
        .I1(AWADDR_IBUF[12]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[12]),
        .I4(sampled_address18_out),
        .O(p_1_in[12]));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[12]_i_3 
       (.I0(sampled_address[12]),
        .O(\sampled_address[12]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[12]_i_4 
       (.I0(sampled_address[11]),
        .O(\sampled_address[12]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[12]_i_5 
       (.I0(sampled_address[10]),
        .O(\sampled_address[12]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[12]_i_6 
       (.I0(sampled_address[9]),
        .O(\sampled_address[12]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[13]_i_1 
       (.I0(ARADDR_IBUF[13]),
        .I1(AWADDR_IBUF[13]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[13]),
        .I4(sampled_address18_out),
        .O(p_1_in[13]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[14]_i_1 
       (.I0(ARADDR_IBUF[14]),
        .I1(AWADDR_IBUF[14]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[14]),
        .I4(sampled_address18_out),
        .O(p_1_in[14]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[15]_i_1 
       (.I0(ARADDR_IBUF[15]),
        .I1(AWADDR_IBUF[15]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[15]),
        .I4(sampled_address18_out),
        .O(p_1_in[15]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[16]_i_1 
       (.I0(ARADDR_IBUF[16]),
        .I1(AWADDR_IBUF[16]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[16]),
        .I4(sampled_address18_out),
        .O(p_1_in[16]));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[16]_i_3 
       (.I0(sampled_address[16]),
        .O(\sampled_address[16]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[16]_i_4 
       (.I0(sampled_address[15]),
        .O(\sampled_address[16]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[16]_i_5 
       (.I0(sampled_address[14]),
        .O(\sampled_address[16]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[16]_i_6 
       (.I0(sampled_address[13]),
        .O(\sampled_address[16]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[17]_i_1 
       (.I0(ARADDR_IBUF[17]),
        .I1(AWADDR_IBUF[17]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[17]),
        .I4(sampled_address18_out),
        .O(p_1_in[17]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[18]_i_1 
       (.I0(ARADDR_IBUF[18]),
        .I1(AWADDR_IBUF[18]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[18]),
        .I4(sampled_address18_out),
        .O(p_1_in[18]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[19]_i_1 
       (.I0(ARADDR_IBUF[19]),
        .I1(AWADDR_IBUF[19]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[19]),
        .I4(sampled_address18_out),
        .O(p_1_in[19]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[1]_i_1 
       (.I0(ARADDR_IBUF[1]),
        .I1(AWADDR_IBUF[1]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[1]),
        .I4(sampled_address18_out),
        .O(p_1_in[1]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[20]_i_1 
       (.I0(ARADDR_IBUF[20]),
        .I1(AWADDR_IBUF[20]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[20]),
        .I4(sampled_address18_out),
        .O(p_1_in[20]));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[20]_i_3 
       (.I0(sampled_address[20]),
        .O(\sampled_address[20]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[20]_i_4 
       (.I0(sampled_address[19]),
        .O(\sampled_address[20]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[20]_i_5 
       (.I0(sampled_address[18]),
        .O(\sampled_address[20]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[20]_i_6 
       (.I0(sampled_address[17]),
        .O(\sampled_address[20]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[21]_i_1 
       (.I0(ARADDR_IBUF[21]),
        .I1(AWADDR_IBUF[21]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[21]),
        .I4(sampled_address18_out),
        .O(p_1_in[21]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[22]_i_1 
       (.I0(ARADDR_IBUF[22]),
        .I1(AWADDR_IBUF[22]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[22]),
        .I4(sampled_address18_out),
        .O(p_1_in[22]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[23]_i_1 
       (.I0(ARADDR_IBUF[23]),
        .I1(AWADDR_IBUF[23]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[23]),
        .I4(sampled_address18_out),
        .O(p_1_in[23]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[24]_i_1 
       (.I0(ARADDR_IBUF[24]),
        .I1(AWADDR_IBUF[24]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[24]),
        .I4(sampled_address18_out),
        .O(p_1_in[24]));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[24]_i_3 
       (.I0(sampled_address[24]),
        .O(\sampled_address[24]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[24]_i_4 
       (.I0(sampled_address[23]),
        .O(\sampled_address[24]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[24]_i_5 
       (.I0(sampled_address[22]),
        .O(\sampled_address[24]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[24]_i_6 
       (.I0(sampled_address[21]),
        .O(\sampled_address[24]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[25]_i_1 
       (.I0(ARADDR_IBUF[25]),
        .I1(AWADDR_IBUF[25]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[25]),
        .I4(sampled_address18_out),
        .O(p_1_in[25]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[26]_i_1 
       (.I0(ARADDR_IBUF[26]),
        .I1(AWADDR_IBUF[26]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[26]),
        .I4(sampled_address18_out),
        .O(p_1_in[26]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[27]_i_1 
       (.I0(ARADDR_IBUF[27]),
        .I1(AWADDR_IBUF[27]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[27]),
        .I4(sampled_address18_out),
        .O(p_1_in[27]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[28]_i_1 
       (.I0(ARADDR_IBUF[28]),
        .I1(AWADDR_IBUF[28]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[28]),
        .I4(sampled_address18_out),
        .O(p_1_in[28]));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[28]_i_3 
       (.I0(sampled_address[28]),
        .O(\sampled_address[28]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[28]_i_4 
       (.I0(sampled_address[27]),
        .O(\sampled_address[28]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[28]_i_5 
       (.I0(sampled_address[26]),
        .O(\sampled_address[28]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[28]_i_6 
       (.I0(sampled_address[25]),
        .O(\sampled_address[28]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[29]_i_1 
       (.I0(ARADDR_IBUF[29]),
        .I1(AWADDR_IBUF[29]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[29]),
        .I4(sampled_address18_out),
        .O(p_1_in[29]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[2]_i_1 
       (.I0(ARADDR_IBUF[2]),
        .I1(AWADDR_IBUF[2]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[2]),
        .I4(sampled_address18_out),
        .O(p_1_in[2]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[30]_i_1 
       (.I0(ARADDR_IBUF[30]),
        .I1(AWADDR_IBUF[30]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[30]),
        .I4(sampled_address18_out),
        .O(p_1_in[30]));
  LUT6 #(
    .INIT(64'hFFFFFFFFEAAEAAAA)) 
    \sampled_address[31]_i_1 
       (.I0(sampled_address17_out),
        .I1(\sampled_address[31]_i_3_n_0 ),
        .I2(present_state[0]),
        .I3(present_state[1]),
        .I4(PREADY_IBUF),
        .I5(sampled_address18_out),
        .O(\sampled_address[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[31]_i_2 
       (.I0(ARADDR_IBUF[31]),
        .I1(AWADDR_IBUF[31]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[31]),
        .I4(sampled_address18_out),
        .O(p_1_in[31]));
  LUT2 #(
    .INIT(4'h2)) 
    \sampled_address[31]_i_3 
       (.I0(present_state[2]),
        .I1(present_state[3]),
        .O(\sampled_address[31]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[31]_i_5 
       (.I0(sampled_address[31]),
        .O(\sampled_address[31]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[31]_i_6 
       (.I0(sampled_address[30]),
        .O(\sampled_address[31]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[31]_i_7 
       (.I0(sampled_address[29]),
        .O(\sampled_address[31]_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[3]_i_1 
       (.I0(ARADDR_IBUF[3]),
        .I1(AWADDR_IBUF[3]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[3]),
        .I4(sampled_address18_out),
        .O(p_1_in[3]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[4]_i_1 
       (.I0(ARADDR_IBUF[4]),
        .I1(AWADDR_IBUF[4]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[4]),
        .I4(sampled_address18_out),
        .O(p_1_in[4]));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[4]_i_3 
       (.I0(sampled_address[4]),
        .O(\sampled_address[4]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[4]_i_4 
       (.I0(sampled_address[3]),
        .O(\sampled_address[4]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[4]_i_5 
       (.I0(sampled_address[2]),
        .O(\sampled_address[4]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h2)) 
    \sampled_address[4]_i_6 
       (.I0(sampled_address[1]),
        .O(\sampled_address[4]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[5]_i_1 
       (.I0(ARADDR_IBUF[5]),
        .I1(AWADDR_IBUF[5]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[5]),
        .I4(sampled_address18_out),
        .O(p_1_in[5]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[6]_i_1 
       (.I0(ARADDR_IBUF[6]),
        .I1(AWADDR_IBUF[6]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[6]),
        .I4(sampled_address18_out),
        .O(p_1_in[6]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[7]_i_1 
       (.I0(ARADDR_IBUF[7]),
        .I1(AWADDR_IBUF[7]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[7]),
        .I4(sampled_address18_out),
        .O(p_1_in[7]));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[8]_i_1 
       (.I0(ARADDR_IBUF[8]),
        .I1(AWADDR_IBUF[8]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[8]),
        .I4(sampled_address18_out),
        .O(p_1_in[8]));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[8]_i_3 
       (.I0(sampled_address[8]),
        .O(\sampled_address[8]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[8]_i_4 
       (.I0(sampled_address[7]),
        .O(\sampled_address[8]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[8]_i_5 
       (.I0(sampled_address[6]),
        .O(\sampled_address[8]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sampled_address[8]_i_6 
       (.I0(sampled_address[5]),
        .O(\sampled_address[8]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hAAAACFC0)) 
    \sampled_address[9]_i_1 
       (.I0(ARADDR_IBUF[9]),
        .I1(AWADDR_IBUF[9]),
        .I2(sampled_address17_out),
        .I3(sampled_address0[9]),
        .I4(sampled_address18_out),
        .O(p_1_in[9]));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[0] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[0]),
        .Q(sampled_address[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[10] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[10]),
        .Q(sampled_address[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[11] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[11]),
        .Q(sampled_address[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[12] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[12]),
        .Q(sampled_address[12]),
        .R(1'b0));
  CARRY4 \sampled_address_reg[12]_i_2 
       (.CI(\sampled_address_reg[8]_i_2_n_0 ),
        .CO({\sampled_address_reg[12]_i_2_n_0 ,\sampled_address_reg[12]_i_2_n_1 ,\sampled_address_reg[12]_i_2_n_2 ,\sampled_address_reg[12]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(sampled_address[12:9]),
        .O(sampled_address0[12:9]),
        .S({\sampled_address[12]_i_3_n_0 ,\sampled_address[12]_i_4_n_0 ,\sampled_address[12]_i_5_n_0 ,\sampled_address[12]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[13] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[13]),
        .Q(sampled_address[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[14] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[14]),
        .Q(sampled_address[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[15] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[15]),
        .Q(sampled_address[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[16] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[16]),
        .Q(sampled_address[16]),
        .R(1'b0));
  CARRY4 \sampled_address_reg[16]_i_2 
       (.CI(\sampled_address_reg[12]_i_2_n_0 ),
        .CO({\sampled_address_reg[16]_i_2_n_0 ,\sampled_address_reg[16]_i_2_n_1 ,\sampled_address_reg[16]_i_2_n_2 ,\sampled_address_reg[16]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(sampled_address[16:13]),
        .O(sampled_address0[16:13]),
        .S({\sampled_address[16]_i_3_n_0 ,\sampled_address[16]_i_4_n_0 ,\sampled_address[16]_i_5_n_0 ,\sampled_address[16]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[17] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[17]),
        .Q(sampled_address[17]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[18] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[18]),
        .Q(sampled_address[18]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[19] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[19]),
        .Q(sampled_address[19]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[1] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[1]),
        .Q(sampled_address[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[20] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[20]),
        .Q(sampled_address[20]),
        .R(1'b0));
  CARRY4 \sampled_address_reg[20]_i_2 
       (.CI(\sampled_address_reg[16]_i_2_n_0 ),
        .CO({\sampled_address_reg[20]_i_2_n_0 ,\sampled_address_reg[20]_i_2_n_1 ,\sampled_address_reg[20]_i_2_n_2 ,\sampled_address_reg[20]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(sampled_address[20:17]),
        .O(sampled_address0[20:17]),
        .S({\sampled_address[20]_i_3_n_0 ,\sampled_address[20]_i_4_n_0 ,\sampled_address[20]_i_5_n_0 ,\sampled_address[20]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[21] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[21]),
        .Q(sampled_address[21]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[22] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[22]),
        .Q(sampled_address[22]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[23] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[23]),
        .Q(sampled_address[23]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[24] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[24]),
        .Q(sampled_address[24]),
        .R(1'b0));
  CARRY4 \sampled_address_reg[24]_i_2 
       (.CI(\sampled_address_reg[20]_i_2_n_0 ),
        .CO({\sampled_address_reg[24]_i_2_n_0 ,\sampled_address_reg[24]_i_2_n_1 ,\sampled_address_reg[24]_i_2_n_2 ,\sampled_address_reg[24]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(sampled_address[24:21]),
        .O(sampled_address0[24:21]),
        .S({\sampled_address[24]_i_3_n_0 ,\sampled_address[24]_i_4_n_0 ,\sampled_address[24]_i_5_n_0 ,\sampled_address[24]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[25] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[25]),
        .Q(sampled_address[25]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[26] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[26]),
        .Q(sampled_address[26]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[27] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[27]),
        .Q(sampled_address[27]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[28] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[28]),
        .Q(sampled_address[28]),
        .R(1'b0));
  CARRY4 \sampled_address_reg[28]_i_2 
       (.CI(\sampled_address_reg[24]_i_2_n_0 ),
        .CO({\sampled_address_reg[28]_i_2_n_0 ,\sampled_address_reg[28]_i_2_n_1 ,\sampled_address_reg[28]_i_2_n_2 ,\sampled_address_reg[28]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(sampled_address[28:25]),
        .O(sampled_address0[28:25]),
        .S({\sampled_address[28]_i_3_n_0 ,\sampled_address[28]_i_4_n_0 ,\sampled_address[28]_i_5_n_0 ,\sampled_address[28]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[29] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[29]),
        .Q(sampled_address[29]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[2] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[2]),
        .Q(sampled_address[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[30] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[30]),
        .Q(sampled_address[30]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[31] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[31]),
        .Q(sampled_address[31]),
        .R(1'b0));
  CARRY4 \sampled_address_reg[31]_i_4 
       (.CI(\sampled_address_reg[28]_i_2_n_0 ),
        .CO({\NLW_sampled_address_reg[31]_i_4_CO_UNCONNECTED [3:2],\sampled_address_reg[31]_i_4_n_2 ,\sampled_address_reg[31]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,sampled_address[30:29]}),
        .O({\NLW_sampled_address_reg[31]_i_4_O_UNCONNECTED [3],sampled_address0[31:29]}),
        .S({1'b0,\sampled_address[31]_i_5_n_0 ,\sampled_address[31]_i_6_n_0 ,\sampled_address[31]_i_7_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[3] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[3]),
        .Q(sampled_address[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[4] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[4]),
        .Q(sampled_address[4]),
        .R(1'b0));
  CARRY4 \sampled_address_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\sampled_address_reg[4]_i_2_n_0 ,\sampled_address_reg[4]_i_2_n_1 ,\sampled_address_reg[4]_i_2_n_2 ,\sampled_address_reg[4]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({sampled_address[4:2],1'b0}),
        .O(sampled_address0[4:1]),
        .S({\sampled_address[4]_i_3_n_0 ,\sampled_address[4]_i_4_n_0 ,\sampled_address[4]_i_5_n_0 ,\sampled_address[4]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[5] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[5]),
        .Q(sampled_address[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[6] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[6]),
        .Q(sampled_address[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[7] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[7]),
        .Q(sampled_address[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[8] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[8]),
        .Q(sampled_address[8]),
        .R(1'b0));
  CARRY4 \sampled_address_reg[8]_i_2 
       (.CI(\sampled_address_reg[4]_i_2_n_0 ),
        .CO({\sampled_address_reg[8]_i_2_n_0 ,\sampled_address_reg[8]_i_2_n_1 ,\sampled_address_reg[8]_i_2_n_2 ,\sampled_address_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(sampled_address[8:5]),
        .O(sampled_address0[8:5]),
        .S({\sampled_address[8]_i_3_n_0 ,\sampled_address[8]_i_4_n_0 ,\sampled_address[8]_i_5_n_0 ,\sampled_address[8]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_address_reg[9] 
       (.C(PCLK_OBUF_BUFG),
        .CE(\sampled_address[31]_i_1_n_0 ),
        .D(p_1_in[9]),
        .Q(sampled_address[9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0000ACAFFFFFACA0)) 
    \sampled_wlen[0]_i_1 
       (.I0(ARLEN_IBUF[0]),
        .I1(AWLEN_IBUF[0]),
        .I2(sampled_address18_out),
        .I3(sampled_address17_out),
        .I4(sampled_wlen1),
        .I5(sampled_wlen[0]),
        .O(\sampled_wlen[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAACCCF5555CCC0)) 
    \sampled_wlen[1]_i_1 
       (.I0(sampled_wlen[0]),
        .I1(\sampled_wlen[1]_i_2_n_0 ),
        .I2(sampled_address18_out),
        .I3(sampled_address17_out),
        .I4(sampled_wlen1),
        .I5(sampled_wlen[1]),
        .O(\sampled_wlen[1]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \sampled_wlen[1]_i_2 
       (.I0(ARLEN_IBUF[1]),
        .I1(sampled_address18_out),
        .I2(AWLEN_IBUF[1]),
        .O(\sampled_wlen[1]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h00000002)) 
    \sampled_wlen[1]_i_3 
       (.I0(ARVALID_IBUF),
        .I1(present_state[1]),
        .I2(present_state[2]),
        .I3(present_state[0]),
        .I4(present_state[3]),
        .O(sampled_address18_out));
  LUT5 #(
    .INIT(32'h00000002)) 
    \sampled_wlen[1]_i_4 
       (.I0(AWVALID_IBUF),
        .I1(present_state[1]),
        .I2(present_state[2]),
        .I3(present_state[0]),
        .I4(present_state[3]),
        .O(sampled_address17_out));
  LUT6 #(
    .INIT(64'h008300C000800000)) 
    \sampled_wlen[1]_i_5 
       (.I0(PREADY_IBUF),
        .I1(present_state[2]),
        .I2(present_state[0]),
        .I3(present_state[3]),
        .I4(present_state[1]),
        .I5(WVALID_IBUF),
        .O(sampled_wlen1));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_wlen_reg[0] 
       (.C(PCLK_OBUF_BUFG),
        .CE(1'b1),
        .D(\sampled_wlen[0]_i_1_n_0 ),
        .Q(sampled_wlen[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sampled_wlen_reg[1] 
       (.C(PCLK_OBUF_BUFG),
        .CE(1'b1),
        .D(\sampled_wlen[1]_i_1_n_0 ),
        .Q(sampled_wlen[1]),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
