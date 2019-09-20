module modulator (
  input clk,
  input rst,
  input [1:0] data_in,
  output [7:0] data_modulated,
  output [7:0] sin_out,
  output [7:0] cos_out,
  output wire clk_out_wire
  );

  assign clk_out_wire = clk_qam_mixer;
  assign sin_out = sin_out_sampled;
  assign cos_out = cos_out_sampled;

  reg clk_qam_mixer;

	integer clk_mixer_count;
	integer data_in_count;

	integer clk_mixer_counter;
	integer data_in_counter;

	reg [1:0] data_in_sampled;
	wire [7:0] signal_out_qam_mixer;

	wire signed [7:0] sin_out_sampled;
	wire signed [7:0] cos_out_sampled;

  sin_cos u1(clk, sin_out_sampled, cos_out_sampled);

  qam_mixer uu1(
    clk_qam_mixer,
    rst,
    data_in_sampled,
    sin_out_sampled,
    cos_out_sampled,
    data_modulated
  );

  initial begin
		clk_qam_mixer = 0;

		clk_mixer_count = 8;
		data_in_count = 1000;

		clk_mixer_counter = 0;
		data_in_counter = 0;
	end //end initial

  always@(posedge clk) begin
    clk_qam_mixer = 0;
    clk_mixer_counter = 1 + clk_mixer_counter;
    if (clk_mixer_counter == clk_mixer_count) begin
      clk_qam_mixer = 1;
      clk_mixer_counter = 0;
    end
  end // always clk_mixer_counter

  always@(posedge clk) begin
    data_in_counter = data_in_counter + 1;
    if (data_in_counter == data_in_count) begin
      data_in_sampled = data_in;
      data_in_counter = 0;
    end
  end // always data_in_counter

endmodule
