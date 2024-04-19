module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=2'b00, B=2'b01, C=2'b10, D=2'b11;

    // State transition logic: next_state = f(state, in)
    always @(*) begin
      case ({state, in})
        {A, 1'b0}: next_state = A;
        {A, 1'b1}: next_state = B;
        {B, 1'b0}: next_state = C;
        {B, 1'b1}: next_state = B;
        {C, 1'b0}: next_state = A;
        {C, 1'b1}: next_state = D;
        {D, 1'b0}: next_state = C;
        default: next_state = B;
      endcase
      out = (state == D);
    end
    // Output logic:  out = f(state) for a Moore state machine

endmodule
