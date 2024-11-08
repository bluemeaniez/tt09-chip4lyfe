`default_nettype none

module lif(
    input wire [3:0]    current,
    input wire          clk,
    input wire          reset_n,
    output reg [3:0]    state,
    output wire         spk
);

    wire [3:0] next_state;  // 4-bit next state variable
    reg [3:0] threshold;    // spike threshold

    always @(posedge clk) begin
        if(!reset_n) begin
            state <= 0;
            threshold <= 8;
            // beta <= 10;
        end else begin
            state <= next_state;
        end    
    end

    // next state logic
    assign next_state = current + (spk ? 0 : (state >> 1)); // reset state to 0 after `spk` is fired, when the state meets/surpasses the threshold

    // spike logic
    assign spk = (state >= threshold);

endmodule
