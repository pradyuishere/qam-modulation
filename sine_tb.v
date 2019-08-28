module tb;

    // Inputs
    reg Clk;
    reg en;
    reg reset;

    // Outputs
    wire signed [7:0] data_out1;
    wire signed [7:0] data_out2;

    // Instantiate the Unit Under Test (UUT)
    sin_cos inst(Clk, data_out1, data_out2);
    // sine_wave_gen uut (
    //     .Clk(Clk),
    //     .data_out(data_out)
    // );

    //Generate a clock with 10 ns clock period.
    initial
      begin

$dumpfile("test.vcd");
$dumpvars;
      reset = 1;
      #100;
      en = 1;
      #100;
      reset = 0;
      #100;
      reset = 1;
        Clk = 0;
        $monitor(" %b,", data_out1);
        #100000 $finish;
      end
    always #5 Clk = ~Clk;

endmodule
