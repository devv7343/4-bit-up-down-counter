// ============================================================================
// Module Name:  up_down_counter_4bit
// Project:      DLCD Lab Project - Problem No. 8
// Description:  4-Bit Synchronous Up/Down Counter with Mode Select
//               mode = 1'b1 : Counts UP   (0 -> 15, wraps to 0)
//               mode = 1'b0 : Counts DOWN (15 -> 0, wraps to 15)
// Inputs:       clk     - Positive edge-triggered clock
//               reset   - Active-high synchronous/asynchronous reset
//               enable  - Count enable (active-high)
//               up_down - Direction control (1 = UP, 0 = DOWN)
// Outputs:      count   - 4-bit counter output [3:0]
//               tc      - Terminal count flag (15 when counting UP, 0 when counting DOWN)
// ============================================================================

`timescale 1ns / 1ps

module up_down_counter_4bit (
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,
    input  wire       up_down,    // 1: Up count, 0: Down count
    output reg  [3:0] count,
    output wire       tc
);

    // Terminal count indicator based on active mode
    assign tc = enable & ((up_down & (count == 4'b1111)) | (~up_down & (count == 4'b0000)));

    // Sequential counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000;
        end else if (enable) begin
            if (up_down) begin
                // Counting UP: 0 -> 15 -> 0
                if (count == 4'b1111)
                    count <= 4'b0000;
                else
                    count <= count + 1'b1;
            end else begin
                // Counting DOWN: wraps from 0 to 15
                if (count == 4'b0000)
                    count <= 4'b1111;
                else
                    count <= count - 1'b1;
            end
        end
    end

endmodule
