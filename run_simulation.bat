@echo off
echo ======================================================================
echo    DLCD Lab Project 8: 4-Bit Up, Down, and Up/Down Counter Simulation
echo ======================================================================
echo.

if not exist sim mkdir sim

echo [1/3] Compiling and running 4-Bit Up Counter...
iverilog -o sim\sim_up.vvp src\up_counter_4bit.v tb\tb_up_counter.v
if %ERRORLEVEL% NEQ 0 ( echo Error compiling Up Counter! & pause & exit /b %ERRORLEVEL% )
vvp sim\sim_up.vvp > sim\up_counter_log.txt
echo     -^> Up Counter simulation log saved to sim\up_counter_log.txt
echo     -^> VCD waveform saved to sim\up_counter.vcd

echo [2/3] Compiling and running 4-Bit Down Counter...
iverilog -o sim\sim_down.vvp src\down_counter_4bit.v tb\tb_down_counter.v
if %ERRORLEVEL% NEQ 0 ( echo Error compiling Down Counter! & pause & exit /b %ERRORLEVEL% )
vvp sim\sim_down.vvp > sim\down_counter_log.txt
echo     -^> Down Counter simulation log saved to sim\down_counter_log.txt
echo     -^> VCD waveform saved to sim\down_counter.vcd

echo [3/3] Compiling and running 4-Bit Up/Down Counter (Behavioral and Structural)...
iverilog -o sim\sim_up_down.vvp src\up_down_counter_4bit.v src\structural_counters.v tb\tb_up_down_counter.v
if %ERRORLEVEL% NEQ 0 ( echo Error compiling Up/Down Counter! & pause & exit /b %ERRORLEVEL% )
vvp sim\sim_up_down.vvp > sim\up_down_counter_log.txt
echo     -^> Up/Down Counter simulation log saved to sim\up_down_counter_log.txt
echo     -^> VCD waveform saved to sim\up_down_counter.vcd

echo.
echo ======================================================================
echo    All simulations completed successfully!
echo    View waveforms with: gtkwave sim\up_down_counter.vcd
echo ======================================================================
