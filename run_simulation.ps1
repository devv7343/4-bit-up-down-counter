# DLCD Lab Project 8: Simulation Runner
Write-Host "======================================================================" -ForegroundColor Cyan
Write-Host "   DLCD Lab Project 8: 4-Bit Up, Down, and Up/Down Counter Simulation" -ForegroundColor Cyan
Write-Host "======================================================================" -ForegroundColor Cyan

if (-not (Test-Path "sim")) { New-Item -ItemType Directory -Path "sim" | Out-Null }

Write-Host "`n[1/3] Compiling and running 4-Bit Up Counter..." -ForegroundColor Yellow
iverilog -o sim/sim_up.vvp src/up_counter_4bit.v tb/tb_up_counter.v
vvp sim/sim_up.vvp | Tee-Object -FilePath sim/up_counter_log.txt | Out-Null
Copy-Item -Path up_counter.vcd -Destination sim/up_counter.vcd -Force
Write-Host "    -> Up Counter simulation log saved to sim/up_counter_log.txt" -ForegroundColor Green
Write-Host "    -> VCD waveform saved to up_counter.vcd (and sim/up_counter.vcd)" -ForegroundColor Green

Write-Host "`n[2/3] Compiling and running 4-Bit Down Counter..." -ForegroundColor Yellow
iverilog -o sim/sim_down.vvp src/down_counter_4bit.v tb/tb_down_counter.v
vvp sim/sim_down.vvp | Tee-Object -FilePath sim/down_counter_log.txt | Out-Null
Copy-Item -Path down_counter.vcd -Destination sim/down_counter.vcd -Force
Write-Host "    -> Down Counter simulation log saved to sim/down_counter_log.txt" -ForegroundColor Green
Write-Host "    -> VCD waveform saved to down_counter.vcd (and sim/down_counter.vcd)" -ForegroundColor Green

Write-Host "`n[3/3] Compiling and running 4-Bit Up/Down Counter (Behavioral & Structural)..." -ForegroundColor Yellow
iverilog -o sim/sim_up_down.vvp src/up_down_counter_4bit.v src/structural_counters.v tb/tb_up_down_counter.v
vvp sim/sim_up_down.vvp | Tee-Object -FilePath sim/up_down_counter_log.txt | Out-Null
Copy-Item -Path up_down_counter.vcd -Destination sim/up_down_counter.vcd -Force
Write-Host "    -> Up/Down Counter simulation log saved to sim/up_down_counter_log.txt" -ForegroundColor Green
Write-Host "    -> VCD waveform saved to up_down_counter.vcd (and sim/up_down_counter.vcd)" -ForegroundColor Green

Write-Host "`n======================================================================" -ForegroundColor Cyan
Write-Host "   All simulations completed successfully!" -ForegroundColor Green
Write-Host "   View waveforms with: gtkwave up_counter.vcd" -ForegroundColor Cyan
Write-Host "                   or:  gtkwave up_down_counter.vcd" -ForegroundColor Cyan
Write-Host "======================================================================" -ForegroundColor Cyan
