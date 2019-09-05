module tb;

	reg clk;
	reg rst;
	reg [1:0] data_in;
  wire [1:0] data_demod_out;

	integer data_in_count;
	integer data_in_counter;

	integer signal_out_counter;
	integer signal_out_count;

	reg [7:0] signal_out_temp;
	reg [7:0] signal_out_final;

  combined u1 (
    clk,
    rst,
    data_in,
    data_demod_out
  );

  initial begin
    signal_out_count = 8;
    signal_out_counter = 0;
    data_in_count = 8000;
    data_in_counter = 0;
    $dumpfile("combined.vcd");
    $dumpvars;
    clk = 0;
    rst = 0;
    data_in = 0;
    #10000;
    rst = 1;
    #100000;
    $finish;
  end


	always begin
		#1 clk = ~clk;
	end

	always @ (posedge clk) begin
		data_in_counter = data_in_counter + 1;
		if (data_in_counter == data_in_count) begin
			data_in_counter = 0;
			data_in = data_in + 1;
		end
	end

endmodule
