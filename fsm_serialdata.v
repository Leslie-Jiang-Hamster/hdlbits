module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 

  parameter IDLE=11, START=0, STOP=10, WAIT=9;
  reg [3:0] cs, ns;

  always @(*) begin
    if (cs == IDLE)
      ns = in ? cs : START;
    else if (0 <= cs && cs < 8)
      ns = cs + 1;
    else if (cs == 8)
      ns = in ? STOP : WAIT;
    else if (cs == WAIT)
      ns = in ? IDLE : WAIT;
    else
      ns = in ? IDLE : START;
  end

  always @(posedge clk) begin
    if (reset) begin
      cs <= IDLE;
      out_byte <= 0;
    end
    else begin
      cs <= ns;
      if (1 <= ns && ns <= 8)
        out_byte[ns - 1] <= in;
    end
  end

  assign done = cs == STOP;
endmodule
