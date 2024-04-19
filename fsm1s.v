// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;
    reg out;

    // Fill in state name declarations
    parameter A = 0, B = 1;
    reg cs, ns;

    always @(posedge clk)
        if (reset)
          cs <= B;
        else 
          cs <= ns;

    assign ns = ~(cs ^ in);
    assign out = cs;

endmodule
