module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 

  parameter IDLE=12, START=0, STOP=11, WAIT=10;
  reg [3:0] cs, ns;
  reg [8:0] out;

  always @(*) begin
    if (cs == IDLE)
      ns = in ? cs : START;
    else if (0 <= cs && cs < 9)
      ns = cs + 1;
    else if (cs == 9)
      ns = in ? STOP : WAIT;
    else if (cs == WAIT)
      ns = in ? IDLE : WAIT;
    else
      ns = in ? IDLE : START;
  end

  always @(posedge clk) begin
    if (reset) begin
      cs <= IDLE;
      out <= 0;
    end
    else begin
      cs <= ns;
      if (1 <= ns && ns <= 9)
        out[ns - 1] <= in;
    end
  end

  assign out_byte = out[7:0];
  assign done = cs == STOP && ^out == 1;
endmodule
