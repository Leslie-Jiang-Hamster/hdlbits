module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
  
  reg [2:0] cs, ns, ps;
  reg reset_;

  always @(*) begin
    if (in)
      ns = cs < 7 ? cs + 1 : cs;
    else
      ns = 0;
  end

  always @(posedge clk) begin
    ps <= cs;
    if (reset) begin
      cs <= 0;
      reset_ <= 1;
    end
    else begin
      cs <= ns;
      reset_ <= 0;
    end
  end

  assign disc = cs == 0 && ps == 5 && ~reset_;
  assign flag = cs == 0 && ps == 6 && ~reset_;
  assign err = cs == 7;
endmodule
