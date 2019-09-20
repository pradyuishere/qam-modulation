module tb;

	reg clk;
	reg rst;
	reg [1:0] data_in;

	integer data_in_count;
	integer data_in_counter;

  wire [7:0] data_modulated;
  wire [7:0] sin_out;
  wire [7:0] cos_out;

  wire clk_out_wire;


	modulator u1 (
		clk,
		rst,
		data_in,
    data_modulated,
    sin_out,
    cos_out,
    clk_out_wire
	);

	initial begin
		data_in_count = 1000;
		data_in_counter = 0;
		$dumpfile("modulated.vcd");
		$dumpvars;
		clk = 0;
		rst = 0;
		data_in = 0;
		#10000;
		rst = 1;
		#1000000;
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
