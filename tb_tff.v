module top_module ();
  reg clk, reset, t, q;

  initial begin
    clk = 0;
    forever begin
      #5 clk = 1;
      #5 clk = 0;
    end
  end

  initial begin
    reset = 1;
    #10 reset = 0;
  end

  initial begin
    t = 0;
    #10 t = 1;
    #10 t = 0;
  end

  tff _ (clk, reset, t, q);
endmodule
