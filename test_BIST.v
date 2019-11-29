module test_BIST;
reg lfsrclk1, lfsrclk2, misrclk, fileclk, enb, rst;
wire [4:0] out;
wire [9:0] cutinp;

reg [50:0] fault_places, fault_control;

integer fd, in, i, file, file1, file0, val, t, t0, t1, val0, val1, flag0, flag1, count0, count1, inread, infile, inp, inp1,  comp;

BIST test(.signature(out), .lfsrclk1(lfsrclk1), .lfsrclk2(lfsrclk2), .misrclk(misrclk), .rst(rst), .enb(enb), .fault_control(fault_control), .fault_places(fault_places), .cutinp(cutinp));

initial begin

fd = $fopen("signature.txt", "w");
in = $fopen("input.txt", "w"); 
fault_places=51'b000000000000000000000000000000000000000000000000000;
fault_control=0;
rst <= 0;
enb <= 1;
lfsrclk1 <= 1;
lfsrclk2 <= 1;
misrclk <= 1;
comp = 0;

$dumpfile("BIST.vcd");
$dumpvars(0, test_BIST);

#3
rst <= 1;

#3841;
comp = 1;
$fclose(fd); 

fault_places=51'b100000000000000000000000000000000000000000000000000;
fault_control=0;

count0 = 0;
count1 = 0;

for (i=0; i<51;i=i+1) begin
    //stuck at 1 faults
    fd = $fopen("signature1.txt", "w"); 
    //$display("time = %0t, file open 2nd time", $time);
    fault_control=fault_places;
    rst <= 0;
    enb <= 1;
    lfsrclk1 <= 1;
    lfsrclk2 <= 1;
    misrclk <= 1;
    
    #3
    rst <= 1;

    #3841;
    $fclose(fd);
    
    // stuck at 0 faults
    fd = $fopen("signature0.txt", "w"); 
    //$display("time = %0t, file open 3nd time", $time);
    fault_control=~fault_places;
    rst <= 0;
    enb <= 1;
    lfsrclk1 <= 1;
    lfsrclk2 <= 1;
    misrclk <= 1;


    #3
    rst <= 1;

    #3841;
    $fclose(fd);
        
    // shifting the fault site
    fault_places=fault_places>>1;

    file = $fopen("signature.txt","r");
    file1 = $fopen("signature1.txt","r");
    file0 = $fopen("signature0.txt","r");
    inread = $fopen("input.txt","r");


    flag0 = 0;
    flag1 = 0;
    
    while (!$feof(file0) | !$feof(file)) begin
        t = $fscanf(file,"%b\n",val);
        t0 = $fscanf(file0,"%b\n",val0);
        t1 = $fscanf(file1,"%b\n",val1);
        infile = $fscanf(inread,"%b\n",inp1);
        
        if (val != val0 & flag0==0) begin
            $display("ERROR !!\n Orignial Signature = %b,\n Generated Signature = %b\n at site '%0d' stuck at 0 for input A = %b, B = %b\n", val[4:0], val0[4:0], 50 - i, inp[4:0], inp[9:5]);
            flag0 =1;
            count0 = count0 + 1;
        end

        if (val != val1 & flag1==0) begin
            $display("ERROR !!\n Orignial Signature = %b,\n Generated Signature = %b\n at site '%0d' stuck at 1 for input A = %b, B = %b\n", val[4:0], val1[4:0], 50 - i, inp[4:0], inp[9:5]);
            flag1 =1;
            count1 = count1 + 1;
        end

        inp = inp1;
    end

    $fclose(file);
    $fclose(file0);
    $fclose(file1);
    
end

if (count0 == 0 & count1 == 0) begin
    $display("No Faults Detected");      
end

$display("Fault Coverage of Stuck at 0 Faults = %0d out of %0d Faults", count0, i);
$display("Fault Coverage of Stuck at 1 Faults = %0d out of %0d Faults", count1, i);

$finish;
$fclose(in);
end

always @(posedge lfsrclk1)
begin
    $fwrite(fd,"%b\n",out);
    if (comp != 1) begin
        $fwrite(in,"%b\n", cutinp);
    end     
end

always #1 misrclk = ~misrclk;
always #2 lfsrclk1 = ~lfsrclk1;
always #62 lfsrclk2 = ~lfsrclk2;
//always #200 $display("out = %b", out);


endmodule 
