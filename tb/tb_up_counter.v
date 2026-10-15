// ============================================================================
// Testbench:    tb_up_counter
// Module Under Test: up_counter_4bit
// Project:      DLCD Lab Project - Problem No. 8
// ============================================================================

`timescale 1ns / 1ps

module tb_up_counter;

    reg        clk;
    reg        reset;
    reg        enable;
    wire [3:0] count;
    wire       tc;

    // Instantiate Device Under Test (DUT)
    up_counter_4bit uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count),
        .tc(tc)
    );

    // Clock generation: 100 MHz (Period = 10ns, Toggle every 5ns)
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Setup waveform dumping for GTKWave
        $dumpfile("sim/up_counter.vcd");
        $dumpvars(0, tb_up_counter);

        // Header for simulation log
        $display("======================================================================");
        $display("   TESTBENCH: 4-BIT SYNCHRONOUS UP COUNTER (0 -> 15 -> 0)             ");
        $display("======================================================================");
        $display("Time(ns) | Reset | Enable | Count (Dec) | Count (Bin) | Terminal Count");
        $display("---------+-------+--------+-------------+-------------+---------------");
        $monitor("%7t  |   %b   |   %b    |     %2d      |    4'b%04b   |       %b", 
                 $time, reset, enable, count, count, tc);

        // Initialize signals
        reset = 1'b1;
        enable = 1'b0;

        // Hold reset for 20ns
        #20;
        reset = 1'b0;
        #10;

        // Enable counter: Observe counting from 0 to 15 and wrapping back to 0
        enable = 1'b1;
        #200; // 20 clock cycles (covers 0 to 15 plus 4 cycles of next wrap)

        // Test enable deassertion (hold count state)
        $display("\n--- Testing Enable Deassertion (Hold State) ---");
        enable = 1'b0;
        #30;

        // Re-enable and test asynchronous reset
        $display("\n--- Testing Re-enable and Asynchronous Reset ---");
        enable = 1'b1;
        #20;
        reset = 1'b1;
        #10;
        reset = 1'b0;
        #30;

        $display("\n======================================================================");
        $display("   UP COUNTER SIMULATION COMPLETED SUCCESSFULLY                       ");
        $display("======================================================================\n");
        $finish;
    end

endmodule
