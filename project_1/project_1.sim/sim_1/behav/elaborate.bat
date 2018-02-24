@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto 300dfdc5400c46ff9b3e0c33943ac0ac -m64 --debug typical --relax --mt 2 --include "../../../project_1.srcs/sources_1/ip/ila_0/ila_v5_1/hdl/verilog" --include "../../../project_1.srcs/sources_1/ip/ila_0/ltlib_v1_0/hdl/verilog" --include "../../../project_1.srcs/sources_1/ip/ila_0/xsdbs_v1_0/hdl/verilog" --include "../../../project_1.srcs/sources_1/ip/vio_0/ltlib_v1_0/hdl/verilog" --include "../../../project_1.srcs/sources_1/ip/vio_0/vio_v3_0/hdl" --include "../../../project_1.srcs/sources_1/ip/vio_0/xsdbs_v1_0/hdl/verilog" -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot Interrupt_Controller_TestBench_behav xil_defaultlib.Interrupt_Controller_TestBench xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
