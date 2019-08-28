module tb;

	reg clk;
	reg rst;
	reg [1:0] data_in;
	wire data_bit_out;
	wire data_out_complete_bit;
	
	reg data_in_count;
	reg data_in_counter;
	
	reg signal_out_counter;
	reg signal_out_count;
	
	reg signed [7:0] signal_out_temp;
	reg signed [7:0] signal_out_final;
	
	top u1 (
		clk,
		rst,
		data_in,
		data_bit_out,
		data_out_complete_bit
	);
	
	initial begin
		signal_out_count = 8;
		signal_out_counter = 0;
		data_in_count = 1000;
		data_in_counter = 0;
		$dumpfile("top.vcd");
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
	
	always @ (posedge clk) begin
		signal_out_counter = signal_out_counter + 1;
		signal_out_temp[signal_out_counter - 1] = data_bit_out;
		if (signal_out_counter == signal_out_count) begin
			signal_out_counter = 0;
			signal_out_final = signal_out_temp;
		end
	end

endmodule
