module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=1'b0, ON=1'b1; 
    reg cs, ns;

    always @(*) begin
      if (j && cs == OFF)
        ns = ON;
      else if (k && cs == ON)
        ns = OFF;
      else
        ns = cs;
    end

    always @(posedge clk, posedge areset) begin
      if (areset)
        cs = OFF;
      else
        cs = ns;
    end

    // Output logic
    // assign out = (state == ...);
    assign out = cs;
endmodule
