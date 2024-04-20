module top_module(
    input clk,
    input in,
    input areset,
    output out); //
    parameter A=0, B=1, C=2, D=3;
    reg [3:0] cs, ns;
    // State transition logic
    always @(*) begin
      ns[A] = (cs[A]|cs[C])&~in;
      ns[B] = (cs[A]|cs[B]|cs[D])&in;
      ns[C] = (cs[B]|cs[D])&~in;
      ns[D] = cs[C]&in;
    end
    // State flip-flops with asynchronous reset
    always @(posedge clk, posedge areset) begin
      if (areset)
        cs <= (1 << A);
      else
        cs <= ns;
    end
    // Output logic
    assign out = cs == (1 << D);
endmodule
