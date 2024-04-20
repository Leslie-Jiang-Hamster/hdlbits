module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    parameter ERROR = 2'b0, ONE = 2'b1, TWO = 2'b10, THREE = 2'b11;
    reg [1:0] cs, ns;
    wire bit3;
    assign bit3 = in[3];
    // State transition logic (combinational)
    always @(*) begin
      if (cs == ERROR)
        ns = bit3 ? ONE : ERROR;
      else if (cs == ONE || cs == TWO)
        ns = cs + 1;
      else
        ns = bit3 ? ONE : ERROR;
    end

    // State flip-flops (sequential)
    always @(posedge clk) begin
      if (reset) begin
        cs <= ERROR;
        out_bytes <= 0;
      end
      else begin
        cs <= ns;
        if (ns == ERROR)
          out_bytes <= 0;
        else if (ns == ONE)
          out_bytes[23:16] <= in;
        else if (ns == TWO)
          out_bytes[15:8] <= in;
        else
          out_bytes[7:0] <= in;
      end
    end
 
    // Output logic
    assign done = cs == THREE;
endmodule
