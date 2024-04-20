module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);

    reg [2:0] cs;

    always @(posedge clk) begin
      if (reset)
        cs <= 4;
      else
        cs <= cs > 0 ? cs - 1 : 0;
    end

    assign shift_ena = cs > 0;
endmodule
