module qam_mixer(
  input clk,
  input rst,
  input signed [1:0] data_in,
  input signed [7:0] sin_in,
  input signed [7:0] cos_in,
  output signed [7:0] signal_out
  );

  reg signed [7:0] cos_part;
  reg signed [7:0] sin_part;

  always@(posedge clk)
  begin
    if (~rst)
    begin
      sin_part = 0;
      cos_part = 0;
    end
    else
    begin
      if (data_in[1] == 0) sin_part = ~sin_in + 1;
      if (data_in[1] == 1) sin_part = sin_in;
      if (data_in[0] == 0) cos_part = ~cos_in + 1;
      if (data_in[0] == 1) cos_part = cos_in;
    end
  end //end always@(posedge clk)

  assign signal_out = sin_part + cos_part;

  endmodule
