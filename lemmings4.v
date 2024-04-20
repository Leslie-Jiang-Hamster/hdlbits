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

    parameter WALK = 2'b0, DIG = 2'b1, FALL = 2'b10, SPLAT = 2'b11;
    parameter L = 1'b0, R = 1'b1;
    reg [2:0] cs, ns;
    reg [4:0] cnt;

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
      else if (cs[2:1] == FALL) begin
        if (ground && cnt >= 20)
          ns = {SPLAT, cs[0]};
        else if (ground)
          ns = {WALK, cs[0]};
        else
          ns = cs;
      end
      else
        ns = cs;
    end

    always @(posedge clk, posedge areset) begin
      if (areset) begin
        cs <= {WALK, L};
        cnt <= 0;
      end
      else if (cs[2:1] == FALL) begin
        cs <= ns;
        cnt <= (cnt >= 20) ? cnt : cnt + 1;
      end
      else begin
        cs <= ns;
        cnt <= 0;
      end
    end

    assign walk_left = cs == 0;
    assign walk_right = cs == 1;
    assign aaah = cs[2:1] == FALL;
    assign digging = cs[2:1] == DIG;
endmodule
