// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
// Date        : Fri Feb 23 15:34:50 2018
// Host        : G-TIRUPATHI running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/vamsi/Desktop/MAJOR_PROJECT/Major_Project_Files/project_1/project_1.srcs/sources_1/ip/vio_0/vio_0_stub.v
// Design      : vio_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "vio,Vivado 2015.2" *)
module vio_0(clk, probe_in0, probe_in1, probe_in2, probe_in3, probe_in4, probe_out0, probe_out1, probe_out2, probe_out3, probe_out4, probe_out5, probe_out6, probe_out7, probe_out8, probe_out9)
/* synthesis syn_black_box black_box_pad_pin="clk,probe_in0[31:0],probe_in1[3:0],probe_in2[3:0],probe_in3[0:0],probe_in4[0:0],probe_out0[1:0],probe_out1[31:0],probe_out2[31:0],probe_out3[0:0],probe_out4[0:0],probe_out5[15:0],probe_out6[15:0],probe_out7[15:0],probe_out8[15:0],probe_out9[31:0]" */;
  input clk;
  input [31:0]probe_in0;
  input [3:0]probe_in1;
  input [3:0]probe_in2;
  input [0:0]probe_in3;
  input [0:0]probe_in4;
  output [1:0]probe_out0;
  output [31:0]probe_out1;
  output [31:0]probe_out2;
  output [0:0]probe_out3;
  output [0:0]probe_out4;
  output [15:0]probe_out5;
  output [15:0]probe_out6;
  output [15:0]probe_out7;
  output [15:0]probe_out8;
  output [31:0]probe_out9;
endmodule
