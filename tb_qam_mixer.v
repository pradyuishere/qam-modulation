module tb;
  reg clk_main;
  integer clk_mixer_count;
  integer clk_sin_and_cos_count;
  integer data_in_count;

  reg clk_qam_mixer;
  reg rst_qam_mixer;
  reg [1:0] data_in_qam_mixer;
  wire signed [7:0] sin_in_qam_mixer;
  wire signed [7:0] cos_in_qam_mixer;
  wire signed [7:0] signal_out_qam_mixer;

  reg clk_sin_and_cos;

  sin_cos u1(
    .Clk(clk_sin_and_cos),
    .data_sin(sin_in_qam_mixer),
    .data_cos(cos_in_qam_mixer)
    );

  qam_mixer uu1(
    .clk(clk_qam_mixer),
    .rst(rst_qam_mixer),
    .data_in(data_in_qam_mixer),
    .sin_in(sin_in_qam_mixer),
    .cos_in(cos_in_qam_mixer),
    .signal_out(signal_out_qam_mixer)
    );

    initial begin
      $dumpfile("qam_mixer.vcd");
      $dumpvars;
      data_in_qam_mixer = 2'b0;
      data_in_count = 0;
      clk_main = 0;
      clk_qam_mixer = 0;
      clk_sin_and_cos = 0;
      rst_qam_mixer = 0;
      clk_mixer_count = 0;
      clk_sin_and_cos_count = 0;
      #10000 rst_qam_mixer = 1;
      #1000000 $finish;
    end // end initial

    always #5 clk_main = ~clk_main;

    always@(posedge clk_main)
    begin
      clk_mixer_count = clk_mixer_count + 1;
      if (clk_mixer_count == 2)
      begin
        clk_mixer_count = 0;
        clk_qam_mixer = ~clk_qam_mixer;
      end
      clk_sin_and_cos = ~clk_sin_and_cos;
    end // end posedge clk_main
    always@(posedge clk_qam_mixer)
    begin
      data_in_count = data_in_count + 1;
      if (data_in_count == 10000)
      begin
        data_in_count = 0;
        data_in_qam_mixer = data_in_qam_mixer + 1;
      end
    end

endmodule
