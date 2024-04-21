module top_module ();
  parameter half = 5;
  reg clk;

  initial begin
    clk = 0;
    forever begin
      #half clk = 1;
      #half clk = 0;
    end
  end

  dut _ (clk);
endmodule