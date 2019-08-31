module tb;

    // Inputs
    reg Clk;
    reg en;
    reg reset;

    // Outputs
    wire signed [7:0] data_out;
   // wire signed [7:0] data_out2;

    // Instantiate the Unit Under Test (UUT)
    //sin_wave_gen inst(Clk, data_out);
     sine_wave_gen uut (
         .Clk(Clk),
         .data_out(data_out)
     );

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
        $monitor(" %b,", data_out);
        #100000 $finish;
      end
    always #5 Clk = ~Clk;

endmodule


module sine_wave_gen(Clk,data_out);
//declare input and output
    input Clk;
    output [7:0] data_out;
//declare the sine ROM - 30 registers each 8 bit wide.
    reg [7:0] sine [0:359];
//Internal signals
    integer i;
    reg [7:0] data_out;
//Initialize the sine rom with samples.
    initial begin
        i = 0;
        sine[0] = 0;
sine[1] = 1;
sine[2] = 3;
sine[3] = 5;
sine[4] = 6;
sine[5] = 8;
sine[6] = 10;
sine[7] = 12;
sine[8] = 13;
sine[9] = 15;
sine[10] = 17;
sine[11] = 19;
sine[12] = 20;
sine[13] = 22;
sine[14] = 24;
sine[15] = 25;
sine[16] = 27;
sine[17] = 29;
sine[18] = 30;
sine[19] = 32;
sine[20] = 34;
sine[21] = 35;
sine[22] = 37;
sine[23] = 39;
sine[24] = 40;
sine[25] = 42;
sine[26] = 43;
sine[27] = 45;
sine[28] = 46;
sine[29] = 48;
sine[30] = 49;
sine[31] = 51;
sine[32] = 52;
sine[33] = 54;
sine[34] = 55;
sine[35] = 57;
sine[36] = 58;
sine[37] = 60;
sine[38] = 61;
sine[39] = 62;
sine[40] = 64;
sine[41] = 65;
sine[42] = 66;
sine[43] = 68;
sine[44] = 69;
sine[45] = 70;
sine[46] = 71;
sine[47] = 73;
sine[48] = 74;
sine[49] = 75;
sine[50] = 76;
sine[51] = 77;
sine[52] = 78;
sine[53] = 79;
sine[54] = 80;
sine[55] = 81;
sine[56] = 82;
sine[57] = 83;
sine[58] = 84;
sine[59] = 85;
sine[60] = 86;
sine[61] = 87;
sine[62] = 88;
sine[63] = 89;
sine[64] = 89;
sine[65] = 90;
sine[66] = 91;
sine[67] = 92;
sine[68] = 92;
sine[69] = 93;
sine[70] = 93;
sine[71] = 94;
sine[72] = 95;
sine[73] = 95;
sine[74] = 96;
sine[75] = 96;
sine[76] = 97;
sine[77] = 97;
sine[78] = 97;
sine[79] = 98;
sine[80] = 98;
sine[81] = 98;
sine[82] = 99;
sine[83] = 99;
sine[84] = 99;
sine[85] = 99;
sine[86] = 99;
sine[87] = 99;
sine[88] = 99;
sine[89] = 99;
sine[90] = 100;
sine[91] = 99;
sine[92] = 99;
sine[93] = 99;
sine[94] = 99;
sine[95] = 99;
sine[96] = 99;
sine[97] = 99;
sine[98] = 99;
sine[99] = 98;
sine[100] = 98;
sine[101] = 98;
sine[102] = 97;
sine[103] = 97;
sine[104] = 97;
sine[105] = 96;
sine[106] = 96;
sine[107] = 95;
sine[108] = 95;
sine[109] = 94;
sine[110] = 93;
sine[111] = 93;
sine[112] = 92;
sine[113] = 92;
sine[114] = 91;
sine[115] = 90;
sine[116] = 89;
sine[117] = 89;
sine[118] = 88;
sine[119] = 87;
sine[120] = 86;
sine[121] = 85;
sine[122] = 84;
sine[123] = 83;
sine[124] = 82;
sine[125] = 81;
sine[126] = 80;
sine[127] = 79;
sine[128] = 78;
sine[129] = 77;
sine[130] = 76;
sine[131] = 75;
sine[132] = 74;
sine[133] = 73;
sine[134] = 71;
sine[135] = 70;
sine[136] = 69;
sine[137] = 68;
sine[138] = 66;
sine[139] = 65;
sine[140] = 64;
sine[141] = 62;
sine[142] = 61;
sine[143] = 60;
sine[144] = 58;
sine[145] = 57;
sine[146] = 55;
sine[147] = 54;
sine[148] = 52;
sine[149] = 51;
sine[150] = 50;
sine[151] = 48;
sine[152] = 46;
sine[153] = 45;
sine[154] = 43;
sine[155] = 42;
sine[156] = 40;
sine[157] = 39;
sine[158] = 37;
sine[159] = 35;
sine[160] = 34;
sine[161] = 32;
sine[162] = 30;
sine[163] = 29;
sine[164] = 27;
sine[165] = 25;
sine[166] = 24;
sine[167] = 22;
sine[168] = 20;
sine[169] = 19;
sine[170] = 17;
sine[171] = 15;
sine[172] = 13;
sine[173] = 12;
sine[174] = 10;
sine[175] = 8;
sine[176] = 6;
sine[177] = 5;
sine[178] = 3;
sine[179] = 1;
sine[180] = 0;
sine[181] = -1;
sine[182] = -3;
sine[183] = -5;
sine[184] = -6;
sine[185] = -8;
sine[186] = -10;
sine[187] = -12;
sine[188] = -13;
sine[189] = -15;
sine[190] = -17;
sine[191] = -19;
sine[192] = -20;
sine[193] = -22;
sine[194] = -24;
sine[195] = -25;
sine[196] = -27;
sine[197] = -29;
sine[198] = -30;
sine[199] = -32;
sine[200] = -34;
sine[201] = -35;
sine[202] = -37;
sine[203] = -39;
sine[204] = -40;
sine[205] = -42;
sine[206] = -43;
sine[207] = -45;
sine[208] = -46;
sine[209] = -48;
sine[210] = -49;
sine[211] = -51;
sine[212] = -52;
sine[213] = -54;
sine[214] = -55;
sine[215] = -57;
sine[216] = -58;
sine[217] = -60;
sine[218] = -61;
sine[219] = -62;
sine[220] = -64;
sine[221] = -65;
sine[222] = -66;
sine[223] = -68;
sine[224] = -69;
sine[225] = -70;
sine[226] = -71;
sine[227] = -73;
sine[228] = -74;
sine[229] = -75;
sine[230] = -76;
sine[231] = -77;
sine[232] = -78;
sine[233] = -79;
sine[234] = -80;
sine[235] = -81;
sine[236] = -82;
sine[237] = -83;
sine[238] = -84;
sine[239] = -85;
sine[240] = -86;
sine[241] = -87;
sine[242] = -88;
sine[243] = -89;
sine[244] = -89;
sine[245] = -90;
sine[246] = -91;
sine[247] = -92;
sine[248] = -92;
sine[249] = -93;
sine[250] = -93;
sine[251] = -94;
sine[252] = -95;
sine[253] = -95;
sine[254] = -96;
sine[255] = -96;
sine[256] = -97;
sine[257] = -97;
sine[258] = -97;
sine[259] = -98;
sine[260] = -98;
sine[261] = -98;
sine[262] = -99;
sine[263] = -99;
sine[264] = -99;
sine[265] = -99;
sine[266] = -99;
sine[267] = -99;
sine[268] = -99;
sine[269] = -99;
sine[270] = -100;
sine[271] = -99;
sine[272] = -99;
sine[273] = -99;
sine[274] = -99;
sine[275] = -99;
sine[276] = -99;
sine[277] = -99;
sine[278] = -99;
sine[279] = -98;
sine[280] = -98;
sine[281] = -98;
sine[282] = -97;
sine[283] = -97;
sine[284] = -97;
sine[285] = -96;
sine[286] = -96;
sine[287] = -95;
sine[288] = -95;
sine[289] = -94;
sine[290] = -93;
sine[291] = -93;
sine[292] = -92;
sine[293] = -92;
sine[294] = -91;
sine[295] = -90;
sine[296] = -89;
sine[297] = -89;
sine[298] = -88;
sine[299] = -87;
sine[300] = -86;
sine[301] = -85;
sine[302] = -84;
sine[303] = -83;
sine[304] = -82;
sine[305] = -81;
sine[306] = -80;
sine[307] = -79;
sine[308] = -78;
sine[309] = -77;
sine[310] = -76;
sine[311] = -75;
sine[312] = -74;
sine[313] = -73;
sine[314] = -71;
sine[315] = -70;
sine[316] = -69;
sine[317] = -68;
sine[318] = -66;
sine[319] = -65;
sine[320] = -64;
sine[321] = -62;
sine[322] = -61;
sine[323] = -60;
sine[324] = -58;
sine[325] = -57;
sine[326] = -55;
sine[327] = -54;
sine[328] = -52;
sine[329] = -51;
sine[330] = -50;
sine[331] = -48;
sine[332] = -46;
sine[333] = -45;
sine[334] = -43;
sine[335] = -42;
sine[336] = -40;
sine[337] = -39;
sine[338] = -37;
sine[339] = -35;
sine[340] = -34;
sine[341] = -32;
sine[342] = -30;
sine[343] = -29;
sine[344] = -27;
sine[345] = -25;
sine[346] = -24;
sine[347] = -22;
sine[348] = -20;
sine[349] = -19;
sine[350] = -17;
sine[351] = -15;
sine[352] = -13;
sine[353] = -12;
sine[354] = -10;
sine[355] = -8;
sine[356] = -6;
sine[357] = -5;
sine[358] = -3;
sine[359] = -1;
    end

    //At every positive edge of the clock, output a sine wave sample.
    always@ (posedge(Clk))
    begin
        data_out = sine[i];
        $display("%d    ",data_out);
        i = i+ 1;
        if(i == 359)
            i = 0;
    end

endmodule
//scale them down to -1,1
//change frequency
//create pcf file
//
