/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_up_down_counter (
    input   [7:0] ui_in,    // Dedicated inputs
    output  [7:0] uo_out,   // Dedicated outputs
    input   [7:0] uio_in,   // IOs: Input path
    output  [7:0] uio_out,  // IOs: Output path
    output  [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input         ena,      // always 1 when the design is powered, so you can ignore it
    input         clk,      // clock
    input         rst_n     // reset_n - low to reset
);
    logic [1:0] count;
    always @(posedge clk) begin
        if (!rst_n) begin
            count <= 2'b00; // Reset count to zero
        end else begin
            if (ui_in[0]) begin // up-down signal; 1 for up, 0 for down
                count <= count + 1'b1; // Increment
            end else begin
                count <= count - 1'b1; // Decrement
            end
        end
    end

    // All output pins must be assigned. If not used, assign to 0.
    assign uo_out  = {6'b0, count};  
    assign uio_out = 0;
    assign uio_oe  = 0;
    
    // List all unused inputs to prevent warnings
    logic _unused;
    assign _unused = &{ena, ui_in[7:1], uio_in, 1'b0};

endmodule
