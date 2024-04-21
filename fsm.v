module top_module (
  input clk,
  input reset,      // Synchronous reset
  input data,
  output shift_ena,
  output counting,
  input done_counting,
  output done,
  input ack );

  parameter S=0,S1=1,S11=2,S110=3,B0=4,B1=5,B2=6,B3=7,COUNT=8,WAIT=9;
  reg [3:0]cs, ns;
  wire d;
  assign d = data;

  always @(*) begin
    if (cs==S)
      ns=cs+d;
    else if (cs==S1)
      ns=d?S11:S;
    else if (cs==S11)
      ns=cs+(d==0);
    else if (cs==S110)
      ns=d?B0:S;
    else if (4<=cs&&cs<=7)
      ns=cs+1;
    else if (cs==COUNT)
      ns=cs+done_counting;
    else
      ns=ack?S:WAIT;
  end

  always @(posedge clk) begin
    if (reset)
      cs <= S;
    else
      cs <= ns;
  end

  assign shift_ena = 4<=cs&&cs<=7;
  assign counting = cs==COUNT;
  assign done = cs==WAIT;
endmodule
