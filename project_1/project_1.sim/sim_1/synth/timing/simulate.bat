@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xsim AXI_2_APB_TestBench_time_synth -key {Post-Synthesis:sim_1:Timing:AXI_2_APB_TestBench} -tclbatch AXI_2_APB_TestBench.tcl -view C:/Users/vamsi/Desktop/MAJOR_PROJECT/Major_Project_Files/project_1/AXI_2_APB_TestBench_behav1.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
