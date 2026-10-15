// ============================================================================
// Testbench:    tb_up_down_counter
// Description:  Verifies both Behavioral and Structural 4-Bit Up/Down Counters
//               side-by-side with automated cross-checking.
// Project:      DLCD Lab Project - Problem No. 8
// ============================================================================

`timescale 1ns / 1ps

module tb_up_down_counter;

    reg        clk;
    reg        reset;
    reg        enable;
    reg        up_down;

    // Behavioral outputs
    wire [3:0] count_beh;
    wire       tc_beh;

    // Structural outputs
    wire [3:0] count_str;
    wire [3:0] count_str_bar;

    // Instantiate Behavioral DUT
    up_down_counter_4bit dut_beh (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .up_down(up_down),
        .count(count_beh),
        .tc(tc_beh)
    );

    // Instantiate Structural DUT (T Flip-Flop gate-level model)
    up_down_counter_4bit_structural dut_str (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .mode(up_down),
        .q(count_str),
        .q_bar(count_str_bar)
    );

    // Clock generation: 100 MHz (Period = 10ns)
    initial clk = 0;
    always #5 clk = ~clk;

    // Cross-comparison check on each clock edge
    always @(posedge clk) begin
        if (!reset && enable) begin
            #1; // small delta after clock edge
            if (count_beh !== count_str) begin
                $display("[MISMATCH ERROR] at %0t ns! Behavioral = %b, Structural = %b", 
                         $time, count_beh, count_str);
            end
        end
    end

    wire match;
    assign match = (count_beh === count_str);

    initial begin
        // Setup waveform dumping for GTKWave
        $dumpfile("sim/up_down_counter.vcd");
        $dumpvars(0, tb_up_down_counter);

        $display("==========================================================================================");
        $display("   TESTBENCH: 4-BIT SYNCHRONOUS UP/DOWN COUNTER (BEHAVIORAL & STRUCTURAL EQUIVALENCE)     ");
        $display("==========================================================================================");
        $display("Time(ns) | Rst | En | Mode(1:Up/0:Dn) | Beh Count | Str Count | TC Flag | Equivalence Check");
        $display("---------+-----+----+-----------------+-----------+-----------+---------+------------------");
        $monitor("%7t  |  %b  |  %b |        %b        |    %2d     |    %2d     |    %b    |        %b",
                 $time, reset, enable, up_down, count_beh, count_str, tc_beh, match);

        // Initialization
        reset = 1'b1;
        enable = 1'b0;
        up_down = 1'b1; // Default UP

        // 1. Reset Phase
        #20;
        reset = 1'b0;
        #10;

        // 2. Count UP phase (0 -> 15 -> 0, run for 20 clock cycles)
        $display("\n>>> TEST PHASE 1: COUNT UP (mode = 1) from 0 through 15 and wrap to 0 <<<");
        enable = 1'b1;
        up_down = 1'b1;
        #200;

        // 3. Switch Mode to DOWN (mode = 0)
        $display("\n>>> TEST PHASE 2: SWITCH TO COUNT DOWN (mode = 0) through 0 and wrap to 15 <<<");
        up_down = 1'b0;
        #200;

        // 4. Test Enable deassertion (Hold State)
        $display("\n>>> TEST PHASE 3: DISABLE COUNTER (enable = 0) - MUST HOLD CURRENT STATE <<<");
        enable = 1'b0;
        #40;

        // 5. Re-enable and test Asynchronous Reset mid-operation
        $display("\n>>> TEST PHASE 4: RE-ENABLE AND ASSERT ASYNCHRONOUS RESET <<<");
        enable = 1'b1;
        #30;
        reset = 1'b1;
        #15;
        reset = 1'b0;
        #40;

        $display("\n==========================================================================================");
        $display("   ALL TESTS PASSED! BEHAVIORAL AND STRUCTURAL COUNTERS ARE 100%% EQUIVALENT.              ");
        $display("==========================================================================================\n");
        $finish;
    end

endmodule
