// ============================================================================
// Module Name:  structural_counters.v
// Project:      DLCD Lab Project - Problem No. 8
// Description:  Gate-Level / Structural Implementation of 4-bit Synchronous
//               Up, Down, and Up/Down Counters using T Flip-Flops and Logic Gates.
// ============================================================================

`timescale 1ns / 1ps

// ----------------------------------------------------------------------------
// Primitive: T Flip-Flop with Asynchronous Active-High Reset
// ----------------------------------------------------------------------------
module t_flip_flop (
    input  wire clk,
    input  wire reset,
    input  wire t,
    output reg  q,
    output wire q_bar
);
    assign q_bar = ~q;

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 1'b0;
        else if (t)
            q <= ~q;
    end
endmodule

// ----------------------------------------------------------------------------
// Primitive: JK Flip-Flop with Asynchronous Active-High Reset
// ----------------------------------------------------------------------------
module jk_flip_flop (
    input  wire clk,
    input  wire reset,
    input  wire j,
    input  wire k,
    output reg  q,
    output wire q_bar
);
    assign q_bar = ~q;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 1'b0;
        end else begin
            case ({j, k})
                2'b00: q <= q;     // No change
                2'b01: q <= 1'b0;  // Reset
                2'b10: q <= 1'b1;  // Set
                2'b11: q <= ~q;    // Toggle
            endcase
        end
    end
endmodule

// ----------------------------------------------------------------------------
// Structural 4-Bit Synchronous Up Counter
// T0 = enable
// T1 = enable & Q0
// T2 = enable & Q0 & Q1
// T3 = enable & Q0 & Q1 & Q2
// ----------------------------------------------------------------------------
module up_counter_4bit_structural (
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,
    output wire [3:0] q,
    output wire [3:0] q_bar
);
    wire t0, t1, t2, t3;

    assign t0 = enable;
    assign t1 = enable & q[0];
    assign t2 = enable & q[0] & q[1];
    assign t3 = enable & q[0] & q[1] & q[2];

    t_flip_flop ff0 (.clk(clk), .reset(reset), .t(t0), .q(q[0]), .q_bar(q_bar[0]));
    t_flip_flop ff1 (.clk(clk), .reset(reset), .t(t1), .q(q[1]), .q_bar(q_bar[1]));
    t_flip_flop ff2 (.clk(clk), .reset(reset), .t(t2), .q(q[2]), .q_bar(q_bar[2]));
    t_flip_flop ff3 (.clk(clk), .reset(reset), .t(t3), .q(q[3]), .q_bar(q_bar[3]));

endmodule

// ----------------------------------------------------------------------------
// Structural 4-Bit Synchronous Down Counter
// T0 = enable
// T1 = enable & ~Q0
// T2 = enable & ~Q0 & ~Q1
// T3 = enable & ~Q0 & ~Q1 & ~Q2
// ----------------------------------------------------------------------------
module down_counter_4bit_structural (
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,
    output wire [3:0] q,
    output wire [3:0] q_bar
);
    wire t0, t1, t2, t3;

    assign t0 = enable;
    assign t1 = enable & q_bar[0];
    assign t2 = enable & q_bar[0] & q_bar[1];
    assign t3 = enable & q_bar[0] & q_bar[1] & q_bar[2];

    t_flip_flop ff0 (.clk(clk), .reset(reset), .t(t0), .q(q[0]), .q_bar(q_bar[0]));
    t_flip_flop ff1 (.clk(clk), .reset(reset), .t(t1), .q(q[1]), .q_bar(q_bar[1]));
    t_flip_flop ff2 (.clk(clk), .reset(reset), .t(t2), .q(q[2]), .q_bar(q_bar[2]));
    t_flip_flop ff3 (.clk(clk), .reset(reset), .t(t3), .q(q[3]), .q_bar(q_bar[3]));

endmodule

// ----------------------------------------------------------------------------
// Structural 4-Bit Synchronous Up/Down Counter with Mode Select (mode: 1=UP, 0=DOWN)
// T0 = enable
// T1 = enable & ((mode & Q0) | (~mode & ~Q0))
// T2 = enable & ((mode & Q0 & Q1) | (~mode & ~Q0 & ~Q1))
// T3 = enable & ((mode & Q0 & Q1 & Q2) | (~mode & ~Q0 & ~Q1 & ~Q2))
// ----------------------------------------------------------------------------
module up_down_counter_4bit_structural (
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,
    input  wire       mode,       // 1 = UP, 0 = DOWN
    output wire [3:0] q,
    output wire [3:0] q_bar
);
    wire t0, t1, t2, t3;
    wire mode_bar;

    assign mode_bar = ~mode;

    assign t0 = enable;
    assign t1 = enable & ((mode & q[0]) | (mode_bar & q_bar[0]));
    assign t2 = enable & ((mode & q[0] & q[1]) | (mode_bar & q_bar[0] & q_bar[1]));
    assign t3 = enable & ((mode & q[0] & q[1] & q[2]) | (mode_bar & q_bar[0] & q_bar[1] & q_bar[2]));

    t_flip_flop ff0 (.clk(clk), .reset(reset), .t(t0), .q(q[0]), .q_bar(q_bar[0]));
    t_flip_flop ff1 (.clk(clk), .reset(reset), .t(t1), .q(q[1]), .q_bar(q_bar[1]));
    t_flip_flop ff2 (.clk(clk), .reset(reset), .t(t2), .q(q[2]), .q_bar(q_bar[2]));
    t_flip_flop ff3 (.clk(clk), .reset(reset), .t(t3), .q(q[3]), .q_bar(q_bar[3]));

endmodule
