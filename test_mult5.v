module test_mult5;
reg [4:0] A, B;
wire [9:0] out;

reg [50:0] fault_control, fault_places;


mult5 test(.A(A), .B(B), .out(out), .fault_control(fault_control), .fault_places(fault_places));

initial begin

fault_places = 51'b000000000000000000000000000000000000000000000100000;
fault_control = 51'b000000000000000000000000000000000000000000000100000;

$dumpfile("mult_5bit.vcd");
$dumpvars(0, test_mult5);

A <= 5'b00000;
B <= 5'b00000;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b00001;
B <= 5'b00000;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b00001;
B <= 5'b00001;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b00010;
B <= 5'b00001;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b11101;
B <= 5'b00000;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b11011;
B <= 5'b10010;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b11011;
B <= 5'b01000;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b11111;
B <= 5'b11111;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b00100;
B <= 5'b10000;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b10001;
B <= 5'b10000;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b10101;
B <= 5'b01101;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b00011;
B <= 5'b10001;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b11101;
B <= 5'b11000;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b11011;
B <= 5'b10011;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b11111;
B <= 5'b01010;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

A <= 5'b11111;
B <= 5'b11110;
#5
$display("A = %d, B = %d, out = %d", A, B, out);

$finish;
end
endmodule
