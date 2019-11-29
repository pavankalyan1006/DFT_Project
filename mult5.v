module half_adder(A, B, sum, c_out);
    input A, B;
    output sum, c_out;

    assign sum = A^B;
    assign c_out = A&B;

endmodule

module full_adder(A, B, c_in, sum, c_out);

    input A, B, c_in;
    output sum, c_out;

    assign sum = A^B^c_in;
    assign c_out = (A&B)|((A^B)&c_in); 

endmodule

// module 5bit_adder(A, B, sum, c_out);

//     input [4:0] A, B;
//     output [4:0] sum;
//     output c_out;

//     wire c0, c1, c2, c3

//     half_adder H1(A[0], B[0], sum[0], c0);
//     full_adder F1(A[1], B[1], c0, summ,. ';[1], c1);
//     full_adder F2(A[2], B[2], c1, sum[2], c2);
//     full_adder F3(A[3], B[3], c2, sum[3], c3);
//     full_adder F4(A[4], B[4], c3, sum[4], c_out);

// endmodule

module mult5(A, B, out, fault_control, fault_places);

    input [4:0] A, B;
    input [50:0] fault_control, fault_places;
    output [9:0] out;
    
    wire [9:0] Z;

    wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19;
    wire s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12;

    wire [50:0] fault;

    assign fault[0] = (fault_places[0] == 0)?A[0]:fault_control[0];
    assign fault[1] = (fault_places[1] == 0)?A[1]:fault_control[1];
    assign fault[2] = (fault_places[2] == 0)?A[2]:fault_control[2];
    assign fault[3] = (fault_places[3] == 0)?A[3]:fault_control[3];
    assign fault[4] = (fault_places[4] == 0)?A[4]:fault_control[4];
    assign fault[5] = (fault_places[5] == 0)?B[0]:fault_control[5];
    assign fault[6] = (fault_places[6] == 0)?B[1]:fault_control[6];
    assign fault[7] = (fault_places[7] == 0)?B[2]:fault_control[7];
    assign fault[8] = (fault_places[8] == 0)?B[3]:fault_control[8];
    assign fault[9] = (fault_places[9] == 0)?B[4]:fault_control[9];
    assign fault[10] = (fault_places[10] == 0)?Z[0]:fault_control[10];
    assign fault[11] = (fault_places[11] == 0)?Z[1]:fault_control[11];
    assign fault[12] = (fault_places[12] == 0)?Z[2]:fault_control[12];
    assign fault[13] = (fault_places[13] == 0)?Z[3]:fault_control[13];
    assign fault[14] = (fault_places[14] == 0)?Z[4]:fault_control[14];
    assign fault[15] = (fault_places[15] == 0)?Z[5]:fault_control[15];
    assign fault[16] = (fault_places[16] == 0)?Z[6]:fault_control[16];
    assign fault[17] = (fault_places[17] == 0)?Z[7]:fault_control[17];
    assign fault[18] = (fault_places[18] == 0)?Z[8]:fault_control[18];
    assign fault[19] = (fault_places[19] == 0)?Z[9]:fault_control[19];
    assign fault[20] = (fault_places[20] == 0)?c1:fault_control[20];
    assign fault[21] = (fault_places[21] == 0)?c2:fault_control[21];
    assign fault[22] = (fault_places[22] == 0)?c3:fault_control[22];
    assign fault[23] = (fault_places[23] == 0)?c4:fault_control[23];
    assign fault[24] = (fault_places[24] == 0)?c5:fault_control[24];
    assign fault[25] = (fault_places[25] == 0)?c6:fault_control[25];
    assign fault[26] = (fault_places[26] == 0)?c7:fault_control[26];
    assign fault[27] = (fault_places[27] == 0)?c8:fault_control[27];
    assign fault[28] = (fault_places[28] == 0)?c9:fault_control[28];
    assign fault[29] = (fault_places[29] == 0)?c10:fault_control[29];
    assign fault[30] = (fault_places[30] == 0)?c11:fault_control[30];
    assign fault[31] = (fault_places[31] == 0)?c12:fault_control[31];
    assign fault[32] = (fault_places[32] == 0)?c13:fault_control[32];
    assign fault[33] = (fault_places[33] == 0)?c14:fault_control[33];
    assign fault[34] = (fault_places[34] == 0)?c15:fault_control[34];
    assign fault[35] = (fault_places[35] == 0)?c16:fault_control[35];
    assign fault[36] = (fault_places[36] == 0)?c17:fault_control[36];
    assign fault[37] = (fault_places[37] == 0)?c18:fault_control[37];
    assign fault[38] = (fault_places[38] == 0)?c19:fault_control[38];
    assign fault[39] = (fault_places[39] == 0)?s1:fault_control[39];
    assign fault[40] = (fault_places[40] == 0)?s2:fault_control[40];
    assign fault[41] = (fault_places[41] == 0)?s3:fault_control[41];
    assign fault[42] = (fault_places[42] == 0)?s4:fault_control[42];
    assign fault[43] = (fault_places[43] == 0)?s5:fault_control[43];
    assign fault[44] = (fault_places[44] == 0)?s6:fault_control[44];
    assign fault[45] = (fault_places[45] == 0)?s7:fault_control[45];
    assign fault[46] = (fault_places[46] == 0)?s8:fault_control[46];
    assign fault[47] = (fault_places[47] == 0)?s9:fault_control[47];
    assign fault[48] = (fault_places[48] == 0)?s10:fault_control[48];
    assign fault[49] = (fault_places[49] == 0)?s11:fault_control[49];
    assign fault[50] = (fault_places[50] == 0)?s12:fault_control[50];
    

    
        // Stage 1
    assign Z[0] = fault[0]&fault[5];
    // Stage 2
    half_adder H1(fault[1]&fault[5], fault[0]&fault[6], Z[1], c1);
    full_adder F1(fault[2]&fault[5], fault[1]&fault[6], fault[20], s1, c2);
    full_adder F2(fault[3]&fault[5], fault[2]&fault[6], fault[21], s2, c3);
    full_adder F3(fault[4]&fault[5], fault[3]&fault[6], fault[22], s3, c4);
    full_adder F4(1'b0, fault[4]&fault[6], fault[23], s4, c5);
    // Stage 3
    half_adder H2(fault[39], fault[0]&fault[7], Z[2], c6);
    full_adder F5(fault[40], fault[1]&fault[7], fault[25], s5, c7);
    full_adder F6(fault[41], fault[2]&fault[7], fault[26], s6, c8);
    full_adder F7(fault[42], fault[3]&fault[7], fault[27], s7, c9);
    full_adder F8(fault[24], fault[4]&fault[7], fault[28], s8, c10);
    // Stage 4
    half_adder H3(fault[43], fault[0]&fault[8], Z[3], c11);
    full_adder F9(fault[44], fault[1]&fault[8], fault[30], s9, c12);
    full_adder F10(fault[45], fault[2]&fault[8], fault[31], s10, c13);
    full_adder F11(fault[46], fault[3]&fault[8], fault[32], s11, c14);
    full_adder F12(fault[29], fault[4]&fault[8], fault[33], s12, c15);
    // Stage 5
    half_adder H4(fault[47], fault[0]&fault[9], Z[4], c16);
    full_adder F13(fault[48], fault[1]&fault[9], fault[35], Z[5], c17);
    full_adder F14(fault[49], fault[2]&fault[9], fault[36], Z[6], c18);
    full_adder F15(fault[50], fault[3]&fault[9], fault[37], Z[7], c19);
    full_adder F16(fault[34], fault[4]&fault[9], fault[38], Z[8], Z[9]);
    
    assign out = fault[19:10];

endmodule