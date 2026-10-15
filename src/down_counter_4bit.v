// ============================================================================
// Module Name:  down_counter_4bit
// Project:      DLCD Lab Project - Problem No. 8
// Description:  4-Bit Synchronous Down Counter (Behavioral Model)
//               Counts cyclically from 15 down to 0 (1111 to 0000) and wraps to 15.
// Inputs:       clk       - Positive edge-triggered clock
//               reset     - Active-high reset
//               enable    - Active-high count enable
// Outputs:      count     - 4-bit present counter value [3:0]
//               borrow_out- Terminal borrow indicator (high when count == 0)
// ============================================================================

`timescale 1ns / 1ps

module down_counter_4bit #(
    parameter RESET_VAL = 4'b1111
)(
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,
    output reg  [3:0] count,
    output wire       borrow_out
);

    // Borrow indicator: High when counter reaches minimum value 0 (4'b0000)
    assign borrow_out = (count == 4'b0000) & enable;

    // Sequential logic for synchronous down-counting with asynchronous active-high reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= RESET_VAL;
        end else if (enable) begin
            if (count == 4'b0000) begin
                count <= 4'b1111;  // Wrap around from 0 to 15
            end else begin
                count <= count - 1'b1;
            end
        end
        // If enable is 0, count retains its state
    end

endmodule
