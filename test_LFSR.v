module test_LFSR;
reg clk1, clk2, rst, enb;
wire [4:0] out1, out2;

bit_5_lfsr test1(.out(out1), .enb(enb), .clk(clk1), .reset(rst));
bit_5_lfsr test2(.out(out2), .enb(enb), .clk(clk2), .reset(rst));

initial begin
rst <= 0;
clk1 <= 1;
clk2 <= 1;
enb <= 1;

$dumpfile("LFSR.vcd");
$dumpvars(0, test_LFSR);

#1
rst <= 1;


#2000 $finish;
end

always #1 clk1 = ~clk1;
always #31 clk2 = ~clk2;
always #2 $display("out = %b, %b", out1, out2);    
endmodule   
