module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    reg [1:0] cs, ns;

    always @(*) begin
      if (cs == 0)
        ns = cs + x;
      else if (cs == 1)
        ns = cs + (x == 0);
      else
        ns = x;
    end

    always @(posedge clk, negedge aresetn) begin
      if (~aresetn)
        cs <= 0;
      else
        cs <= ns;
    end

    assign z = cs == 2 && x;
endmodule
