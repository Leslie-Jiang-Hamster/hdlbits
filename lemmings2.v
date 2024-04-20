module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    parameter L = 1'b0, R = 1'b1;
    parameter NOT_FALL = 1'b0, FALL = 1'b1;
    reg [1:0] cs, ns;

    always @(*) begin
      if (cs[1] == FALL && ~ground)
        ns = cs;
      else if (cs[1] == FALL && ground)
        ns = cs & 1;
      else if (cs[1] != FALL && ~ground)
        ns = cs | 2;
      else if (cs[0] == L && bump_left || cs[0] == R && bump_right)
        ns = {cs[1], ~cs[0]};
      else
        ns = cs;
    end

    always @(posedge clk, posedge areset) begin
      if (areset)
        cs <= {NOT_FALL, L};
      else
        cs <= ns;
    end

    assign walk_left = cs == {NOT_FALL, L};
    assign walk_right = cs == {NOT_FALL, R};
    assign aaah = cs[1] == FALL;
endmodule
