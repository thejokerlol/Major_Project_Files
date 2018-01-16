@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xsim APB_Slave_Interface_behav -key {Behavioral:sim_1:Functional:APB_Slave_Interface} -tclbatch APB_Slave_Interface.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
