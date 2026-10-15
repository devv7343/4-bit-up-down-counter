# DLCD Lab Project - Problem No. 8
## 4-Bit Synchronous Up Counter, Down Counter, and Up/Down Counter

This repository contains the complete design, testbenches, simulation logs, waveform dumps, and comprehensive laboratory report for **Problem No. 8** of the **Digital Logic and Circuit Design (CS159)** course.

---

### Project Structure

```
dlcd mini/
│
├── DLCD-LAB-PROJECT.docx        # Original project problem statements and guidelines
├── PROJECT_REPORT.md            # Complete, submission-ready project report
├── README.md                    # Project overview and quickstart guide
├── run_simulation.bat           # 1-Click Windows batch script to compile and run all simulations
├── run_simulation.ps1           # PowerShell version of simulation runner
│
├── src/                         # Verilog HDL Design Sources
│   ├── up_counter_4bit.v        # Behavioral 4-bit Up Counter (0 -> 15 -> 0)
│   ├── down_counter_4bit.v      # Behavioral 4-bit Down Counter (15 -> 0 -> 15)
│   ├── up_down_counter_4bit.v   # Behavioral 4-bit Up/Down Counter with mode select
│   └── structural_counters.v    # Gate-level structural models with T and JK Flip-Flops
│
├── tb/                          # Verilog Testbenches
│   ├── tb_up_counter.v          # Up counter testbench with wrap-around verification
│   ├── tb_down_counter.v        # Down counter testbench with wrap-around verification
│   └── tb_up_down_counter.v     # Side-by-side behavioral vs. structural equivalence testbench
│
└── sim/                         # Simulation Artifacts
    ├── up_counter_log.txt       # Up counter execution transcript
    ├── up_counter.vcd           # Up counter waveform dump (viewable in GTKWave)
    ├── down_counter_log.txt     # Down counter execution transcript
    ├── down_counter.vcd         # Down counter waveform dump
    ├── up_down_counter_log.txt  # Up/down counter execution transcript with 100% equivalence checks
    └── up_down_counter.vcd      # Up/down counter waveform dump
```

---

### Quick Start: Running Simulations

You can run all three simulations with a single command:

#### Option 1: Using Windows Command Prompt / Batch file
Double-click `run_simulation.bat` or run in terminal:
```cmd
run_simulation.bat
```

#### Option 2: Using PowerShell
```powershell
.\run_simulation.ps1
```

#### Option 3: Manual compilation with Icarus Verilog (`iverilog`)
```cmd
# 1. 4-bit Up Counter
iverilog -o sim/sim_up.vvp src/up_counter_4bit.v tb/tb_up_counter.v
vvp sim/sim_up.vvp

# 2. 4-bit Down Counter
iverilog -o sim/sim_down.vvp src/down_counter_4bit.v tb/tb_down_counter.v
vvp sim/sim_down.vvp

# 3. 4-bit Up/Down Counter (Behavioral & Structural)
iverilog -o sim/sim_up_down.vvp src/up_down_counter_4bit.v src/structural_counters.v tb/tb_up_down_counter.v
vvp sim/sim_up_down.vvp
```

---

### Viewing Waveforms in GTKWave

The simulation outputs `.vcd` files inside the `sim/` directory. To open them in GTKWave:
```cmd
gtkwave sim/up_down_counter.vcd
```
1. In GTKWave, select `tb_up_down_counter` from the hierarchy.
2. Select signals `clk`, `reset`, `enable`, `up_down`, `count_beh[3:0]`, `count_str[3:0]`, `tc_beh`, and click **Append**.
3. Right click `count_beh[3:0]` $\to$ **Data Format** $\to$ **Decimal** to view numeric count steps.

---

### Project Report
The complete report is documented in [`PROJECT_REPORT.md`](file:///c:/Devansh/C/CS159/s3/dlcd%20mini/PROJECT_REPORT.md), covering:
- Problem Statement & Objectives
- Literature Survey (Ripple vs. Synchronous counters, T vs. JK flip-flops, commercial ICs)
- Design Theory & Boolean Logic Derivations (Lower-bit toggle conditions)
- 16-State Truth / State Tables with Flip-Flop Excitation values
- FSM State Diagrams (Clockwise and counter-clockwise 16-state rings)
- Gate-level circuit schematics
- Complete Verilog source code & testbenches
- Verified simulation transcripts & equivalence proofs
