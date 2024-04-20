module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
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
      if (reset)
        cs <= ERROR;
      else
        cs <= ns;
    end
 
    // Output logic
    assign done = cs == THREE;
endmodule
