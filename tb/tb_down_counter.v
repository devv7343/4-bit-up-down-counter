// ============================================================================
// Testbench:    tb_down_counter
// Module Under Test: down_counter_4bit
// Project:      DLCD Lab Project - Problem No. 8
// ============================================================================

`timescale 1ns / 1ps

module tb_down_counter;

    reg        clk;
    reg        reset;
    reg        enable;
    wire [3:0] count;
    wire       borrow_out;

    // Instantiate Device Under Test (DUT)
    down_counter_4bit #(
        .RESET_VAL(4'b1111)
    ) uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count),
        .borrow_out(borrow_out)
    );

    // Clock generation: 100 MHz (Period = 10ns, Toggle every 5ns)
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Setup waveform dumping for GTKWave
        $dumpfile("down_counter.vcd");
        $dumpvars(0, tb_down_counter);

        // Header for simulation log
        $display("======================================================================");
        $display("  TESTBENCH: 4-BIT SYNCHRONOUS DOWN COUNTER (15 -> 0 -> 15)           ");
        $display("======================================================================");
        $display("Time(ns) | Reset | Enable | Count (Dec) | Count (Bin) | Borrow Out");
        $display("---------+-------+--------+-------------+-------------+-----------");
        $monitor("%7t  |   %b   |   %b    |     %2d      |    4'b%04b   |     %b", 
                 $time, reset, enable, count, count, borrow_out);

        // Initialize signals
        reset = 1'b1;
        enable = 1'b0;

        // Hold reset for 20ns
        #20;
        reset = 1'b0;
        #10;

        // Enable counter: Observe counting from 15 down to 0 and wrapping back to 15
        enable = 1'b1;
        #200; // 20 clock cycles (covers 15 to 0 plus 4 cycles of next wrap)

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
        $display("  DOWN COUNTER SIMULATION COMPLETED SUCCESSFULLY                      ");
        $display("   -> VCD Waveform saved: down_counter.vcd                            ");
        $display("   -> View with: gtkwave down_counter.vcd                             ");
        $display("======================================================================\n");
        $finish;
    end

endmodule
