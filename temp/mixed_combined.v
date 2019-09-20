module combined(
	input clk,
	input rst,
	input [1:0] data_in,
	output [1:0] data_demod_out
);

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
		signal_out_qam_mixer
	);

	qam_demodulator uuu1(
		clk_qam_mixer,
		signal_out_qam_mixer,
		sin_out_sampled,
		cos_out_sampled,
		data_demod_out
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

module sin_cos (
  input Clk,
  output reg signed [7:0] data_sin,
  output reg signed [7:0] data_cos);
//declare the sine ROM - 30 registers each 8 bit wide.
    reg [7:0] sine [0:359];
//Internal signals
    integer i_sin;
    integer i_cos;
//Initialize the sine rom with samples.
    initial begin
        i_sin = 0;
        i_cos = 90;
        sine[0] = 0;
        sine[0] = 0;
        sine[1] = 1;
        sine[2] = 2;
        sine[3] = 3;
        sine[4] = 4;
        sine[5] = 5;
        sine[6] = 6;
        sine[7] = 7;
        sine[8] = 8;
        sine[9] = 10;
        sine[10] = 11;
        sine[11] = 12;
        sine[12] = 13;
        sine[13] = 14;
        sine[14] = 15;
        sine[15] = 16;
        sine[16] = 17;
        sine[17] = 18;
        sine[18] = 19;
        sine[19] = 20;
        sine[20] = 21;
        sine[21] = 22;
        sine[22] = 23;
        sine[23] = 25;
        sine[24] = 26;
        sine[25] = 27;
        sine[26] = 28;
        sine[27] = 29;
        sine[28] = 30;
        sine[29] = 31;
        sine[30] = 31;
        sine[31] = 32;
        sine[32] = 33;
        sine[33] = 34;
        sine[34] = 35;
        sine[35] = 36;
        sine[36] = 37;
        sine[37] = 38;
        sine[38] = 39;
        sine[39] = 40;
        sine[40] = 41;
        sine[41] = 41;
        sine[42] = 42;
        sine[43] = 43;
        sine[44] = 44;
        sine[45] = 45;
        sine[46] = 46;
        sine[47] = 46;
        sine[48] = 47;
        sine[49] = 48;
        sine[50] = 49;
        sine[51] = 49;
        sine[52] = 50;
        sine[53] = 51;
        sine[54] = 51;
        sine[55] = 52;
        sine[56] = 53;
        sine[57] = 53;
        sine[58] = 54;
        sine[59] = 54;
        sine[60] = 55;
        sine[61] = 55;
        sine[62] = 56;
        sine[63] = 57;
        sine[64] = 57;
        sine[65] = 58;
        sine[66] = 58;
        sine[67] = 58;
        sine[68] = 59;
        sine[69] = 59;
        sine[70] = 60;
        sine[71] = 60;
        sine[72] = 60;
        sine[73] = 61;
        sine[74] = 61;
        sine[75] = 61;
        sine[76] = 62;
        sine[77] = 62;
        sine[78] = 62;
        sine[79] = 62;
        sine[80] = 63;
        sine[81] = 63;
        sine[82] = 63;
        sine[83] = 63;
        sine[84] = 63;
        sine[85] = 63;
        sine[86] = 63;
        sine[87] = 63;
        sine[88] = 63;
        sine[89] = 63;
        sine[90] = 63;
        sine[91] = 63;
        sine[92] = 63;
        sine[93] = 63;
        sine[94] = 63;
        sine[95] = 63;
        sine[96] = 63;
        sine[97] = 63;
        sine[98] = 63;
        sine[99] = 63;
        sine[100] = 63;
        sine[101] = 62;
        sine[102] = 62;
        sine[103] = 62;
        sine[104] = 62;
        sine[105] = 61;
        sine[106] = 61;
        sine[107] = 61;
        sine[108] = 60;
        sine[109] = 60;
        sine[110] = 60;
        sine[111] = 59;
        sine[112] = 59;
        sine[113] = 58;
        sine[114] = 58;
        sine[115] = 58;
        sine[116] = 57;
        sine[117] = 57;
        sine[118] = 56;
        sine[119] = 55;
        sine[120] = 55;
        sine[121] = 54;
        sine[122] = 54;
        sine[123] = 53;
        sine[124] = 53;
        sine[125] = 52;
        sine[126] = 51;
        sine[127] = 51;
        sine[128] = 50;
        sine[129] = 49;
        sine[130] = 49;
        sine[131] = 48;
        sine[132] = 47;
        sine[133] = 46;
        sine[134] = 46;
        sine[135] = 45;
        sine[136] = 44;
        sine[137] = 43;
        sine[138] = 42;
        sine[139] = 41;
        sine[140] = 41;
        sine[141] = 40;
        sine[142] = 39;
        sine[143] = 38;
        sine[144] = 37;
        sine[145] = 36;
        sine[146] = 35;
        sine[147] = 34;
        sine[148] = 33;
        sine[149] = 32;
        sine[150] = 32;
        sine[151] = 31;
        sine[152] = 30;
        sine[153] = 29;
        sine[154] = 28;
        sine[155] = 27;
        sine[156] = 26;
        sine[157] = 25;
        sine[158] = 23;
        sine[159] = 22;
        sine[160] = 21;
        sine[161] = 20;
        sine[162] = 19;
        sine[163] = 18;
        sine[164] = 17;
        sine[165] = 16;
        sine[166] = 15;
        sine[167] = 14;
        sine[168] = 13;
        sine[169] = 12;
        sine[170] = 11;
        sine[171] = 10;
        sine[172] = 8;
        sine[173] = 7;
        sine[174] = 6;
        sine[175] = 5;
        sine[176] = 4;
        sine[177] = 3;
        sine[178] = 2;
        sine[179] = 1;
        sine[180] = 0;
        sine[181] = -1;
        sine[182] = -2;
        sine[183] = -3;
        sine[184] = -4;
        sine[185] = -5;
        sine[186] = -6;
        sine[187] = -7;
        sine[188] = -8;
        sine[189] = -10;
        sine[190] = -11;
        sine[191] = -12;
        sine[192] = -13;
        sine[193] = -14;
        sine[194] = -15;
        sine[195] = -16;
        sine[196] = -17;
        sine[197] = -18;
        sine[198] = -19;
        sine[199] = -20;
        sine[200] = -21;
        sine[201] = -22;
        sine[202] = -23;
        sine[203] = -25;
        sine[204] = -26;
        sine[205] = -27;
        sine[206] = -28;
        sine[207] = -29;
        sine[208] = -30;
        sine[209] = -31;
        sine[210] = -31;
        sine[211] = -32;
        sine[212] = -33;
        sine[213] = -34;
        sine[214] = -35;
        sine[215] = -36;
        sine[216] = -37;
        sine[217] = -38;
        sine[218] = -39;
        sine[219] = -40;
        sine[220] = -41;
        sine[221] = -41;
        sine[222] = -42;
        sine[223] = -43;
        sine[224] = -44;
        sine[225] = -45;
        sine[226] = -46;
        sine[227] = -46;
        sine[228] = -47;
        sine[229] = -48;
        sine[230] = -49;
        sine[231] = -49;
        sine[232] = -50;
        sine[233] = -51;
        sine[234] = -51;
        sine[235] = -52;
        sine[236] = -53;
        sine[237] = -53;
        sine[238] = -54;
        sine[239] = -54;
        sine[240] = -55;
        sine[241] = -55;
        sine[242] = -56;
        sine[243] = -57;
        sine[244] = -57;
        sine[245] = -58;
        sine[246] = -58;
        sine[247] = -58;
        sine[248] = -59;
        sine[249] = -59;
        sine[250] = -60;
        sine[251] = -60;
        sine[252] = -60;
        sine[253] = -61;
        sine[254] = -61;
        sine[255] = -61;
        sine[256] = -62;
        sine[257] = -62;
        sine[258] = -62;
        sine[259] = -62;
        sine[260] = -63;
        sine[261] = -63;
        sine[262] = -63;
        sine[263] = -63;
        sine[264] = -63;
        sine[265] = -63;
        sine[266] = -63;
        sine[267] = -63;
        sine[268] = -63;
        sine[269] = -63;
        sine[270] = -63;
        sine[271] = -63;
        sine[272] = -63;
        sine[273] = -63;
        sine[274] = -63;
        sine[275] = -63;
        sine[276] = -63;
        sine[277] = -63;
        sine[278] = -63;
        sine[279] = -63;
        sine[280] = -63;
        sine[281] = -62;
        sine[282] = -62;
        sine[283] = -62;
        sine[284] = -62;
        sine[285] = -61;
        sine[286] = -61;
        sine[287] = -61;
        sine[288] = -60;
        sine[289] = -60;
        sine[290] = -60;
        sine[291] = -59;
        sine[292] = -59;
        sine[293] = -58;
        sine[294] = -58;
        sine[295] = -58;
        sine[296] = -57;
        sine[297] = -57;
        sine[298] = -56;
        sine[299] = -55;
        sine[300] = -55;
        sine[301] = -54;
        sine[302] = -54;
        sine[303] = -53;
        sine[304] = -53;
        sine[305] = -52;
        sine[306] = -51;
        sine[307] = -51;
        sine[308] = -50;
        sine[309] = -49;
        sine[310] = -49;
        sine[311] = -48;
        sine[312] = -47;
        sine[313] = -46;
        sine[314] = -46;
        sine[315] = -45;
        sine[316] = -44;
        sine[317] = -43;
        sine[318] = -42;
        sine[319] = -41;
        sine[320] = -41;
        sine[321] = -40;
        sine[322] = -39;
        sine[323] = -38;
        sine[324] = -37;
        sine[325] = -36;
        sine[326] = -35;
        sine[327] = -34;
        sine[328] = -33;
        sine[329] = -32;
        sine[330] = -32;
        sine[331] = -31;
        sine[332] = -30;
        sine[333] = -29;
        sine[334] = -28;
        sine[335] = -27;
        sine[336] = -26;
        sine[337] = -25;
        sine[338] = -23;
        sine[339] = -22;
        sine[340] = -21;
        sine[341] = -20;
        sine[342] = -19;
        sine[343] = -18;
        sine[344] = -17;
        sine[345] = -16;
        sine[346] = -15;
        sine[347] = -14;
        sine[348] = -13;
        sine[349] = -12;
        sine[350] = -11;
        sine[351] = -10;
        sine[352] = -8;
        sine[353] = -7;
        sine[354] = -6;
        sine[355] = -5;
        sine[356] = -4;
        sine[357] = -3;
        sine[358] = -2;
        sine[359] = -1;
    end

    //At every positive edge of the clock, output a sine wave sample.
    always@ (posedge(Clk))
    begin
        data_sin = sine[i_sin];
        i_sin = i_sin+ 1;
        if(i_sin == 359)
            i_sin = 0;
    end


    //At every positive edge of the clock, output a sine wave sample.
    always@ (posedge(Clk))
    begin
        data_cos = sine[i_cos];
        i_cos = i_cos+ 1;
        if(i_cos == 359)
            i_cos = 0;
    end

endmodule

module qam_demodulator(
  input clk,
  input signed [7:0] input_signal,
  input signed [7:0] sin_in,
  input signed [7:0] cos_in,
  output reg [1:0] data_demod
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

  moving_avg_filt mov_avg2(
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

module moving_avg_filt(
  input clk,
  input signed [15:0] signal_in,
  output reg signed [15:0] signal_out
  );

  parameter N = 16; //**must be a power of 2

  reg signed [15:0] input_signal_queue [0:N-1];
  reg signed [19:0] signal_in_sum;
  integer iter;

  always @ (posedge clk) begin
    input_signal_queue[0] <= signal_in;
    for (iter = 0; iter < N - 1; iter = iter + 1)
    begin
      input_signal_queue[iter + 1] <= input_signal_queue[iter];
    end // end for
  end

  always@(posedge clk) begin
    for (iter = 0; iter < N; iter = iter + 1) begin
      signal_in_sum = signal_in_sum + input_signal_queue[iter];
    end
    signal_out = signal_in_sum >>> 4;
  end //end always posedge clk

  always@(negedge clk) begin
    signal_in_sum = 0;
  end
endmodule
