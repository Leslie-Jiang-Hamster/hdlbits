module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter WALK = 2'b0, DIG = 2'b1, FALL = 2'b10;
    parameter L = 1'b0, R = 1'b1;
    reg [2:0] cs, ns;

    always @(*) begin
      if (cs[2:1] == WALK) begin
        if (~ground)
          ns = {FALL, cs[0]};
        else if (dig)
          ns = {DIG, cs[0]};
        else if (cs[0] == L && bump_left || cs[0] == R && bump_right)
          ns = {WALK, ~cs[0]};
        else
          ns = cs;
      end
      else if (cs[2:1] == DIG) begin
        if (~ground)
          ns = {FALL, cs[0]};
        else
          ns = cs;
      end
      else begin
        if (ground)
          ns = {WALK, cs[0]};
        else
          ns = cs;
      end
    end

    always @(posedge clk, posedge areset) begin
      if (areset)
        cs <= {WALK, L};
      else
        cs <= ns;
    end

    assign walk_left = cs == 0;
    assign walk_right = cs == 1;
    assign aaah = cs[2:1] == FALL;
    assign digging = cs[2:1] == DIG;
endmodule
