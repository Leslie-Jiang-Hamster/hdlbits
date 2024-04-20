module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    // parameter LEFT=0, RIGHT=1, ...
    parameter L=0, R=1;
    reg state, next_state;

    always @(*) begin
        // State transition logic
        if (state == L && bump_left)
          next_state = R;
        else if (state == R && bump_right)
          next_state = L;
        else
          next_state = state;
    end

    always @(posedge clk, posedge areset) begin
        if (areset)
          state <= L;
        else
          state <= next_state;
    end

    // Output logic
    // assign walk_left = (state == ...);
    // assign walk_right = (state == ...);
    assign walk_left = state == L;
    assign walk_right = state == R;

endmodule
