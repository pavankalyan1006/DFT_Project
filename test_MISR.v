module test_MISR;
reg [4:0] M;
reg clk, rst, enb;
wire [4:0] out;

bit_10to5_misr test(.out(out), .M(M), .enb(enb), .clk(clk), .reset(rst));


initial begin
rst <= 0;
clk <= 0;
enb <= 1;
M <= 0;

$dumpfile("MISR.vcd");
$dumpvars(0, test_MISR);

#2
rst <= 1;


#2000 $finish;
end

always #1 clk = ~clk;
always #2 M = M +1'b1;
always #2 $display("out = %b", out);    
endmodule