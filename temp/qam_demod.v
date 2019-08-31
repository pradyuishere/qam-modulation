module qam_demodulator(
  input signed [7:0] input_signal;
  input clk;
  input signed [7:0] sin_in;
  input signed [7:0] cos_in;
  output [2:0] data_demod;
  );

  reg signed [15:0] avg_filt_in1;
  wire signed [15:0] avg_filt_out1;

  reg signed [15:0] avg_filt_in2;
  wire signed [15:0] avg_filt_out2;

  moving_avg_filt mov_avg1(
    clk,
    avg_filt_in1,
    avg_filt_out1
    );

  moving_avg_filt mov_avg1(
    clk,
    avg_filt_in2,
    avg_filt_out2
    );

  always@(posedge clk) begin
    avg_filt_in1 = input_signal * sin_in;
    avg_filt_in2 = input_signal * cos_in;

    if (avg_filt_out1 > 0) begin
      data_demod[1] = 1;
    end // end if
    else begin
      data_demod[1] = 0;
    end

    if (avg_filt_out2 > 0) begin
      data_demod[0] = 1;
    end // end if
    else begin
      data_demod[0] = 0;
    end
  end //end posedge clk

endmodule
