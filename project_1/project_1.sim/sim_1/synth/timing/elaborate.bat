@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto 300dfdc5400c46ff9b3e0c33943ac0ac -m64 --debug typical --relax --mt 2 --maxdelay -L xil_defaultlib -L simprims_ver -L secureip --snapshot AXI_2_APB_TestBench_time_synth -transport_int_delays -pulse_r 0 -pulse_int_r 0 xil_defaultlib.AXI_2_APB_TestBench xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
