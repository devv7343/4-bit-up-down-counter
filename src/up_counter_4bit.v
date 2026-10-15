// ============================================================================
// Module Name:  up_counter_4bit
// Project:      DLCD Lab Project - Problem No. 8
// Description:  4-Bit Synchronous Up Counter (Behavioral Model)
//               Counts cyclically from 0 to 15 (0000 to 1111) and wraps to 0.
// Inputs:       clk   - Positive edge-triggered clock
//               reset - Active-high synchronous/asynchronous reset
//               enable- Active-high count enable
// Outputs:      count - 4-bit present counter value [3:0]
//               tc    - Terminal count (high when count == 15)
// ============================================================================

`timescale 1ns / 1ps

module up_counter_4bit (
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,
    output reg  [3:0] count,
    output wire       tc
);

    // Terminal count indicator: High when counter reaches maximum value 15 (4'b1111)
    assign tc = (count == 4'b1111) & enable;

    // Sequential logic for synchronous counting with asynchronous active-high reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000;
        end else if (enable) begin
            if (count == 4'b1111) begin
                count <= 4'b0000;  // Wrap around from 15 to 0
            end else begin
                count <= count + 1'b1;
            end
        end
        // If enable is 0, count retains its state
    end

endmodule
