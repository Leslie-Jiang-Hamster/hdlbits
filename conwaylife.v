module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
  always @(posedge clk) begin
    if (load)
      q <= data;
    else begin
      for (integer i = 0; i < 16; i += 1) begin
        for (integer j = 0; j < 16; j += 1) begin
          case (q[i*16+(j+1)%16]+q[i*16+(j-1+16)%16]+q[((i-1+16)%16)*16+(j+1)%16]+q[((i-1+16)%16)*16+j]+q[((i-1+16)%16)*16+(j-1+16)%16]+q[((i+1)%16)*16+(j-1+16)%16]+q[((i+1)%16)*16+j]+q[((i+1)%16)*16+(j+1)%16])
            2: q[i*16+j] <= q[i*16+j];
            3: q[i*16+j] <= 1;
            default: q[i*16+j] <= 0;
          endcase
        end
      end
    end
  end
endmodule
