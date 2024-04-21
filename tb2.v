module top_module();
  reg clk, in, out;
  reg [2:0] s;

  initial begin
    clk = 0;
    forever begin
      #5 clk = 1;
      #5 clk = 0;
    end
  end

  initial begin
    in = 0;
    #20 in = 1;
    #10 in = 0;
    #10 in = 1;
    #30 in = 0;
  end

  initial begin
    s = 2;
    #10 s = 6;
    #10 s = 2;
    #10 s = 7;
    #10 s = 0;
  end

  q7 _ (clk, in, s, out);
endmodule