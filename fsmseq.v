module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

    reg [1:0] cs, ns;

    always @(*) begin
      if (cs == 0)
        ns = cs + data;
      else if (cs == 1)
        ns = data ? 2 : 0;
      else if (cs == 2)
        ns = cs + (data == 0);
      else
        ns = data;
    end

    always @(posedge clk) begin
      if (reset)
        cs <= 0;
      else
        cs <= ns;
    end

    always @(posedge clk) begin
      if (reset)
        start_shifting <= 0;
      else if (cs == 3 && data)
        start_shifting <= 1;
      else
        start_shifting <= start_shifting;
    end
endmodule
