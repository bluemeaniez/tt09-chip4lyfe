/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_chip4lyfe (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out [3:0] = 0;
  assign uio_oe  = 1;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, uio_in, 1'b0};

  // initialize wires
  wire [7:0] innerstates_o;

  // instantiate lif neuron
  lif lif1_1 (.current(ui_in[3:0]), .clk(clk), .reset_n(rst_n), .state(innerstates_o[3:0]), .spk(uio_out[7]));
  lif lif2_1 (.current(ui_in[7:4]), .clk(clk), .reset_n(rst_n), .state(innerstates_o[7:4]), .spk(uio_out[6]));

  lif lif1_2 (.current({uio_out[7], innerstates_o[3:1]}), .clk(clk), .reset_n(rst_n), .state(uo_out[3:0]), .spk(uio_out[5]));
  lif lif2_2 (.current({uio_out[6], innerstates_o[7:5]}), .clk(clk), .reset_n(rst_n), .state(uo_out[7:4]), .spk(uio_out[4]));

endmodule
